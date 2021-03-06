SUMMARY = "Collection of enigma2 subtitles plugins"
HOMEPAGE = "https://github.com/mx3L/subssupport"
AUTHOR = "Maroš Ondrášek <mx3ldev@gmail.com>"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

RDEPENDS_${PN} = "python-requests python-xmlrpc python-compression python-codecs python-zlib python-difflib unrar"

inherit autotools-brokensep gettext

SRC_URI = "git://github.com/mx3L/subssupport;protocol=https;branch=master"

S = "${WORKDIR}/git"

PV = "1.5.8"
PKGV = "1.5.8"

FILES_${PN} = "${libdir}/enigma2/python/Plugins/Extensions/SubsSupport \
${localstatedir}/lib/subssupport"

do_install_append() {
    install -d ${D}${localstatedir}/lib/subssupport
}

