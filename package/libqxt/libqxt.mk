#############################################################
#
# libqxt
#
#############################################################

LIBQXT_VERSION = 0.6.2
LIBQXT_SOURCE = v$(LIBQXT_VERSION).tar.gz
LIBQXT_SITE = http://dev.libqxt.org/libqxt/get
LIBQXT_DEPENDENCIES = qt

LIBQXT_INSTALL_STAGING = YES

LIBQXT_CONFIGURE_OPTS = -prefix $(STAGING_DIR)/usr -verbose -qws -nomake designer

ifneq ($(BR2_HAVE_DOCUMENTATION),y)
LIBQXT_CONFIGURE_OPTS += -nomake docs
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
LIBQXT_CONFIGURE_OPTS += -debug
else
LIBQXT_CONFIGURE_OPTS += -release
endif

ifneq ($(BR2_PACKAGE_BERKELEY),y)
LIBQXT_CONFIGURE_OPTS += -no-db
endif

ifeq ($(BR2_PACKAGE_AVAHI),y)
LIBQXT_DEPENDENCIES += avahi
else
LIBQXT_CONFIGURE_OPTS += -no-zeroconf
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXRANDR),y)
LIBQXT_DEPENDENCIES += xlib_libXrandr
else
LIBQXT_CONFIGURE_OPTS += -no-xrandr 
endif

ifeq ($(BR2_PACKAGE_LIBQXT_STATIC),y)
LIBQXT_CONFIGURE_OPTS += -static
endif

LIBQXT_INSTALL_LIBS = QxtCore

ifeq ($(BR2_PACKAGE_LIBQXT_BERKELEYDB_MODULE),y)
LIBQXT_DEPENDENCIES += berkeleydb
LIBQXT_INSTALL_LIBS += QxtBerkeley
else
LIBQXT_CONFIGURE_OPTS += -nomake berkeley
endif

ifeq ($(BR2_PACKAGE_LIBQXT_GUI_MODULE),y)
LIBQXT_INSTALL_LIBS += QxtGui
else
LIBQXT_CONFIGURE_OPTS += -nomake gui
endif

ifeq ($(BR2_PACKAGE_LIBQXT_NETWORK_MODULE),y)
LIBQXT_INSTALL_LIBS += QxtNetwork
else
LIBQXT_CONFIGURE_OPTS += -nomake network
endif

ifeq ($(BR2_PACKAGE_LIBQXT_SQL_MODULE),y)
LIBQXT_INSTALL_LIBS += QxtSql
else
LIBQXT_CONFIGURE_OPTS += -nomake sql
endif

ifeq ($(BR2_PACKAGE_LIBQXT_WEB_MODULE),y)
LIBQXT_INSTALL_LIBS += QxtWeb
else
LIBQXT_CONFIGURE_OPTS += -nomake web
endif

ifeq ($(BR2_PACKAGE_LIBQXT_ZEROCONF_MODULE),y)
LIBQXT_INSTALL_LIBS += QxtZeroconf
else
LIBQXT_CONFIGURE_OPTS += -nomake zeroconf
endif

define LIBQXT_CONFIGURE_CMDS
	cd $(@D) && \
		$(TARGET_MAKE_ENV) ./configure $(LIBQXT_CONFIGURE_OPTS)
endef

define LIBQXT_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define LIBQXT_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install
endef

# Library installation
ifeq ($(BR2_PACKAGE_LIBQXT_SHARED),y)
define LIBQXT_INSTALL_TARGET_LIBS
        for lib in $(LIBQXT_INSTALL_LIBS); do \
                cp -dpf $(STAGING_DIR)/usr/lib/lib$${lib}.so.* $(TARGET_DIR)/usr/lib ; \
        done
endef
endif

define LIBQXT_INSTALL_TARGET_CMDS
	$(LIBQXT_INSTALL_TARGET_LIBS)
endef

$(eval $(generic-package))
