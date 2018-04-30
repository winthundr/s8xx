################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="qca9377-firmware-aml"
PKG_VERSION="1.0.0-3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://boundarydevices.com/product/bd_sdmac_wifi/"
PKG_URL="$ALEXELEC_SRC/qca-firmware_${PKG_VERSION}_armhf.deb"
PKG_SOURCE_DIR="qca-firmware-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  mkdir -p "$BUILD/$PKG_NAME-$PKG_VERSION"
  dpkg -x "$SOURCES/$PKG_NAME/$PKG_SOURCE_NAME" "$BUILD/$PKG_NAME-$PKG_VERSION"
}

make_target() {
  : # nothing todo
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/firmware
    cp -PR lib/firmware $INSTALL/lib
    cp -P usr/share/doc/qca-firmware/copyright $INSTALL/lib/firmware/LICENSE.qca
}
