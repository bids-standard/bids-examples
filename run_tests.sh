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
        echo "validating NIfTI headers. "
    fi

    echo "Running $CMD"

    $CMD || failed+=" $i"
done
if [ -n "$failed" ]; then
    echo "Datasets failed validation: $failed"
    exit 1
fi
