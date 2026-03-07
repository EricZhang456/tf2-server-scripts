import json
import vdf

with open("gamemodes_server.txt", "r", encoding="utf-8") as f:
    gamemodes_server_content = f.read()

gamemodes_server = vdf.loads(gamemodes_server_content)
all_mapgroups_content = gamemodes_server.get("GameModes_Server.txt").get("mapgroups")
all_mapgroups = []

for key, value in all_mapgroups_content.items():
    current_mapgroup = {
        "name": key,
        "maps": []
    }
    maps = value.get("maps")
    for key in maps:
        current_mapgroup["maps"].append(key)
    all_mapgroups.append(current_mapgroup)

with open("gamemode-vote-base.json", "r", encoding="utf-8") as f:
    gamemode_base = json.load(f)

with open("target-gamemodes.json", "r", encoding="utf-8") as f:
    target_gamemodes = json.load(f)

gamemodes = []

for i in target_gamemodes:
    mapgroup = i.get("mapgroup")
    maps = []
    for k in all_mapgroups:
        current_mapgroup_name = k.get("name")
        if current_mapgroup_name == mapgroup:
            maps = k.get("maps")
            break
    if not maps:
        raise RuntimeError(f"mapgroup {mapgroup} not found")
    current_gamemode = i.copy()
    current_gamemode["maplist"] = maps
    gamemodes.append(current_gamemode)

gamemodes.extend(gamemode_base)

print(json.dumps(gamemodes, indent=4))
