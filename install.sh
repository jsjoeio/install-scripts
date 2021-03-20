#!/bin/sh

dry_run=false

# set stands for setting options for the script
# -e means exit if something returns a non-zero status
# -u treat unset variables and params as errors and exit
# To learn more about `set -eu` read these:
# https://explainshell.com/explain?cmd=set+-eu
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -eu

# source: https://unix.stackexchange.com/a/433806/363304
if "$dry_run"; then
  echo "Performing a dry run..."
  cmd=echo
else
  echo "Running installation..."
  cmd=''
fi


