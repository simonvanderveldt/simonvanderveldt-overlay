# Adapted from https://linuxmusicians.com/viewtopic.php?p=66884&sid=68abcc2e25e44f573ed2ddd6c9fc7969#p66884
# Note: This has not been tested with Qt5

EAPI="5"

inherit git-r3

DESCRIPTION="Fully-featured audio plugin host, with support for many audio drivers and plugin formats."
HOMEPAGE="http://kxstudio.linuxaudio.org/Applications:Carla"
SRC_URI=""
EGIT_REPO_URI="https://github.com/falkTX/Carla.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="qt5 alsa jack -pulseaudio X magic osc sf2 gig sfz +rdf fftw mxml zlib ntk opengl projectm"

RDEPEND="!qt5? ( dev-python/PyQt4[X,svg] )
	qt5? ( dev-python/PyQt5 )
  alsa? ( media-libs/alsa-lib )
  jack? ( media-sound/jack-audio-connection-kit )
  pulseaudio? ( media-sound/pulseaudio )
  X? ( x11-base/xorg-server )
  magic? ( sys-libs/libmagic )
  osc? ( media-libs/liblo )
	sf2? ( media-sound/fluidsynth )
  gig? ( media-sound/linuxsampler )
  sfz? ( media-sound/linuxsampler )
  rdf? ( dev-python/rdflib )
  fftw? ( sci-libs/fftw:3.0 )
  mxml? ( dev-libs/mini-xml )
  zlib? ( sys-libs/zlib )
  ntk? ( x11-libs/ntk )
  opengl? ( virtual/opengl )
  projectm? ( media-libs/libprojectm )"
DEPEND=${RDEPEND}

src_compile() {
   emake PREFIX="/usr"
}

src_install() {
   emake PREFIX="/usr" DESTDIR="${D}" install
}
