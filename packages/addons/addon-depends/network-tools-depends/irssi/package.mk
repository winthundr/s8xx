################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="irssi"
PKG_VERSION="0.8.19"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.irssi.org/"
PKG_URL="https://github.com/irssi-import/irssi/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib netbsd-curses openssl"
PKG_SECTION="tools"
PKG_SHORTDESC="IRC client"
PKG_LONGDESC="Irssi is a terminal based IRC client for UNIX systems"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
        --enable-ssl \
        --disable-glibtest \
        --without-socks \
        --with-textui \
        --without-bot \
        --without-proxy \
        --with-gc \
        --without-perl \
        --without-sco"

pre_configure_target() {
  export CFLAGS="$CFLAGS -I$ROOT/$PKG_BUILD"
  export LIBS="-ltermcap"
}

makeinstall_target() {
  : # nop
}
