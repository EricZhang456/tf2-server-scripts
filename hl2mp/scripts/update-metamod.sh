#!/bin/sh

LATEST_METAMOD=$(curl https://mms.alliedmods.net/mmsdrop/1.12/mmsource-latest-linux)

mkdir tmp

cd tmp
wget https://mms.alliedmods.net/mmsdrop/1.12/$LATEST_METAMOD
mkdir mm
cd mm
tar xvf ../$LATEST_METAMOD
rsync -va * /home/hl2mp/hl2mp/hl2mp/
cd ..
cd ..

rm -rf tmp
