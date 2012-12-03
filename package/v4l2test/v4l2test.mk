#############################################################
#
# v4l2test
#
#############################################################

V4L2TEST_VERSION = ca3aef8
V4L2TEST_SITE_METHOD = git
V4L2TEST_SITE = ssh://git@bitbucket.org/fhunleth/v4l2test.git
V4L2TEST_DEPENDENCIES = ti-framework-components ti-codec-engine ti-xdctools qt libqxt ti-dm365-codecs-h264enc 

define V4L2TEST_CONFIGURE_CMDS
	cd $(@D) && BUILDROOT_BASE=$(TOPDIR) $(QT_QMAKE) -after "target.path=$(TARGET_DIR)/usr/bin" v4l2test.pro
endef

define V4L2TEST_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define V4L2TEST_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
