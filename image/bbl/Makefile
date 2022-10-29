# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package-defaults.mk

PKG_NAME := bbl
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

#EXTRA_LDFLAGS := -L$(PKG_BUILD_DIR)

CONFIG_VARS := \
	CC="$(TARGET_CC)" LD="$(TARGET_CROSS)ld" CFLAGS="$(TARGET_CFLAGS)"

CONFIGURE_ARGS += \
	--enable-logo \
	--with-arch=rv64imafdc \
	--with-payload=$(KERNEL_BUILD_DIR)/vmlinux \
	--prefix=$(KERNEL_BUILD_DIR) \
	--srcdir=..

$(PKG_BUILD_DIR)/.prepared:
	mkdir $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
	mkdir $(PKG_BUILD_DIR)/work
	cd $(PKG_BUILD_DIR)/work; chmod +x ../configure; $(CONFIG_VARS) ../configure $(CONFIGURE_ARGS)
	touch $@

$(PKG_BUILD_DIR)/bbl: $(PKG_BUILD_DIR)/.prepared
	$(MAKE) -C $(PKG_BUILD_DIR)/work bbl
	$(CP) $(PKG_BUILD_DIR)/work/bbl $(BIN_DIR)/bbl.qemu
	$(TARGET_CROSS)objcopy -S -O binary --change-addresses -0x80000000 $(PKG_BUILD_DIR)/work/bbl $(BIN_DIR)/bbl.bin

download: 
prepare: $(PKG_BUILD_DIR)/.prepared
compile: $(PKG_BUILD_DIR)/bbl
install:

clean:
	rm -rf $(PKG_BUILD_DIR)
