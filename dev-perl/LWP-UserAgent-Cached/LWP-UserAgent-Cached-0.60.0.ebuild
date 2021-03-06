# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWP-UserAgent-Cached/LWP-UserAgent-Cached-0.60.0.ebuild,v 1.1 2015/05/19 22:50:35 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=OLEG
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="LWP::UserAgent with simple caching mechanism"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/libwww-perl"
DEPEND="${RDEPEND}
	virtual/perl-File-Temp
	>=virtual/perl-ExtUtils-MakeMaker-6.520.0
	test? (
		>=dev-perl/Test-Mock-LWP-Dispatch-0.20.0
		>=virtual/perl-Test-Simple-0.880.0
	)
"

SRC_TEST="do parallel"
