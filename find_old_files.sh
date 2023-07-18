#!/bin/bash

csv_file="directory_list.csv"

# Read the CSV file
while IFS=, read -r directory_path days_threshold; do
if [ -d "$directory_path" ]; then

    # Result file name
    directory_name=$(basename "$directory_path")
    result_file="${directory_name}.txt"

    # Find files older than the given threshold in the directory
      find "$directory_path" -type f -mtime +"$days_threshold" -printf "%p\t%Tc\t%t\n" > "$result_file"
    # find "$directory_path" -type f -mtime +"$days_threshold" -exec stat --printf="%n\t%y\t%z\n" {} + > "$result_file"
    # find "$directory_path" -type f -mtime +5 exec ls -l --time-style="+%Y-%m-%d %H:%M:%S" {} \; | awk '{print $9 "\t" $6 " " $7 "\t" $8}' 

    echo "Result file created: $result_file"
  else
    echo "Invalid directory name: $directory_path"
  fi
done < "$csv_file"


