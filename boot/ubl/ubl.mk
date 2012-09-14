#############################################################
#
# UBL
#
#############################################################
UBL_VERSION = 338445e
UBL_SITE = git@bitbucket.org:fhunleth/dm36x-flash-utils.git
UBL_SITE_METHOD = git

UBL_INSTALL_IMAGES = YES

UBL_BUILD_TYPE = dm368sdmmc

define UBL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/DM36x/GNU/ubl/build TYPE=$(UBL_BUILD_TYPE)
endef

define UBL_INSTALL_IMAGES_CMDS
	cp -dpf $(@D)/DM36x/GNU/ubl/ubl_DM36x_$(UBL_BUILD_TYPE).bin $(BINARIES_DIR)/
endef

$(eval $(generic-package))

