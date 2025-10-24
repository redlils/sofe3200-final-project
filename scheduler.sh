#! /bin/bash

# Implement task scheduling system
# Most likely use cron

# Usage:
# scheduler
#   --add name path
#     Adds a new scheduled task with the given name
#   --remove name
#     Removes a scheduled task with the given name
#   --list
#     Lists all scheduled tasks with their names and programs

# Globals
script_name=$(basename $0) # Use basename for if this script is being read through a symlink

# Functions
print_help() {
  printf "Usage: $script_name [COMMAND]

Commands:
  --add <name> <path>   add a new scheduled task
  --remove <name>       remove <name> task
  --list                list all scheduled tasks
  --help                show this help message
  --version             show the version\n" 
}

print_usage_info() {
  printf "Use $script_name --help for program usage information\n"
}

# Command handlers
add_task() {
  # handle adding task
  echo ":3"
}

if [ $# -eq 0 ]; then
  printf "$script_name: need --add, --remove, or --list\n\n"
  print_usage_info 
  exit 2
fi

# Handle arguments
# --help
if [ "$1" = "--help" ]; then
  print_help;
# --add
elif [ "$1" = "--add" ]; then
  # Verify proper argument length
  if [ $# -lt 3 ]; then
    printf "$script_name: --add needs <name> <path>\n\n"
    print_usage_info 
  fi
  add_task
else
  
fi

