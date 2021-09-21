#!/bin/bash

rc = 0;
for i in $(ls -d */ | grep -v node_modules); do
    echo "Validating dataset" $i

    if [ -f ${i%%/}/.SKIP_VALIDATION ]; then
        echo "Skipping validation for ${i%%/}"
	continue
    fi

    CMD="bids-validator ${i%%/} $VALIDATOR_ARGS"

    # Use default configuration unless overridden
    if [ ! -f ${i%%/}/.bids-validator-config.json ]; then
	CMD="$CMD -c $PWD/bidsconfig.json"
    fi

    # Ignore NIfTI headers except for synthetic dataset
    if [ $i != "synthetic/" ]; then
	CMD="$CMD --ignoreNiftiHeaders"
    else
        echo "Validating NIfTI headers for dataset" $i
    fi

    echo $CMD
    $CMD || rc=$?
done
exit $rc;
