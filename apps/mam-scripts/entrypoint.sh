#!/usr/bin/env bash
#shellcheck disable=SC2086

if [ -z "${SCRIPT_NAME}" ]; then
  echo "Error: SCRIPT_NAME not set."
  echo "Please set the SCRIPT_NAME environment variable to the script you wish to run, for example:"
  echo "  SCRIPT_NAME='seedbox-api.sh'"
  exit 1
fi

exec /bin/bash /app/"${SCRIPT_NAME}" "$@"
