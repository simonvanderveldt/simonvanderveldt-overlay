# Adapted from https://linuxmusicians.com/viewtopic.php?p=66866#p66866
EAPI=6

inherit git-r3

DESCRIPTION="Collection of tools useful for audio production"
HOMEPAGE="http://kxstudio.linuxaudio.org/"
EGIT_REPO_URI="https://github.com/falkTX/Cadence.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="-pulseaudio a2jmidid"

RDEPEND="=media-sound/jack-audio-connection-kit-1.9.10
	dev-python/PyQt4
	dev-python/dbus-python
	>=media-sound/ladish-9999
	a2jmidid? ( media-sound/a2jmidid )
	pulseaudio? ( media-sound/pulseaudio[jack] )"
DEPEND=${RDEPEND}

src_compile() {
	emake PREFIX="/usr"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
