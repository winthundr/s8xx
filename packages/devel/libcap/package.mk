################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libcap"
PKG_VERSION="2.25"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="libcap: A library for getting and setting POSIX.1e capabilities"
PKG_LONGDESC="As of Linux 2.2.0, the power of the superuser has been partitioned into a set of discrete capabilities (in other places, these capabilities are know as privileges). The contents of the libcap package are a library and a number of simple programs that are intended to show how an application/daemon can be protected (with wrappers) or rewritten to take advantage of this fine grained approach to constraining the danger to your system from programs running as 'root'."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  mkdir -p $ROOT/$PKG_BUILD/.$HOST_NAME
  cp -r $ROOT/$PKG_BUILD/* $ROOT/$PKG_BUILD/.$HOST_NAME
  mkdir -p $ROOT/$PKG_BUILD/.$TARGET_NAME 
  cp -r $ROOT/$PKG_BUILD/* $ROOT/$PKG_BUILD/.$TARGET_NAME
}


make_host() {
  cd $ROOT/$PKG_BUILD/.$HOST_NAME
  make CC=$CC \
       AR=$AR \
       RANLIB=$RANLIB \
       CFLAGS="$HOST_CFLAGS" \
       BUILD_CFLAGS="$HOST_CFLAGS -I$ROOT/$PKG_BUILD/libcap/include" \
       PAM_CAP=no \
       lib=/lib \
       -C libcap libcap.pc libcap.a
}

make_target() {
  cd $ROOT/$PKG_BUILD/.$TARGET_NAME
  make CC=$CC \
       AR=$AR \
       RANLIB=$RANLIB \
       CFLAGS="$TARGET_CFLAGS" \
       BUILD_CC=$HOST_CC \
       BUILD_CFLAGS="$HOST_CFLAGS -I$ROOT/$PKG_BUILD/libcap/include" \
       PAM_CAP=no \
       lib=/lib \
       -C libcap libcap.pc libcap.a
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/lib
    cp libcap/libcap.a $ROOT/$TOOLCHAIN/lib

  mkdir -p $ROOT/$TOOLCHAIN/lib/pkgconfig
    cp libcap/libcap.pc $ROOT/$TOOLCHAIN/lib/pkgconfig

  mkdir -p $ROOT/$TOOLCHAIN/include/sys
    cp libcap/include/sys/capability.h $ROOT/$TOOLCHAIN/include/sys
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp libcap/libcap.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libcap/libcap.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

  mkdir -p $SYSROOT_PREFIX/usr/include/sys
    cp libcap/include/sys/capability.h $SYSROOT_PREFIX/usr/include/sys
}
