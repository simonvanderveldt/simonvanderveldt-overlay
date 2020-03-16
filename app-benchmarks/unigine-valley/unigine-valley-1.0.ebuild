# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on https://github.com/ennui93/ennui/blob/675481c5920e4dd8670a416c14870f9467ff9f37/app-benchmarks/valley/valley-1.0-r1.ebuild

EAPI=7

inherit unpacker eutils desktop xdg-utils

DESCRIPTION="Extreme performance and stability test for PC hardware"
HOMEPAGE="https://benchmark.unigine.com/valley"
SRC_URI="https://assets.unigine.com/d/Unigine_Valley-${PV}.run"
RESTRICT="mirror strip"
KEYWORDS="~amd64"
LICENSE="Unigine-Benchmark"
SLOT="0"

IUSE=""

BDEPEND="dev-util/patchelf"
RDEPEND="
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	dev-libs/libbsd
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	media-libs/openal
	x11-libs/libxcb
"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	# Replace ./ RPATH with $ORIGIN to avoid the following security check fault
	# scanelf: rpath_security_checks(): Security problem with relative DT_RPATH
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/browser_x64
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/valley_x64

	# Add RPATH=$ORIGIN to libraries to prevent QA Notice: Unresolved soname dependencies for libUnigine_x64.so
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/libAppStereo_x64.so
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/libAppSurround_x64.so
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/libAppWall_x64.so
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/libGPUMonitor_x64.so

	insinto "/opt/${PN}"
	doins -r data documentation

	insinto "/opt/${PN}/bin"
	doins bin/libUnigine_x64.so
	doins bin/libAppStereo_x64.so
	doins bin/libAppSurround_x64.so
	doins bin/libAppWall_x64.so
	doins bin/libGPUMonitor_x64.so
	doins bin/libQtCoreUnigine_x64.so.4
	doins bin/libQtGuiUnigine_x64.so.4
	doins bin/libQtNetworkUnigine_x64.so.4
	doins bin/libQtWebKitUnigine_x64.so.4
	doins bin/libQtXmlUnigine_x64.so.4

	into "/opt/${PN}"
	dobin bin/browser_x64
	dobin bin/valley_x64

	newicon data/launcher/icon.png ${PN}.png
	make_wrapper ${PN} "/opt/${PN}/bin/browser_x64 -config /opt/${PN}/data/launcher/launcher.xml" /opt/${PN}/bin /opt/${PN}/bin
	make_desktop_entry /opt/${PN}/bin/${PN} "Unigine Valley"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
