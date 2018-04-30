################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mt7610u"
PKG_VERSION="34a7865"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/sohaib17/mt7610u"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Mediatek mt7610u Linux driver"
PKG_LONGDESC="Mediatek mt7610u Linux driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  sed -i '198s|.*LINUX_SRC.*|LINUX_SRC = '$(kernel_path)'|' Makefile
  sed -i '199s|.*LINUX_SRC_MODULE.*|LINUX_SRC_MODULE = '$INSTALL'/lib/modules/'$(get_module_dir)'/kernel/drivers/net/wireless/|' Makefile

  # fix system version ignore
  sed -i 's|findstring 2.4|findstring 9999|g' Makefile
  sed -i 's|findstring 2.4|findstring 9999|g' os/linux/config.mk

  make osdrv

}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp os/linux/mt7610u_sta.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
  mkdir -p $INSTALL/lib/firmware/mt7610u
    cp RT2870STA.dat $INSTALL/lib/firmware/mt7610u/mt7610u_sta.dat
}
