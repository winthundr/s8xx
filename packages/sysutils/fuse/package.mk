################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="fuse"
PKG_VERSION="2.9.7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/libfuse/"
PKG_URL="https://github.com/libfuse/libfuse/releases/download/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="fuse: A simple user-space filesystem interface for Linux"
PKG_LONGDESC="FUSE provides a simple interface for userspace programs to export a virtual filesystem to the Linux kernel. FUSE also aims to provide a secure method for non privileged users to create and mount their own filesystem implementations."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-lib \
                           --enable-util \
                           --disable-example \
                           --enable-mtab \
                           --disable-rpath \
                           --with-gnu-ld"

pre_configure_target() {
# fuse fails to build with GOLD linker on gcc-4.9
  strip_gold
}

post_makeinstall_target() {
  rm -rf $INSTALL/etc/init.d
  rm -rf $INSTALL/etc/udev
}
