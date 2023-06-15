#!/usr/bin/bash

# Function to extract a zip file into its own folder
extract_zip() {
    local file="$1"
    local dir="${file%.zip}"

    # Create the directory if it doesn't exist
    mkdir -p "$dir"

    # Extract the zip file into the directory
    unzip -d "$dir" "$file"

    # Call recursive_extract function for the extracted directory
    recursive_extract "$dir"
}

# Function to recursively extract zip files in a directory
recursive_extract() {
    local dir="$1"

    # Loop through all files in the directory
    for file in "$dir"/*; do
        if [[ -d "$file" ]]; then
            # If the file is a directory, recursively call the function
            recursive_extract "$file"
        elif [[ -f "$file" && "$file" == *.zip ]]; then
            # If the file is a zip file, extract it into its own folder
            extract_zip "$file"
        fi
    done
}

# Function to remove all directories in a given directory
remove_directories() {
    local dir="$1"

    # Loop through all directories in the directory
    for folder in "$dir"/*/; do
        # Check if the folder exists and is not a symbolic link
        if [[ -d "$folder" && ! -L "$folder" ]]; then
            # Delete the folder and its contents recursively
            rm -r "$folder"
        fi
    done
}

# Function to lowercase all files in a given directory
lowercase_files() {
    local dir="$1"

    # Loop through all files in the directory
    for file in "$dir"/*; do
        # Check if the file exists and is not a directory
        if [[ -f "$file" && "$file" != "${file,,}" ]]; then
            # Convert the filename to lowercase
            lowercase_name="${file,,}"

            # Rename the file
            mv "$file" "$lowercase_name"
        fi
    done
}

# Main script

# Check if the directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: bash script.sh <directory>"
    exit 1
fi

# Navigate to the directory
mkdir -p eureka_zip
cd "$1" || exit

# Remove all directories in the specified directory
remove_directories "."

# Lowercase all files in the specified directory
lowercase_files "."

# Call the recursive_extract function with the specified directory
recursive_extract "."
