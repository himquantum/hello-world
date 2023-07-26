#!/bin/bash

# Set the directory path where you want to search for files
directory="/path/to/your/directory"

# Set the output zip file name
output_zip="older_than_180_days.zip"

# Set the log file path
log_file="zip_log.txt"

# Get the size of files before zip
size_before=$(du -sh "$directory" | cut -f1)

# Find files older than 180 days and zip them
find "$directory" -type f -mtime +180 -exec zip "$output_zip" {} + >> "$log_file" 2>&1

# Check if the zip command executed successfully
if [ $? -eq 0 ]; then
  # Get the size of files after zip
  size_after=$(du -sh "$output_zip" | cut -f1)

  # Calculate the storage space released
  released_space=$(( $(du -b "$directory" | awk '{sum+=$1} END{print sum}') - $(du -b "$output_zip" | awk '{sum+=$1} END{print sum}') ))
  
  echo "Files older than 180 days have been zipped successfully." >> "$log_file"
  echo "Storage space released after zip: $released_space bytes" >> "$log_file"
  echo "Size before zip: $size_before" >> "$log_file"
  echo "Size after zip: $size_after" >> "$log_file"
else
  echo "Error occurred while zipping files." >> "$log_file"
fi
