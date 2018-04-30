################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="usbutils"
PKG_VERSION="008"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linux-usb.org/"
PKG_URL="http://kernel.org/pub/linux/utils/usb/usbutils/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libusb systemd"
PKG_SECTION="system"
PKG_SHORTDESC="usbutils: Linux USB Utilities"
PKG_LONGDESC="This package contains various utilities for inspecting and setting of devices connected to the USB bus. Requires a kernel version including usbdevfs support - and this usbdevfs mounted to /proc/bus/usb."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/lsusb.py
  rm -rf $INSTALL/usr/bin/usbhid-dump
}
