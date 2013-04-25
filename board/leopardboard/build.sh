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

HOST_DIR=`pwd`/output/host

# Create .fw file
echo Building firmware file...
UBLNAME=`grep UBL_CONFIGNAME .config | awk -F\" '{print $(NF-1)}'`
$HOST_DIR/usr/bin/dm36xpackager.py -v $VERSION -s output/images/ubl_DM36x_$UBLNAME.bin -u output/images/u-boot.bin -r output/images/rootfs.ext2 -f $FW_FILENAME -c board/leopardboard/dm368/sdcard-map.cfg

echo ------------------------------
echo Built $FW_FILENAME

