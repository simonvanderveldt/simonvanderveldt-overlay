#!/usr/bin/env sh
set -x

# Disable news messages from portage and disable rsync's output
export FEATURES="-news" PORTAGE_RSYNC_EXTRA_OPTS="-q"

# Update the portage tree and install dependencies
emerge --sync
emerge -q --buildpkg --usepkg dev-vcs/git dev-python/lxml
# Install fork or repoman with failing tests that are irrelevant for overlays stripped out
ebuild tests/app-portage/repoman/repoman-2.3.1.ebuild manifest clean merge  > /dev/null

# Run the tests
repoman full --xmlparse
