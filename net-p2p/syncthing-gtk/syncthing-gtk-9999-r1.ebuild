# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 xdg-utils

DESCRIPTION="GTK3 & python based GUI for Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-gtk"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/syncthing/syncthing-gtk.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/syncthing/syncthing-gtk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-2"
SLOT="0"

IUSE="libnotify nautilus"

DEPEND=""
RDEPEND="
		${DEPEND}
		$(python_gen_cond_dep 'dev-python/bcrypt[${PYTHON_MULTI_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/pygobject[cairo,${PYTHON_MULTI_USEDEP}]')
		$(python_gen_cond_dep 'dev-python/python-dateutil[${PYTHON_MULTI_USEDEP}]')
		sys-process/psmisc
		x11-libs/gtk+:3
		>=net-p2p/syncthing-0.13
		libnotify? ( x11-libs/libnotify )
		nautilus? ( dev-python/nautilus-python[${PYTHON_SINGLE_USEDEP}] )
"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
