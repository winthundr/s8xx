################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libretro-picodrive"
PKG_VERSION="9ae88ef"
PKG_CYCLONE="66dda84"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="picodrive-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain $PKG_NAME:host"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="Libretro implementation of PicoDrive. (Sega Megadrive/Genesis/Sega Master System/Sega GameGear/Sega CD/32X)"
PKG_LONGDESC="This is yet another Megadrive / Genesis / Sega CD / Mega CD / 32X / SMS emulator, which was written having ARM-based handheld devices in mind (such as smartphones and handheld consoles like GP2X and Pandora), but also runs on non-ARM little-endian hardware too."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  cd $PKG_BUILD
  git clone https://github.com/notaz/cyclone68000.git cpu/cyclone
  cd cpu/cyclone
  git reset --hard $PKG_CYCLONE
  cd $ROOT
}

pre_configure_host() {
  # fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$HOST_NAME
}

configure_host() {
  : none
}

make_host() {
  make -C cpu/cyclone CONFIG_FILE=../cyclone_config.h
}

makeinstall_host() {
  : none
}

pre_configure_target() {
  # fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME
}

configure_target() {
  strip_gold
}

make_target() {
  make -f Makefile.libretro GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp `find . -name "*.so" | xargs echo` $INSTALL/usr/lib/libretro/
}
