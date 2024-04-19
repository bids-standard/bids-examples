#!/usr/bin/env bash

failed=

which bids-validator
if bids-validator --help | grep -q -e '--config'; then
       VALIDATOR_SUPPORTS_CONFIG=yes
else
       VALIDATOR_SUPPORTS_CONFIG=
fi

for i in $(ls -d */ | grep -v node_modules); do
    echo -n "Validating dataset $i: "

    if [ -f ${i%%/}/.SKIP_VALIDATION ]; then
        echo "skipping validation"
        continue
    fi

    # Set the VALIDATOR_ARGS environment variable to pass additional arguments to the 
    # validator.
    CMD="bids-validator ${i%%/} $VALIDATOR_ARGS"

    # Use default configuration unless overridden
    if [ -n "$VALIDATOR_SUPPORTS_CONFIG" ]; then
        if [ ! -f ${i%%/}/.bids-validator-config.json ]; then
            CMD="$CMD -c $PWD/bidsconfig.json"
        fi
    else
        # with new one we do not have config so let's get --json and exclude some using jq
        CMD="$CMD --json"
    fi

    # Ignore NIfTI headers except for synthetic dataset
    if [ $i != "synthetic/" ]; then
        CMD="$CMD --ignoreNiftiHeaders"
    else
        echo "validating NIfTI headers. "
    fi

    echo "Running " $CMD

    if [ -n "$VALIDATOR_SUPPORTS_CONFIG" ]; then
        $CMD || failed+=" $i"
    else
        # exit code is not returned correctly anyways and for the best since we need to ignore
        # ref: https://github.com/bids-standard/bids-validator/issues/1909
        # NOTE:  limit to 1 file per error to not flood screen!
        errors=$($CMD 2>/dev/null \
          | jq '(.issues | map(select(.severity == "error" and .key != "EMPTY_FILE"))) | map(.files_1 = (.files | if length > 0 then .[0:1] else empty end) | del(.files)) | if length > 0 then . else empty end' \
        )
        if [ -n "$errors" ]; then
            echo -e "$errors" | sed -e 's,^,  ,g'
            failed+=" $i"
        fi
    fi
done
if [ -n "$failed" ]; then
    echo "Datasets failed validation: $failed"
    exit 1
fi
