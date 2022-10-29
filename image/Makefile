#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/Clean
	$(MAKE) -C bbl clean
endef

define Image/Prepare
	cp $(KDIR)/vmlinux.elf $(BIN_DIR)/$(IMG_PREFIX)-vmlinux.elf
endef

define Image/Build/riscv-sdcard
	./gen_riscv64_sdcard_img.sh \
		$(BIN_DIR)/sdcard.img \
		$(BIN_DIR)/bbl.bin \
		$(KDIR)/root.$(1) \
		$(CONFIG_RISCV64_SD_BOOT_PARTSIZE) \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE)
	gzip -f9 $(BIN_DIR)/sdcard.img
endef

define Image/Build
	$(MAKE) -C bbl compile
	$(call Image/Build/riscv-sdcard,$(1),$(IMG_PREFIX)-$(PROFILE)-sdcard.img)
	
	$(CP) $(KDIR)/root.$(1) $(BIN_DIR)/
endef

$(eval $(call BuildImage))
