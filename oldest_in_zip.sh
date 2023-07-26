#!/bin/bash

# Set the path to the zip archive
zip_file="box.zip"

# Extract the file list from the zip archive along with their modification times
unzip -l "$zip_file" | awk '{if (NR > 3) print $4, $5, $6}' > temp_file_list.txt

# Find the oldest file based on modification time
oldest_file=$(ls -rt -d --full-time $(awk '{print $3}' temp_file_list.txt) | head -n 1)

# Clean up the temporary file list
rm temp_file_list.txt

echo "Oldest file in $zip_file: $oldest_file"
