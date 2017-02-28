# Adapted from https://linuxmusicians.com/viewtopic.php?p=66884&sid=68abcc2e25e44f573ed2ddd6c9fc7969#p66884
# Note: This has not been tested with Qt5

EAPI=6

inherit git-r3

DESCRIPTION="Fully-featured audio plugin host, supports many audio drivers and plugin formats"
HOMEPAGE="http://kxstudio.linuxaudio.org/Applications:Carla"
EGIT_REPO_URI="https://github.com/falkTX/Carla.git"
LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="qt5 alsa -pulseaudio X osc sf2 gig sfz +rdf zlib gtk gtk2 -distrho-prom -zynaddsubfx -zynaddsubfx-ui +hylia"

RDEPEND="!qt5? ( dev-python/PyQt4[X,svg] )
	qt5? ( dev-python/PyQt5 )
	gtk? ( x11-libs/gtk+:3 )
	gtk2? ( x11-libs/gtk+:2 )
	media-sound/jack-audio-connection-kit
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	X? ( x11-base/xorg-server )
	osc? ( media-libs/liblo )
	sf2? ( media-sound/fluidsynth )
	gig? ( media-sound/linuxsampler )
	sfz? ( media-sound/linuxsampler )
	rdf? ( dev-python/rdflib )
	zlib? ( sys-libs/zlib )
	distrho-prom? ( virtual/opengl
		media-libs/libprojectm )
	zynaddsubfx? ( media-libs/liblo
		sci-libs/fftw:3.0
		dev-libs/mini-xml
		sys-libs/zlib )
	zynaddsubfx-ui? ( x11-libs/fltk )"
DEPEND=${RDEPEND}

src_compile() {
	myemakeargs=(
		USE_COLORS=false
		SKIP_STRIPPING=true
		EXPERIMENTAL_PLUGINS=false
		HAVE_GTK2=$(usex gtk2 true false)
		HAVE_GTK3=$(usex gtk true false)
		HAVE_ALSA=$(usex alsa true false)
		HAVE_X11=$(usex X true false)
		HAVE_PULSEAUDIO=$(usex pulseaudio true false)
		HAVE_LIBLO=$(usex osc true false)
		HAVE_FLUIDSYNTH=$(usex sf2 true false)
		HAVE_LINUXSAMPLER=$(usex gig true false)
		HAVE_LINUXSAMPLER=$(usex sfz true false)
		HAVE_DGL=$(usex distrho-prom true false)
		HAVE_PROJECTM=$(usex distrho-prom true false)
		HAVE_ZYN_DEPS=$(usex zynaddsubfx true false)
		HAVE_ZYN_UI_DEPS=$(usex zynaddsubfx-ui true false)
		HAVE_HYLIA=$(usex hylia true false)
	)

	make features PREFIX="/usr" "${myemakeargs[@]}"

	emake PREFIX="/usr" "${myemakeargs[@]}"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" "${myemakeargs[@]}" install
}
