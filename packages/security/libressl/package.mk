################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libressl"
PKG_VERSION="2.4.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.libressl.org/"
PKG_URL="http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="security"
PKG_SHORTDESC="libressl: a FREE version of the SSL/TLS protocol forked from OpenSSL"
PKG_LONGDESC="LibreSSL is a FREE version of the SSL/TLS protocol forked from OpenSSL"

PKG_IS_ADDON="no"
PKG_USE_CMAKE="no"
PKG_AUTORECONF="yes"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp */.libs/*.so.?? $INSTALL/usr/lib/
}
