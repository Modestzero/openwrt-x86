#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
mkdir -p package/helloworld
for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt" "redsocks2"; do \
  svn checkout "https://github.com/immortalwrt/packages/trunk/net/$i" "package/helloworld/$i"; \
done

svn checkout https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
svn checkout https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx

sed -i 'N;24a\tools-y += ucl upx' tools/Makefile
sed -i 'N;40a\$(curdir)/upx/compile := $(curdir)/ucl/compile' tools/Makefile


tools-y += ucl upx
$(curdir)/upx/compile := $(curdir)/ucl/compile
