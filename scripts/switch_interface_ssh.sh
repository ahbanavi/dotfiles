#!/bin/bash

interface=$1

# Check if the interface is valid and set the other interface
if [[ $interface == "wan" ]]; then
    other_interface="wanb"
elif [[ $interface == "wanb" ]]; then
    other_interface="wan"
else
    echo "Invalid interface: $interface"
    echo "Please choose either 'wan' or 'wanb'"
    exit 1
fi

# SSH into the OpenWrt router and switch the interface
echo "Switching to $interface..."
ssh root@192.168.1.1 "ifup $interface && sleep 30 && ifdown $other_interface" &