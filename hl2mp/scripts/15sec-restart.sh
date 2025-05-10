#!/bin/sh

ttyecho -n /dev/tty22 'say This server will restart in 15 seconds.'
sleep 15
ttyecho -n /dev/tty22 'killserver'
sleep 5
systemctl restart hl2mp
