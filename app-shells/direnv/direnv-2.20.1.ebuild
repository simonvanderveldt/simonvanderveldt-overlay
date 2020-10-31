# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/${PN}/${PN}"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
	KEYWORDS=""
else
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Automatically load and unload environment variables depending on the current dir"
HOMEPAGE="https://direnv.net"
LICENSE="MIT"
SLOT="0"

src_install() {
	dobin direnv
}
