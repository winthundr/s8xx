################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="tinc"
PKG_VERSION="1.1pre14"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://www.tinc-vpn.org/"
PKG_URL="${PKG_SITE}/packages/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl lzo zlib"
PKG_SECTION="service/system"
PKG_SHORTDESC="tinc: a Virtual Private Network daemon"
PKG_LONGDESC="tinc ($PKG_VERSION) is a Virtual Private Network (VPN) daemon that uses tunnelling and encryption to create a secure private network between hosts on the Internet. Because the VPN appears to the IP level network code as a normal network device, there is no need to adapt any existing software. This allows VPN sites to share information with each other over the Internet without exposing any information to others."
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="tinc"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

PKG_CONFIGURE_OPTS_TARGET="--disable-curses   \
                           --disable-readline \
                           --sysconfdir=/storage/.cache"

pre_configure_target() {
  # tinc fails to build in subdirs
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/src/tinc \
     $PKG_BUILD/src/tincd \
     $ADDON_BUILD/$PKG_ADDON_ID/bin
}
