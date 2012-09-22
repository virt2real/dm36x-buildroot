#############################################################
#
# dm36x-packager
#
#############################################################
DM36X_PACKAGER_VERSION = 277df03
DM36X_PACKAGER_SITE = git@bitbucket.org:fhunleth/dm36x-packager.git
DM36X_PACKAGER_SITE_METHOD = git

$(eval $(host-autotools-package))
