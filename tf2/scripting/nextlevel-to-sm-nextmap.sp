#include <nextmap>
#include <convars>
#include <usermessages>
#include <bitbuffer>
#include <string>

#define VOTETYPE_LENGTH 50
#define MAP_LENGTH 128

ConVar g_cvNextLevel, g_cvNextMap;

bool g_bChangeLevelIssued = false;

char g_sOldMap[MAP_LENGTH];

public Plugin myinfo = {
    name = "TF2 Map Voting Fix",
    author = "Eric Zhang",
    description = "Fixes TF2 built-in map voting with nextmap.",
    version = "1.1",
    url = "https://ericaftereric.top"
}

public void OnPluginStart() {
    g_cvNextLevel = FindConVar("nextlevel");
    g_cvNextMap = FindConVar("sm_nextmap")

    int flags = g_cvNextLevel.Flags;
    flags &= ~FCVAR_NOTIFY;
    g_cvNextLevel.Flags = flags;

    if (g_cvNextLevel != null) {
        g_cvNextLevel.AddChangeHook(NextLevelToNextMap);
    }

    AddCommandListener(HandleCallVote, "callvote");

    HookUserMessage(GetUserMessageId("VoteFailed"), HandleVoteFail, false);
    HookUserMessage(GetUserMessageId("CallVoteFailed"), HandleVoteFail, false);
//    HookUserMessage(GetUserMessageId("VotePass"), HandleVotePass, true);
}

public void OnMapStart() {
    // restores sm_nextmap's notify flag if needed
    int flags = g_cvNextMap.Flags;
    flags |= FCVAR_NOTIFY;
    g_cvNextMap.Flags = flags;

    g_bChangeLevelIssued = false;
}

public void NextLevelToNextMap(ConVar convar, char[] oldValue, char[] newValue) {
    char empty[10] = "";
    SetNextMap(newValue);
    g_cvNextLevel.SetString(empty, false, false);
}

public Action HandleCallVote(int client, const char[] command, int argc) {
    char voteType[VOTETYPE_LENGTH];
    char details[MAP_LENGTH];

    GetCmdArg(1, voteType, sizeof(voteType));
    GetCmdArg(2, details, sizeof(details));

    if (StrEqual(voteType, "changelevel", false)) {
        // since we can't parse user messages anymore this is what we'll have to do
        g_bChangeLevelIssued = true;
        // stores the current next map
        GetNextMap(g_sOldMap, sizeof(g_sOldMap));
        // strips sm_nextmap's notify flag
        int flags = g_cvNextMap.Flags;
        flags &= ~FCVAR_NOTIFY;
        g_cvNextMap.Flags = flags;
        // temporarily changes our next map until vote fails
        SetNextMap(details);
    }

    return Plugin_Continue;
}

public Action HandleVoteFail(UserMsg msg_id, BfRead msg, const int[] players, int playersNum, bool reliable, bool init) {
    if (g_bChangeLevelIssued) {
        // changes our next level back for vote fail
        SetNextMap(g_sOldMap);
        // adds back notify to sm_nextmap
        int flags = g_cvNextMap.Flags;
        flags |= FCVAR_NOTIFY;
        g_cvNextMap.Flags = flags;
    }

    g_bChangeLevelIssued = false;

    return Plugin_Continue;
}


// i hope i can get back to this one day but votepass user message in tf2 seems to be broken rn
/*
public Action HandleVotePass(UserMsg msg_id, BfRead msg, const int[] players, int playersNum, bool reliable, bool init) {
    char voteType[VOTETYPE_LENGTH];
    char details[MAP_LENGTH];

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
*/