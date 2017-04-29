EAPI=6

inherit git-r3 eutils

DESCRIPTION="Simple single-osc synth based on the 303. DISTRHO port to LV2 and VST of nekobee"
HOMEPAGE="http://distrho.sourceforge.net/ports"
EGIT_REPO_URI="https://github.com/simonvanderveldt/Nekobi.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="X dssi +lv2 vst standalone"

REQUIRED_USE="|| ( dssi lv2 vst standalone )"

X_DEPEND="( media-libs/mesa
	x11-libs/libX11 )"

RDEPEND="standalone? ( ${X_DEPEND}
		virtual/jack )
	dssi? ( X? ( ${X_DEPEND}
		media-libs/liblo ) )"

DEPEND="${RDEPEND}"

src_compile() {
	myemakeargs=(
		SKIP_STRIPPING=true
		HAVE_DGL=$(usex X true $(usex standalone true false))
		HAVE_JACK=$(usex standalone true false)
		HAVE_LIBLO=$(usex dssi $(usex X true false) false)
		BUILD_DSSI=$(usex dssi true false)
		BUILD_LV2=$(usex lv2 true false)
		BUILD_VST=$(usex vst true false)
	)

	emake "${myemakeargs[@]}"
}

src_install() {
	if use standalone; then
		dobin bin/Nekobi
		newicon plugins/Nekobi/artwork/tail.png ${PN}.png
		make_desktop_entry Nekobi Nekobi ${PN} "AudioVideo;AudioVideoEditing"
	fi
	if use dssi; then
		insopts -m0755
		insinto /usr/$(get_libdir)/dssi
		doins bin/Nekobi-dssi.so
		if use X; then
			doins -r bin/Nekobi-dssi
		fi
	fi
	if use lv2; then
		insopts -m0755
		insinto /usr/$(get_libdir)/lv2
		doins -r bin/Nekobi.lv2
	fi
	if use vst; then
		insopts -m0755
		insinto /usr/$(get_libdir)/vst
		doins bin/Nekobi-vst.so
	fi
}
