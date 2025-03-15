#!/bin/sh

ttyecho -n /dev/tty21 'say This server will restart in 15 seconds.'
sleep 15
ttyecho -n /dev/tty21 'killserver'
sleep 5
systemctl restart l4d2
