#include <nextmap>
#include <convars>

ConVar g_sNextLevel;

public Plugin myinfo = {
    name = "nextlevel to sm_nextmap",
    author = "Eric Zhang",
    description = "Changes the nextlevel cvar to sm_nextmap.",
    version = "1.0",
    url = "https://ericaftereric.top"
}

public void OnPluginStart() {
    g_sNextLevel =  FindConVar("nextlevel");

    int flags = g_sNextLevel.Flags;
    flags &= ~FCVAR_NOTIFY;
    g_sNextLevel.Flags = flags;

    if (g_sNextLevel != null) {
        g_sNextLevel.AddChangeHook(NextLevelToNextMap);
    }
}

public void NextLevelToNextMap(ConVar convar, char[] oldValue, char[] newValue) {
    char empty[10] = "";
    SetNextMap(newValue);
    g_sNextLevel.SetString(empty, false, false);
}