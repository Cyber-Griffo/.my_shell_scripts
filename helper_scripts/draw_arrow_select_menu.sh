#!/bin/bash

# Set up some terminal control functions
ESC=$(printf "\033")                                                             # ANSI escape code
cursor_blink_on() { printf "$ESC[?25h"; }                                        # Turn on cursor blinking
cursor_blink_off() { printf "$ESC[?25l"; }                                       # Turn off cursor blinking
cursor_to() { printf "$ESC[$1;${2:-1}H"; }                                       # Move the cursor to a specific position
print_option() { printf "$(tput setaf $1)   $2 $(tput sgr0)"; }                  # Print the option in the specified color
print_selected() { printf "$(tput setaf $1)  $ESC[7m $2 $ESC[27m$(tput sgr0)"; } # Print the selected option with inverted colors
get_cursor_row() {                                                               # Get the row of the cursor
  IFS=';' read -sdR -p $'\E[6n' ROW COL
  echo ${ROW#*[}
}
key_input() { # Read user input
  read -s -n3 key 2>/dev/null >&2
  if [[ $key = $ESC[A ]]; then echo up; fi   # Up arrow key
  if [[ $key = $ESC[B ]]; then echo down; fi # Down arrow key
  if [[ $key = "" ]]; then echo enter; fi    # Enter key
}

# Print some initial new lines
for opt; do printf "\n"; done

# Determine the starting row for displaying the options
lastrow=$(get_cursor_row)
startrow=$(($lastrow - $#))

# Set up a trap to handle ctrl+c during read -s
trap "cursor_blink_on; stty echo; printf '\n'; exit" 1
cursor_blink_off

# Set up variables for tracking the selected option and its color
selected=0
colors=($(seq 1 $(($# * 2))))

# Main loop
while true; do
  # Display the options
  idx=0
  for opt; do
    cursor_to $(($startrow + $idx))
    if [ $idx -eq $selected ]; then
      print_selected $((${colors[$idx]} % 8 + 1)) "$opt"
    else
      print_option $((${colors[$idx]} % 8 + 1)) "$opt"
    fi
    ((idx++))
  done

  # Handle user input
  case $(key_input) in
  enter) break ;; # Exit loop on enter key
  up)
    ((selected--))
    if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi # Wrap around to the end of the options
    ;;
  down)
    ((selected++))
    if [ $selected -ge $# ]; then selected=0; fi # Wrap around to the start of the options
    ;;
  esac
done

# cursor position back to normal
cursor_to $lastrow
printf "\n"
cursor_blink_on

# export the selected option
export SELECTED=$selected
