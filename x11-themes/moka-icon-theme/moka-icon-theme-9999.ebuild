EAPI=8

inherit meson xdg

DESCRIPTION="A stylized icon set created with simplicity in mind"
HOMEPAGE="https://github.com/UbuntuBudgie/moka-icon-theme"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/UbuntuBudgie/moka-icon-theme.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/UbuntuBudgie/moka-icon-theme/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"
RESTRICT="mirror"

DEPEND="x11-themes/faba-icon-theme"
RDEPEND="${DEPEND}"
