################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libusb-compat"
PKG_VERSION="0.1.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libusb.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/libusb/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="system"
PKG_SHORTDESC="libusb-compat: OS independent USB device access"
PKG_LONGDESC="The libusb project's aim is to create a Library for use by user level applications to USB devices regardless of OS."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-log --disable-debug-log --disable-examples-build"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i $SYSROOT_PREFIX/usr/bin/libusb-config
}
