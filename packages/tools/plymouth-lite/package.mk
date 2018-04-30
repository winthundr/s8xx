################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="plymouth-lite"
PKG_VERSION="0.6.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.meego.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_INIT="toolchain gcc:init libpng"
PKG_SECTION="tools"
PKG_SHORTDESC="plymouth-lite: Boot splash screen based on Fedora's Plymouth code"
PKG_LONGDESC="Boot splash screen based on Fedora's Plymouth code"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$UVESAFB_SUPPORT" = yes ]; then
  PKG_DEPENDS_INIT="$PKG_DEPENDS_INIT v86d:init"
fi

pre_configure_init() {
  # plymouth-lite dont support to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME-init
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
    cp ply-image $INSTALL/bin

  mkdir -p $INSTALL/splash
    if ls $PROJECT_DIR/$PROJECT/devices/$DEVICE/splash/splash-*.png 1>/dev/null 2>&1; then
      cp $PROJECT_DIR/$PROJECT/devices/$DEVICE/splash/splash-*.png $INSTALL/splash
    elif ls $PROJECT_DIR/$PROJECT/splash/splash-*.png 1>/dev/null 2>&1; then
      cp $PROJECT_DIR/$PROJECT/splash/splash-*.png $INSTALL/splash
    elif ls $DISTRO_DIR/$DISTRO/splash/splash-*.png 1>/dev/null 2>&1; then
      cp $DISTRO_DIR/$DISTRO/splash/splash-*.png $INSTALL/splash
    else
      cp $PKG_DIR/splash/splash-*.png $INSTALL/splash
    fi
}
