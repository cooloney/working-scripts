#!/bin/bash

TMP_DIR=`mktemp -d`

mkdir -p $TMP_DIR/mnt
MNT_DIR=$TMP_DIR/mnt

sudo umount $1
sudo mount $1 $MNT_DIR 

cp $MNT_DIR/boot.scr $TMP_DIR
vi $TMP_DIR/boot.scr

cd $TMP_DIR
sudo umkimg.sh -s boot.scr $MNT_DIR/boot.scr
cd -
sudo umount $MNT_DIR

