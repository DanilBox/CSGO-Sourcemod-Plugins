#pragma semicolon 1

#include <sourcemod>

#define VERSION "0.0.1"

static const String : message[] = "\nOutput message\n";

public Plugin : myinfo = {
    name    = "MessageConsoleEveryRound",
    author  = "Danil42Russia",
    version = VERSION,
    url     = "vk.com/danil42russia"
};

public OnPluginStart()
{
    HookEvent("round_start", Event_RoundStart);
}

public void Event_RoundStart(Handle hEvent, char[] sEvName, bool bDontBroadcast)
{
    for (new i = 1; i <= MaxClients; i++)
    {
        if (IsClientInGame(i))
            PrintToConsole(i, message);
    }
}
