#!/bin/sh
pids=`pidof swaybg`
echo $pids
if test -n "$pids" ; then
    kill $pids
fi
swaybg -i $1 -m fill &>/dev/null &
