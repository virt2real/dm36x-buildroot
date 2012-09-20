#!/bin/sh

set -e

DEFCONFIG=leopardboard_dm368_defconfig
VERSION=`git describe --dirty`

FW_FILENAME=leopardboard_$VERSION.fw
echo Config: $DEFCONFIG
echo Output: $FW_FILENAME...
echo ------------------------------

# Qt things won't compile right if QMAKESPEC is set.
unset QMAKESPEC

make $DEFCONFIG
make

UBLNAME=`grep UBL_CONFIGNAME .config | awk -F\" '{print $(NF-1)}'`
output/host/usr/bin/packager -v $VERSION output/images/ubl_DM36x_$UBLNAME.bin output/images/u-boot.bin output/images/rootfs.ext2 $FW_FILENAME

echo ------------------------------
echo Built $FW_FILENAME

