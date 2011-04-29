#!/bin/bash

if [[ "$1" = "" || "$2" = "" || "$3" = "" ]]; then
	echo "Usage: umkimg.sh"
	echo "umkimg.sh {-k|-r|-s} input output"
	echo "-k: kernel image"
	echo "-r: ramdisk image"
	echo "-s: boot script for Ubuntu"
	exit 1;
fi

TARGET="$1"
INPUT="$2"
OUTPUT="$3"

if [ ! -f $INPUT ]; then
	echo "Input file $INPUT doesn't exist"
	exit 2;
fi

if [ "$TARGET" = "-k" ]; then
	echo "mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Ubuntu Kernel" -d $INPUT $OUTPUT"
	mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Ubuntu Kernel" -d $INPUT $OUTPUT
elif [ "$TARGET" = "-r" ]; then
	echo "mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n initramfs -d $INPUT $OUTPUT"
	mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n initramfs -d $INPUT $OUTPUT
elif [ "$TARGET" = "-s" ]; then
	echo "mkimage -A arm -T script -C none -n "Ubuntu boot script" -d $INPUT $OUTPUT"
	mkimage -A arm -T script -C none -n "Ubuntu boot script" -d $INPUT $OUTPUT
else
	echo "Wrong target $TARGET, which should be {-k|-r|-s}"
fi

sync

exit 0
