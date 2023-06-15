#!/usr/bin/bash

# List of folders where the script will run
folders=("a10" "a20" "a20e" "a30" "a30s" "a40")

# Loop through each folder
for folder in "${folders[@]}"; do
    mkdir -p "$folder" &
done

./internal_extract_zips.sh eureka_zip/

cd eureka_zip/

# Loop through each folder
for folder in "${folders[@]}"; do
    mv "*$folder*/dtbo/dtbo.img" ../$folder/
done
