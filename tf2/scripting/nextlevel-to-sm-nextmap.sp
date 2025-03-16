#include <nextmap>
#include <convars>
#include <usermessages>
#include <bitbuffer>
#include <string>

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

    HookUserMessage(GetUserMessageId("VotePass"), HandleVotePass, true);
}

public void NextLevelToNextMap(ConVar convar, char[] oldValue, char[] newValue) {
    char empty[10] = "";
    SetNextMap(newValue);
    g_sNextLevel.SetString(empty, false, false);
}

public Action HandleVotePass(UserMsg msg_id, BfRead msg, const int[] players, int playersNum, bool reliable, bool init) {
    char voteType[50];
    char details[128];
    
    msg.ReadByte();
    msg.ReadString(voteType, sizeof(voteType));
    msg.ReadString(details, sizeof(details));

    if (StrEqual(voteType, "#TF_vote_passed_changelevel")) {
        SetNextMap(details);
        return Plugin_Handled;
    } else {
        return Plugin_Continue;
    }
}