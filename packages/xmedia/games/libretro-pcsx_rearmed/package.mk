################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libretro-pcsx_rearmed"
PKG_VERSION="358a876"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="pcsx_rearmed-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_LONGDESC="PCSX ReARMed is yet another PCSX fork based on the PCSX-Reloaded project, which itself contains code from PCSX, PCSX-df and PCSX-Revolution."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  strip_gold
}

make_target() {
  cd $ROOT/$PKG_BUILD
  make -f Makefile.libretro platform="armv neon hardfloat" GIT_VERSION=$PKG_VERSION
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp `find . -name "*.so" | xargs echo` $INSTALL/usr/lib/libretro/
}
