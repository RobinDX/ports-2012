# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="5-progress"
PYTHON_ABI_TYPE="multiple"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy"

inherit distutils

DESCRIPTION="Python ODBC library"
HOMEPAGE="http://code.google.com/p/pyodbc https://github.com/mkleehammer/pyodbc"
SRC_URI="https://github.com/mkleehammer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="mssql"

RDEPEND=">=dev-db/unixODBC-2.3.0
	mssql? ( >=dev-db/freetds-0.64[odbc] )"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	# Fix version.
	sed -e "s/name, numbers = _get_version_pkginfo()/name, numbers = '${PV}', '${PV}'.split('.')/" -i setup.py
}
