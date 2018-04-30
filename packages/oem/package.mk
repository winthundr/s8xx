################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="oem"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="various"
PKG_SITE="http://alexelec.in.ua"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain rng-tools u-boot-tools"
PKG_SECTION="virtual"
PKG_SHORTDESC="OEM: Metapackage for various OEM packages"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_install() {
  if [ -n "$DEVICE" -a -d "$PROJECT_DIR/$PROJECT/devices/$DEVICE/filesystem" ]; then
    cp -LR $PROJECT_DIR/$PROJECT/devices/$DEVICE/filesystem/* $ROOT/$BUILD/image/system
  fi

  if [ -n "$DEVICE" -a -e "$PROJECT_DIR/$PROJECT/devices/$DEVICE/install/files/logo.img" ]; then
    mkdir -p $ROOT/$BUILD/image/system/usr/share/bootloader
    cp -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/install/files/logo.img $ROOT/$BUILD/image/system/usr/share/bootloader
  elif [ -e "$PROJECT_DIR/$PROJECT/install/files/logo.img" ]; then
    mkdir -p $ROOT/$BUILD/image/system/usr/share/bootloader
    cp -f $PROJECT_DIR/$PROJECT/install/files/logo.img $ROOT/$BUILD/image/system/usr/share/bootloader
  fi
}

# services net
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET acestream-aml"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET HTTPAceProxy"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET acephproxy"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET transmission"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET minidlna"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET noxbit"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET plexmediaserver"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET tor"

# tv services
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vdr-all tvheadend"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET wicard oscam tvip"

# tools
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET ImageMagick mc aml-vnc scan-s2 scan-m3u serviceref"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET udpxy syncthing xupnpd boblightd htop"

# games
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation retroarch"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-parallel-n64"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-ppsspp"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-pcsx_rearmed"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-genesis-plus-gx"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-snes9x2010"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-mame2003"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-fbalpha"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-fuse"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-nestopia"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libretro-picodrive"

# dvb drivers
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET media_build_cc"
