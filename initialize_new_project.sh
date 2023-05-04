#!/bin/bash

# Add helper_scripts directory to PATH
currentDirectory="$(pwd)"
PATH=$PATH:$(dirname $0)/helper_scripts

# Get the absolute path of the project_types directory
TOPDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DIR="${TOPDIR}/project_types"

# Clear the screen
clear

# Find all executable files in the project_types directory and sort them alphabetically
sortedfiles=($(find_executable_files_in_dir.sh $DIR))

# Generate underscored text for the filenames in sortedfiles
underscorefiles=($(generate_disyplay_text.sh "${sortedfiles[@]}"))

# Display a menu of the underscored filenames and allow the user to select one
echo "Select what kind of project you want to initialize using up/down keys and enter to confirm:"
echo
source draw_arrow_select_menu.sh "${underscorefiles[@]}"
choice=$SELECTED
clear

# Generate spaced text for the selected filename and execute it
chosenfile="$(generate_spaced_text.sh "${sortedfiles[$choice]}")"
$DIR/"$chosenfile" $currentDirectory
