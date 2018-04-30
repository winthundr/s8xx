################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mysql"
PKG_VERSION="5.7.15"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mysql.com"
PKG_URL="http://ftp.gwdg.de/pub/misc/$PKG_NAME/Downloads/MySQL-5.7/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib netbsd-curses openssl boost mysql:host"
PKG_SECTION="database"
PKG_SHORTDESC="mysql: A database server"
PKG_LONGDESC="MySQL is a SQL (Structured Query Language) database server. SQL is the most popular database language in the world. MySQL is a client server implementation that consists of a server daemon mysqld and many different client programs/libraries."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  sed -i 's|GET_TARGET_PROPERTY(LIBMYSQL_OS_OUTPUT_NAME libmysql OUTPUT_NAME)|SET(LIBMYSQL_OS_OUTPUT_NAME "mysqlclient")|' $ROOT/$PKG_BUILD/scripts/CMakeLists.txt
  sed -i "s|COMMAND comp_err|COMMAND $ROOT/$TOOLCHAIN/bin/comp_err|" $ROOT/$PKG_BUILD/extra/CMakeLists.txt
  sed -i "s|COMMAND comp_sql|COMMAND $ROOT/$TOOLCHAIN/bin/comp_sql|" $ROOT/$PKG_BUILD/scripts/CMakeLists.txt
  sed -i "s|COMMAND gen_lex_hash|COMMAND $ROOT/$TOOLCHAIN/bin/gen_lex_hash|" $ROOT/$PKG_BUILD/sql/CMakeLists.txt

  sed -i '/^IF(NOT BOOST_MINOR_VERSION.*$/,/^ENDIF()$/d' $ROOT/$PKG_BUILD/cmake/boost.cmake
}

PKG_CMAKE_OPTS_HOST="-DCMAKE_BUILD_TYPE=Release \
                     -DSTACK_DIRECTION=-1 \
                     -DHAVE_LLVM_LIBCPP_EXITCODE=0 \
                     -DHAVE_FALLOC_PUNCH_HOLE_AND_KEEP_SIZE_EXITCODE=0 \
                     -DWITHOUT_SERVER=OFF \
                     -DWITH_EMBEDDED_SERVER=OFF \
                     -DWITH_INNOBASE_STORAGE_ENGINE=OFF \
                     -DWITH_PARTITION_STORAGE_ENGINE=OFF \
                     -DWITH_PERFSCHEMA_STORAGE_ENGINE=OFF \
                     -DWITH_EXTRA_CHARSETS=none \
                     -DWITH_EDITLINE=bundled \
                     -DWITH_LIBEVENT=bundled \
                     -DDOWNLOAD_BOOST=0 \
                     -DLOCAL_BOOST_DIR=$(get_build_dir boost) \
                     -DWITH_UNIT_TESTS=OFF \
                     -DWITH_ZLIB=bundled"

make_host() {
  make comp_err
  make gen_lex_hash
  make comp_sql
}

post_make_host() {
  # needed so the binary isn't built for target
  cp scripts/comp_sql ../scripts/comp_sql
}

makeinstall_host() {
  cp -P extra/comp_err $ROOT/$TOOLCHAIN/bin
  cp -P sql/gen_lex_hash $ROOT/$TOOLCHAIN/bin
  cp -P scripts/comp_sql $ROOT/$TOOLCHAIN/bin
}

PKG_CMAKE_OPTS_TARGET="-DINSTALL_INCLUDEDIR=include/mysql \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DFEATURE_SET=classic \
                       -DDISABLE_SHARED=ON \
                       -DENABLE_DTRACE=OFF \
                       -DWITH_EMBEDDED_SERVER=OFF \
                       -DWITH_INNOBASE_STORAGE_ENGINE=OFF \
                       -DWITH_PARTITION_STORAGE_ENGINE=OFF \
                       -DWITH_PERFSCHEMA_STORAGE_ENGINE=OFF \
                       -DWITH_EXTRA_CHARSETS=all \
                       -DWITH_UNIT_TESTS=OFF \
                       -DWITHOUT_SERVER=ON \
                       -DWITH_EDITLINE=bundled \
                       -DWITH_LIBEVENT=bundled \
                       -DWITH_ZLIB=system \
                       -DWITH_SSL=$SYSROOT_PREFIX/usr \
                       -DDOWNLOAD_BOOST=0 \
                       -DLOCAL_BOOST_DIR=$(get_build_dir boost) \
                       -DSTACK_DIRECTION=1 \
                       -DHAVE_LLVM_LIBCPP=1"

post_makeinstall_target() {
  sed -i "s|pkgincludedir=.*|pkgincludedir=\'$SYSROOT_PREFIX/usr/include/mysql\'|" scripts/mysql_config
  sed -i "s|pkglibdir=.*|pkglibdir=\'$SYSROOT_PREFIX/usr/lib/mysql\'|" scripts/mysql_config
  cp scripts/mysql_config $SYSROOT_PREFIX/usr/bin
  ln -sf $SYSROOT_PREFIX/usr/bin/mysql_config $ROOT/$TOOLCHAIN/bin/mysql_config

  rm -rf $INSTALL
}
