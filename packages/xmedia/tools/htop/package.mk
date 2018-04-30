################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="htop"
PKG_VERSION="2.0.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://hisham.hm/htop"
PKG_URL="https://github.com/hishamhm/htop/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="An interactive process viewer for Unix"
PKG_LONGDESC="An interactive process viewer for Unix."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fno-strict-aliasing -lncurses -lterminfo"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share
}
