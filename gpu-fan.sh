#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly BIN_DIR="${HOME}/bin/scripts"
readonly LOG_FILE="${BIN_DIR}/gpu-fan.log"

#sleep 30 was used to make sure this starts after the Nvidia driver
#but that's no longer needed after placing in .xprofile
nvidia-settings -a "GPUFanControlState=1" > "${LOG_FILE}" 2>&1
 
while true
do
    temp=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits > "${LOG_FILE}" 2>&1`

    fan=$((temp*3))
    fan=$((fan-95))
    if [[ $fan -ge 80 ]]; then
        fan=100
    elif [[ $fan -le 40 ]]; then
        fan=40
    fi

    nvidia-settings -a "GPUTargetFanSpeed=$fan" > "${LOG_FILE}" 2>&1
    sleep 5
done
