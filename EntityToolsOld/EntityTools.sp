#pragma semicolon 1
#pragma newdecls required

#include <sdktools>

bool g_bWaitChat;

public Plugin myinfo =
{
    name    = "EntityTools",
    author  = "Danil42Russia",
    version = "0.1",
    url     = "http://vk.com/danil42russia"
}

#include "EntityTools/menu.sp"
#include "EntityTools/cmds.sp"
#include "EntityTools/util.sp"

public void OnPluginStart() {
    RegAdminCmd("sm_et", EtCmd, ADMFLAG_ROOT);
    RegAdminCmd("sm_et_ec", EtEditCoordCmd, ADMFLAG_ROOT, "sm_et_ec <[x/y/z]> <[+/-] величина>");
    RegAdminCmd("sm_et_ea", EtEditAngleCmd, ADMFLAG_ROOT, "sm_et_ea <[x/y/z]> <[+/-] величина [-360..360]>");
    RegAdminCmd("sm_et_ev", EtEditVisibilityCmd, ADMFLAG_ROOT, "sm_et_ev <[+/-] величина [0..255]>");
}

public Action OnClientSayCommand(int iClient, const char[] szCommand, const char[] szArgs)
{
    if (iClient && g_bWaitChat)
    {
        DisplayCustomChatMenu(iClient, szArgs);

        g_bWaitChat = false;

        return Plugin_Handled;
    }
    return Plugin_Continue;
}
