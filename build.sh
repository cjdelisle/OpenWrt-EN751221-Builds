#!/bin/sh

git clone https://github.com/cjdelisle/openwrt.git
cd openwrt || exit 1
git checkout econet-new-device-zyxel-pmg5617ga-oct28-2025

./scripts/feeds update -a
./scripts/feeds install -a

echo '
CONFIG_TARGET_econet=y
CONFIG_TARGET_econet_en751221=y
CONFIG_TARGET_MULTI_PROFILE=y
CONFIG_TARGET_DEVICE_econet_en751221_DEVICE_en751221_generic=y
CONFIG_TARGET_DEVICE_PACKAGES_econet_en751221_DEVICE_en751221_generic=""
CONFIG_TARGET_DEVICE_econet_en751221_DEVICE_nokia_g240g-e=y
CONFIG_TARGET_DEVICE_PACKAGES_econet_en751221_DEVICE_nokia_g240g-e=""
CONFIG_TARGET_DEVICE_econet_en751221_DEVICE_smartfiber_xp8421-b=y
CONFIG_TARGET_DEVICE_PACKAGES_econet_en751221_DEVICE_smartfiber_xp8421-b=""
CONFIG_TARGET_DEVICE_econet_en751221_DEVICE_tplink_archer-vr1200v-v2=y
CONFIG_TARGET_DEVICE_PACKAGES_econet_en751221_DEVICE_tplink_archer-vr1200v-v2=""
CONFIG_TARGET_DEVICE_econet_en751221_DEVICE_zyxel_pmg5617ga=y
CONFIG_TARGET_DEVICE_PACKAGES_econet_en751221_DEVICE_zyxel_pmg5617ga=""
CONFIG_TARGET_PER_DEVICE_ROOTFS=y
CONFIG_FEED_luci=y
CONFIG_FEED_packages=y
CONFIG_FEED_routing=y
CONFIG_FEED_telephony=y
CONFIG_FEED_video=y
CONFIG_IMAGEOPT=y
CONFIG_PACKAGE_kmod-crypto-sha256=y
CONFIG_PACKAGE_kmod-fs-ext4=y
CONFIG_PACKAGE_kmod-fs-vfat=y
CONFIG_PACKAGE_kmod-lib-crc16=y
CONFIG_PACKAGE_kmod-libphy=y
CONFIG_PACKAGE_kmod-mii=y
CONFIG_PACKAGE_kmod-nls-cp437=y
CONFIG_PACKAGE_kmod-nls-iso8859-1=y
CONFIG_PACKAGE_kmod-nls-utf8=y
CONFIG_PACKAGE_kmod-scsi-core=y
CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_kmod-usb-net-rtl8152=y
CONFIG_PACKAGE_kmod-usb-storage=y
CONFIG_PACKAGE_nand-utils=y
CONFIG_PACKAGE_libatomic=y
CONFIG_PACKAGE_libpthread=y
CONFIG_PACKAGE_librt=y
CONFIG_PACKAGE_libstdcpp=y
CONFIG_PACKAGE_r8152-firmware=y
CONFIG_TARGET_INITRAMFS_COMPRESSION_NONE=y
CONFIG_TARGET_ROOTFS_INITRAMFS=y
' > .config

make defconfig

make "-j$(nproc)"

# We need to do this for now because otherwise the binaries are unfindable
cd ./bin/targets/econet/en751221
ls | sed -n -e 's/openwrt-snapshot-\(.*\)-econet-\(.*\)/mv openwrt-snapshot-\1-econet-\2 openwrt-econet-\2/p' | sh

