#!/bin/bash

interface=$1

# Scan the local network interface for devices
devices=$(sudo arp-scan --interface=$interface --localnet | fzf)

# If no devices were found, exit
if [[ -z $devices ]]; then
  echo "No devices found."
  exit 1
fi

# Get the IP address of the selected device
ip=$(sudo arp-scan --interface=$interface --localnet | grep "$devices" | awk '{print $1}')

# Connect to the device using SSH
ssh root@$ip
