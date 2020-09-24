#!/bin/bash

#cpufan.sh - works only with liquidctl interface

temp=0  #cpu temp
fan=25   #fan speed
min=25
low=50
high=85
max=100

getTemp() {
    #sensors|grep 'Package id'|cut -f 2 -d '+'|cut -f 1 -d '.'

    temp=`sensors|grep 'Package id'|cut -f 2 -d '+'|cut -f 1 -d '.'`
}

setFanSpeed() {
    # fan is always the current fan speed
    # sudo liquidctl set fan speed ##
    newfan=$((2*$temp))
    newfan=$(($newfan-35))
    if [[ $newfan -lt $low ]]; then
        newfan=$min
    elif [[ $newfan -ge $high ]]; then
        newfan=$max
    fi
    if [[ $newfan -ne $fan ]]; then
        fan=$(($newfan))
        sudo liquidctl set fan speed $fan
    fi
}

runLoop() {
    while true
    do
        # check temp
        # set fan speed
        getTemp
        setFanSpeed

        #delay or sleep
        sleep 1
    done
}


#initialize the fan speed and the fan variable
#sleep 30
#sudo liquidctl initialize all


sudo liquidctl set fan speed $fan
#runLoop


## debug testing fans
sudo liquidctl set fan speed 100

