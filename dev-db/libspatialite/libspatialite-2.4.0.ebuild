# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit autotools eutils versionator

KEYWORDS="~amd64 ~x86"

DESCRIPTION="SpatiaLite extension enables SQLite to support spatial data in a way conformant to OpenGis specifications."
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${PV}/libspatialite-amalgamation-${PV}.tar.gz"


LICENSE="MPL-1.1"

SLOT="0"
IUSE="geos proj readline"

RDEPEND=">=dev-db/sqlite-3
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )
	readline? ( sys-libs/readline )"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "libspatialite-amalgamation-2.4.0"
}

src_compile(){
	cd "libspatialite-amalgamation-2.4.0"
	local myconf
	if use geos; then
		myconf="--enable-geos --with-geos-lib=/usr/lib"
	fi

	if use proj; then
		myconf="${myconf} --enable-proj --with-proj-lib=/usr/lib"
	fi

	if use readline; then
		myconf="${myconf} --enable-readline"
	fi

	econf --enable-autoconf ${myconf} ||\
			die "Error: econf failed"

	emake || die "Error: emake failed"
}

src_install(){
	cd "libspatialite-amalgamation-2.4.0"
	emake DESTDIR="${D}" install || die "emake install failed"
}
