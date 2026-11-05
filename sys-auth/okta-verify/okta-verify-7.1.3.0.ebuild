EAPI=7

inherit xdg-utils systemd

DESCRIPTION="Okta Verify Authenticator for Linux"
HOMEPAGE="https://okta.com"
SRC_URI="okta-verify-${PV}-7b3f449-amd64.deb"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

RDEPEND="
  acct-user/okta-ff
  acct-group/okta-ff
  dev-util/lttng-ust-compat
"

S="${WORKDIR}"

QA_PREBUILT="*"

src_unpack() {
  default
  unpack "${WORKDIR}"/data.tar.xz
}

src_install() {
  insinto /

  doins -r etc/
  doins -r lib/
  doins -r opt/
  doins -r usr/

  fowners root:okta-ff /etc/okta
  fperms 1775 /etc/okta

  fowners root:okta-ff /etc/okta/azureconfig.json
  fperms 440 /etc/okta/azureconfig.json

  # Fix permissions
  chmod +x "${ED}"/opt/okta/verify/oktaverify || die
  chmod +x "${ED}"/opt/okta/okta-authenticator/Okta.OktaAuthenticatorService || die
  chmod +x "${ED}"/opt/okta/feature-flag-service/Okta.LinuxFeatureFlagService || die

  keepdir /var/log/okta
  fowners root:okta-ff /var/log/okta
  fperms 775 /var/log/okta
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
  systemd_enable_service multi-user.target okta-authenticator.service
  systemd_enable_service multi-user.target okta-feature-flag.service
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
