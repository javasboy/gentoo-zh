# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker

DESCRIPTION="A Windows/macOS/Linux GUI based on Clash and Electron."
HOMEPAGE="https://github.com/Fndroid/clash_for_windows_pkg"
SRC_URI="https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${PV}/Clash.for.Windows-0.19.7-x64-linux.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

QA_PRESTRIPPED="*"
QA_PREBUILT="*"

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver"

S="${WORKDIR}"

src_configure() {
	mv "${S}/Clash for Windows-0.19.7-x64-linux" "${S}/${PN}"
}

src_install() {
	insinto "/opt"
	doins -r "${S}/${PN}"
	doicon -s 512 "${FILESDIR}/${PN}.png"
	domenu "${FILESDIR}/${PN}.desktop"
	fperms 0755 "/opt/${PN}" -R
}

src_postinst() {
	elog "To use TUN mode, net-firewall/nftables is required."
}
