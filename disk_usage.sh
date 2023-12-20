#!/bin/bash

# Set the threshold for disk usage (in percentage)
threshold=80

# Get current disk usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# Check if disk usage exceeds the threshold
if [ "$disk_usage" -gt "$threshold" ]; then
    echo "Warning: Disk usage is $disk_usage%, exceeding $threshold% threshold."
else
    echo "Disk usage is $disk_usage%, within acceptable limits."
fi
