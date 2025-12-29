EAPI=8

inherit meson

DESCRIPTION="Minimal set of icons to serve as a base for other themes (such as Moka)"
HOMEPAGE="https://snwh.org/moka#faba-icon-theme"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/snwh/faba-icon-theme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/snwh/faba-icon-theme/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
RESTRICT="mirror"
