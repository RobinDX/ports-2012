# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdegraphics-meta/kdegraphics-meta-4.14.3.ebuild,v 1.1 2015/06/04 18:44:39 kensington Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/applications/graphics/"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="scanner"

RDEPEND="
	$(add_kdeapps_dep gwenview)
	$(add_kdeapps_dep kamera)
	$(add_kdeapps_dep kcolorchooser)
	$(add_kdeapps_dep kdegraphics-mobipocket)
	$(add_kdeapps_dep kgamma)
	$(add_kdeapps_dep kolourpaint)
	$(add_kdeapps_dep kruler)
	$(add_kdeapps_dep ksnapshot)
	$(add_kdeapps_dep libkdcraw)
	$(add_kdeapps_dep libkexiv2)
	$(add_kdeapps_dep libkipi)
	$(add_kdeapps_dep okular)
	$(add_kdeapps_dep svgpart)
	$(add_kdeapps_dep thumbnailers)
	scanner? (
		$(add_kdeapps_dep ksaneplugin)
		$(add_kdeapps_dep libksane)
	)
"
