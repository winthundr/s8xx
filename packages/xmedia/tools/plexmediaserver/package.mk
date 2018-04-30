################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="plexmediaserver"
PKG_VERSION="1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://plex.tv"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="Plex Media Server"
PKG_LONGDESC="Plex Media Server."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : none
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/* $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/share/plex
    cp -P $PKG_DIR/config/* $INSTALL/usr/share/plex
}

post_install() {
  enable_service plex.service
}
