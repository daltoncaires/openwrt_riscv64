#!/usr/bin/env bash
#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

set -ex
[ $# -eq 5 ] || {
    echo "SYNTAX: $0 <file> <bbl image> <rootfs image> <bbl size> <rootfs size>"
    # <u-boot image>"
    exit 1
}

BBL_UUID="2E54B353-1271-4842-806F-E436D6AF6985"
LINUX_UUID="0FC63DAF-8483-4772-8E79-3D69D8477DE4"

OUTPUT="$1"
BOOTFS="$2"
ROOTFS="$3"
BOOTFSSIZE="$4"
ROOTFSSIZE="$5"
FULLSIZE="$(($BOOTFSSIZE+$ROOTFSSIZE+2))"
echo "Full size is: ${FULLSIZE}M"

ROOTFSOFFSET="$(($BOOTFSSIZE*1048576 / 512 + 2048))" #8187
echo "Rootfs offset is: $ROOTFSOFFSET"

dd if=/dev/zero of=$OUTPUT bs=1M count=$FULLSIZE

sgdisk --clear \
    --new=1:2048:${BOOTFSSIZE}M  --change-name=1:bootloader --typecode=1:${BBL_UUID} \
    --new=2:${ROOTFSOFFSET}:     --change-name=2:root       --typecode=2:${LINUX_UUID} $OUTPUT

dd bs=512 if="$BOOTFS" of="$OUTPUT" seek=2048 conv=notrunc
dd bs=512 if="$ROOTFS" of="$OUTPUT" seek="$ROOTFSOFFSET" conv=notrunc
