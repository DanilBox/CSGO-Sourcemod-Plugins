//Координаты
public Action EtEditPositionCmd(int iClient, int iArgs)
{
    if (!(iArgs == 2 || iArgs == 3))
    {
        PrintToChat(iClient, "Ошибка в количестве аргументах");
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

    if (!(szBuffer[0] == 'x' || szBuffer[0] == 'y' || szBuffer[0] == 'z'))
    {
        PrintToChat(iClient, "Не верные аргументы");
        return Plugin_Handled;
    }
    char cAxes = szBuffer[0];

    GetCmdArg(2, szBuffer, sizeof(szBuffer));

    if (iArgs == 2)
    {
        float fValue = StringToFloat(szBuffer);
        EditCoord(iClient, iEntity, cAxes, fValue, ' ');
    }

    if (iArgs == 3)
    {
        if (!(szBuffer[0] == '+' || szBuffer[0] == '-'))
        {
            PrintToChat(iClient, "Не верные аргументы");
            return Plugin_Handled;
        }
        char cType = szBuffer[0];

        GetCmdArg(3, szBuffer, sizeof(szBuffer));
        float fValue = StringToFloat(szBuffer);

        EditCoord(iClient, iEntity, cAxes, fValue, cType);
    }

    return Plugin_Handled;
}

//Угол
public Action EtEditAngleCmd(int iClient, int iArgs)
{
    if (!(iArgs == 2 || iArgs == 3))
    {
        PrintToChat(iClient, "Ошибка в количестве аргументах");
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

    if (!(szBuffer[0] == 'x' || szBuffer[0] == 'y' || szBuffer[0] == 'z'))
    {
        PrintToChat(iClient, "Не верные аргументы");
        return Plugin_Handled;
    }
    char cAxes = szBuffer[0];

    GetCmdArg(2, szBuffer, sizeof(szBuffer));

    if (iArgs == 2)
    {
        float fValue = StringToFloat(szBuffer);
        EditAngle(iClient, iEntity, cAxes, fValue, ' ');
    }

    if (iArgs == 3)
    {
        if (!(szBuffer[0] == '+' || szBuffer[0] == '-'))
        {
            PrintToChat(iClient, "Не верные аргументы");
            return Plugin_Handled;
        }
        char cType = szBuffer[0];

        GetCmdArg(3, szBuffer, sizeof(szBuffer));
        float fValue = StringToFloat(szBuffer);

        EditAngle(iClient, iEntity, cAxes, fValue, cType);
    }

    return Plugin_Handled;
}

//Прозрачность
public Action EtEditVisibilityCmd(int iClient, int iArgs)
{
    if (!(iArgs == 1 || iArgs == 2))
    {
        PrintToChat(iClient, "Ошибка в количестве аргументах");
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

    if (iArgs == 1)
    {
        int iValue = StringToInt(szBuffer);
        EditVisibility(iClient, iEntity, iValue, ' ');
    }

    if (iArgs == 2)
    {
        if (!(szBuffer[0] == '+' || szBuffer[0] == '-'))
        {
            PrintToChat(iClient, "Не верные аргументы");
            return Plugin_Handled;
        }

        char cType = szBuffer[0];

        GetCmdArg(2, szBuffer, sizeof(szBuffer));
        int iValue = StringToInt(szBuffer);

        EditVisibility(iClient, iEntity, iValue, cType);
    }

    return Plugin_Handled;
}

//Цвет
public Action EtEditColorCmd(int iClient, int iArgs)
{
    if (!(iArgs == 2 || iArgs == 3))
    {
        PrintToChat(iClient, "Ошибка в количестве аргументах");
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

    if (!(szBuffer[0] == 'r' || szBuffer[0] == 'g' || szBuffer[0] == 'b'))
    {
        PrintToChat(iClient, "Не верные аргументы");
        return Plugin_Handled;
    }
    char cColor = szBuffer[0];

    GetCmdArg(2, szBuffer, sizeof(szBuffer));

    if (iArgs == 2)
    {
        int iValue = StringToInt(szBuffer);
        EditColor(iClient, iEntity, cColor, iValue, ' ');
    }

    if (iArgs == 3)
    {
        if (!(szBuffer[0] == '+' || szBuffer[0] == '-'))
        {
            PrintToChat(iClient, "Не верные аргументы");
            return Plugin_Handled;
        }
        char cType = szBuffer[0];

        GetCmdArg(3, szBuffer, sizeof(szBuffer));
        int iValue = StringToInt(szBuffer);

        EditColor(iClient, iEntity, cColor, iValue, cType);
    }

    return Plugin_Handled;
}
