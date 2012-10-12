#############################################################
#
# UBL
#
#############################################################
UBL_VERSION = cf5d4f1
UBL_SITE = git@bitbucket.org:fhunleth/dm36x-flash-utils.git
UBL_SITE_METHOD = git

UBL_INSTALL_IMAGES = YES
UBL_CONFIGNAME = $(call qstrip,$(BR2_TARGET_UBL_CONFIGNAME))

define UBL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/DM36x/GNU/ubl/build TYPE=$(UBL_CONFIGNAME)
endef

define UBL_INSTALL_IMAGES_CMDS
	cp -dpf $(@D)/DM36x/GNU/ubl/ubl_DM36x_$(UBL_CONFIGNAME).bin $(BINARIES_DIR)/
endef

$(eval $(generic-package))

