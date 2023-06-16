#!/usr/bin/bash

if [ ! -f ../ramdisk.cpio ]; then
    echo "Failed with error 1"
    exit
fi
mv Image kernel
rm boot.img
cp ../dummy_boot.img ./
cp ../header ./
cp ../ramdisk.cpio ./

magiskboot repack dummy_boot.img boot.img

rm header kernel dummy_boot.img ramdisk.cpio
