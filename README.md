# simonvanderveldt-overlay [![Build Status](https://travis-ci.org/simonvanderveldt/simonvanderveldt-overlay.svg?branch=master)](https://travis-ci.org/simonvanderveldt/simonvanderveldt-overlay)

Overlay with applications that aren't available upstream or in other overlays.
The music/pro-audio packages have all been moved to the [audio-overlay](https://github.com/gentoo-audio/audio-overlay).

## How to use this overlay
- Add an entry to [`/etc/portage/repos.conf`](https://wiki.gentoo.org/wiki//etc/portage/repos.conf):
```ini
[simonvanderveldt]
# Use the location where you store your overlays
location = /usr/local/overlay/simonvanderveldt
sync-type = git
sync-uri = https://github.com/simonvanderveldt/simonvanderveldt-overlay.git
auto-sync = yes
```
- Sync
```sh
emerge --sync
```
- You're all set. Go and install a package :)

### Problems?
If you run into problems please [create an issue](https://github.com/simonvanderveldt/simonvanderveldt-overlay/issues/new) or send a pull request if you already know how to fix it :)

## Automated quality control
- GitHub's [branch protection](https://help.github.com/articles/about-protected-branches/) is enabled for the `master` branch
- Changes can only be done using [pull requests](https://help.github.com/articles/about-pull-requests/)
- Pull requests can only be merged if they pass the automated tests, which are run by [Travis CI](https://travis-ci.org)
- [Travis CI](https://travis-ci.org) also runs daily checks if a new version of one of the packages in this overlay is released. If so, an issue requesting a version bump will be created

## Automated tests
The following tests are run for every pull request:
- [repoman](https://wiki.gentoo.org/wiki/Repoman) checks:
 - `full` to check if the overlay and ebuilds are correct
 - `--xmlparse` to check if the `metadata.xml` files are correct
