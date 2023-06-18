mv Magisk* magisk.apk
adb push magisk.apk /tmp/magisk.zip

folders=("a10" "a20" "a20e" "a30" "a30s" "a40")

for folder in "${folders[@]}"; do
    adb push "$folder/boot.img" "/dev/block/by-name/boot"
    adb shell twrp install "/tmp/magisk.zip"
    adb pull "/dev/block/by-name/boot" "$folder/boot.img"
done
