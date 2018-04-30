################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="arm-mem"
PKG_VERSION="3aee5f4"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/bavison/arm-mem"
PKG_URL="https://github.com/bavison/arm-mem/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain arm-mem"
PKG_SECTION="devel"
PKG_SHORTDESC="arm-mem: ARM-accelerated versions of selected functions from string.h"
PKG_LONGDESC="arm-mem is a ARM-accelerated versions of selected functions from string.h"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="libarmmem.so"

pre_make_target() {
  export CROSS_COMPILE=$TARGET_PREFIX
  export CFLAGS="$CFLAGS -fPIC"
}

make_init() {
  : # reuse make_target()
}

makeinstall_target() {
  mkdir -p $INSTALL/lib
    cp -P libarmmem.so $INSTALL/lib

  mkdir -p $INSTALL/etc
    echo "/lib/libarmmem.so" >> $INSTALL/etc/ld.so.preload
}

makeinstall_init() {
  mkdir -p $INSTALL/lib
    cp -P libarmmem.so $INSTALL/lib

  mkdir -p $INSTALL/etc
    echo "/lib/libarmmem.so" >> $INSTALL/etc/ld.so.preload
}
