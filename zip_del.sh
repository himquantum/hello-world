#!/bin/bash

# Check if the directory identifier is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_identifier>"
  exit 1
fi

# Directory identifier (e.g., dir1)
DIR_IDENTIFIER=$1

# Find all directories matching the identifier
for DIR in $(find . -type d -name "$DIR_IDENTIFIER*"); do
  ZIP_FILE="${DIR}.zip"
  
  # Create the zip file
  zip -r "$ZIP_FILE" "$DIR"
  
  # Check if zip was successful
  if [ $? -eq 0 ]; then
    echo "Successfully zipped $DIR to $ZIP_FILE"
    
    # Delete the original directory
    rm -rf "$DIR"
    
    # Check if the directory was successfully deleted
    if [ ! -d "$DIR" ]; then
      echo "Successfully deleted $DIR"
    else
      echo "Failed to delete $DIR"
    fi
  else
    echo "Failed to zip $DIR"
  fi
done