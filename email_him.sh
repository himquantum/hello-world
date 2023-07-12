#!/bin/bash

# Read directory names and days from dir_days.csv
while IFS=, read -r directory days; do
  # Read email IDs from dir_email.cnf for the corresponding directory
  email_file="dir_email.cnf"
  email_ids=()
  while IFS= read -r line; do
    if [[ "$line" == \[$directory\]* ]]; then
      break
    fi
  done < "$email_file"
  
  while IFS= read -r line; do
    if [[ "$line" == \[* ]]; then
      break
    fi
    email_ids+=("$line")
  done < "$email_file"
  
  # Find files older than x days in the directory
  files=$(find "$directory" -type f -mtime +"$days")
echo $files
  # Email the directory owners with the list of files
  if [ ${#email_ids[@]} -gt 0 ] && [ -n "$files" ]; then
    echo "The following files in directory '$directory' are older than $days days:" > email_body.txt
    echo "$files" >> email_body.txt
    
    echo "Email IDs: ${email_ids[@]}"
    cat email_body.txt | mail -s "Files older than $days days in directory $directory" "${email_ids[@]}"
    
    if [ $? -eq 0 ]; then
      echo "Email sent successfully."
      cp email_body.txt "email_body_${directory}.txt"
    else
      echo "Failed to send email."
    fi
    
    #rm email_body.txt
  fi
done < dir_days.csv
