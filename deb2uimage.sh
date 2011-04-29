#!/bin/bash

#if [ !$2 ]

DPKG_DIR=`mktemp -d`
BOOT_DIR=$DPKG_DIR/boot

mkdir -p $DPKG_DIR/mnt
MNT_DIR=$DPKG_DIR/mnt

dpkg -x $1 $DPKG_DIR

sudo umount $2
sudo mount $2 $MNT_DIR 
cd $BOOT_DIR
sudo umkimg.sh -k vmlinuz-* $MNT_DIR/uImage
cd -
sudo umount $MNT_DIR

