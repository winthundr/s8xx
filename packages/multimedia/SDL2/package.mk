################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="SDL2"
PKG_VERSION="4829339"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org/"
PKG_URL="https://github.com/RetroPie/SDL-mirror/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="SDL-mirror-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain yasm:host alsa-lib systemd dbus"
PKG_SECTION="multimedia"
PKG_SHORTDESC="SDL2: A cross-platform Graphic API"
PKG_LONGDESC="Simple DirectMedia Layer is a cross-platform multimedia library designed to provide fast access to the graphics framebuffer and audio device. It is used by MPEG playback software, emulators, and many popular games, including the award winning Linux port of 'Civilization: Call To Power.' Simple DirectMedia Layer supports Linux, Win32, BeOS, MacOS, Solaris, IRIX, and FreeBSD."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DSDL_STATIC=OFF \
		       -DDUMMYAUDIO=OFF \
		       -DOSS=OFF \
		       -DRPATH=OFF \
		       -DVIDEO_DUMMY=OFF \
		       -DDISKAUDIO=OFF \
               -DVIDEO_X11=OFF \
               -DVIDEO_MALI=ON"

post_makeinstall_target() {
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/sdl2-config

  rm -rf $INSTALL/usr/bin
}
