EAPI=6

inherit git-r3 eutils

DESCRIPTION="DISTRHO port of MVerb, a studio quality open-source reverb"
HOMEPAGE="http://distrho.sourceforge.net/ports"
EGIT_REPO_URI="https://github.com/simonvanderveldt/MVerb.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

IUSE="+X dssi ladspa +lv2 vst standalone"

REQUIRED_USE="|| ( dssi ladspa lv2 vst standalone )"

X_DEPEND="( media-libs/mesa
	x11-libs/libX11 )"

RDEPEND="X? ( ${X_DEPEND} )
	standalone? ( ${X_DEPEND}
		virtual/jack )
	dssi? ( X? ( media-libs/liblo ) )"

DEPEND="${RDEPEND}"

src_compile() {
	myemakeargs=(
		SKIP_STRIPPING=true
		HAVE_DGL=$(usex X true $(usex standalone true false))
		HAVE_JACK=$(usex standalone true false)
		HAVE_LIBLO=$(usex dssi $(usex X true false) false)
		BUILD_DSSI=$(usex dssi true false)
		BUILD_LADSPA=$(usex ladspa true false)
		BUILD_LV2=$(usex lv2 true false)
		BUILD_VST=$(usex vst true false)
	)

	emake "${myemakeargs[@]}"
}

src_install() {
	if use standalone; then
		dobin bin/MVerb
		make_desktop_entry MVerb MVerb ${PN} "AudioVideo;AudioVideoEditing"
	fi
	if use dssi; then
		insopts -m0755
		insinto /usr/$(get_libdir)/dssi
		doins bin/MVerb-dssi.so
		if use X; then
			doins -r bin/MVerb-dssi
		fi
	fi
	if use ladspa; then
		insopts -m0755
		insinto /usr/$(get_libdir)/ladspa
		doins bin/MVerb-ladspa.so
	fi
	if use lv2; then
		insopts -m0755
		insinto /usr/$(get_libdir)/lv2
		doins -r bin/MVerb.lv2
	fi
	if use vst; then
		insopts -m0755
		insinto /usr/$(get_libdir)/vst
		doins bin/MVerb-vst.so
	fi
}
