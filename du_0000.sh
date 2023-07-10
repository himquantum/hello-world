#!/bin/bash

# Function to get the disk usage summary for a directory
get_disk_usage() {
    disk_usage=$(du -sh "$1" | cut -f1)
    echo "$disk_usage"
}

# Find directories with four digits in their names
root_directory="/path/to/your/directory"
target_directories=$(find "$root_directory" -type d -name '[0-9][0-9][0-9][0-9]' 2>/dev/null)

# Create a temporary file to store directory and disk usage data
tmp_file=$(mktemp)

# Get disk usage for each directory and store in the temporary file
for directory in $target_directories; do
    disk_usage=$(get_disk_usage "$directory")
    echo "$directory $disk_usage" >> "$tmp_file"
done

# Sort directories based on disk usage in descending order
sorted_directories=$(sort -k2 -rn "$tmp_file")

# Print the sorted directories
echo "Directories sorted by disk usage:"
echo "---------------------------------"
while read -r line; do
    directory=$(echo "$line" | awk '{print $1}')
    disk_usage=$(echo "$line" | awk '{print $2}')
    echo "Directory: $directory   Disk Usage: $disk_usage"
done <<< "$sorted_directories"

# Remove the temporary file
rm "$tmp_file"
