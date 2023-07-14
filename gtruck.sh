#!/bin/bash

# Specify the directories to check
target_dirs=("/abc/def/pqr/" "/abc/111/pqr/")

# Check if any of the target directories are present in the dustbin.txt file
if grep -E -q "${target_dirs[0]}|${target_dirs[1]}" "dustbin.txt"; then
    # Read the file line by line
    while IFS= read -r line
    do
        # Check if the line starts with any of the target directories
        if ! echo "$line" | grep -E -q "^${target_dirs[0]}|^${target_dirs[1]}"; then
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
    echo "No lines with the target directories found in dustbin.txt."
fi
