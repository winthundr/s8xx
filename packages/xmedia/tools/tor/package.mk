################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="tor"
PKG_VERSION="0.3.1.7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.torproject.org"
PKG_URL="https://archive.torproject.org/tor-package-archive/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl libevent"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="Anonymizing overlay network"
PKG_LONGDESC="Anonymizing overlay network."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="\
              --enable-upnp \
              --enable-libevent \
              --disable-gcc-hardening"

post_makeinstall_target() {
  mkdir -p  $INSTALL/usr/config
    mv -f $INSTALL/etc/tor $INSTALL/usr/config
    ln -sf /storage/.config/tor $INSTALL/etc/tor
}

post_install() {
  add_user tor x 990 990 "Tor Server" "/storage" "/bin/sh"
  add_group tor 990
}
