################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="diskdev_cmds"
PKG_VERSION="332.14"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="APSL"
PKG_SITE="http://src.gnu-darwin.org/DarwinSourceArchive/expanded/diskdev_cmds/"
PKG_URL="http://www.opensource.apple.com/tarballs/diskdev_cmds/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_SECTION="system"
PKG_SHORTDESC="diskdev_cmds: hfs filesystem utilities"
PKG_LONGDESC="The fsck and mkfs utliities for hfs and hfsplus filesystems."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="-f Makefile.lnx CC=$CC"

pre_make_target() {
  export CFLAGS="$TARGET_CFLAGS -g3 -Wall -I$PKG_BUILD/include -DDEBUG_BUILD=0 -D_FILE_OFFSET_BITS=64 -D LINUX=1 -D BSD=1"
}

makeinstall_target() {
  mkdir -p $INSTALL/sbin
    cp fsck_hfs.tproj/fsck_hfs $INSTALL/sbin
      ln -sf fsck_hfs $INSTALL/sbin/fsck.hfs
      ln -sf fsck_hfs $INSTALL/sbin/fsck.hfsplus
}

make_init() {
  : # we reuse make_target()
}
