#!/bin/bash

if [ -z "$*" ]; then # Check if no parameters are provided
  echo "No parameters provided."
else
  file=${1//:/ } # Replace any colon characters with spaces in the first parameter
  # (assuming it is a file name with spaces replaced with colons)

  printf "$file" # Print the updated file name
fi
