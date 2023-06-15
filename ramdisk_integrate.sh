#!/usr/bin/bash

if [ ! -f ramdisk.cpio ]; then
    echo "Failed with error 1"
    exit
fi
