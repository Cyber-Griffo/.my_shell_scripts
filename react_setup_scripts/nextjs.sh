#!/bin/bash

currDir=$(pwd)

helperDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/../helper_scripts"

cd $helperDir

source colors.sh
# Source the utils.sh file
source utils.sh

cd $currDir

pname="my_next_app"

if [ -e "$pname" ]; then
  i=1
  while [ -e "${pname}_$i" ]; do
    i=$((i + 1))
  done
  pname="${pname}_$i"
fi

read -e -p "$(echo -e "Enter your desired ${BYellow}projectname${Color_Off} (default: ${Cyan}$pname${Color_Off}): ")" user_pname
echo -e "${UPurple}loading...${Color_Off}"

if
  [ -n "$user_pname" ]
then
  pname="$user_pname"
fi

npx create-next-app "$pname"
wait

clear

yninput "Do you want to ${BYellow}add custom folderstructure?${Color_Off} (${Cyan}Y/n${Color_Off}): " addfolderstructure

if [ $addfolderstructure = true ]; then
  yninput " - Do you want to ${BYellow}add the atomic component design?${Color_Off} (${Cyan}Y/n${Color_Off}): " addatomiccomponentdesign
fi

yninput "Do you want to ${BYellow}add custom eslint rules?${Color_Off} (${Cyan}Y/n${Color_Off}): " addeslint
yninput "Do you want to ${BYellow}add custom prettier rules?${Color_Off} (${Cyan}Y/n${Color_Off}): " addprettier
yninput "Do you want to ${BYellow}add testing?${Color_Off} (${Cyan}Y/n${Color_Off}): " addtesting
yninput "Do you want to ${BYellow}add absolut paths?${Color_Off} (${Cyan}Y/n${Color_Off}): " addabsolutpaths

cd $pname

custom_folders=("constants" "helpers" "hooks" "styles" "utils")
comp_folders=("atoms" "molecules" "organisms" "templates" "pages")
keep_file=".gitkeep"

if [ $addfolderstructure = true ]; then
  fodlerstructureancor="."
  if [ -d "$fodlerstructureancor/src" ]; then
    fodlerstructureancor="$fodlerstructureancor/src"
    echo "Adding folders & .gitkeep files to the projects src folder ${fodlerstructureancor}..."
    for folder in "${custom_folders[@]}"; do
      mkdir -p "$fodlerstructureancor/$folder"
      touch "$fodlerstructureancor/$folder/$keep_file"
    done
  else
    echo "Adding folders & .gitkeep files to the projects root folder ${fodlerstructureancor}..."
    for folder in "${custom_folders[@]}"; do
      mkdir -p "$fodlerstructureancor/$folder"
      touch "$fodlerstructureancor/$folder/$keep_file"
    done
  fi
  if [ $addatomiccomponentdesign = true ]; then
    echo "Adding folders & .gitkeep files to the projects components folder ${fodlerstructureancor}/components..."
    for folder in "${comp_folders[@]}"; do
      mkdir -p "$fodlerstructureancor/components/$folder"
      touch "$fodlerstructureancor/components/$folder/$keep_file"
    done
  else
    mkdir -p "$fodlerstructureancor/components"
    touch "$fodlerstructureancor/components/$keep_file"
  fi
fi
