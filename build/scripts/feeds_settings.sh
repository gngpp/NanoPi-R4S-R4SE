#!/bin/bash

# Set to local feeds
pushd customfeeds/packages
export packages_feed="$(pwd)"
popd
pushd customfeeds/luci
export luci_feed="$(pwd)"
popd
sed -i '/src-git packages/d' feeds.conf.default
sed -i '/src-link packages/d' feeds.conf.default
echo "src-link packages $packages_feed" >> feeds.conf.default

sed -i '/src-git luci/d' feeds.conf.default
sed -i '/src-link luci/d' feeds.conf.default 
echo "src-link luci $luci_feed" >> feeds.conf.default

# Add linkease app
sed -i '/src-git nas/d' feeds.conf.default
sed -i '/src-git nas_luci/d' feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default

cat feeds.conf.default

./scripts/feeds update -a && ./scripts/feeds install -a
