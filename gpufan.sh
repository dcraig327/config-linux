#!/bin/bash
# Put "sleep 30" here if you run it at start-up
# to make sure this starts after the Nvidia driver does.

#    fanSpeed1=$(($degreesC1 ** 2))
#    fanSpeed1=$(($fanSpeed1 / 50))
#    if [[ $fanSpeed1 -gt 100 ]]
#    then
#        fanSpeed1=100
#    fi

sleep 30

#echo "GPU fan controller service started."
#nvidia-settings -a "[gpu:1]/GPUFanControlState=1"
#nvidia-settings -a "[gpu:0]/GPUFanControlState=1"
nvidia-settings -a "GPUFanControlState=1" > /dev/null 2>&1
 
while true
do
    temp=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits`

    fan=$((temp*3))
    fan=$((fan-95))
    if [[ $fan -ge 80 ]]; then
        fan=100
    elif [[ $fan -le 40 ]]; then
        fan=40
    fi

    nvidia-settings -a "GPUTargetFanSpeed=$fan" > /dev/null 2>&1
    sleep 1
done
