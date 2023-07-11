#!/bin/bash

# Function to get the disk usage summary for a directory
get_disk_usage() {
    disk_usage=$(du -sh "$1" | cut -f1)
    echo "$disk_usage"
}

# Find directories with four digits in their names
root_directory="/Users/himanshu/Downloads"
find "$root_directory" -maxdepth 1 -type d -name '[0-9][0-9][0-9][0-9]' 2>/dev/null | while read -r directory; do
    disk_usage=$(get_disk_usage "$directory")
    echo "$directory $disk_usage"
done > directory_disk_usages.txt

# Sort directories based on disk usage in descending order
sorted_directories=$(sort -k2 -rn directory_disk_usages.txt)

# Print the sorted directories
echo "Directories sorted by disk usage:"
echo "---------------------------------"
while read -r line; do
    directory=$(echo "$line" | awk '{print $1}')
    disk_usage=$(echo "$line" | awk '{print $2}')
    echo "Directory: $directory   Disk Usage: $disk_usage"
done <<< "$sorted_directories"

# Remove the temporary file
rm directory_disk_usages.txt
