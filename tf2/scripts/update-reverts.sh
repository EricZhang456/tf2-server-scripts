#!/bin/sh

mkdir tmp
cd tmp
wget -O artifact.zip https://nightly.link/rsedxcftvgyhbujnkiqwe/castaway-plugins/workflows/build/master/artifact.zip
unzip artifact.zip
mv -v gamedata/* /home/tf2/tf2/tf/addons/sourcemod/gamedata/
mv -v plugins/reverts.smx /home/tf2/tf2/tf/addons/sourcemod/plugins/
cd ..
rm -r tmp
