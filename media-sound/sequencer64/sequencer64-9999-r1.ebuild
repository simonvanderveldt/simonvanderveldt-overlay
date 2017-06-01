EAPI=6

inherit eutils

DESCRIPTION="A significant reboot of Seq24, with additional features and bug fixes"
HOMEPAGE="https://github.com/ahlstromcj/sequencer64"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ahlstromcj/sequencer64.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ahlstromcj/sequencer64/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

IUSE="jack jacksession lash"

REQUIRED_USE="jacksession? ( jack )"

RDEPEND=">=dev-cpp/gtkmm-2.4:2.4
	>=dev-libs/libsigc++-2.2:2
	media-libs/libpng:=
	jack? ( virtual/jack )
	lash? ( media-sound/lash )"

DEPEND="${RDEPEND}"

src_prepare()
{
	default
	./bootstrap
}

src_configure()
{
	local -a myeconfargs=(
		$(use_enable jack)
		$(use_enable jacksession jack-session)
		$(use_enable lash)
	)
	econf "${myeconfargs[@]}"
}

src_install()
{
	emake DESTDIR="${D}" install

	newicon resources/pixmaps/seq64.xpm sequencer64.xpm
	make_desktop_entry sequencer64
}
