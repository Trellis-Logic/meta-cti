SUMMARY = "ConnectTech L4T Binaries"
DESCRIPTION = "Downloads CTI L4T BSP content for sharing with other recipes"
SECTION = "base"

require cti-bsp.inc


WORKDIR = "${CTI_BSP_SHARED_BASE_DIR}"
SSTATE_SWSPEC = "sstate:cti-binaries::${CTI_BSP_VERSION}::${SSTATE_VERSION}:"
STAMP = "${STAMPS_DIR}/work-shared/L4T-${CTI_BSP_ARCH}-${CTI_BSP_VERSION}"
STAMPCLEAN = "${STAMPS_DIR}/work-shared/L4T-${CTI_BSP_ARCH}-${CTI_BSP_VERSION}-*"

INHIBIT_DEFAULT_DEPS = "1"
DEPENDS = ""
PACKAGES = ""

deltask do_configure
deltask do_compile
deltask do_package
deltask do_package_write_rpm
deltask do_package_write_ipk
deltask do_package_write_deb
deltask do_install
deltask do_populate_sysroot
deltask do_package_qa
deltask do_packagedata
RM_WORK_EXCLUDE += "${PN}"

addtask preconfigure after do_patch
