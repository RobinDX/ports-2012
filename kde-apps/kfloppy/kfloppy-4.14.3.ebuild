# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kfloppy/kfloppy-4.14.3.ebuild,v 1.1 2015/06/04 18:44:42 kensington Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KFloppy - formats disks and puts a DOS or ext2fs filesystem on them"
HOMEPAGE="
	http://www.kde.org/applications/utilities/kfloppy/
	http://utils.kde.org/projects/kfloppy/
"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
