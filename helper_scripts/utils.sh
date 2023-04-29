#!/bin/bash

function yninput {
  read -e -p "$(echo -e "$1")" input

  while [[ "$input" != "y" && "$input" != "n" ]]; do
    read -e -p "$(echo -e "${BRed}Invalid input. Please enter 'y' or 'n':${Color_Off} ")" input
  done

  if [ "$input" == "y" ]; then
    eval "$2=true"
  else
    eval "$2=false"
  fi
}
