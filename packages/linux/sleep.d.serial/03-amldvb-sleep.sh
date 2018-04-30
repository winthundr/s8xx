#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

AVL_MODULE_RUN="/usr/bin/avl-dvb.run"
WETEK_MODULE_RUN="/usr/bin/wetek-dvb.run"

case $1 in
  pre)
    [ -x "$AVL_MODULE_RUN" ] && $AVL_MODULE_RUN del
    [ -x "$WETEK_MODULE_RUN" ] && $WETEK_MODULE_RUN del
    ;;
  post)
    [ -x "$AVL_MODULE_RUN" ] && $AVL_MODULE_RUN
    [ -x "$WETEK_MODULE_RUN" ] && $WETEK_MODULE_RUN
    ;;
esac
