EAPI=6

inherit git-r3

DESCRIPTION="Offers quick command-line access to files and directories, inspired by autojump, z and v"
HOMEPAGE="https://github.com/clvv/fasd"
EGIT_REPO_URI="git://github.com/clvv/fasd.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
