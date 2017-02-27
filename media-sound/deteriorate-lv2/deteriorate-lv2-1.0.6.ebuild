# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit git-r3 python-any-r1 waf-utils

IUSE=""

DESCRIPTION="A set of plugins to deteriorate the sound quality"
HOMEPAGE="https://objectivewave.wordpress.com/deteriorate-lv2/"
EGIT_REPO_URI="https://github.com/blablack/${PN}.git"
LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="dev-cpp/gtkmm:2.4
  x11-libs/gtk+:2
  x11-libs/cairo
  media-libs/lv2
  media-libs/lvtk[gtk2]"

DEPEND="${RDEPEND}"
