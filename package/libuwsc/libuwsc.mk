################################################################################
#
# libuwsc
#
################################################################################

LIBUWSC_VERSION = 3.0.3
LIBUWSC_SITE = $(call github,zhaojh329,libuwsc,v$(LIBUWSC_VERSION))
LIBUWSC_INSTALL_STAGING = YES
LIBUWSC_LICENSE = LGPL-2.1
LIBUWSC_LICENSE_FILES = LICENSE
LIBUWSC_DEPENDENCIES = libev

LIBUWSC_CONF_OPTS += -DCMAKE_INCLUDE_PATH=$(TARGET_DIR)/usr
LIBUWSC_CONF_OPTS += -DCMAKE_LIBRARY_PATH=$(TARGET_DIR)/usr

ifeq ($(BR2_PACKAGE_LIBUWSC_OPENSSL),y)
LIBUWSC_DEPENDENCIES += openssl
LIBUWSC_CONF_OPTS += -DUWSC_USE_OPENSSL=ON
else ifeq ($(BR2_PACKAGE_LIBUWSC_WOLFSSL),y)
LIBUWSC_DEPENDENCIES += wolfssl
LIBUWSC_CONF_OPTS += -DUWSC_USE_WOLFSSL=ON
else ifeq ($(BR2_PACKAGE_LIBUWSC_MBEDTLS),y)
LIBUWSC_DEPENDENCIES += mbedtls
LIBUWSC_CONF_OPTS += -DUWSC_USE_MBEDTLS=ON
else
LIBUWSC_CONF_OPTS += -DUWSC_SSL_SUPPORT=OFF
endif

$(eval $(cmake-package))
