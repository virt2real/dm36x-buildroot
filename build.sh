#!/bin/sh

set -e

VERSION=`git describe --dirty`

FW_FILENAME=leopardboard_$VERSION.fw
echo Building $FW_FILENAME...
echo ------------------------------

# Qt things won't compile right if QMAKESPEC is set.
unset QMAKESPEC

make leopardboard_dm368_defconfig
make

output/host/usr/bin/packager -v $VERSION output/images/ubl_DM36x_dm368sdmmc.bin output/images/u-boot.bin output/images/rootfs.ext2 $FW_FILENAME

echo ------------------------------
echo Built $FW_FILENAME

