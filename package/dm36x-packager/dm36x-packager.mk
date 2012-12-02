#############################################################
#
# dm36x-packager
#
#############################################################
DM36X_PACKAGER_VERSION = edc59f1
DM36X_PACKAGER_SITE = http://github.com/fhunleth/dm36x-packager/tarball/master

define HOST_DM36X_PACKAGER_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/dm36xpackager.py \
		$(HOST_DIR)/usr/bin/dm36xpackager.py
endef

$(eval $(host-generic-package))
