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
version=$(git tag --points-at HEAD)+$(git rev-parse --short HEAD)
verbose=true

print_verbose() {
  if [ "$verbose" = true ]; then
    printf "%s\n" "$1"
  fi
}
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
  printf "$script_name: need --add, --remove, or --list\n\n" 1>&2
  print_usage_info 1>&2
  exit 1
fi

# Handle arguments
# --help
if [ "$1" = "--help" ]; then
  print_help;
elif [ "$1" = "--version" ]; then
  echo "$script_name"
  echo "Version: $version"
  exit 0
# --add
elif [ "$1" = "--add" ]; then
  # Verify proper argument length
  if [ $# -lt 3 ]; then
    printf "$script_name: --add needs <name> <path>\n\n" 1>&2
    print_usage_info 1>&2
    exit 1
  fi
  add_task
else
  echo ":3"
fi

