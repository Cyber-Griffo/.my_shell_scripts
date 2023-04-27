#!/bin/bash

# Check if the first parameter is provided
if [ -z "$1" ]; then
  echo "No parameters provided."
else
  # Change directory to the first parameter
  cd $1
fi

# Create an empty array to store file names
files=()

# Loop through each file in the current directory
while IFS= read -r -d '' file; do
  # Check if the file is executable
  if [[ -x "$file" ]]; then
    # Remove "./" from the file name
    file="${file#.\/}"
    # Replace spaces with colons in the file name
    file="${file// /:}"
    # Add the file name to the array
    files+=("$file")
  fi
done < <(find . -maxdepth 1 -type f -print0)

# Print the file names in alphabetical order
printf "%s\n" "${files[@]}" | sort
