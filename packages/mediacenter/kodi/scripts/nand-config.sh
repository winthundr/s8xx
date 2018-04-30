#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

rm -f /var/lock/nand.lock
cat /proc/cmdline | grep 'BOOT_IMAGE=kernel.img' > /dev/null

if [ $? == 0 ]; then
  mkdir -p /storage/nand
  touch /var/lock/nand.lock
else
  if [ ! -f /storage/.config/kodi.skins/nand.install ]; then
    touch /storage/.config/kodi.skins/nand.install
    cp -f /usr/share/kodi/config/Nox-DialogButtonMenu.xml /storage/.config/kodi.skins/skin.aeon.nox.5ae/1080i/DialogButtonMenu.xml
    cp -f /usr/share/kodi/config/Estuary-DialogButtonMenu.xml /storage/.config/kodi.skins/skin.estuary/xml/DialogButtonMenu.xml
  fi
fi

exit 0
