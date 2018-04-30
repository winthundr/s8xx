################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libcec"
PKG_VERSION="f2c4ca7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libcec.pulse-eight.com/"
PKG_URL="https://github.com/Pulse-Eight/libcec/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd lockdev p8-platform"
PKG_SECTION="system"
PKG_SHORTDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor"
PKG_LONGDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=1 \
                       -DCMAKE_INSTALL_LIBDIR=/usr/lib \
                       -DCMAKE_INSTALL_LIBDIR_NOARCH=/usr/lib \
                       -DCMAKE_INSTALL_PREFIX_TOOLCHAIN=$SYSROOT_PREFIX/usr \
                       -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr"


if [ "$KODIPLAYER_DRIVER" = "libamcodec" ]; then
  if [ "$TARGET_KERNEL_ARCH" = "arm64" ]; then
    PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_AOCEC_API=1"
  else
    PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_AMLOGIC_API=1"
  fi
else
  PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_AOCEC_API=0 -DHAVE_AMLOGIC_API=0"
fi

post_makeinstall_target() {
  if [ -d $INSTALL/usr/lib/python2.7/dist-packages ]; then 
    mv $INSTALL/usr/lib/python2.7/dist-packages $INSTALL/usr/lib/python2.7/site-packages
  fi
}
