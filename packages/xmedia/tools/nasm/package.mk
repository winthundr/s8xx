################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="nasm"
PKG_VERSION="2.12.02"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://nasm.sourceforge.net/"
PKG_URL="http://www.nasm.us/pub/nasm/releasebuilds/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="toolchain"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="nasm: A 80x86 assembler which can create a wide rande of object formats"
PKG_LONGDESC="The Netwide Assembler, NASM, is an 80x86 assembler designed for portability and modularity."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_host() {
  cd $ROOT/$PKG_BUILD
    rm -rf .$HOST_NAME
}
