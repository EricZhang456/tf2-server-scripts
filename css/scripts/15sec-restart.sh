#!/bin/sh

ttyecho -n /dev/tty23 'say This server will restart in 15 seconds.'
sleep 15
ttyecho -n /dev/tty23 'killserver'
sleep 5
systemctl restart css
