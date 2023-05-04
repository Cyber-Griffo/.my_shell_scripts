#!/bin/bash

# Check if there are no parameters provided
if [ -z "$*" ]; then
  echo "No parameters provided."
else
  underscored_files=()

  # Loop through each parameter provided
  for file in "$@"; do
    # Replace all occurrences of ":" with "_"
    file="${file//:/_}"
    file="${file//.sh/}"
    underscored_files+=("$file")
  done

  # Print the updated parameter values
  printf '%s\n' "${underscored_files[@]}"
fi
