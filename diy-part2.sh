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
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

#!/bash
# 1. 修改 DTS 分区表支持 512M (核心修改)
# 注意：一定要确认 0x7000000 这个原长度在你的源码版本中是否准确
sed -i 's/0x0580000/0x1E000000/g' target/linux/mediatek/dts/mt7986a-netcore-n60-pro.dts

# 2. 修改 Makefile 插入 IMAGE_SIZE 限制 (防止超限报错)
# sed -i '/Device\/netcore_n60-pro/,/endef/ { /DEVICE_DTS :=/ a \  IMAGE_SIZE := 480M' } target/linux/mediatek/image/filogic.mk

# 3. 调整 Rootfs 默认大小 (你觉得 160MB 太大，这里改回 100MB)
# 这会修改你上传的 .config 中的配置值
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=160/CONFIG_TARGET_ROOTFS_PARTSIZE=100/g' .config
