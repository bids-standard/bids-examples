#!/usr/bin/env bash

failed=

which bids-validator

if bids-validator --help | grep -q Description; then
    VARIANT="schema"
else
    VARIANT="legacy"
fi

if [ "$#" -gt 0 ]; then
    datasets=( "$@" )
else
    datasets=( $(ls -d */ | grep -v node_modules) )
fi

echo "Will be validating ${#datasets[@]} dataset(s)"
for i in "${datasets[@]}"; do
    echo -n "Validating dataset $i: "

    if [ -f "${i%%/}/.SKIP_VALIDATION" ]; then
        echo "skipping validation due to .SKIP_VALIDATION"
        continue
    fi

    # Set the VALIDATOR_ARGS environment variable to pass additional arguments to the 
    # validator.
    CMD="bids-validator ${i%%/} $VALIDATOR_ARGS"

    # Use default configuration unless overridden
    if [[ ! ( -f "${i%%/}/.bids-validator-config.json" || $CMD =~ /--config/ ) ]]; then
        CMD="$CMD --config $PWD/${VARIANT}config.json"
    fi

    # Ignore NIfTI headers except for synthetic dataset
    if [ "$i" != "synthetic/" ]; then
        CMD="$CMD --ignoreNiftiHeaders"
    else
        echo "validating NIfTI headers."
    fi

    # We want json to better parse errors/issues
    CMD="$CMD --json"

    echo "Running $CMD"

    # Capture JSON output and count errors by path
    # Capture both stdout and stderr, but JSON should be on stdout
    JSON_OUTPUT=$(eval "$CMD" 2>&1)
    VALIDATOR_EXIT=$?

    # Check if we got valid JSON
    if echo "$JSON_OUTPUT" | jq empty >/dev/null 2>&1; then
        # Count errors grouped by path (root '/' or '/derivatives/<name>')
        # Handle empty or missing derivativesSummary
        # Should probably switch this script over to a Python or JS one at some point.
        ERROR_COUNTS=$(echo "$JSON_OUTPUT" | jq -c '
        {
          "/": ([.issues.issues[] | select(.severity == "error")] | length)
        } + (
          (.derivativesSummary // {}) | to_entries | map({
            key: "/derivatives/\(.key)",
            value: ([.value.issues.issues[] | select(.severity == "error")] | length)
          }) | from_entries
        ) | to_entries | map({path: .key, error_count: .value}) | map(select(.error_count > 0))')

        # Display error counts
        if [ -n "$ERROR_COUNTS" ] && [ "$ERROR_COUNTS" != "[]" ]; then
            echo "Error counts by path:"
            echo "$ERROR_COUNTS" | jq -r '.[] | "  \(.path): \(.error_count) error(s)"'
            failed+=" $i"
            # rerun the command but send the ouput to console for users see on github
            errors_only="$CMD --ignoreWarnings | jq"
            eval "$errors_only"
        else
            :
        fi
    else
        echo "Validator output is not valid JSON or validator failed"
        if [ $VALIDATOR_EXIT -ne 0 ]; then
            echo "Validator exit code: $VALIDATOR_EXIT"
        fi
        failed+=" $i"
    fi
done
if [ -n "$failed" ]; then
    echo "Datasets failed validation: $failed"
    exit 1
fi
