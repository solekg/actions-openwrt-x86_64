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

# Modify rust
#sed -i '78s/true/false/' feeds/packages/lang/rust/Makefile

# 移除要替换的包
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/packages/net/{adguardhome,mosdns,v2ray-geodata,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
git clone https://github.com/pymumu/luci-app-smartdns feeds/luci/applications/luci-app-smartdns
git clone https://github.com/sbwml/v2ray-geodata feeds/packages/net/v2ray-geodata
#git clone https://github.com/pymumu/openwrt-smartdns feeds/packages/net/smartdns
#git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

cp -r feeds/kenzo/adguardhome/* feeds/packages/net/adguardhome

#openclash core clash_meta
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz -o tmp/clash_meta.tar.gz
tar xzvf tmp/clash_meta.tar.gz -C tmp --transform='s/^clash/clash_meta/' >/dev/null 2>&1
chmod +x tmp/clash_meta >/dev/null 2>&1
mv tmp/clash_meta files/etc/openclash/core >/dev/null 2>&1
rm -rf tmp/clash_meta.tar.gz >/dev/null 2>&1

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
