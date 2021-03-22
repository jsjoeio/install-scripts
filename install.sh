#!/bin/sh

# Credit to this Stack Exchange answer for explaining this:
# https://unix.stackexchange.com/a/343974/363304
SUCCESS_CHECKMARK=$(printf '\342\234\224\n' | iconv -f UTF-8)
CROSS_MARK=$(printf '\342\235\214\n' | iconv -f UTF-8)
# dry_run=false

# set stands for setting options for the script
# -e means exit if something returns a non-zero status
# -u treat unset variables and params as errors and exit
# To learn more about `set -eu` read these:
# https://explainshell.com/explain?cmd=set+-eu
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -eu

# source: https://unix.stackexchange.com/a/433806/363304
# if "$dry_run"; then
#   echo "Performing a dry run..."
#   cmd=echo
# else
#   echo "Running installation..."
#   cmd=''
# fi

# TODOS
# 1. Write function to download course files
# 1. Add --dry-run option
# 1. Add loading spinner: https://stackoverflow.com/questions/12498304/using-bash-to-display-a-progress-indicator
# 1. Write documentation
# 1. Deploy script
# 1. Test it out
# 1. Add page to website
# 1. Plan next step (making actual tutorial/course)

 verify_purchase() {
  # Learned this trick from here:
  # https://coderwall.com/p/s8n9qa/default-parameter-value-in-bash
  # local payment_id="$1"
  local payment_id="${1:-}"
  if [ -z "$payment_id" ]; then
    echo "$CROSS_MARK ERROR: payment_id is required"
    echo "   Please run the script again"
  fi

  RESPONSE=$(curl --silent https://flurly.com/api/verify_redirect/"$payment_id")
  # credit for helping me figured this grep string thing out
  # https://linuxize.com/post/how-to-check-if-string-contains-substring-in-bash/
  # echo "$RESPONSE"
  if printf '%s' "$RESPONSE" | grep -q "paid" ; then
    echo "$SUCCESS_CHECKMARK Verified purchase"
  fi

}

verify_purchase cs_live_a1VHFUz7lYnXOL3PUus13VbktedDQDubwfew8E70EvnS1BTOfNTSUXqO0i
