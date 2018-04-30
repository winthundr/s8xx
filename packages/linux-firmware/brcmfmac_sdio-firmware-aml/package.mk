################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="brcmfmac_sdio-firmware-aml"
PKG_VERSION="da1c4e4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kszaq/brcmfmac_sdio-firmware-aml"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="brcmfmac_sdio-firmware: firmware for brcm bluetooth chips used in some Amlogic based devices"
PKG_LONGDESC="Firmware for Broadcom Bluetooth devices used in some Amlogic based devices, and brcm-patchram-plus that downloads a patchram files in the HCD format to the Bluetooth based silicon and combo chips and other utility functions."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_makeinstall_target() {
  cd $INSTALL/lib/firmware/brcm
  for f in *.hcd; do
    ln -sr $f $(grep --text -o 'BCM\S*' $f).hcd 2>/dev/null || true
    ln -sr $f $(grep --text -o 'BCM\S*' $f | cut -c4-).hcd 2>/dev/null || true
    ln -sr $f $(echo $f | sed -r 's/[^.]*/\U&/') 2>/dev/null || true
    ln -sr bcm4335_V0343.0353.hcd BCM4335A0.hcd 2>/dev/null || true
  done
}
