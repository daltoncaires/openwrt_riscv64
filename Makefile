#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=riscv64
BOARD:=riscv64
BOARDNAME:=RISC-V HiFive Unleashed / QEMU
FEATURES:=ext4
DEVICE_TYPE:=developerboard
MAINTAINER:=Zoltan HERPAI <wigyori@uid0.hu>, Alex Guo <xfguo@xfguo.org>

KERNEL_PATCHVER:=4.19

include $(INCLUDE_DIR)/target.mk

define Target/Description
	Build firmware images for the HiFive Unleashed and QEMU
endef

DEFAULT_PACKAGES += kmod-leds-gpio kmod-usb-net wpad-mini

$(eval $(call BuildTarget))
