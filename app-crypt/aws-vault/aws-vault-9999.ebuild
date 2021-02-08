EAPI=6

DESCRIPTION="Vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
EGO_PN=github.com/99designs/aws-vault
if [[ ${PV} == *9999 ]]; then
	inherit golang-vcs
	KEYWORDS=""
else
	EGIT_COMMIT=v${PV}
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
	KEYWORDS="~amd64"
fi
LICENSE="MIT"
SLOT="0"

inherit golang-build

# src_install() {
#         "${S}"/go-md2man -in src/${EGO_PN}/go-md2man.1.md -out go-md2man.1
#         dobin go-md2man
#         doman go-md2man.1
# }
