# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user

MY_PN="${PN/-bin/}"
MY_PV="${PV}-1"

DESCRIPTION="Scalable datastore for metrics, events, and real-time analytics"
HOMEPAGE="https://github.com/influxdata/influxdb"
SRC_URI="https://dl.influxdata.com/influxdb/releases/influxdb-1.3.2_linux_amd64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="bindist mirror"

RDEPEND="dev-lang/go"

QA_PREBUILT=""

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_install() {
	rm -r ./etc/logrotate.d
	rm -r ./usr/lib
	rm -r ./var/log
	insinto /
	doins -r .
	fperms +x /usr/bin/influx
	fperms +x /usr/bin/influxd
	fperms +x /usr/bin/influx_inspect
	fperms +x /usr/bin/influx_stress
	fperms +x /usr/bin/influx_tsm

	newinitd "${FILESDIR}"/influxd.rc influxd
	newconfd "${FILESDIR}"/influxd.conf influxd
}

pkg_preinst() {
	enewgroup influxdb
	enewuser influxdb -1 -1 "/var/lib/influxdb" influxdb

	fowners influxdb:influxdb /var/lib/influxdb
}
