#!/bin/bash

set -euxo pipefail

main() {
    echo "Value of token: '$token'"
    echo "Value of files_to_upload: '${files_to_upload[@]}'"

    url="https://opencgaeglhstage.blob.core.windows.net/stage"

    mkdir inputs

    for i in ${!files_to_upload[@]}; do
        dx download "${files_to_upload[$i]}" -o inputs/
    done

    # extract azcopy
    tar xvzf azcopy_linux_amd64_10.6.0.tar.gz

    # login to azure and send data
    cd azcopy_linux_amd64_10.6.0
    
    ./azcopy copy '/home/dnanexus/inputs/*' "${url}/home/dnanexus/inputs?${token}"
    
    echo "Upload successful"
}
