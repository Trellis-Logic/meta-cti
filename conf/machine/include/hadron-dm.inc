# Override carrier specific references to use hadron DM

KERNEL_DEVICETREE = "tegra234-orin-nx-cti-NGX024.dtb"

# Generated with ../tools/get_flashvars.sh
TEGRA_FLASHVAR_GPIOINT_CONFIG="tegra234-cti-orin-nx-mb1-bct-gpioint.dts"
TEGRA_FLASHVAR_PINMUX_CONFIG="tegra234-cti-orin-nx-mb1-bct-pinmux.dtsi"
TEGRA_FLASHVAR_PMC_CONFIG="tegra234-mb1-bct-padvoltage-p3767-hdmi-a03.dtsi"
TEGRA_FLASHVAR_SCR_CONFIG="tegra234-cti-orin-nx-mb2-bct-scr.dts"
#TEGRA_FLASHVAR_BPF_FILE=missing
#TEGRA_FLASHVAR_BR_CMD_CONFIG=missing
#TEGRA_FLASHVAR_CHIP_SKU=missing
#TEGRA_FLASHVAR_MB2BCT_CFG=missing
#TEGRA_FLASHVAR_MISC_COLD_BOOT_CONFIG=missing
#TEGRA_FLASHVAR_RAMCODE=missing
#TEGRA_FLASHVAR_SCR_COLD_BOOT_CONFIG=missing
#TEGRA_FLASHVAR_UPHY_CONFIG=missing

# Modified values from ones generated with get_flashvars:

#Use the default provided config from orin-nx.inc which substitutes PMICREV
#TEGRA_FLASHVAR_PMIC_CONFIG="tegra234-mb1-bct-pmic-p3767-0000-a02.dts"

# Prefix with --minirachet_config to match oe4t scarthgap implementation
#TEGRA_FLASHVAR_MINRATCHET_CONFIG="tegra234-mb1-bct-ratchet-p3767-0000.dts"

# Use later version from OE4T scarthgap
#TEGRA_FLASHVAR_WB0SDRAM_BCT="tegra234-p3767-0000-wb0sdram-l4t.dts"

# Use @DTBFILE@ as done with oe4t
#TEGRA_FLASHVAR_TBCDTB_FILE="tegra234-orin-nano-cti-NGX024-uefi.dtb"

# Renamed from MB2_BCT in upstream L4T
TEGRA_FLASHVAR_MB2BCT_CFG="tegra234-cti-orin-nx-mb2-bct-misc.dts"

# Disabled as MACHINE specific, use MACHINE defaults instead which in each case actually match these anyway
#TEGRA_FLASHVAR_BPFDTB_FILE="tegra234-bpmp-3767-0000-a02-3509-a02.dtb"
#TEGRA_FLASHVAR_DEVICE_CONFIG="tegra234-mb1-bct-device-p3767-0000.dts"
#TEGRA_FLASHVAR_DEVICEPROD_CONFIG="tegra234-mb1-bct-cprod-p3767-0000.dts"
#TEGRA_FLASHVAR_DEV_PARAMS="tegra234-br-bct-p3767-0000-l4t.dts"
#TEGRA_FLASHVAR_DEV_PARAMS_B="tegra234-br-bct_b-p3767-0000-l4t.dts"
#TEGRA_FLASHVAR_DEV_PARAMS_B="tegra234-br-bct_b-p3767-0000-l4t.dts"
#TEGRA_FLASHVAR_MISC_CONFIG="tegra234-mb1-bct-misc-p3767-0000.dts"
#TEGRA_FLASHVAR_PROD_CONFIG="tegra234-mb1-bct-prod-p3767-0000.dts"
#TEGRA_FLASHVAR_EMC_FUSE_DEV_PARAMS="tegra234-br-bct-diag-boot.dts"
