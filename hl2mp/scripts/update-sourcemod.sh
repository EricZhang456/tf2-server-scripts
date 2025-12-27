#!/bin/sh

LATEST_SOURCEMOD=$(curl https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux)

mkdir tmp

cd tmp
wget https://sm.alliedmods.net/smdrop/1.12/$LATEST_SOURCEMOD
mkdir mm
cd mm
tar xvf ../$LATEST_SOURCEMOD
rsync -va * /home/hl2mp/hl2mp/hl2mp/
cd ..
cd ..

rm -rf tmp

cp ~hl2mp/hl2mp/hl2mp/addons/sourcemod/configs/admins_simple.ini.bak ~hl2mp/hl2mp/hl2mp/addons/sourcemod/configs/admins_simple.ini
