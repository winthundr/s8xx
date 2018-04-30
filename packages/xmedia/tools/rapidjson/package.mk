################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="rapidjson"
PKG_VERSION="1.1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/miloyip/rapidjson"
PKG_URL="$PKG_SITE/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="rapidjson: JSON parser/generator"
PKG_LONGDESC="A fast JSON parser/generator for C++ with both SAX/DOM style API"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DRAPIDJSON_BUILD_DOC=OFF \
                       -DRAPIDJSON_BUILD_EXAMPLES=OFF
                       -DRAPIDJSON_BUILD_TESTS=OFF \
                       -DRAPIDJSON_BUILD_THIRDPARTY_GTEST=OFF \
                       -DRAPIDJSON_BUILD_ASAN=OFF \
                       -DRAPIDJSON_BUILD_UBSAN=OFF \
                       -DRAPIDJSON_HAS_STDSTRING=ON"
