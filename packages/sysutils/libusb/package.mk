################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libusb"
PKG_VERSION="1.0.20"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://libusb.info/"
PKG_URL="$SOURCEFORGE_SRC/libusb/files/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_SECTION="system"
PKG_SHORTDESC="libusb: OS independent USB device access"
PKG_LONGDESC="The libusb project's aim is to create a Library for use by user level applications to USB devices regardless of OS."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
            --enable-static \
            --disable-log \
            --disable-debug-log \
            --enable-udev \
            --disable-examples-build"

pre_configure_target () {
  #libusb sometimes fails to build if building paralell
  export MAKEFLAGS=-j1
}
