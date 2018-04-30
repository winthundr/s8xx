################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="media_build_cc"
PKG_VERSION="20170628"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/CrazyCat/media_build"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="xmedia/dvb"
PKG_SHORTDESC="Build system to use the latest experimental drivers/patches without needing to replace the entire Kernel"
PKG_LONGDESC="Build system to use the latest experimental drivers/patches without needing to replace the entire Kernel"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
  export PATH=$ROOT/$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  TARGET_PREFIX=aarch64-linux-gnu-
fi

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  unset LDFLAGS
}

make_target() {
  # Amlogic AMLVIDEO driver
  if [ -e "$(kernel_path)/drivers/amlogic/video_dev" ]; then
    # Copy, patch and enable amlvideodri module
    cp -a "$(kernel_path)/drivers/amlogic/video_dev" "linux/drivers/media/"
    sed -i 's,common/,,g; s,"trace/,",g' $(find linux/drivers/media/video_dev/ -type f)
    sed -i 's,\$(CONFIG_V4L_AMLOGIC_VIDEO),m,g' "linux/drivers/media/video_dev/Makefile"
    echo "obj-y += video_dev/" >> "linux/drivers/media/Makefile"

    # Copy and enable videobuf-res module
    cp -a "$(kernel_path)/drivers/media/v4l2-core/videobuf-res.c" "linux/drivers/media/v4l2-core/"
    cp -a "$(kernel_path)/include/media/videobuf-res.h" "linux/include/media/"
    echo "obj-m += videobuf-res.o" >> "linux/drivers/media/v4l2-core/Makefile"
  fi

  # Amlogic DVB driver avl6862 & wetekdvb
  if [ "$PROJECT" = "S905" ]; then
    if [ -d $PROJECT_DIR/$PROJECT/dvb_tv ]; then
      cp -a $PROJECT_DIR/$PROJECT/dvb_tv linux/drivers/media
      echo "obj-y += dvb_tv/" >> linux/drivers/media/Makefile
    fi
    echo "obj-y += amlogic/dvb_tv/" >> "linux/drivers/media/Makefile"
  fi

  make VER=$KERNEL_VER SRCDIR=$(kernel_path) stagingconfig
  # Geniatech T220A
  sed -i -e "s|^.*CONFIG_DVB_CXD2820R.*$|CONFIG_DVB_CXD2820R=m|" "v4l/.config"
  make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  : # not
}

post_install() {
  MOD_VER=$(get_module_dir)

  # install media_build CrazyCat drivers
  cp -Pa $INSTALL/lib/modules/$MOD_VER $INSTALL/lib/modules/$MOD_VER-mbcc
  mkdir -p $INSTALL/lib/modules/$MOD_VER-mbcc/updates/mbcc
  find $ROOT/$PKG_BUILD/v4l/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$MOD_VER-mbcc/updates/mbcc \;
  echo "Media_Build CrazyCat drivers version: $PKG_VERSION" > $INSTALL/lib/modules/$MOD_VER-mbcc/updates/mbcc-drivers.txt
}
