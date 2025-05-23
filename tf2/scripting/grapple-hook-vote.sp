#include <sourcemod>
#include <tf2>
#include <nativevotes>

bool g_bServerWaitingForPlayers, g_bNativeVotesLoaded = false;

int g_iLastGrapplingHookVoteTime;

ConVar g_cvGrapplingHookEnabled, g_cvServerArena, g_cvSpecVote, g_cvVoteDuration;
ConVar g_cvGrapplingHookVoteAllowed, g_cvGrapplingHookVoteMenuPercent, g_cvGrapplingHookVoteCooldown;

public Plugin myinfo = {
    name = "TF2 Grappling Hook Vote",
    author = "Eric Zhang",
    description = "Vote to toggle Grappling Hook in TF2.",
    version = "1.0",
    url = "https://ericaftereric.top"
}

public void OnPluginStart() {
    g_cvGrapplingHookEnabled = FindConVar("tf_grapplinghook_enable");
    g_cvServerArena = FindConVar("tf_gamemode_arena");
    g_cvSpecVote = FindConVar("sv_vote_allow_spectators");
    g_cvVoteDuration = FindConVar("sv_vote_timer_duration");

    RegConsoleCmd("sm_votehook", Cmd_HandleVoteHook, "Start a vote to enable grappling hook.");

    g_cvGrapplingHookVoteAllowed = CreateConVar("sm_vote_issue_grapplinghook_allowed", "0", "Can players call votes to toggle grappling hook?");
    g_cvGrapplingHookVoteMenuPercent = CreateConVar("sm_vote_issue_grapplinghook_quorum", "0.6",
                                                    "The minimum ratio of eligible players needed to pass a pre-round grappling hook vote.", 0, true, 0.1, true, 1.0);
    g_cvGrapplingHookVoteCooldown = CreateConVar("sm_vote_issue_grapplinghook_cooldown", "300",
                                                 "Minimum time before another grappling hook vote can occur (in seconds).");

    AutoExecConfig(false);
}

public void OnMapStart() {
    ResetConVar(g_cvGrapplingHookEnabled);
    g_iLastGrapplingHookVoteTime = 0;
    g_bServerWaitingForPlayers = false;
}

public void OnServerEnterHibernation() {
    ResetConVar(g_cvGrapplingHookEnabled);
}

public void TF2_OnWaitingForPlayersStart() {
    if (!g_cvServerArena.BoolValue) {
        g_bServerWaitingForPlayers = true;
    }
}

public void TF2_OnWaitingForPlayersEnd() {
    if (!g_cvServerArena.BoolValue) {
        g_bServerWaitingForPlayers = false;
    }
}

void StartVote(int client, const char[] toggleType) {
    if (!g_bNativeVotesLoaded) {
        PrintToChat(client, "Server has not yet loaded the required library.");
        return;
    }

    if (NativeVotes_IsVoteInProgress()) {
        PrintToChat(client, "A vote is already in progress.");
        return;
    }

    if (g_bServerWaitingForPlayers) {
        NativeVotes_DisplayCallVoteFail(client, NativeVotesCallFail_Waiting);
        return;
    }

    if ((!g_cvSpecVote.BoolValue && GetClientTeam(client) == 1) || GetClientTeam(client) == 0) {
        NativeVotes_DisplayCallVoteFail(client, NativeVotesCallFail_Spectators);
        return;
    }

    int voteCooldownTimePassed = GetTime() - g_iLastGrapplingHookVoteTime;
    if (NativeVotes_CheckVoteDelay() != 0 || voteCooldownTimePassed < g_cvGrapplingHookVoteCooldown.IntValue) {
        int voteCooldownTimeLeft = g_cvGrapplingHookVoteCooldown.IntValue - voteCooldownTimePassed;
        if (voteCooldownTimeLeft > voteCooldownTimeLeft || voteCooldownTimeLeft < 0) {
            voteCooldownTimeLeft = 0;
        }
        NativeVotes_DisplayCallVoteFail(client, NativeVotesCallFail_Recent,
                                        NativeVotes_CheckVoteDelay() + voteCooldownTimeLeft);
        return;
    }

    NativeVote vote = new NativeVote(HandleHookVote, NativeVotesType_Custom_Mult);
    vote.Initiator = client;
    vote.SetDetails("Turn %s grappling hook?", toggleType);
    vote.AddItem("yes", "Yes");
    vote.AddItem("no", "No");
    vote.DisplayVoteToAll(g_cvVoteDuration.IntValue);
    g_iLastGrapplingHookVoteTime = GetTime();
}

bool CountVote(NativeVote vote, int client, int items) {
    char item[64];
    int votes, totalVotes;

    GetMenuVoteInfo(items, votes, totalVotes);
    vote.GetItem(client, item, sizeof(item));

    float percent = float(votes) / float(totalVotes);
    float limit = g_cvGrapplingHookVoteMenuPercent.FloatValue;

    if (FloatCompare(percent, limit) >= 0 && StrEqual(item, "yes")) {
        return true;
    } else {
        return false;
    }
}

public int HandleHookVote(NativeVote vote, MenuAction action, int client, int items) {
    switch (action) {
        case MenuAction_End: {
            vote.Close();
        }
        case MenuAction_VoteCancel: {
            if (client == VoteCancel_NoVotes) {
                vote.DisplayFail(NativeVotesFail_NotEnoughVotes);
            } else {
                vote.DisplayFail(NativeVotesFail_Generic);
            }
        }
        case MenuAction_VoteEnd: {
            if (client == NATIVEVOTES_VOTE_NO || client == NATIVEVOTES_VOTE_INVALID) {
                vote.DisplayFail(NativeVotesFail_Loses);
            } else {
                if (CountVote(vote, client, items)) {
                    vote.DisplayPassCustom("Turning %s grappling hook...", g_cvGrapplingHookEnabled.BoolValue ? "off" : "on" );
                    g_cvGrapplingHookEnabled.BoolValue = !g_cvGrapplingHookEnabled.BoolValue;
                } else {
                    vote.DisplayFail(NativeVotesFail_Loses);
                }
            }
        }
    }
    return 0;
}

public Action Cmd_HandleVoteHook(int client, int args) {
    if (g_cvGrapplingHookVoteAllowed.BoolValue && client != 0) {
        StartVote(client, g_cvGrapplingHookEnabled.BoolValue ? "off" : "on" );
    } else {
        PrintToChat(client, "Grappling hook vote is not allowed.")
    }
    return Plugin_Handled;
}

public void OnLibraryAdded(const char[] name) {
    if (StrEqual(name, "nativevotes")) {
        g_bNativeVotesLoaded = true;
    }
}

public void OnLibraryRemoved(const char[] name) {
    if (StrEqual(name, "nativevotes")) {
        g_bNativeVotesLoaded = false;
    }
}

public void OnAllPluginsLoaded() {
    if (LibraryExists("nativevotes")) {
        g_bNativeVotesLoaded = true;
    }
}
