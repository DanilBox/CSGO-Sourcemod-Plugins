#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>

#define ADMIN_FLAG ADMFLAG_ROOT

public Plugin myinfo =
{
    name    = "PlayerInfo",
    author  = "Danil42Russia",
    version = "0.1",
    url     = "http://vk.com/danil42russia"
}

char g_MouseSensitivity[MAXPLAYERS + 1][64];
char g_ZoomSensitivity[MAXPLAYERS + 1][64];

public void OnPluginStart()
{
    LoadTranslations("common.phrases");

    RegAdminCmd("sm_pinfo", PlayerInfoCmd, ADMIN_FLAG, "Usage: sm_pinfo <#userid|name>");
    RegAdminCmd("sm_playerinfo", PlayerInfoCmd, ADMIN_FLAG, "Usage: sm_playerinfo <#userid|name>");
    RegAdminCmd("sm_pi", PlayerInfoCmd, ADMIN_FLAG, "Usage: sm_pi <#userid|name>");
}

public Action PlayerInfoCmd(int iClient, int iArgs)
{
    if (iArgs != 1)
    {
        ReplyToCommand(iClient, "Usage: command <#userid|name>");
        return Plugin_Handled;
    }

    char szArgs[64];
    GetCmdArg(1, szArgs, sizeof(szArgs));

    int iTarget = FindTarget(iClient, szArgs, true, true);
    if (iTarget <= 0)
    {
        return Plugin_Handled;
    }

    GetInfo(iTarget);

    DataPack hPack = new DataPack();
    hPack.WriteCell(iClient);    // iClient
    hPack.WriteCell(iTarget);    // iTarget

    CreateTimer(0.5, Timer_MouseCheck, hPack, TIMER_FLAG_NO_MAPCHANGE | TIMER_DATA_HNDL_CLOSE);

    return Plugin_Handled;
}

void GetInfo(int iTarget)
{
    QueryClientConVar(iTarget, "sensitivity", Query_MouseSensitivityCheck);
    QueryClientConVar(iTarget, "zoom_sensitivity_ratio_mouse", Query_ZoomSensitivityCheck);
}

public Action Timer_MouseCheck(Handle hTimer, Handle hDataPack)
{
    DataPack hPack = view_as<DataPack>(hDataPack);
    hPack.Reset();

    int iClient = hPack.ReadCell();
    int iTarget = hPack.ReadCell();

    PanelInfo(iClient, iTarget);
}

void PanelInfo(int iClient, int iTarget)
{
    Panel hPanel = new Panel();
    hPanel.SetTitle("PlayerInfo");

    hPanel.DrawText(" ");

    char szBuffer[64];
    char szName[64];
    GetClientName(iTarget, szName, sizeof(szName));
    FormatEx(szBuffer, sizeof(szBuffer), "Name %s", szName);
    hPanel.DrawText(szBuffer);

    FormatEx(szBuffer, sizeof(szBuffer), "sensitivity %s", g_MouseSensitivity[iTarget]);
    hPanel.DrawText(szBuffer);

    FormatEx(szBuffer, sizeof(szBuffer), "zoom_sensitivity %s", g_ZoomSensitivity[iTarget]);
    hPanel.DrawText(szBuffer);

    hPanel.DrawItem("Закрыть", ITEMDRAW_CONTROL);

    hPanel.Send(iClient, SelectInfoPanel, 20);

    delete hPanel;
}

public void Query_MouseSensitivityCheck(QueryCookie cookie, int client, ConVarQueryResult result, char[] cvarName, char[] cvarValue)
{
    if (result == ConVarQuery_Okay)
    {
        char szBuffer[16];
        FormatEx(szBuffer, sizeof(szBuffer), cvarValue);
        g_MouseSensitivity[client] = szBuffer;
    }
}

public void Query_ZoomSensitivityCheck(QueryCookie cookie, int client, ConVarQueryResult result, char[] cvarName, char[] cvarValue)
{
    if (result == ConVarQuery_Okay)
    {
        char szBuffer[16];
        FormatEx(szBuffer, sizeof(szBuffer), cvarValue);
        g_ZoomSensitivity[client] = szBuffer;
    }
}

public int SelectInfoPanel(Menu hPanel, MenuAction action, int iClient, int iOption)
{
}
