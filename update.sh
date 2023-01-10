#!/bin/bash
ROOT=$(pwd)
pushd openwrt
#update cache
git pull

#delete old packages
rm -rf ./customfeeds

#update packages
mkdir customfeeds
git clone --depth=1 https://github.com/DHDAXCW/packages customfeeds/packages
git clone --depth=1 https://github.com/DHDAXCW/luci customfeeds/luci
chmod +x $ROOT/scripts/*.sh && $ROOT/scripts/hook-feeds.sh
#delete cache
./scripts/feeds update -a && ./scripts/feeds install -a

#Load Custom Configuration
rm -rf ./files && mkdir files
rm .config && mv $ROOT/configs/lean/lean_docker.config .config

chmod +x scripts/*.sh
$ROOT/scripts/lean.sh
$ROOT/scripts/preset-clash-core.sh arm64
$ROOT/scripts/preset-terminal-tools.sh
make defconfig

#Download Package
make download -j8
