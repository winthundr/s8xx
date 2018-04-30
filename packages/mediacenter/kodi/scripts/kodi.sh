#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

. /etc/profile

trap cleanup TERM

SAVED_ARGS="$@"

cleanup() {
  # make systemd happy by not exiting immediately but
  # wait for kodi to exit
  while killall -0 kodi.bin &>/dev/null; do
    sleep 0.5
  done
}

# clean up any stale cores. just in case
rm -f /storage/.cache/cores/*

# wait for AceStream
ACE_CONF="/storage/.cache/services/acestream.conf"
ACE_START="/tmp/ace_run.tmp"

if [ ! -f "$ACE_START" -a -f "$ACE_CONF" ]; then
  . $ACE_CONF
  touch $ACE_START
  [ -z "$ACE_WAIT" ] && ACE_WAIT="none"
  if [ "$ACE_WAIT" != "none" ]; then
      sleep $ACE_WAIT
  fi
fi

/usr/lib/kodi/kodi.bin $SAVED_ARGS
RET=$?

exit $RET
