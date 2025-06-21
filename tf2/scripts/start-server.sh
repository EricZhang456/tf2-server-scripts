#!/bin/sh

/home/tf2/tf2/srcds_run -game tf -secure -port 27015 -maxplayers 24 +randommap +servercfgfile server.cfg +mapcyclefile mapcycle.txt +sv_setsteamaccount $STEAM_SERVER_TOKEN -steam_dir /usr/games/ -steamcmd_script /home/tf2/scripts/steamcmd-script.txt -autoupdate -replay
