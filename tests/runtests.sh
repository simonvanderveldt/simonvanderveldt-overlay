#!/usr/bin/env sh
set -x

# First update portage and install dependencies
emerge-webrsync
emerge dev-vcs/git repoman

# Run the tests
repoman full
