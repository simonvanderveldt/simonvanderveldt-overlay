#!/usr/bin/env sh
set -x

# Ensure we run as root
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@"
fi

# Get this scripts directory
SCRIPT=$(readlink -f "${0}")
BASEDIR=$(dirname "${SCRIPT}")
echo "$BASEDIR"

# Add symlink to this directroy in overlays directory
ln -s "${BASEDIR}" /usr/local/portage/simonvanderveldt
