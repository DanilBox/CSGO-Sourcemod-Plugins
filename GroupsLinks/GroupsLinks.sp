#pragma semicolon 1

#include <csgo_colors>
#include <sourcemod>

#define VERSION    "0.0.1"

#define DEBUG_MODE 0

static const char vkCommand[][]      = { "!vk", "vk", "!вк", "вк" };
static const char steamCommand[][]   = { "!steam", "steam", "!стим", "стим", "!st", "st" };
static const char discordCommand[][] = { "!discord", "discord", "!дискорд", "дискорд", "!ds", "ds", "!дс", "дс" };
static const char ipCommand[][]      = { "!ip", "ip", "!ип", "ип" };

static const char vkSend[]           = "Группа в {BLUE}Вконтакте {DEFAULT} links{DEFAULT}";
static const char steamSend[]        = "Группа в {BLUE}Steam {DEFAULT} links{DEFAULT}";
static const char discordSend[]      = "Группа в {BLUE}Discord {DEFAULT} links{DEFAULT}";

public Plugin : myinfo = {
    name    = "GroupsLinks",
    author  = "Danil42Russia",
    version = VERSION,
    url     = "vk.com/danil42russia"
};

public OnPluginStart()
{
#if DEBUG_MODE 1
    PrintToServer("Plugin GroupsLinks is load");
    PrintToChatAll("Plugin GroupsLinks is load");
#endif
}

public void OnClientSayCommand_Post(int iClient, const char[] command, const char[] sArgs)
{
    for (int i; i < sizeof(vkCommand); i++)
    {
        if (StrEqual(sArgs, vkCommand[i], false)) SentChatVk();
    }

    for (int i; i < sizeof(steamCommand); i++)
    {
        if (StrEqual(sArgs, steamCommand[i], false)) SentChatSteam();
    }

    for (int i; i < sizeof(discordCommand); i++)
    {
        if (StrEqual(sArgs, discordCommand[i], false)) SentChatDiscord();
    }

    for (int i; i < sizeof(ipCommand); i++)
    {
        if (StrEqual(sArgs, ipCommand[i], false)) GetIPAndPort();
    }
}

public void SentChatVk()
{
    CGOPrintToChatAll(vkSend);
}

public void SentChatSteam()
{
    CGOPrintToChatAll(steamSend);
}

public void SentChatDiscord()
{
    CGOPrintToChatAll(discordSend);
}

public void GetIPAndPort()
{
    char sText[2][128];

    int  ip = FindConVar("hostip").IntValue;
    FormatEx(sText[0], 128, "%d.%d.%d.%d", ip >>> 24 & 255, ip >>> 16 & 255, ip >>> 8 & 255, ip & 255);
    GetConVarString(FindConVar("hostport"), sText[1], 128);

    CGOPrintToChatAll("IP-адрес и порт сервера - {PURPLE}%s:%s{DEFAULT}", sText[0], sText[1]);
}
