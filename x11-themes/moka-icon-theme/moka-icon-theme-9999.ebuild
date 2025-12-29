EAPI=8

inherit meson

DESCRIPTION="A stylized icon set created with simplicity in mind"
HOMEPAGE="https://snwh.org/moka"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/snwh/moka-icon-theme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/snwh/moka-icon-theme/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
RESTRICT="mirror"

DEPEND="x11-themes/faba-icon-theme"
RDEPEND="${DEPEND}"
