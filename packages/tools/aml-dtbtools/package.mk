################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="aml-dtbtools"
PKG_VERSION="cce100f"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="free"
PKG_SITE="https://github.com/Wilhansen/aml-dtbtools"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_SECTION="tools"
PKG_SHORTDESC="AML DTB Tools"
PKG_LONGDESC="AML DTB Tools"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_HOST="dtbTool"

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp dtbTool $ROOT/$TOOLCHAIN/bin
}
