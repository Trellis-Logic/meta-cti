HOMEPAGE = "https://connecttech.com/resource-center/l4t-board-support-packages/"
# Haven't been able to find a license reference anywhere...
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://CTI-L4T/readme.txt;md5=6e6814d80998aca3f4ac56eb3ba0a1c3"

inherit cti_bsp

CTI_URI_BASE ?= "https://connecttech.com/ftp/Drivers/"

SRC_URI = "${CTI_URI_BASE}/CTI-L4T-${CTI_SOM_BSP}-${CTI_L4T_VERSION}-${CTI_BSP_RELEASE_VERSION}.tgz \
"

SRC_URI[sha256sum] = "4f296b7f29a1c17d45370928760655fc9def303c76a3bd80e86b9a8ce3f9e142"

S = "${CTI_BSP_SHARED_BASE_DIR}"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

COMPATIBLE_MACHINE = "connecttech"
