################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="newt"
PKG_VERSION="0.52.19"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://pagure.io/newt"
PKG_URL="https://releases.pagure.org/newt/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain slang popt"
PKG_SECTION="tools"
PKG_SHORTDESC="newt: A programming library for color text mode, widget based user interfaces"
PKG_LONGDESC="Newt is a programming library for color text mode, widget based user interfaces. Newt can be used to add stacked windows, entry widgets, checkboxes, radio buttons, labels, plain text fields, scrollbars, etc., to text mode user interfaces. Newt is based on the S-Lang library."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-python \
                           --without-tcl"

pre_configure_target() {
 # newt fails to build in subdirs
 cd $ROOT/$PKG_BUILD
 rm -rf .$TARGET_NAME
}

pre_configure_host() {
 # newt fails to build in subdirs
 cd $ROOT/$PKG_BUILD
 rm -rf .$HOST_NAME
}

