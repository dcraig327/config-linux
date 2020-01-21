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
nvidia-settings -a "[gpu:1]/GPUFanControlState=1"
nvidia-settings -a "[gpu:0]/GPUFanControlState=1"
 
while true
do
    temp1=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | tail -n 1`

    fan1=$((temp1*3))
    fan1=$((fan1-95))
    if [[ $fan1 -ge 80 ]]; then
        fan1=100
    elif [[ $fan1 -le 40 ]]; then
        fan1=40
    fi

    nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=$fan1"
    nvidia-settings -a "[fan:1]/GPUTargetFanSpeed=$fan1"

    temp2=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | head -n 1`

    fan2=$((temp2*3))
    fan2=$((fan2-95))
    if [[ $fan2 -ge 80 ]]; then
        fan2=100
    elif [[ $fan2 -le 40 ]]; then
        fan2=40
    fi

    nvidia-settings -a "[fan:2]/GPUTargetFanSpeed=$fan2"
    sleep 1
done