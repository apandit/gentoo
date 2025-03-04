# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

MY_P=${PN}-v${PV}

DESCRIPTION="Internet platforms for proposition development and decision making"
HOMEPAGE="https://www.public-software-group.org/liquid_feedback"
SRC_URI="https://www.public-software-group.org/pub/projects/liquid_feedback/backend/v${PV}/${MY_P}.tar.gz"

LICENSE="HPND CC-BY-2.5"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-db/postgresql:="
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${PN}-3.0.4-gentoo.patch )

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		CPPFLAGS="-I $(pg_config --includedir)" \
		LDFLAGS="${LDFLAGS} -L $(pg_config --libdir)"
}

src_install() {
	dobin lf_update lf_update_suggestion_order lf_export
	insinto /usr/share/${PN}
	doins -r {core,init,demo,test}.sql update
	dodoc README "${FILESDIR}"/postinstall-en.txt
}
