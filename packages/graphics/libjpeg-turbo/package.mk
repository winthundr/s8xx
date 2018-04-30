################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libjpeg-turbo"
PKG_VERSION="1.5.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libjpeg-turbo.virtualgl.org/"
PKG_URL="$SOURCEFORGE_SRC/libjpeg-turbo/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="graphics"
PKG_SHORTDESC="libjpeg-turbo: a high-speed version of libjpeg for x86 and x86-64 processors which uses SIMD instructions (MMX, SSE2, etc.) to accelerate baseline JPEG compression and decompression."
PKG_LONGDESC="libjpeg-turbo is a high-speed version of libjpeg for x86 and x86-64 processors which uses SIMD instructions (MMX, SSE2, etc.) to accelerate baseline JPEG compression and decompression. libjpeg-turbo is generally 2-4x as fast as the unmodified version of libjpeg, all else being equal."

PKG_IS_ADDON="no"
PKG_USE_CMAKE="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="--enable-static \
                         --disable-shared \
                         --with-jpeg8 \
                         --without-simd"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --enable-shared --with-jpeg8"

pre_configure_host() {
  export CFLAGS="$CFLAGS -fPIC -DPIC"
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC -DPIC"
}

if [ "$SIMD_SUPPORT" = "no" ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --without-simd"
fi

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
