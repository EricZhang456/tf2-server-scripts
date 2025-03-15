#!/bin/sh

export WORKING_DIR=$(pwd)

if [ -n "${STEAMCMD_EXEC}" ] && ! [ -x "${STEAMCMD_EXEC}" ]; then
    echo 'STEAMCMD_EXEC invalid.'
    exit 1
fi

if [ -z "${STEAMCMD_EXEC}" ]; then
    if command -v steamcmd > /dev/null; then
        export STEAMCMD_EXEC=steamcmd
    else
        if command -v steamcmd.sh > /dev/null; then
            export STEAMCMD_EXEC=steamcmd.sh
        else
            echo 'steamcmd not found. Add steamcmd to PATH or set STEAMCMD_EXEC to the path of steamcmd.'
            exit 1
        fi
    fi
fi

if [ -z "${WORKSHOP_ITEMS_TXT}" ]; then
    if [ -e ./workshop-items.txt ]; then
        export WORKSHOP_ITEMS_TXT="${WORKING_DIR}/workshop-items.txt"
    else
        echo "WORKSHOP_ITEMS_TXT not set. Create $WORKING_DIR/workshop-items.txt or set WORKSHOP_ITEMS_TXT to a plain text list of Steam Workshop IDs."
        exit 1
    fi
fi

if [ -z "${STEAM_USERNAME}" ]; then
    echo 'STEAM_USERNAME not set.'
    exit 1
fi

if [ -z "${L4D2_PATH}" ]; then
    echo 'L4D2_PATH not set.'
    exit 1
else 
    if ! [ -d "${L4D2_PATH}/left4dead2/addons/workshop/" ]; then
        echo "${L4D2_PATH}/left4dead2/addons/workshop/ doesn't exist."
        exit 1
    fi
fi

mkdir -p "${WORKING_DIR}/tmp/download"

cat << EOF > ${WORKING_DIR}/tmp/steamcmd_script.txt
force_install_dir "${WORKING_DIR}/tmp/download"
@sSteamCmdForcePlatformType linux
login "${STEAM_USERNAME}"
EOF

while IFS= read -r line; do
    echo "workshop_download_item 550 ${line}" >> "${WORKING_DIR}/tmp/steamcmd_script.txt"
done < "${WORKSHOP_ITEMS_TXT}"

echo 'quit' >> "${WORKING_DIR}/tmp/steamcmd_script.txt"

"${STEAMCMD_EXEC}" +runscript "${WORKING_DIR}/tmp/steamcmd_script.txt"

cd "${WORKING_DIR}/tmp/download/steamapps/workshop/content/550"

while IFS= read -r line; do
    cd $line
    mv * "${L4D2_PATH}/left4dead2/addons/workshop/${line}.vpk"
    cd ..
done < "${WORKSHOP_ITEMS_TXT}"

rm -r "${WORKING_DIR}/tmp/"

echo 'Restart Left 4 Dead 2 dedicated server to load the newly installed workshop items.'
