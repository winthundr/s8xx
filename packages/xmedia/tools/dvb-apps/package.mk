################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="dvb-apps"
PKG_VERSION="3d43b280298c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.linuxtv.org/wiki/index.php/LinuxTV_dvb-apps"
PKG_URL="http://linuxtv.org/hg/dvb-apps/archive/${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="Digitial Video Broadcasting (DVB) applications"
PKG_LONGDESC="Applications and utilities geared towards the initial setup, testing and operation of an DVB device supporting the DVB-S, DVB-C, DVB-T, and ATSC standards."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export PERL_USE_UNSAFE_INC=1
}
