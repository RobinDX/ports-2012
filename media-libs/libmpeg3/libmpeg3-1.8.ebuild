# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.8.ebuild,v 1.9 2015/01/29 17:39:36 mgorny Exp $

EAPI=4

inherit eutils autotools toolchain-funcs

DESCRIPTION="An mpeg library for linux"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2
	mirror://gentoo/${PN}-1.7-gentoo.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="cpu_flags_x86_mmx"

RDEPEND="sys-libs/zlib
	virtual/jpeg
	media-libs/a52dec"
DEPEND="${RDEPEND}
	cpu_flags_x86_mmx? ( dev-lang/nasm )"

src_prepare() {
	epatch "${WORKDIR}"/${PN}-1.7-mpeg3split.patch
	epatch "${WORKDIR}"/${PN}-1.7-textrel.patch
	epatch "${WORKDIR}"/${PN}-1.7-gnustack.patch
	epatch "${WORKDIR}"/${PN}-1.7-a52.patch
	epatch "${WORKDIR}"/${PN}-1.7-all_gcc4.patch
	epatch "${WORKDIR}"/${PN}-1.7-all_pthread.patch

	cp -rf "${WORKDIR}"/1.7/* .
	eautoreconf
}

src_configure() {
	#disabling css since it's a fake one.
	#One can find in the sources this message :
	#  Stubs for deCSS which can't be distributed in source form

	econf \
		$(use_enable cpu_flags_x86_mmx mmx) \
		--disable-css
}

src_install() {
	default
	dohtml -r docs
	# This is a workaround, it wants to rebuild
	# everything if the headers	 have changed
	# So we patch them after install...
	cd "${ED}/usr/include/libmpeg3"
	# This patch patches the .h files that get installed into /usr/include
	# to show the correct include syntax '<>' instead of '""'  This patch
	# was also generated using info from SF's src.rpm
	epatch "${WORKDIR}"/gentoo-p2.patch

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
