#!/bin/sh

# Credit to this Stack Exchange answer for explaining this:
# https://unix.stackexchange.com/a/343974/363304
SUCCESS_CHECKMARK=$(printf '\342\234\224\n' | iconv -f UTF-8)
CROSS_MARK=$(printf '\342\235\214\n' | iconv -f UTF-8)
ZIP="fake-course.zip"
DOWNLOADED_NAME="download.zip"
# learned the cut trick from here: https://stackoverflow.com/q/965053/3015595
FOLDER_NAME=$(echo "$ZIP" | cut -d'.' -f1)
# intialize as false
DRY_RUN=1
PAYMENT_ID=""
CMD=""

# set stands for setting options for the script
# -e means exit if something returns a non-zero status
# -u treat unset variables and params as errors and exit
# To learn more about `set -eu` read these:
# https://explainshell.com/explain?cmd=set+-eu
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -eu

# Testing this script
# sh install.sh --payment-id cs_live_a1VHFUz7lYnXOL3PUus13VbktedDQDubwfew8E70EvnS1BTOfNTSUXqO0i

# TODOS
# 1. Write documentation
# 1. Refactor everything (like Tad suggested)
# 1. Deploy script
# 1. Test it out
# 1. Add page to website
# 1. Plan next step (making actual tutorial/course)

main() {
  # credit to https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
  PARAMS=""
  while (( "$#" )); do
    case "$1" in
      -d|--dry-run)
        DRY_RUN=0
        shift
        ;;
      -i|--payment-id)
        if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
          PAYMENT_ID=$2
          shift 2
        else
          echo "Error: Argument for $1 is missing" >&2
          exit 1
        fi
        ;;
      -*|--*=) # unsupported flags
        echo "Error: Unsupported flag $1" >&2
        exit 1
        ;;
      *) # preserve positional arguments
        PARAMS="$PARAMS \$1\""
        shift
        ;;
    esac
  done
  # set positional arguments in their proper place
  eval set -- "$PARAMS"
  # source: https://unix.stackexchange.com/a/433806/363304
  if [ "$DRY_RUN" -eq 0 ]; then
    echo "Performing a dry run..."
    CMD=echo
  else
    echo "Running installation..."
    CMD=''
  fi

  $CMD verify_purchase "$PAYMENT_ID"
  $CMD download_zip
  $CMD unzip_course "$DOWNLOADED_NAME"
}


 verify_purchase() {
  # Learned this trick from here:
  # https://coderwall.com/p/s8n9qa/default-parameter-value-in-bash
  local payment_id="${1:-}"
  if [ -z "$payment_id" ]; then
    echo "$CROSS_MARK ERROR: payment_id is required"
    echo "   Please run the install script again"
    exit 1
  fi

  RESPONSE=$(curl --silent https://flurly.com/api/verify_redirect/"$payment_id")
  # credit for helping me figured this grep string thing out
  # https://linuxize.com/post/how-to-check-if-string-contains-substring-in-bash/
  if printf '%s' "$RESPONSE" | grep -q "paid" ; then
    echo "$SUCCESS_CHECKMARK Verified purchase"
  else
    echo "$CROSS_MARK ERROR: could not verify purchase"
    echo "   Please contact joe at joe previte [dot com]"
    exit 1
  fi

}

download_zip() {
  # Note: for now, I'll just download it from this open source GitHub repo
  # But eventually, I may want to run a cURL to an endpoint
  # which then verifies the purchase again and it it's legit, downloads the course

  if [ -f "$DOWNLOADED_NAME" ]
  then
    echo "$SUCCESS_CHECKMARK Course zip already downloaded (skipping download)"
  else
    echo "Downloading zip..."
    curl --silent "https://raw.githubusercontent.com/jsjoeio/install-scripts/main/$ZIP" -L -o "$DOWNLOADED_NAME"
    if [ -f "$DOWNLOADED_NAME" ]
    then
      echo "$SUCCESS_CHECKMARK Succesfully downloaded course zip"
    else
      echo "$CROSS_MARK ERROR: Failed to download course zip"
      echo "   Please run the install script again"
      exit 1
    fi
  fi
}

unzip_course() {
  # Don't forget the - before the word
  # Otherwise shellcheck things you're indexing the string
  local DOWNLOADED_ZIP_NAME="${1:-download.zip}"

  # Check that the directory exists
  if [ -d "$FOLDER_NAME" ]
  then
    echo "$SUCCESS_CHECKMARK Course already unzipped (skipping unzip)"
  else
    # TODO add log level info
    # echo "Unzipping course..."
    unzip -qq -n "$DOWNLOADED_ZIP_NAME"
    if [ -d "$FOLDER_NAME" ]
    then
      echo "$SUCCESS_CHECKMARK Course unzipped successfully"
    else
      echo "$CROSS_MARK ERROR: Failed to unzip course"
      echo "   Please run the install script again"
      exit 1
    fi
  fi
}

main "$@"
