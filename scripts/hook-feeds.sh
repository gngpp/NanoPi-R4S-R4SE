#!/bin/bash
#=================================================
# File name: hook-feeds.sh
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================
# Svn checkout packages from immortalwrt's repository
pushd customfeeds

# Add luci-app-onliner (need luci-app-nlbwmon)
#git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner
svn export https://github.com/immortalwrt/luci/branches/openwrt-18.06-k5.4/applications/luci-app-onliner luci/applications/luci-app-onliner


# Add luci-app-eqos
# svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-eqos luci/applications/luci-app-eqos
# mv ./luci/applications/luci-app-eqos/po/zh_Hans ./luci/applications/luci-app-eqos/po/zh-cn
# svn co https://github.com/haiibo/openwrt-packages/trunk/luci-app-eqos luci/applications/luci-app-eqos

# Add luci-proto-modemmanager
svn co https://github.com/immortalwrt/luci/trunk/protocols/luci-proto-modemmanager luci/protocols/luci-proto-modemmanager

# Add luci-app-gowebdav
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-gowebdav luci/applications/luci-app-gowebdav
svn co https://github.com/immortalwrt/packages/trunk/net/gowebdav packages/net/gowebdav

# Add tmate
git clone --depth=1 https://github.com/immortalwrt/openwrt-tmate

# Add gotop
svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/admin/gotop packages/admin/gotop

# Add minieap
svn co https://github.com/immortalwrt/packages/trunk/net/minieap packages/net/minieap

# Replace smartdns with the official version
#rm -rf packages/net/smartdns
#svn co https://github.com/openwrt/packages/trunk/net/smartdns packages/net/smartdns
