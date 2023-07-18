#!/bin/bash

# Path to the config file
config_file="email_list"

# Company name passed as an argument
company_name="$1"

# Variable to track if the desired company is found
found_company=false

# Read the config file line by line
while IFS= read -r line; do
  # Check if the line starts with '[', indicating a company name
  if [[ $line == [* ]]; then
    # Extract the company name by removing the brackets and leading/trailing whitespace
    current_company=$(echo "$line" | sed 's/[][]//g' | awk '{$1=$1};1')

    # Check if the current company matches the provided company name
    if [[ "$current_company" == "$company_name" ]]; then
      # Found a match, set the flag and continue to the next line
      found_company=true
      continue
    else
      # Did not find a match, unset the flag
      found_company=false
    fi
  fi

  # Print the email IDs for the desired company
  if [[ $found_company == true ]]; then
    # Skip empty lines
    if [[ -n "$line" ]]; then
      # Print the email ID without any modifications
      echo -n "$line "
    fi
  fi
done < "$config_file"
