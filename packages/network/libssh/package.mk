################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libssh"
PKG_VERSION="0.7.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OpenSource"
PKG_SITE="http://www.libssh.org/"
PKG_URL="https://git.libssh.org/projects/libssh.git/snapshot/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_SECTION="network"
PKG_SHORTDESC="libssh: A working SSH implementation by means of a library"
PKG_LONGDESC="The ssh library was designed to be used by programmers needing a working SSH implementation by the mean of a library. The complete control of the client is made by the programmer. With libssh, you can remotely execute programs, transfer files, use a secure and transparent tunnel for your remote programs. With its Secure FTP implementation, you can play with remote files easily, without third-party programs others than libcrypto (from openssl)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DWITH_STATIC_LIB=1 -DWITH_SERVER=OFF -DWITH_GCRYPT=OFF"

makeinstall_target() {
# install static library only
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp src/libssh.a $SYSROOT_PREFIX/usr/lib
    cp src/threads/libssh_threads.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libssh.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libssh_threads.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

  mkdir -p $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/callbacks.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/legacy.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/libssh.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/server.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/sftp.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/ssh2.h $SYSROOT_PREFIX/usr/include/libssh
}
