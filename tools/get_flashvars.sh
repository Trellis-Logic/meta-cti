foundvars=
missingvars=
# Fill this in based on the list in the appropriate branch at https://github.com/OE4T/meta-tegra/blob/9ff93d621c829f09d675ad53adc2349667da90c5/conf/machine/include/tegra-common.inc#L107
flashvars="BPFDTB_FILE BPF_FILE BR_CMD_CONFIG CHIP_SKU DEVICE_CONFIG DEVICEPROD_CONFIG DEV_PARAMS DEV_PARAMS_B EMC_FUSE_DEV_PARAMS GPIOINT_CONFIG MB2BCT_CFG MINRATCHET_CONFIG MISC_COLD_BOOT_CONFIG MISC_CONFIG PINMUX_CONFIG PMC_CONFIG PMIC_CONFIG PROD_CONFIG RAMCODE SCR_COLD_BOOT_CONFIG SCR_CONFIG TBCDTB_FILE UPHY_CONFIG WB0SDRAM_BCT"
#Fill this in based on the path to work files for the appropriate target
reffiles="tmp/work-shared/ORIN-NX-NANO-35.6.0-V005/CTI-L4T/conf/cti-orin-nx.conf.common tmp/work-shared/ORIN-NX-NANO-35.6.0-V005/CTI-L4T/conf/cti/orin-nano/hadron-dual-mipi/base.conf"

for var in $flashvars
do
    prefix=""
    result=$(cat $reffiles | grep ^$var)
    if [ $? -ne 0 ]; then
        missingvars="$missingvars $var=missing"
    else
        foundvars="$foundvars $(echo "$result" | tr -d ';')"
    fi
done
for var in $foundvars
do
    echo TEGRA_FLASHVAR_$var
done
for var in $missingvars
do
    echo "#TEGRA_FLASHVAR_$var"
done

