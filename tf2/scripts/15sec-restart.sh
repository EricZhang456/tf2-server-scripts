#!/bin/sh

ttyecho -n /dev/tty20 'say This server will restart in 15 seconds.'
sleep 15
ttyecho -n /dev/tty20 'killserver'
sleep 5
#/home/tf2/scripts/update-maprotate.sh
cd /home/tf2/scripts
sudo -u tf2 /home/tf2/scripts/update-reverts.sh
systemctl restart tf2
