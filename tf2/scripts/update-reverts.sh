#!/bin/sh

mkdir tmp
cd tmp
wget -O artifact.zip https://nightly.link/rsedxcftvgyhbujnkiqwe/castaway-plugins/workflows/build/master/package-1.12.zip
unzip artifact.zip
mv -v gamedata/* /home/tf2/tf2/tf/addons/sourcemod/gamedata/
mv -v plugins/reverts.smx /home/tf2/tf2/tf/addons/sourcemod/plugins/
rsync -va translations/* /home/tf2/tf2/tf/addons/sourcemod/translations/
cd ..
rm -r tmp
