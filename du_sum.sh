#!/bin/bash

# Function to get the disk usage summary for a directory
get_disk_usage() {
    disk_usage=$(du -sh "$1" | cut -f1)
    echo "$disk_usage"
}

# Find directories with four digits in their names
root_directory="/path/dir"
target_directories=$(find "$root_directory" -type d -name '[0-9][0-9][0-9][0-9]' 2>/dev/null)

# Get disk usage for each directory
declare -A directory_disk_usages
for directory in $target_directories; do
    disk_usage=$(get_disk_usage "$directory")
    directory_disk_usages["$directory"]=$disk_usage
done

# Sort directories based on disk usage in descending order
sorted_directories=$(for directory in "${!directory_disk_usages[@]}"; do
    echo "$directory ${directory_disk_usages[$directory]}"
done | sort -k2 -rn)

# Print the sorted directories
echo "Directories sorted by disk usage:"
echo "---------------------------------"
while read -r line; do
    directory=$(echo "$line" | awk '{print $1}')
    disk_usage=$(echo "$line" | awk '{print $2}')
    echo "Directory: $directory   Disk Usage: $disk_usage"
done <<< "$sorted_directories"
