################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="bkeymaps"
PKG_VERSION="1.13"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alpinelinux.org"
PKG_URL="http://dev.alpinelinux.org/archive/bkeymaps/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain busybox"
PKG_SECTION="system"
PKG_SHORTDESC="bkeymaps: binary keyboard maps for busybox"
PKG_LONGDESC="bkeymaps: binary keyboard maps for busybox"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo, we install manually
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/keymaps
    cp -PR bkeymaps/* $INSTALL/usr/lib/keymaps

  #russian UTF-8 keymap for a 102 key keyboard
  rm -rf $INSTALL/usr/lib/keymaps/ru/*
  cp $PKG_DIR/config/Russian-Ctrl_Shift.bmap $INSTALL/usr/lib/keymaps/ru
}
