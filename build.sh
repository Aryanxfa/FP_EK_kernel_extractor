#!/usr/bin/bash

# List of folders where the script will run
folders=("a10" "a20" "a20e" "a30" "a30s" "a40")
directory=eureka_zip/

mkdir $directory

# Loop through each folder
for folder in "${folders[@]}"; do
    mkdir -p "$folder" &
done

# Copy changelog for history
ls $directory >../version

# Loop through Extract each folder
./internal_extract_zips.sh $directory

# Loop through each folder
cd $directory
pwd
for folder in "${folders[@]}"; do
    # mv *$folder-*"/dtbo/dtbo.img" "../$folder/"
    # mv *$folder-*"/dtb/oneui3/perm/5/dtb.img" "../$folder/"
    mv *$folder-*"/kernel/oneui3/Image" "../$folder/"
done
cd ..

for folder in "${folders[@]}"; do
    cd $folder
    echo
    echo Packing $folder...
    ../pack_boot.sh boot.img
    cd ..
done
