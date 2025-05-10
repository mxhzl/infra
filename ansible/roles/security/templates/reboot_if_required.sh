#!/bin/bash

# Check if the /var/run/reboot-required file exists
if [ -f "/var/run/reboot-required" ]; then
    echo "Reboot required. Initiating the reboot..."

    # Stop all processes managed by supervisorctl
    # supervisorctl stop all

    # Reboot the system
    sudo reboot
else
    echo "No reboot required."
fi
