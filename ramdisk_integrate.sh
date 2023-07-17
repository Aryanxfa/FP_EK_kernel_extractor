#!/usr/bin/bash

if [ -z "$1" ]; then
    echo "Out file name not provided"
    exit
fi

if [ ! -f ../ramdisk.cpio ]; then
    echo "Ramdisk Missing"
    exit
fi
mv Image kernel
rm $1
cp ../dummy_boot.img ./
cp ../header ./
cp ../ramdisk.cpio ./

magiskboot repack dummy_boot.img $1

rm header kernel dummy_boot.img ramdisk.cpio
chmod 644 *
