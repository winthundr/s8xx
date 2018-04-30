################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-sc"
PKG_VERSION="a6fc7dc"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/3PO/vdr-plugin-sc"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr libdvbcsa openssl"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="Softcam plugin to VDR"
PKG_LONGDESC="Softcam plugin to VDR."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_LOCALE_INSTALL="yes"

pre_make_target() {
  # dont build parallel
  MAKEFLAGS=-j1
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
       LIBDVBCSA=1 \
       RELEASE="1.1" \
       SUBREL="AlexELEC"
}

makeinstall_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
       LIBDVBCSA=1 \
       RELEASE="1.1" \
       SUBREL="AlexELEC" \
       DESTDIR=$INSTALL \
       install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/vdr/plugins/sc
    cp $PKG_DIR/config/* $INSTALL/usr/config/vdr/plugins/sc
}
