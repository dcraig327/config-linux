#!/bin/bash
# Put "sleep 30" here if you run it at start-up
# to make sure this starts after the Nvidia driver does.

fan="0"
gpu="0"
echo "GPU fan controller service started."
nvidia-settings -a "[gpu:$gpu]/GPUFanControlState=1"

while true
do
    degreesC=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader`
    fanSpeed=$(($degreesC ** 2))
    fanSpeed=$(($fanSpeed / 50))
    if [[ $fanSpeed -gt 100 ]]
    then
        fanSpeed=100
    fi
    nvidia-settings -a "[fan:$fan]/GPUTargetFanSpeed=$fanSpeed"
    sleep 8
done
