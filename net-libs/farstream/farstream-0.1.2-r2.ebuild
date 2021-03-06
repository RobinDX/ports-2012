# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="Audio/video conferencing framework specifically designed for instant messengers"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/Farstream"
SRC_URI="http://freedesktop.org/software/farstream/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
KEYWORDS="*"
IUSE="+introspection python msn test upnp"

SLOT="0.1"

# Tests need shmsink from gst-plugins-bad, which isn't packaged
RESTRICT="test"

COMMONDEPEND="
	>=media-libs/gstreamer-0.10.33:0.10
	>=media-libs/gst-plugins-base-0.10.33:0.10
	>=dev-libs/glib-2.30:2
	>=net-libs/libnice-0.1.0
	introspection? ( >=dev-libs/gobject-introspection-0.10.11 )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-2.16:2[${PYTHON_USEDEP}]
		>=dev-python/gst-python-0.10.10:0.10[${PYTHON_USEDEP}] )
	upnp? ( net-libs/gupnp-igd )
"
RDEPEND="${COMMONDEPEND}
	>=media-libs/gst-plugins-good-0.10.17:0.10
	>=media-libs/gst-plugins-bad-0.10.17:0.10
	|| (
		>=media-plugins/gst-plugins-libnice-0.1.0:0.10
		<=net-libs/libnice-0.1.3[gstreamer] )
	msn? ( >=media-plugins/gst-plugins-mimic-0.10.17:0.10 )
	!net-libs/farsight2
"
# This package is just a rename from farsight2

MAKEOPTS="${MAKEOPTS} -j1" # Parallel is completely broken on this slot, bug #434618

DEPEND="${COMMONDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig
	test? (
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-vorbis:0.10 )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	# Fix building with gobject-introspection-1.33.x, bug #425096
	epatch "${FILESDIR}/${P}-introspection-tag-order.patch"
}

src_configure() {
	plugins="fsrawconference,fsrtpconference,fsfunnel,fsrtcpfilter,fsvideoanyrate"
	use msn && plugins="${plugins},fsmsnconference"
	econf --disable-static \
		$(use_enable introspection) \
		$(use_enable python) \
		$(use_enable upnp gupnp) \
		--with-plugins=${plugins}
}

src_install() {
	# Parallel install fails, bug #434618 (fixed in latest slot)
	emake -j1 install DESTDIR="${D}"
	dodoc AUTHORS README ChangeLog

	# Remove .la files since static libs are no longer being installed
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}

src_test() {
	# FIXME: do an out-of-tree build for tests if USE=-msn
	if ! use msn; then
		elog "Tests disabled without msn use flag"
		return
	fi

	emake -j1 check
}
