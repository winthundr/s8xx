################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="pcsc-lite"
PKG_VERSION="1.8.22"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pcsclite.alioth.debian.org/pcsclite.html"
PKG_URL="https://alioth.debian.org/frs/download.php/file/4225/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="xmedia/camd"
PKG_SHORTDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
            --disable-static \
            --disable-libudev \
            --enable-libusb \
            --enable-usbdropdir=/usr/lib/pcsc/drivers"
