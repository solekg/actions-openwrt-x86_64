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

#v2ray-geodata
rm -rf feeds/packages/net/v2ray-geodata/*
git clone https://github.com/sbwml/v2ray-geodata feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-geodata/.git

#openclash core clash
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz -o ./tmp/clash.tar.gz
tar zxvf ./tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x ./tmp/clash >/dev/null 2>&1
mkdir -p ./files/etc/openclash/core
mv ./tmp/clash ./files/etc/openclash/core >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

#openclash core clash_tun
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-amd64-2023.08.17-13-gdcc8d87.gz -o ./tmp/clash_tun.gz
tar xzvf ./tmp/clash_tun.gz -C ./tmp --transform='s/^clash/clash_tun/' >/dev/null 2>&1
chmod +x ./tmp/clash_tun >/dev/null 2>&1
mv ./tmp/clash_tun ./files/etc/openclash/core >/dev/null 2>&1
rm -rf /tmp/clash_tun.gz >/dev/null 2>&1

#openclash core clash_meta
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz -o ./tmp/clash_meta.tar.gz
tar xzvf ./tmp/clash_meta.gz -C ./tmp --transform='s/^clash/clash_meta/' >/dev/null 2>&1
chmod +x ./tmp/clash_meta >/dev/null 2>&1
mv ./tmp/clash_meta ./files/etc/openclash/core >/dev/null 2>&1
rm -rf /tmp/clash_meta.tar.gz >/dev/null 2>&1

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
