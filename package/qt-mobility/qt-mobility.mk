######################################################################
#
# Qt Mobility
#
######################################################################

QT_MOBILITY_VERSION = 1.2.0
QT_MOBILITY_SOURCE  = v$(QT_MOBILITY_VERSION)
QT_MOBILITY_SITE    = http://qt.gitorious.org/qt-mobility/qt-mobility/archive-tarball
QT_MOBILITY_DEPENDENCIES = qt
QT_MOBILITY_INSTALL_STAGING = YES

define QT_MOBILITY_EXTRACT_CMDS
	cd $(@D) && tar xf $(DL_DIR)/$(QT_MOBILITY_SOURCE)
	mv $(@D)/qt-mobility-qt-mobility/* $(@D)/qt-mobility-qt-mobility/.commit-template $(@D)/qt-mobility-qt-mobility/.git* $(@D)
	rmdir $(@D)/qt-mobility-qt-mobility
endef

ifeq ($(BR2_PACKAGE_QT_MOBILITY_DEMOS),y)
QT_MOBILITY_CONFIGURE_OPTS += -examplesdir $(TARGET_DIR)/usr/share/qt-mobility/examples -demosdir $(TARGET_DIR)/usr/share/qt-mobility/demos -examples -demos
endif

ifeq ($(BR2_PACKAGE_QT_MOBILITY_DEBUG),y)
QT_MOBILITY_CONFIGURE_OPTS += -debug
else
QT_MOBILITY_CONFIGURE_OPTS += -release
endif

# Build the list of libraries and plugins to install to the target
ifeq ($(BR2_PACKAGE_QT_MOBILITY_BEARER),y)
QT_MOBILITY_MODULES         += bearer
QT_MOBILITY_INSTALL_LIBS    += QtBearer
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_CONTACTS),y)
QT_MOBILITY_MODULES         += contacts
QT_MOBILITY_INSTALL_LIBS    += QtContacts
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_GALLERY),y)
QT_MOBILITY_MODULES         += gallery
QT_MOBILITY_INSTALL_LIBS    += QtGallery
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_LOCATION),y)
QT_MOBILITY_MODULES         += location
QT_MOBILITY_INSTALL_LIBS    += QtLocation
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_PUBLISHSUBSCRIBE),y)
QT_MOBILITY_MODULES         += publishsubscribe
QT_MOBILITY_INSTALL_LIBS    += QtPublishSubscribe
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_MESSAGING),y)
QT_MOBILITY_MODULES         += messaging
QT_MOBILITY_INSTALL_LIBS    += QtMessaging
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_SYSTEMINFO),y)
QT_MOBILITY_MODULES         += systeminfo
QT_MOBILITY_INSTALL_LIBS    += QtSystemInfo
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_SERVICEFRAMEWORK),y)
QT_MOBILITY_MODULES         += serviceframework
QT_MOBILITY_INSTALL_LIBS    += QtServiceFramework
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_SENSORS),y)
QT_MOBILITY_MODULES         += sensors
QT_MOBILITY_INSTALL_LIBS    += QtSensors
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_VERSIT),y)
QT_MOBILITY_MODULES         += versit
QT_MOBILITY_INSTALL_LIBS    += QtVersit
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_ORGANIZER),y)
QT_MOBILITY_MODULES         += organizer
QT_MOBILITY_INSTALL_LIBS    += QtOrganizer
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_FEEDBACK),y)
QT_MOBILITY_MODULES         += feedback
QT_MOBILITY_INSTALL_LIBS    += QtFeedback
endif
ifeq ($(BR2_PACKAGE_QT_MOBILITY_CONNECTIVITY),y)
QT_MOBILITY_MODULES         += connectivity
QT_MOBILITY_INSTALL_LIBS    += QtConnectivity
endif

define QT_MOBILITY_CONFIGURE_CMDS
	-[ -f $(@D)/Makefile ] && $(MAKE) -C $(@D) confclean
	(cd $(@D); \
		MAKEFLAGS="$(MAKEFLAGS) -j$(BR2_JLEVEL)" ./configure \
		$(if $(VERBOSE),,-silent) \
		-qmake-exec "$(HOST_DIR)/usr/bin/qmake" \
		$(QT_MOBILITY_CONFIGURE_OPTS) \
		-no-docs \
		-no-tools \
		-modules "$(QT_MOBILITY_MODULES)" \
		-prefix $(STAGING_DIR)/usr \
	)
endef

define QT_MOBILITY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT_MOBILITY_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install
endef

# Library installation
define QT_MOBILITY_INSTALL_TARGET_LIBS
	for lib in $(QT_MOBILITY_INSTALL_LIBS); do \
		cp -dpf $(STAGING_DIR)/usr/lib/lib$${lib}.so.* $(TARGET_DIR)/usr/lib ; \
	done
endef

# Plugin installation
define QT_MOBILITY_INSTALL_TARGET_PLUGINS
	if [ -d $(STAGING_DIR)/usr/lib/qt/plugins/ ] ; then \
		mkdir -p $(TARGET_DIR)/usr/lib/qt/plugins ; \
		cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/* $(TARGET_DIR)/usr/lib/qt/plugins ; \
	fi
endef

define QT_MOBILITY_INSTALL_TARGET_CMDS
	$(QT_MOBILITY_INSTALL_TARGET_LIBS)
	$(QT_MOBILITY_INSTALL_TARGET_PLUGINS)
endef

$(eval $(generic-package))
