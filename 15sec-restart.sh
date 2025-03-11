#!/bin/sh

ttyecho -n /dev/tty20 'say This server will restart in 15 seconds.'
sleep 15
ttyecho -n /dev/tty20 'killserver'
sleep 5
/home/tf2/scripts/update-mapcycle.sh
systemctl restart tf2
