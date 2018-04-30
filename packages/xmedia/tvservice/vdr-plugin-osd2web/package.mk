################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-osd2web"
PKG_VERSION="b9e0a00"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/horchi/vdr-plugin-osd2web"
PKG_URL="https://github.com/horchi/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr libwebsockets jansson tinyxml2"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="TV"
PKG_LONGDESC="TV"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_LOCALE_INSTALL="yes"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR CXX=$CXX GIT_REV=$PKG_VERSION
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config
    mv -f $INSTALL/storage/.config/vdr $INSTALL/usr/config
  rm -rf $INSTALL/storage
}
