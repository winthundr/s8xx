################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libretro-parallel-n64"
PKG_VERSION="44700e6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="https://github.com/libretro/parallel-n64/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="parallel-n64-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/games"
PKG_SHORTDESC="mupen64plus-libretro: Libretro port of Mupen64 Plus."
PKG_LONGDESC="mupen64plus-libretro: Libretro port of Mupen64 Plus."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  strip_lto
}

pre_build_target() {
  export GIT_VERSION=$PKG_VERSION
}

make_target() {
  case $PROJECT in
    S805*)
      project=armv-aml805
      ;;
    S812*)
      project=armv-aml812
      ;;
    S905*)
      project=armv-aml905
      ;;
  esac
  make WITH_DYNAREC=$TARGET_ARCH platform=$project
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp `find . -name "*.so" | xargs echo` $INSTALL/usr/lib/libretro/
}
