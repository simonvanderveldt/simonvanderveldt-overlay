EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit git-r3 distutils-r1 xdg-utils gnome2-utils

DESCRIPTION="GTK3 & python based GUI for Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-gtk"
EGIT_REPO_URI="https://github.com/syncthing/syncthing-gtk.git"
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"

IUSE="libnotify nautilus caja"

DEPEND=""
RDEPEND="
		${DEPEND}
		dev-python/bcrypt[${PYTHON_USEDEP}]
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		sys-process/psmisc
		x11-libs/gtk+:3
		>=net-p2p/syncthing-0.13
		libnotify? ( x11-libs/libnotify )
		nautilus? ( dev-python/nautilus-python[${PYTHON_USEDEP}] )
		caja? ( dev-python/python-caja[${PYTHON_USEDEP}] )"

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
