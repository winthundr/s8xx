################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libvlc"
PKG_VERSION="2.2.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org"
PKG_URL="http://get.videolan.org/vlc/$PKG_VERSION/vlc-$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="vlc-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain ffmpeg2 libmad"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="VLC library"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-libgcrypt --disable-taglib --disable-lua --disable-a52 --disable-vlc"

pre_configure_target() {
  export PKG_CONFIG_PATH=$SYSROOT_PREFIX/usr/lib/ffmpeg2/pkgconfig
  strip_lto
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/usr/lib/vlc/plugins/video_filter
  rm -rf $INSTALL/usr/lib/vlc/plugins/visualization
}
