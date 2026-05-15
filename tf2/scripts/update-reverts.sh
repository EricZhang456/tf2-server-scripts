#!/bin/sh

set -e

mkdir tmp
cd tmp

LATEST_REVERTS_DOWNLOAD=$(curl "https://api.github.com/repos/rsedxcftvgyhbujnkiqwe/castaway-plugins/releases?per_page=5" | jq -r '.[0].assets[] | select(.name == "package-1.12.zip") | .browser_download_url')

wget -O artifact.zip $LATEST_REVERTS_DOWNLOAD
unzip artifact.zip
mv -v gamedata/reverts.txt /home/tf2/tf2/tf/addons/sourcemod/gamedata/reverts.txt
mv -v gamedata/memorypatch_reverts.txt /home/tf2/tf2/tf/addons/sourcemod/gamedata/memorypatch_reverts.txt
mv -v plugins/reverts.smx /home/tf2/tf2/tf/addons/sourcemod/plugins/
rsync -va --include="*/" --include="reverts.phrases*" --exclude="*" translations/* /home/tf2/tf2/tf/addons/sourcemod/translations/
cd ..

rm -r tmp

# curl https://raw.githubusercontent.com/EricZhang456/tf2-server-scripts/refs/heads/master/tf2/cfg/reverts.cfg > /home/tf2/tf2/tf/cfg/sourcemod/reverts.cfg
