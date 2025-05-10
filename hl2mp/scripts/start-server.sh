#!/bin/sh

/home/hl2mp/hl2mp/srcds_run -game hl2mp -secure -port 27021 +map dm_overwatch +maxplayers 16 +sv_setsteamaccount $STEAM_SERVER_TOKEN +servercfgfile server.cfg -steam_dir /usr/games/ -steamcmd_script /home/hl2mp/scripts/steamcmd-script.txt -autoupdate
