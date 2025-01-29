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
git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang

#v2ray-geodata
rm -rf feeds/packages/net/v2ray-geodata/*
git clone https://github.com/sbwml/v2ray-geodata feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-geodata/.git

#v2ray-plugin 更改go_pkg源
sed -i '25s/shadowsocks/teddysun/' feeds/small/v2ray-plugin/Makefile

# 创建OpenClash使用的clash二进制文件所在的路径
#mkdir -p files/etc/openclash/core
# 设置Clash下载地址变量
# 从github上指定分支的文件中下载
#OPENCLASH_MAIN_URL=$( curl -sL https://api.github.com/repos/vernesong/OpenClash/contents/dev/dev?ref=core | grep dev/clash-linux-amd64.tar.gz | awk -F '"' '{print $4}' | awk 'NR==4{print}' )
#CLASH_TUN_URL=$( curl -sL https://api.github.com/repos/vernesong/OpenClash/contents/dev/premium?ref=core | grep premium/clash-linux-amd64-20 | awk -F '"' '{print $4}' | awk 'NR==4{print}' )
#CLASH_META_URL=$( curl -sL https://api.github.com/repos/vernesong/OpenClash/contents/dev/meta?ref=core | grep meta/clash-linux-amd64.tar.gz | awk -F '"' '{print $4}' | awk 'NR==4{print}' )
# 下载并解压OpenClash的执行文件
#wget -qO- $OPENCLASH_MAIN_URL | tar xOvz > files/etc/openclash/core/clash
#wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
#wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
# 给Clash二进制文件增加执行权限
#chmod +x files/etc/openclash/core/clash*

#openclash core clash
#curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz -o tmp/clash.tar.gz
#tar zxvf tmp/clash.tar.gz -C tmp >/dev/null 2>&1
#chmod +x tmp/clash >/dev/null 2>&1
#mkdir -p files/etc/openclash/core
#mv tmp/clash files/etc/openclash/core >/dev/null 2>&1
#rm -rf tmp/clash.tar.gz >/dev/null 2>&1

#openclash core clash_tun
#curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-amd64-2023.08.17-13-gdcc8d87.gz -o tmp/clash_tun.gz
#gzip -d tmp/clash_tun.gz >/dev/null 2>&1
#chmod +x tmp/clash_tun >/dev/null 2>&1
#mv tmp/clash_tun files/etc/openclash/core >/dev/null 2>&1

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
