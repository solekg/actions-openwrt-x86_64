#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.50.201/g' package/base-files/files/bin/config_generate

# rm -rf feeds/luci/applications/luci-app-mosdns
# rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,sing-box,smartdns}
# rm -rf feeds/packages/utils/v2dat

#smartdns
rm -rf feeds/packages/net/smartdns/*
git clone https://github.com/pymumu/openwrt-smartdns feeds/packages/net/smartdns
rm -rf feeds/packages/net/smartdns/.git
rm -rf feeds/luci/applications/luci-app-smartdns/*
git clone https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-smartdns/.git

#adguardhome
rm -rf feeds/packages/net/adguardhome/*
cp -r feeds/kenzo/adguardhome/* feeds/packages/net/adguardhome

#golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
