#!/bin/bash

rc=0;
for i in $(ls -d */ | grep -v node_modules);
do
    echo "Validating dataset" $i

    if [ -f ${i%%/}/.SKIP_VALIDATION ]; then

        echo "Skipping validation for ${i%%/}"

    elif [ -f ${i%%/}/.bids-validator-config.json ]; then

        bids-validator ${i%%/} $VALIDATOR_ARGS --ignoreNiftiHeaders || rc=$?

    else

        if [ $i == "synthetic/" ]; then

            echo "Validating NIfTI headers for dataset" $i
            bids-validator ${i%%/} $VALIDATOR_ARGS -c $PWD/bidsconfig.json || rc=$?

        else

            bids-validator ${i%%/} $VALIDATOR_ARGS --ignoreNiftiHeaders -c $PWD/bidsconfig.json || rc=$?

        fi

    fi
done
exit $rc;
