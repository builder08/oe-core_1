
# Remove acl, cups etc. support.
PACKAGECONFIG_remove = "acl cups"

EXTRA_OECONF += " \
                 --without-cluster-support \
                 --without-profiling-data \
                 --with-sockets-dir=${localstatedir}/run \
                 --with-logfilebase=${localstatedir}/log \
                 --nopyc \
                 --disable-iprint \
                 --without-ads \
                 --without-dnsupdate \
                 --without-quotas \
                 --without-winbind \
                 --without-syslog \
                 --disable-python \
                "

EXTRA_OECONF_remove = " \
                       --with-cluster-support \
                       --with-profiling-data \
                       --with-sockets-dir=${localstatedir}/run/samba \
                      "

# Remove unused, add own config, init script
SRC_URI += " \
           file://smb.conf \
           file://samba.sh \
           file://22-disable-python.patch \
           "

FILES_${PN}-base += "${sysconfdir}/init.d/samba.sh"

do_install_append() {
	rm -fR ${D}/var
	rm -fR ${D}/run
	rm -fR ${D}${bindir}
	rm -fR ${D}${sysconfdir}/tmpfiles.d
	rm -fR ${D}${sysconfdir}/sysconfig
	install -d ${D}/var/lib/samba/private
	install -d ${D}${sysconfdir}/samba
	install -m 644 ${WORKDIR}/smb.conf ${D}${sysconfdir}/samba
	install -d ${D}${sysconfdir}/init.d
	install -m 755 ${WORKDIR}/samba.sh ${D}${sysconfdir}/init.d
}

inherit update-rc.d
INITSCRIPT_PACKAGES = "${PN}-base"
INITSCRIPT_NAME_${PN}-base = "samba.sh"
INITSCRIPT_PARAMS_${PN}-base = "defaults"

CONFFILES_${BPN}-common = "${sysconfdir}/samba/smb.conf"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# workaround to get rid of perl dependency
DEPENDS_remove = "perl"
