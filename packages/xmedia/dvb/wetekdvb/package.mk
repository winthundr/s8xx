################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="wetekdvb"
PKG_VERSION="20170608"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.wetek.com/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="xmedia/dvb"
PKG_SHORTDESC="wetekdvb: Wetek DVB driver"
PKG_LONGDESC="These package contains Wetek's DVB driver "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp $PKG_DIR/module_bin/wetekdvb.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/lib/firmware
    cp firmware/* $INSTALL/lib/firmware
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service wetekdvb.service
}
