#!/bin/bash

# Specify the directory to check
target_dir="/abc/def/pqr/"

# Check if the target directory is present in the dustbin.txt file
if grep -q "$target_dir" "dustbin.txt"; then
    # Read the file line by line
    while IFS= read -r line
    do
        # Check if the line starts with the target directory
        if ! echo "$line" | grep -q "^$target_dir"; then
            echo "Permission denied."
            exit 1
        fi

        # Check if the path exists
        if [ -e "$line" ]; then
            # Check if the path is a directory
            if [ -d "$line" ]; then
                # Delete files within the directory, excluding subdirectories, and count the number of files deleted
                deleted_files=$(find "$line" -type f -delete -print | wc -l)
                echo "Deleted $deleted_files files within directory: $line"
            elif [ -f "$line" ]; then
                # Delete the file
                rm "$line"
                echo "Deleted file: $line"
            fi
        fi
    done < "dustbin.txt"
else
    echo "No lines with \"$target_dir\" found in dustbin.txt."
fi
