# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes" # plugins are dlopened
PYTHON_COMPAT=( python3_{2,3,4} )
PYTHON_REQ_USE="xml"

inherit eutils gnome2 multilib python-r1

DESCRIPTION="Official plugins for gedit"
HOMEPAGE="https://wiki.gnome.org/Apps/Gedit/ShippedPlugins"

LICENSE="GPL-2+"
KEYWORDS="*"
SLOT="0"

IUSE_plugins="charmap git terminal zeitgeist"
IUSE="+python ${IUSE_plugins}"
REQUIRED_USE="
	charmap? ( python )
	git? ( python )
	terminal? ( python )
	zeitgeist? ( python )
	python? ( ${REQUIRED_PYTHON_USE} )
"

RDEPEND="
	>=app-editors/gedit-3.14.0[python?]
	>=dev-libs/glib-2.42.0:2
	>=dev-libs/libpeas-1.12.0[gtk,python?]
	>=x11-libs/gtk+-3.14.0:3
	>=x11-libs/gtksourceview-3.14.0:3.0
	python? (
		${PYTHON_DEPS}
		>=app-editors/gedit-3.14.0[introspection,${PYTHON_USEDEP}]
		dev-libs/libpeas[${PYTHON_USEDEP}]
		>=dev-python/dbus-python-0.82[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
		>=x11-libs/gtk+-3.14.0:3[introspection]
		>=x11-libs/gtksourceview-3.14.0:3.0[introspection]
		x11-libs/pango[introspection]
		x11-libs/gdk-pixbuf:2[introspection]
	)
	charmap? ( >=gnome-extra/gucharmap-3.14.0:2.90[introspection] )
	git? ( >=dev-libs/libgit2-glib-0.0.6 )
	terminal? ( x11-libs/vte:2.91[introspection] )
	zeitgeist? ( >=gnome-extra/zeitgeist-0.9.12[introspection] )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure \
		$(use_enable python) \
		ITSTOOL=$(type -P true)
}

src_install() {
	gnome2_src_install

	# FIXME: crazy !!!
	if use python; then
		find "${ED}"/usr/share/gedit -name "*.py*" -delete || die
		find "${ED}"/usr/share/gedit -type d -empty -delete || die
	fi

	# FIXME: upstream made this automagic...
	clean_plugin charmap
	clean_plugin git
	clean_plugin terminal
	clean_plugin zeitgeist
}

clean_plugin() {
	if use !${1} ; then
		rm -rf "${ED}"/usr/share/gedit/plugins/${1}*
		rm -rf "${ED}"/usr/$(get_libdir)/gedit/plugins/${1}*
	fi
}
