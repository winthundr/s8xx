################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="tinyxml2"
PKG_VERSION="5.0.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="zlib"
PKG_SITE="http://www.grinninglizard.com/tinyxml2/index.html"
PKG_URL="https://github.com/leethomason/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="textproc"
PKG_SHORTDESC="tinyxml2: XML parser library"
PKG_LONGDESC="TinyXML2 is a simple, small, C++ XML parser that can be easily integrating into other programs."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=off -DBUILD_STATIC_LIBS=on"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
