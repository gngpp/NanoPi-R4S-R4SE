#!/bin/bash

PROJECTROOT=$(pwd)
CONFIG_FILE=configs/lean/lean_docker.config

#Clone Source Code
echo "-------------------------------------------[Clone Source Code]-------------------------------------------"
git clone https://github.com/DHDAXCW/lede-rockchip -b stable openwrt
pushd openwrt
OPENWRTROOT=$(pwd)
echo "OPENWRTROOT=$OPENWRTROOT"

#Update Feeds
echo "-------------------------------------------[Clone Packages]-------------------------------------------"
mkdir customfeeds
git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages
git clone --depth=1 https://github.com/gngpp/luci customfeeds/luci
chmod +x ../scripts/*.sh
../scripts/hook-feeds.sh
../scripts/feeds_settings.sh

pushd $OPENWRTROOT

#Install Feeds
echo "-------------------------------------------[Update And Install Feeds]-------------------------------------------"
./scripts/feeds update -a
./scripts/feeds install -a


#Load Custom Configuration
echo "-------------------------------------------[Load Custom Configuration]-------------------------------------------"
mkdir $OPENWRTROOT/files
cp $PROJECTROOT/$CONFIG_FILE $OPENWRTROOT/.config
chmod +x scripts/*.sh
pushd $OPENWRTROOT
$PROJECTROOT/scripts/lean.sh
$PROJECTROOT/scripts/preset-clash-core.sh arm64
$PROJECTROOT/scripts/preset-terminal-tools.sh
make defconfig

#Download Package
echo "-------------------------------------------[Download Package]-------------------------------------------"
pushd $OPENWRTROOT
cat .config
make download -j8 V=s
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;

#Compile Packages
echo "-------------------------------------------[Compile Packages]-------------------------------------------"
pushd $OPENWRTROOT
echo -e "$(nproc) thread compile"
export FORCE_UNSAFE_CONFIGURE=1
make tools/compile -j$(nproc)
make toolchain/compile -j$(nproc)
make target/compile -j$(nproc)
make diffconfig
make package/compile -j$(nproc)
make package/index
pushd $OPENWRTROOT/bin/packages/*
PLATFORM=$(basename `pwd`)
echo "PLATFORM=$PLATFORM"
pushd $OPENWRTROOT/bin/targets/*
TARGET=$(basename `pwd`)
echo "TARGET=$TARGET"
pushd *
SUBTARGET=$(basename `pwd`)
echo "SUBTARGET=$SUBTARGET"

#Generate Firmware
echo "-------------------------------------------[Generate Firmware]-------------------------------------------"
pushd $PROJECTROOT/configs/opkg
        sed -i "s/subtarget/$SUBTARGET/g" distfeeds*.conf
        sed -i "s/target\//$TARGET\//g" distfeeds*.conf
        sed -i "s/platform/$PLATFORM/g" distfeeds*.conf
pushd $OPENWRTROOT
        mkdir -p files/etc/uci-defaults/
        cp ../scripts/init-settings.sh files/etc/uci-defaults/99-init-settings
        mkdir -p files/etc/opkg
        cp ../configs/opkg/distfeeds-packages-server.conf files/etc/opkg/distfeeds.conf.server
        mkdir -p files/etc/opkg/keys
        cp ../configs/opkg/1035ac73cc4e59e3 files/etc/opkg/keys/1035ac73cc4e59e3
	    mkdir -p files/www/snapshots
            cp -r bin/targets files/www/snapshots
            cp ../configs/opkg/distfeeds-18.06-local.conf files/etc/opkg/distfeeds.conf
	            cp files/etc/opkg/distfeeds.conf.server files/etc/opkg/distfeeds.conf.mirror
        sed -i "s/http:\/\/192.168.123.100:2345\/snapshots/https:\/\/openwrt.cc\/snapshots\/$(date +"%Y-%m-%d")\/lean/g" files/etc/opkg/distfeeds.conf.mirror

	make package/install -j$(nproc) || make package/install -j1 V=s
	make target/install -j$(nproc) || make target/install -j1 V=s
	pushd $OPENWRTROOT/bin/targets/rockchip/armv8
	rm -rf openwrt-rockchip-armv8.manifest
        rm -rf openwrt-rockchip-armv8-rootfs.tar.gz
        rm -rf config.buildinfo
        rm -rf packages-server.zip
        mv openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz docker-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz
        mv openwrt-rockchip-armv8-friendlyarm_nanopi-r4se-ext4-sysupgrade.img.gz docker-friendlyarm_nanopi-r4se-ext4-sysupgrade.img.gz
        mv openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-squashfs-sysupgrade.img.gz docker-friendlyarm_nanopi-r4s-squashfs-sysupgrade.img.gz
        mv openwrt-rockchip-armv8-friendlyarm_nanopi-r4se-squashfs-sysupgrade.img.gz docker-friendlyarm_nanopi-r4se-squashfs-sysupgrade.img.gz
        popd
        make checksum
        mv bin/targets/rockchip/armv8/sha256sums bin/targets/rockchip/armv8/docker-sha256sums
	ls -la
	echo "complete!"
