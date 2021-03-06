# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevplatform/kdevplatform-1.7.1.ebuild,v 1.2 2015/06/04 19:02:21 kensington Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
KMNAME="kdevelop"
KDE_LINGUAS="bs ca ca@valencia da de el en_GB es et fi fr gl it kk nb nl pl pt
pt_BR ru sk sl sv th tr uk zh_CN zh_TW"
VIRTUALDBUS_TEST="true"
VIRTUALX_REQUIRED="test"
EGIT_REPONAME="${PN}"
EGIT_BRANCH="1.7"
inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"
LICENSE="GPL-2 LGPL-2"
IUSE="+classbrowser cvs debug +konsole reviewboard subversion"

if [[ $PV == *9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~ppc ~x86"
fi

RESTRICT="test"

COMMON_DEPEND="
	dev-libs/grantlee:0
	reviewboard? ( dev-libs/qjson )
	subversion? (
		dev-libs/apr
		dev-libs/apr-util
		dev-vcs/subversion
	)
"
DEPEND="${COMMON_DEPEND}
	classbrowser? ( dev-libs/boost )
"
RDEPEND="${COMMON_DEPEND}
	konsole? ( $(add_kdeapps_dep konsole) )
	cvs? ( dev-vcs/cvs )
	!<dev-util/kdevelop-${KDEVELOP_VERSION}:4
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build classbrowser)
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build konsole)
		$(cmake-utils_use_find_package reviewboard QJSON)
		$(cmake-utils_use_build subversion)
	)

	kde4-base_src_configure
}
