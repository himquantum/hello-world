#!/bin/bash

# Define the log file path
LOG_FILE="/home/log/log.txt"

# Function to log messages with a timestamp
log_message() {
  local message="$1"
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $message" >> "$LOG_FILE"
}

# Create or clear the log file
> "$LOG_FILE"

# Prompt user for the parent directory path
read -p "Enter the parent directory path: " PARENT_DIR

# Check if the provided path is a directory
if [ ! -d "$PARENT_DIR" ]; then
  log_message "Error: The specified path is not a directory or does not exist: $PARENT_DIR"
  echo "Error: The specified path is not a directory or does not exist."
  exit 1
fi
log_message "Parent directory path: $PARENT_DIR"

# Prompt user for the directory identifier
read -p "Enter the directory identifier (e.g., dir1): " DIR_IDENTIFIER
log_message "Directory identifier: $DIR_IDENTIFIER"

# Change to the parent directory
cd "$PARENT_DIR" || {
  log_message "Failed to change directory to $PARENT_DIR"
  exit 1
}

# Find all directories matching the identifier
for DIR in $(find . -maxdepth 1 -type d -name "$DIR_IDENTIFIER*"); do
  ZIP_FILE="${DIR}.zip"
  
  # Create the zip file
  zip -r "$ZIP_FILE" "$DIR" >> "$LOG_FILE" 2>&1
  
  # Check if zip was successful
  if [ $? -eq 0 ]; then
    log_message "Successfully zipped $DIR to $ZIP_FILE"
    
    # Delete the original directory
    rm -rf "$DIR"
    
    # Check if the directory was successfully deleted
    if [ ! -d "$DIR" ]; then
      log_message "Successfully deleted $DIR"
    else
      log_message "Failed to delete $DIR"
    fi
  else
    log_message "Failed to zip $DIR"
  fi
done