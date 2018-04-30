################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libamcodec"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="other"
PKG_SITE="http://openlinux.amlogic.com"
case $TARGET_KERNEL_ARCH in
  arm)
    PKG_VERSION="5e23a81"
    PKG_URL="https://github.com/codesnake/libamcodec/archive/$PKG_VERSION.tar.gz"
    ;;
  arm64)
    PKG_VERSION="6d5faf2"
    PKG_URL="https://github.com/AlexELEC/libamcodec/archive/$PKG_VERSION.tar.gz"
    ;;
esac
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libamcodec: Interface library for Amlogic media codecs"
PKG_LONGDESC="libamplayer: Interface library for Amlogic media codecs"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make -C amavutils CC="$CC" PREFIX="$SYSROOT_PREFIX/usr"
  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PR amavutils/*.so $SYSROOT_PREFIX/usr/lib

  make -C amadec CC="$CC" PREFIX="$SYSROOT_PREFIX/usr" CROSS_PREFIX="$TARGET_PREFIX" install
  make -C amcodec CC="$CC" HEADERS_DIR="$SYSROOT_PREFIX/usr/include/amcodec" PREFIX="$SYSROOT_PREFIX/usr" CROSS_PREFIX="$TARGET_PREFIX" install
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp -PR amavutils/*.so $INSTALL/usr/lib

  make -C amadec PREFIX="$INSTALL/usr" install
  make -C amcodec HEADERS_DIR="$INSTALL/usr/include/amcodec" PREFIX="$INSTALL/usr" install
}
