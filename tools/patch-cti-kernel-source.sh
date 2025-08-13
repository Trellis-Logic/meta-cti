#!/usr/bin/env bash
# Patch kernel sources
set -e


helptext="usage: $0 kernel-directory bsp-directory [-h]


positional arguments:
  kernel-directory      Directory of kernel to patch
  bsp-directory         Directory of bsp sources to generate patches from

optional arguments:
  -h, --help                            show this help message and exit"


# Argument parsing adapted from https://stackoverflow.com/a/14203146
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    shift # past argument
    echo "$helptext"
    exit 0
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# Function to check arg
check_arg() {
    if [ -z "${1}" ]; then
        echo "Error: Missing positional argument '${2}'"
        echo "$helptext"
        exit 1
    fi
}

kernel_folder="${1}"
check_arg "${kernel_folder}" "kernel-directory"
shift

cti_patches_folder="${1}"
check_arg "${cti_patches_folder}" "bsp-directory"
shift

# At this point, should be no more arguments.
if [ ! -z "${1}" ]; then
    echo "Error: Too many arguments: '$*'"
    echo "$helptext"
    exit 1
fi

echo "kernel_folder: $kernel_folder"
echo "cti_patches_folder: $cti_patches_folder"

# Sanity-check
if [ ! -d "$cti_patches_folder/kernel" ]; then
    echo "error: No kernel folder found at $cti_patches_folder/kernel. Wrong path?"
    exit 1;
fi

if [ ! -f "$kernel_folder/Kconfig" ]; then
    echo "error: No source kernel config found at $kernel_folder/Kconfig. Wrong path?"
    exit 1
fi

# Copy hardware platform drivers
echo "Copying platform drivers"
cp -R "$cti_patches_folder"/hardware/nvidia/* "$kernel_folder"/nvidia
git -C "$kernel_folder" add .
git -C "$kernel_folder"  commit --quiet -m "cti: Copy hardware platform drivers"

# Copy kernel changes
# Exclude their build-system changes, re-add them later
echo "Copy kernel changes"
rsync -r \
    --exclude "Makefile" \
    --exclude "kernel-overlays.txt" \
    --exclude "kernel-int-overlays.txt" \
    --links \
    "$cti_patches_folder"/kernel/kernel-5.10/* "$kernel_folder"
git -C "$kernel_folder"  add .
git -C "$kernel_folder"  commit --quiet -m "cti: Copy kernel changes"

echo "Copy CTI drivers"
rsync -r \
    "$cti_patches_folder"/kernel/cti "$kernel_folder"
git -C "$kernel_folder"  add .
git -C "$kernel_folder"  commit --quiet -m "cti: Copy CTI drivers"


# NB! These are vey old, so consider if we want to do this or not..
# Location is governed by oe4t location, example: https://github.com/OE4T/linux-tegra-5.10/commit/8960b6444839da8ecc41ad228dfebabab885cd8e
# First delete as a lot of files are just different
echo "Copy nvethernetrm"
rm -rf "$kernel_folder"/nvidia/drivers/net/ethernet/nvidia/nvethernet/nvethernetrm/*
cp -R "$cti_patches_folder"/kernel/nvethernetrm/* "$kernel_folder"/nvidia/drivers/net/ethernet/nvidia/nvethernet/nvethernetrm/
git -C "$kernel_folder"  add .
git -C "$kernel_folder"  commit --allow-empty --quiet -m "cti: nvethernetrm"

echo "Copy gpu drivers"
cp -R "$cti_patches_folder"/kernel/nvgpu/* "$kernel_folder"/nvidia/nvgpu/
git -C "$kernel_folder"  add .
git -C "$kernel_folder"  commit --allow-empty --quiet  -m "cti: Copy gpu drivers"

echo "Copy stereolabs drivers"
rsync -r \
    "$cti_patches_folder"/kernel/stereolabs/drivers/stereolabs "$kernel_folder"/drivers/
cat "$cti_patches_folder"/kernel/stereolabs/drivers/Makefile >> "$kernel_folder"/drivers/Makefile
cat "$cti_patches_folder"/kernel/stereolabs/drivers/Kconfig >> "$kernel_folder"/drivers/Kconfig
git -C "$kernel_folder"  add .
git -C "$kernel_folder"  commit --allow-empty --quiet  -m "Copy stereolabs drivers."

echo "Copy main nvidia drivers"
rsync -r --exclude "drivers/net/ethernet/nvidia/nvethernet" "$cti_patches_folder"/kernel/nvidia/* "$kernel_folder"/nvidia
git -C "$kernel_folder"  add .
pushd $kernel_folder && find . -name "*.bin" | xargs git add -f && popd
git -C "$kernel_folder"  commit --allow-empty --quiet  -m "Copy all other nvidia driver changes."

echo "CTI changes added from $cti_patches_folder to $kernel_folder"
echo "Makefile changes in $cti_patches_folder/kernel/kernel-5.10/Makefile must be manually added"
echo "Or cherry-picked from a previous release branch into $kernel_folder/Makefile"
echo "Current diff:"
diff -u $kernel_folder/Makefile $cti_patches_folder/kernel/kernel-5.10/Makefile
