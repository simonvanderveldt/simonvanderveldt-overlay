# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Raspberry Pi USB booting tool"
HOMEPAGE="https://github.com/raspberrypi/usbboot"
EGIT_REPO_URI="https://github.com/raspberrypi/usbboot.git"
KEYWORDS=""
LICENSE="Apache-2.0"
SLOT="0"

IUSE=""

RDEPEND="virtual/libusb:1"

src_install() {
	dosbin rpiboot
	insinto /usr/share/rpiboot
	doins -r msd
}
