################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libwebsockets"
PKG_VERSION="2.2.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libwebsockets.org/"
PKG_URL="https://github.com/warmcat/$PKG_NAME/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="C library for websocket clients and servers"
PKG_LONGDESC="C library for websocket clients and servers."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share
}
