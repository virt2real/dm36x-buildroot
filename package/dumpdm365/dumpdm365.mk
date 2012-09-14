#############################################################
#
# dumpdm365
#
#############################################################

DUMPDM365_VERSION = master
DUMPDM365_SITE = https://github.com/fhunleth/dumpdm365.git
DUMPDM365_SITE_METHOD = git

define DUMPDM365_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CROSS)gcc -C $(@D)
endef

define DUMPDM365_INSTALL_TARGET_CMDS
	cp -pPrf $(@D)/dumpdm365 $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
