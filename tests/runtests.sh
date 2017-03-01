#!/usr/bin/env sh
set -x

# Update the portage tree and install dependencies
PORTAGE_RSYNC_EXTRA_OPTS="-q" emerge --sync
emerge -q --buildpkg --usepkg dev-vcs/git repoman

# Run the tests
repoman full
