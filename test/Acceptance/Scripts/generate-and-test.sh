#!/bin/bash

set -eo pipefail

script_dir=$(dirname "${BASH_SOURCE[0]}")
out_dir="$(cd "${script_dir}/../../../out" && pwd)"
source_out_dir="$(cd "${script_dir}/../Sources/Acceptance/Contracts" && pwd)"
contracts=("DeFiScripts" "Multicall" "QuotePay" "QuarkBuilder" "AcrossScripts")

for contract in "${contracts[@]}"; do
    contract_path=$out_dir/$contract.sol
    if [ -d $contract_path ]; then
        for file in $contract_path/*.json; do   
            echo "Generating $contract from $(basename $file)"
            swift run Geno $file --outDir $source_out_dir
        done
    else
        echo "Contract $contract not found at $contract_path"
        exit 1
    fi
done

swiftformat ./Sources/Acceptance/Contracts/*.swift

swift test
