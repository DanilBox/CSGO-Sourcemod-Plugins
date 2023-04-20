void EditCoord(int iClient, int iEntity, char cAxes, float fValue, char type)
{
    float fPos[3];
    GetEntPropVector(iEntity, Prop_Send, "m_vecOrigin", fPos);

    float temp;
    int   index;

    switch (cAxes)
    {
        case 'x':
        {
            index = 0;
            temp  = fPos[0];
        }
        case 'y':
        {
            index = 1;
            temp  = fPos[1];
        }
        case 'z':
        {
            index = 2;
            temp  = fPos[2];
        }
    }

    float fMapMin[3];
    float fMapMax[3];
    GetEntPropVector(0, Prop_Data, "m_WorldMins", fMapMin);
    GetEntPropVector(0, Prop_Data, "m_WorldMaxs", fMapMax);

    float fNum = temp;

    switch (type)
    {
        case '+':
        {
            if ((temp + fValue) > fMapMax[index])
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                fNum = temp + fValue;
        }
        case '-':
        {
            if ((temp - fValue) < fMapMin[index])
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                fNum = temp - fValue;
        }
        case ' ':
        {
            if (fValue < fMapMin[index] || fValue > fMapMax[index])
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                fNum = fValue;
        }
    }

    if (fNum != temp)
    {
        fPos[index] = fNum;
        TeleportEntity(iEntity, fPos, NULL_VECTOR, NULL_VECTOR);
    }
}

void EditAngle(int iClient, int iEntity, char cAxes, float fValue, char type)
{
    float fAng[3];
    GetEntPropVector(iEntity, Prop_Send, "m_angRotation", fAng);

    float temp;
    int   index;

    switch (cAxes)
    {
        case 'x':
        {
            index = 0;
            temp  = fAng[0];
        }
        case 'y':
        {
            index = 1;
            temp  = fAng[1];
        }
        case 'z':
        {
            index = 2;
            temp  = fAng[2];
        }
    }

    float fNum = temp;

    switch (type)
    {
        case '+':
        {
            if ((temp + fValue) > 360.0)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                fNum = temp + fValue;
        }

        case '-':
        {
            if ((temp + fValue) < -360.0)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                fNum = temp + fValue;
        }

        case ' ':
        {
            if (fValue < -360.0 || fValue > 360.0)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                fNum = fValue;
        }
    }

    if (fNum != temp)
    {
        fAng[index] = fNum;
        TeleportEntity(iEntity, NULL_VECTOR, fAng, NULL_VECTOR);
    }
}

void EditVisibility(int iClient, int iEntity, int value, char type)
{
    int iColors[4];
    GetEntityRenderColor(iEntity, iColors[0], iColors[1], iColors[2], iColors[3]);

    int iNum = iColors[3];

    switch (type)
    {
        case '+':
        {
            if ((iColors[3] + value) > 255)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = iColors[3] + value;
        }

        case '-':
        {
            if ((iColors[3] + value) < 0)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = iColors[3] + value;
        }

        case ' ':
        {
            if (value < 0 || value > 255)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = value;
        }
    }

    if (iNum != iColors[3])
    {
        SetEntityRenderMode(iEntity, RENDER_TRANSCOLOR);
        SetEntityRenderColor(iEntity, 255, 255, 255, iNum);
    }
}
