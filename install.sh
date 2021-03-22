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

# TODOS
# 1. Write function to verify Flurly payment
# 1. Write function to download course files
# 1. Add --dry-run option
# 1. Write documentation
# 1. Deploy script
# 1. Test it out
# 1. Add page to website
# 1. Plan next step (making actual tutorial/course)

function verify_purchase {
  echo "Running verify purchase"
  ## TODO
  # 1. argumentize the function. first arg should be the paymentId
  # 2. Remove hardcoded RESPONSE
  # Note: fo now, I've hard-coded the response.
  # RESPONSE=$(curl --silent https://flurly.com/api/verify_redirect/cs_live_a1VHFUz7lYnXOL3PUus13VbktedDQDubwfew8E70EvnS1BTOfNTSUXqO0i)
  RESPONSE='{"payment_status":"paid"}'
  # credit for helping me figured this grep string thing out
  # https://linuxize.com/post/how-to-check-if-string-contains-substring-in-bash/
  echo "$RESPONSE"
  if grep -q "paid" <<< "$RESPONSE"; then
   echo "This person has paid"
  fi

}

verify_purchase
