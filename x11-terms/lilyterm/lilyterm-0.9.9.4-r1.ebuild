# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils
DESCRIPTION="a terminal emulator based off of libvte that aims to be fast and lightweight"
HOMEPAGE="http://lilyterm.luna.com.tw"
LICENSE="GPL-3"
SRC_URI="http://${PN}.luna.com.tw/file/${P}.tar.gz"

SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	x11-libs/vte:0
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	sys-devel/autogen
	sys-devel/gettext
	virtual/pkgconfig
"

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.9.4-locale.patch
}
