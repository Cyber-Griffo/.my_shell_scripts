#!/bin/bash

currentDirectory="$1"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
projecttype=$(basename $0)
projecttype=${projecttype//.sh/}
DIR=$DIR/../"${projecttype// /_}_setup_scripts"
set keyseq-timeout 0

# read -e -p "Enter your desired projectname (leave empty for the default): " projectname

if [ -z "$projectname" ]; then
    projectname="my-app"
fi

# Find all executable files in the project_types directory and sort them alphabetically
sortedfiles=($(find_executable_files_in_dir.sh $DIR))

# Generate underscored text for the filenames in sortedfiles
underscorefiles=($(generate_disyplay_text.sh "${sortedfiles[@]}"))

# Display a menu of the underscored filenames and allow the user to select one
echo "Select what kind of project you want to initialize using up/down keys and enter to confirm:"
echo
source draw_arrow_select_menu.sh "${underscorefiles[@]}"
choice=$selected
clear

# Generate spaced text for the selected filename and execute it
chosenfile="$(generate_spaced_text.sh "${sortedfiles[$choice]}")"
$DIR/"$chosenfile" $currentDirectory
wait
