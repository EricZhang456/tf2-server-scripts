#!/bin/sh

/home/css/css/srcds_run -game cstrike -secure -port 27023 +map de_dust2 +maxplayers 32 +sv_setsteamaccount $STEAM_SERVER_TOKEN +servercfgfile server.cfg -steam_dir /usr/games/ -steamcmd_script /home/css/scripts/steamcmd-script.txt -autoupdate
