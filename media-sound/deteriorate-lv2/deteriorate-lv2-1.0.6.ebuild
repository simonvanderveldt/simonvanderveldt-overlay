EAPI=6

# required by waf
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit git-r3 python-any-r1 waf-utils

DESCRIPTION="A set of plugins to deteriorate the sound quality"
HOMEPAGE="https://objectivewave.wordpress.com/deteriorate-lv2/"
EGIT_REPO_URI="https://github.com/blablack/deteriorate-lv2.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-cpp/gtkmm:2.4
	x11-libs/gtk+:2
	x11-libs/cairo
	media-libs/lv2
	media-libs/lvtk[gtk2]"

DEPEND="${RDEPEND}"
