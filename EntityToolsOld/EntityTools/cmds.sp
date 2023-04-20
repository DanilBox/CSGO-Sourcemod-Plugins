public Action EtCmd(int iClient, int iArgs)
{
    if (GetUserFlagBits(iClient))
        MainMenu(iClient);
    return Plugin_Handled;
}

public Action EtEditCoordCmd(int iClient, int iArgs)
{
    return Plugin_Handled;
}

//Изменение координат
public Action EtEditCoordCmd(int iClient, int iArgs)
{
    if (iArgs != 2)
    {
        PrintToChat(iClient, "Мало аргументов");
        return Plugin_Handled;
    }

    int iEntity = GetClientAimTarget(iClient, false);
    if (iEntity <= 0)
    {
        PrintToChat(iClient, "Entity не найден");
        return Plugin_Handled;
    }

    char cAxes;
    char szBuffer[64];
    GetCmdArg(1, szBuffer, sizeof(szBuffer));
    cAxes = szBuffer[0];

    if (!(cAxes == 'x' || cAxes == 'y' || cAxes == 'z'))
    {
        PrintToChat(iClient, "Не верные аргументы");
        return Plugin_Handled;
    }

    GetCmdArg(2, szBuffer, sizeof(szBuffer));
    float fValue = StringToFloat(szBuffer);

    if (szBuffer[0] == '+' || szBuffer[0] == '-')
        EditCoord(iClient, iEntity, cAxes, fValue, szBuffer[0]);
    else
        EditCoord(iClient, iEntity, cAxes, fValue, ' ');

    return Plugin_Handled;
}

//Изменение угла наклона
public Action EtEditAngleCmd(int iClient, int iArgs)
{
    if (iArgs != 2)
    {
        PrintToChat(iClient, "Мало аргументов");
        return Plugin_Handled;
    }

    int iEntity = GetClientAimTarget(iClient, false);
    if (iEntity <= 0)
    {
        PrintToChat(iClient, "Entity не найден");
        return Plugin_Handled;
    }

    char cAxes;
    char szBuffer[64];
    GetCmdArg(1, szBuffer, sizeof(szBuffer));
    cAxes = szBuffer[0];

    if (!(cAxes == 'x' || cAxes == 'y' || cAxes == 'z'))
    {
        PrintToChat(iClient, "Не верные аргументы");
        return Plugin_Handled;
    }

    GetCmdArg(2, szBuffer, sizeof(szBuffer));
    float fValue = StringToFloat(szBuffer);

    if (szBuffer[0] == '+' || szBuffer[0] == '-')
        EditAngle(iClient, iEntity, cAxes, fValue, szBuffer[0]);
    else
        EditAngle(iClient, iEntity, cAxes, fValue, ' ');

    return Plugin_Handled;
}

//Изменение видимости
public Action EtEditVisibilityCmd(int iClient, int iArgs)
{
    if (iArgs != 1)
    {
        PrintToChat(iClient, "Мало аргументов");
        return Plugin_Handled;
    }

    int iEntity = GetClientAimTarget(iClient, false);
    if (iEntity <= 0)
    {
        PrintToChat(iClient, "Entity не найден");
        return Plugin_Handled;
    }

    char szBuffer[64];
    GetCmdArg(1, szBuffer, sizeof(szBuffer));
    int iValue = StringToInt(szBuffer);

    if (szBuffer[0] == '+' || szBuffer[0] == '-')
        EditVisibility(iClient, iEntity, iValue, szBuffer[0]);
    else
        EditVisibility(iClient, iEntity, iValue, ' ');

    return Plugin_Handled;
}
