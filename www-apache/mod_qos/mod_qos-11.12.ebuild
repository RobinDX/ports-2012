# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_qos/mod_qos-11.12.ebuild,v 1.2 2015/05/09 10:41:33 patrick Exp $

EAPI="5"
inherit autotools apache-module

DESCRIPTION="A QOS module for the apache webserver"
HOMEPAGE="http://mod-qos.sourceforge.net/"
SRC_URI="mirror://sourceforge/mod-qos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libpcre
	dev-libs/openssl:0
	media-libs/libpng:0=
	sys-libs/zlib
"
DEPEND="${DEPEND}"

APXS2_S="${S}/apache2"
APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="QOS"
DOCFILES="${S}/doc/*.txt ${S}/README.TXT"

need_apache2

src_prepare() {
	cd "${S}/tools" && eautoreconf
}

src_configure() {
	cd "${S}/tools" && econf
}

src_compile() {
	apache-module_src_compile
	emake -C "${S}/tools"
}

src_install() {
	einfo "Installing Apache module ..."
	cd "${S}/tools"
	apache-module_src_install

	einfo "Installing module utilities ..."
	emake -C "${S}/tools" install DESTDIR="${D}"

	# installing html documentation
	dohtml -r -x *.txt "${S}/doc/"
}
