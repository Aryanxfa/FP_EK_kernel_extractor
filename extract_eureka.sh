#!/usr/bin/bash

# List of folders where the script will run
folders=("a10" "a20" "a20e" "a30" "a30s" "a40")
directory=eureka_zip/

# Loop through each folder
for folder in "${folders[@]}"; do
    mkdir -p "$folder" &
done

# Copy changelog for history
ls $directory >../version
cp $directory/*a10*/META-INF/com/google/android/aroma/changelog.txt .

# Loop through Extract each folder
./internal_extract_zips.sh $directory

# Loop through each folder
cd $directory
for folder in "${folders[@]}"; do
    mv *$folder-*"/dtbo/dtbo.img" "../$folder/"
    mv *$folder-*"/dtb/oneui3/perm/5/dtb.img" "../$folder/"
    mv *$folder-*"/kernel/oneui4/Image" "../$folder/"
done
cd ..

for folder in "${folders[@]}"; do
    ../ramdisk_integrate.sh
done
