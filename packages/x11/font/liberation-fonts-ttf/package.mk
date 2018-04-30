################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="liberation-fonts-ttf"
PKG_VERSION="2.00.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OFL1_1"
PKG_SITE="https://www.redhat.com/promo/fonts/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_SECTION="x11/fonts"
PKG_SHORTDESC="liberation-fonts: High quality "open-sourced" vector fonts"
PKG_LONGDESC="This packages included the high-quality and open-sourced TrueType vector fonts released by RedHat."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/fonts/liberation
    cp *.ttf $INSTALL/usr/share/fonts/liberation
}

post_install() {
  mkfontdir $INSTALL/usr/share/fonts/liberation
  mkfontscale $INSTALL/usr/share/fonts/liberation
}
