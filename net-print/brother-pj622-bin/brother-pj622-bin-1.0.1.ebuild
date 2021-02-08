# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# TODO This is working for some reason, no clue why, used to work
# TODO, try https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=brother-pj723

EAPI=6

inherit eutils rpm linux-info

DESCRIPTION="Brother printer driver for DCP-9020CDW & DCP-9022CDW"

HOMEPAGE="http://support.brother.com"
SRC_URI="http://download.brother.com/welcome/dlfp002235/pj622lpr-1.0.1-1.i386.rpm
http://download.brother.com/welcome/dlfp002237/pj622cupswrapper-1.0.1-1.i386.rpm"
LICENSE="brother-eula GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror strip"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

S=${WORKDIR}

# PATCHES=( "${FILESDIR}/${PN}-disable-all-scripts-except-for-outputting-config-files.patch" )

pkg_setup() {
	CONFIG_CHECK=""
	if use amd64; then
		CONFIG_CHECK="${CONFIG_CHECK} ~IA32_EMULATION"
	fi

	linux-info_pkg_setup
}

src_unpack() {
	rpm_unpack ${A}
}

src_prepare() {
  default
  cd opt/brother/PTouch/pj622/cupswrapper/ || die
  ./cupswrapperpj622pt1 || die
  rm cupswrapperpj622pt1 || die
}

src_install() {
  mkdir -p "${D}usr/share/ppd/Brother" || die
	mkdir -p "${D}usr/libexec/cups/filter" || die

  cp -r opt "${D}" || die
  cp -r usr "${D}" || die

	chmod 0755 "${D}opt/brother/PTouch/pj622/cupswrapper/brother_lpdwrapper_pj622" || die
	( ln -s "${D}opt/brother/PTouch/pj622/cupswrapper/brother_lpdwrapper_pj622" "${D}usr/libexec/cups/filter/brother_lpdwrapper_pj622" ) || die
  ( ln -s "${D}opt/brother/PTouch/pj622/cupswrapper/brother_pj622_printer_en.ppd" "${D}usr/share/ppd/Brother/brother_pj622_printer_en.ppd" ) || die
}
