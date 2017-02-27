EAPI=6

inherit git-r3 eutils

DESCRIPTION="A significant reboot of Seq24, with additional features and bug fixes"
HOMEPAGE="https://github.com/ahlstromcj/sequencer64"
EGIT_REPO_URI="https://github.com/ahlstromcj/sequencer64.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="jack jack-session lash"

RDEPEND=">=dev-cpp/gtkmm-2.4:2.4
	>=dev-libs/libsigc++-2.2:2
  media-libs/libpng
	jack? ( media-sound/jack-audio-connection-kit )
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
    $(use_enable jack-session)
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
