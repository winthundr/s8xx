################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="udevil"
PKG_VERSION="0.4.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/IgnorantGuru/udevil"
PKG_URL="https://github.com/IgnorantGuru/udevil/raw/pkg/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain systemd glib"
PKG_SECTION="system"
PKG_SHORTDESC="udevil: Mounts and unmounts removable devices and networks without a password."
PKG_LONGDESC="udevil Mounts and unmounts removable devices and networks without a password (set suid), shows device info, monitors device changes. Emulates mount's and udisks's command line usage and udisks v1's output. Includes the devmon automounting daemon."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-systemd \
                           --with-mount-prog=/bin/mount \
                           --with-umount-prog=/bin/umount \
                           --with-losetup-prog=/sbin/losetup \
                           --with-setfacl-prog=/usr/bin/setfacl"

makeinstall_target() {
 : # nothing to install
}

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/udevil
    cp $PKG_DIR/config/udevil.conf $INSTALL/etc/udevil

  mkdir -p $INSTALL/usr/bin
    cp -PR src/udevil $INSTALL/usr/bin
}

post_install() {
  enable_service udevil-mount@.service
}
