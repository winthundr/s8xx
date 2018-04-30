################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="openvpn"
PKG_VERSION="2.3.12"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://openvpn.net"
PKG_URL="http://swupdate.openvpn.org/community/releases/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain lzo openssl"
PKG_SECTION="network"
PKG_SHORTDESC="openvpn: a full featured SSL VPN software solution that integrates OpenVPN server capabilities."
PKG_LONGDESC="OpenVPN Access Server is a full featured SSL VPN software solution that integrates OpenVPN server capabilities, enterprise management capabilities, simplified OpenVPN Connect UI, and OpenVPN Client software packages that accommodate Windows, MAC, and Linux OS environments. OpenVPN Access Server supports a wide range of configurations, including secure and granular remote access to internal network and/ or private cloud network resources and applications with fine-grained access control."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_have_decl_TUNSETPERSIST=no \
                           --disable-server \
                           --enable-password-save \
                           --disable-plugins \
                           --enable-iproute2 IPROUTE=/sbin/ip \
                           --enable-management \
                           --disable-socks \
                           --disable-http-proxy \
                           --enable-fragment \
                           --disable-multihome \
                           --disable-port-share \
                           --disable-debug"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    ln -sf ../sbin/openvpn $INSTALL/usr/bin/openvpn
}
