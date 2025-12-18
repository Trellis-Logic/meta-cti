inherit cti_bsp

DEPENDS:connecttech += "cti-bsp"

move_files_cti() {
    cp ${CTI_BSP_SHARED_BASE_DIR}/CTI-L4T/bl/t186ref/BCT/*.dts ${S}/bootloader/ || :
    cp ${CTI_BSP_SHARED_BASE_DIR}/CTI-L4T/bl/t186ref/BCT/*.dtsi ${S}/bootloader/ || :
    cp ${CTI_BSP_SHARED_BASE_DIR}/CTI-L4T/kernel/dtb/*.dtb ${S}/bootloader/ || :
}

do_unpack:append:connecttech() {
    bb.build.exec_func('move_files_cti', d)
}
