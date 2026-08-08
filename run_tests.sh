#!/usr/bin/env bash

failed=

which bids-validator
bids_validator_version=$(bids-validator --version 2>&1 | grep -oP '\d+\.\d+\.\d+')

# BIDS_VALIDATOR_STORE: if set, store validation outputs under derivatives/
#   'versioned'   -> derivatives/bids-validator-{version}/
#   'unversioned' -> derivatives/bids-validator/
if [ -n "$BIDS_VALIDATOR_STORE" ]; then
    case "$BIDS_VALIDATOR_STORE" in
        versioned)
            store_subdir="bids-validator-${bids_validator_version}"
            ;;
        unversioned)
            store_subdir="bids-validator"
            ;;
        *)
            echo "Error: BIDS_VALIDATOR_STORE must be 'versioned' or 'unversioned', got '$BIDS_VALIDATOR_STORE'"
            exit 2
            ;;
    esac
    echo "Will store validation outputs under derivatives/$store_subdir/"
fi

if [ "$#" -gt 0 ]; then
    datasets=( "$@" )
else
    datasets=( $(ls -d */ | grep -v node_modules) )
fi

echo "Will be validating ${#datasets[@]} dataset(s)"
for i in "${datasets[@]}"; do
    echo -n "Validating dataset $i: "
    ds="${i%%/}"

    if [ -f "$ds/.SKIP_VALIDATION" ]; then
        echo "skipping validation due to .SKIP_VALIDATION"
        continue
    fi

    # Set the VALIDATOR_ARGS environment variable to pass additional arguments to the
    # validator.
    CMD="bids-validator $ds $VALIDATOR_ARGS"

    # Use default configuration unless overridden
    if [[ ! ( -f "$ds/.bids-validator-config.json" || $CMD =~ /--config/ ) ]]; then
        CMD="$CMD --config $PWD/default-config.json"
    fi

    # Ignore NIfTI headers except for synthetic dataset
    if [ "$i" != "synthetic/" ]; then
        CMD="$CMD --ignoreNiftiHeaders"
    else
        echo "validating NIfTI headers. "
    fi

    if [ -n "$BIDS_VALIDATOR_STORE" ]; then
        outdir="$ds/derivatives/$store_subdir"
        mkdir -p "$outdir"

        echo "Running $CMD --format json_pp -o $outdir/output.json"
        $CMD --format json_pp -o "$outdir/output.json"

        echo "Running $CMD -o $outdir/output.txt"
        SECONDS=0
        $CMD -o "$outdir/output.txt"
        rc=$?
        duration=$SECONDS

        printf '{\n  "validator_version": "%s",\n  "duration": %d\n}\n' \
            "$bids_validator_version" "$duration" > "$outdir/info.json"

        echo "--- Validation output for $ds ---"
        cat "$outdir/output.txt"
        echo "--- End of output for $ds ---"

        [ $rc -ne 0 ] && failed+=" $i"
    else
        echo "Running $CMD"
        $CMD || failed+=" $i"
    fi
done
if [ -n "$failed" ]; then
    echo "Datasets failed validation: $failed"
    exit 1
fi
