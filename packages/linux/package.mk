################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="linux"
PKG_VERSION="$KERNEL_VERSION"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kernel.org"
PKG_URL="$KERNEL_URL"
PKG_SOURCE_DIR="$KERNEL_SOURCE_DIR"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain cpio:host kmod:host pciutils xz:host wireless-regdb keyutils"
PKG_DEPENDS_INIT="toolchain"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="linux"
PKG_SHORTDESC="linux26: The Linux kernel 2.6 precompiled kernel binary image and modules"
PKG_LONGDESC="This package contains a precompiled kernel image and the modules."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
  export PATH=$ROOT/$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  TARGET_PREFIX=aarch64-linux-gnu-
  PKG_MAKE_OPTS_HOST="ARCH=$TARGET_ARCH headers_check"
else
  PKG_MAKE_OPTS_HOST="ARCH=$TARGET_KERNEL_ARCH headers_check"
fi

if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mkbootimg:host"
fi

post_patch() {

  if [ -d $PROJECT_DIR/$PROJECT/dvb_aml ]; then
    rm -fR $PKG_BUILD/drivers/amlogic/dvb_tv/*
    cp -f $PROJECT_DIR/$PROJECT/dvb_aml/* $PKG_BUILD/drivers/amlogic/dvb_tv/	
  fi

  if [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -f $PKG_DIR/config/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PKG_DIR/config/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf
  else
    KERNEL_CFG_FILE=$PKG_DIR/config/$PKG_NAME.$TARGET_ARCH.conf
  fi

  sed -i -e "s|^HOSTCC[[:space:]]*=.*$|HOSTCC = $ROOT/$TOOLCHAIN/bin/host-gcc|" \
         -e "s|^HOSTCXX[[:space:]]*=.*$|HOSTCXX = $ROOT/$TOOLCHAIN/bin/host-g++|" \
         -e "s|^ARCH[[:space:]]*?=.*$|ARCH = $TARGET_KERNEL_ARCH|" \
         -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = $TARGET_PREFIX|" \
         $PKG_BUILD/Makefile

  cp $KERNEL_CFG_FILE $PKG_BUILD/.config
  if [ ! "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"$ROOT/$BUILD/image/initramfs.cpio\"|" $PKG_BUILD/.config
  fi

  # set default hostname based on $DISTRONAME
    sed -i -e "s|@DISTRONAME@|$DISTRONAME|g" $PKG_BUILD/.config

  # disable swap support if not enabled
  if [ ! "$SWAP_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_SWAP=.*$|# CONFIG_SWAP is not set|" $PKG_BUILD/.config
  fi

  # disable nfs support if not enabled
  if [ ! "$NFS_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_NFS_FS=.*$|# CONFIG_NFS_FS is not set|" $PKG_BUILD/.config
  fi

  # disable cifs support if not enabled
  if [ ! "$SAMBA_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_CIFS=.*$|# CONFIG_CIFS is not set|" $PKG_BUILD/.config
  fi

  # disable iscsi support if not enabled
  if [ ! "$ISCSI_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_SCSI_ISCSI_ATTRS=.*$|# CONFIG_SCSI_ISCSI_ATTRS is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_TCP=.*$|# CONFIG_ISCSI_TCP is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_BOOT_SYSFS=.*$|# CONFIG_ISCSI_BOOT_SYSFS is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT_FIND=.*$|# CONFIG_ISCSI_IBFT_FIND is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT=.*$|# CONFIG_ISCSI_IBFT is not set|" $PKG_BUILD/.config
  fi

}

makeinstall_host() {
  if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
    make ARCH=$TARGET_ARCH INSTALL_HDR_PATH=dest headers_install
  else
    make ARCH=$TARGET_KERNEL_ARCH INSTALL_HDR_PATH=dest headers_install
  fi
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -R dest/include/* $SYSROOT_PREFIX/usr/include
}

pre_make_target() {
  make oldconfig

  # regdb
  cp $(get_build_dir wireless-regdb)/db.txt $ROOT/$PKG_BUILD/net/wireless/db.txt

  if [ "$BOOTLOADER" = "u-boot" ]; then
    ( cd $ROOT
      $SCRIPTS/build u-boot
    )
  fi
}

make_target() {
  LDFLAGS="" make modules
  LDFLAGS="" make INSTALL_MOD_PATH=$INSTALL DEPMOD="$ROOT/$TOOLCHAIN/bin/depmod" modules_install
  rm -f $INSTALL/lib/modules/*/build
  rm -f $INSTALL/lib/modules/*/source

  ( cd $ROOT
    if ls $PROJECT_DIR/$PROJECT/devices/$DEVICE/splash/splash-*.png 1>/dev/null 2>&1; then
      rm -rf $ROOT/$BUILD/plymouth-lite-*
    elif ls $PROJECT_DIR/$PROJECT/splash/splash-*.png 1>/dev/null 2>&1; then
      rm -rf $ROOT/$BUILD/plymouth-lite-*
    fi
    rm -rf $ROOT/$BUILD/initramfs
    $SCRIPTS/install initramfs
  )

  if [ "$BOOTLOADER" = "u-boot" -a -n "$KERNEL_UBOOT_EXTRA_TARGET" -a -z "$BUILD_ANDROID_BOOTIMG" ]; then
    for extra_target in "$KERNEL_UBOOT_EXTRA_TARGET"; do
      LDFLAGS="" make $extra_target
    done
  fi

  LDFLAGS="" make $KERNEL_TARGET $KERNEL_MAKE_EXTRACMD
}

makeinstall_target() {
  if [ "$BOOTLOADER" = "u-boot" ]; then
    mkdir -p $INSTALL/usr/share/bootloader
    for dtb in arch/$TARGET_KERNEL_ARCH/boot/dts/*.dtb; do
      cp $dtb $INSTALL/usr/share/bootloader 2>/dev/null || :
    done
    if [ -d arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic -a -f "arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$KERNEL_UBOOT_EXTRA_TARGET" ]; then
      cp "arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$KERNEL_UBOOT_EXTRA_TARGET" $INSTALL/usr/share/bootloader/dtb.img 2>/dev/null || :
    fi
  fi
}

make_init() {
 : # reuse make_target()
}

makeinstall_init() {
  if [ -n "$INITRAMFS_MODULES" ]; then
    mkdir -p $INSTALL/etc
    mkdir -p $INSTALL/lib/modules

    for i in $INITRAMFS_MODULES; do
      module=`find .install_pkg/lib/modules/$(get_module_dir)/kernel -name $i.ko`
      if [ -n "$module" ]; then
        echo $i >> $INSTALL/etc/modules
        cp $module $INSTALL/lib/modules/`basename $module`
      fi
    done
  fi

  if [ "$UVESAFB_SUPPORT" = yes ]; then
    mkdir -p $INSTALL/lib/modules
      uvesafb=`find .install_pkg/lib/modules/$(get_module_dir)/kernel -name uvesafb.ko`
      cp $uvesafb $INSTALL/lib/modules/`basename $uvesafb`
  fi
}

post_install() {
  mkdir -p $INSTALL/lib/firmware/
  mkdir -p $INSTALL/usr/config/firmware/
    ln -sf /storage/.config/firmware/ $INSTALL/lib/firmware/updates

  # bluez looks in /etc/firmware/
    ln -sf /lib/firmware/ $INSTALL/etc/firmware
}
