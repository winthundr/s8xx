################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="lftp"
PKG_VERSION="4.6.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://lftp.yar.ru/"
PKG_URL="http://lftp.yar.ru/ftp/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain readline openssl zlib"
PKG_SECTION="tools"
PKG_SHORTDESC="ftp client"
PKG_LONGDESC="LFTP is a sophisticated ftp/http client, and a file transfer program supporting a number of network protocols"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls --with-gnu-ld --without-gnutls --with-openssl"

makeinstall_target() {
  : # nop
}

pre_configure_target() {
  # fails to build with gcc 4.9 + lto
  strip_lto
}
