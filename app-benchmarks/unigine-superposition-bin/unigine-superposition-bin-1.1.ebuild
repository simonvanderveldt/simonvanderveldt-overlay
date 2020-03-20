# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on https://github.com/ennui93/ennui/blob/675481c5920e4dd8670a416c14870f9467ff9f37/app-benchmarks/valley/valley-1.0-r1.ebuild

EAPI=7

inherit unpacker eutils desktop xdg-utils

DESCRIPTION="Extreme performance and stability test for PC hardware"
HOMEPAGE="https://benchmark.unigine.com/superposition"
SRC_URI="https://assets.unigine.com/d/Unigine_Superposition-${PV}.run"
RESTRICT="mirror strip"
KEYWORDS="~amd64"
LICENSE="Unigine-Superposition"
SLOT="0"

IUSE=""

BDEPEND="dev-util/patchelf"
RDEPEND="
	dev-libs/libbsd
	media-libs/openal
	sys-devel/gcc
	sys-libs/glibc
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	# Replace ./ RPATH with $ORIGIN to avoid the following security check fault
	# scanelf: rpath_security_checks(): Security problem with relative DT_RPATH
	# Need to add qt/lib because of the old Qt version used the launcher won't work
	# with system Qt libraries
	patchelf --force-rpath --set-rpath '$ORIGIN:$ORIGIN/qt/lib' bin/launcher

	# Add RPATH=$ORIGIN to libraries to prevent QA Notice: Unresolved soname dependencies for libUnigine_x64.so
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/libAppVive_x64.so
	patchelf --force-rpath --set-rpath '$ORIGIN' bin/libGPUMonitor_x64.so

	insinto "/opt/${PN}"
	doins -r data docs

	insinto "/opt/${PN}/bin"
	doins bin/libAppVive_x64.so
	doins bin/libGPUMonitor_x64.so
	doins bin/libopenvr_api.so
	doins bin/libUnigine_x64.so
	# Unfortunately it's not possible to make the launcher work with the system Qt>5.9
	# Probably because an icon variabla was added in Qt 5.10 that clashes with a custom icon variable in the launcher
	# See https://github.com/getavalon/launcher/issues/23
	doins -r bin/qt
	doins bin/qt.conf

	into "/opt/${PN}"
	dobin bin/launcher
	dobin bin/superposition
	dobin bin/superposition_cli

	newicon -s 512 icons/superposition_icon_512.png ${PN}.png
	make_wrapper ${PN} "/opt/${PN}/bin/launcher"
	make_desktop_entry /opt/${PN}/bin/${PN} "Unigine Superposition"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
