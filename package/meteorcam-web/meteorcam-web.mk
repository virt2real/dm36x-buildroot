#############################################################
#
# meteorcam-web
#
#############################################################

METEORCAM_WEB_VERSION = 007a22a
METEORCAM_WEB_SITE_METHOD = git
METEORCAM_WEB_SITE = ssh://git@bitbucket.org/fhunleth/meteorcam-web.git
METEORCAM_WEB_DEPENDENCIES = lighttpd

define METEORCAM_WEB_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/www/htdocs
	$(MAKE) -C $(@D) WEB_ROOT=$(TARGET_DIR)/var/www/htdocs install
endef

$(eval $(generic-package))
