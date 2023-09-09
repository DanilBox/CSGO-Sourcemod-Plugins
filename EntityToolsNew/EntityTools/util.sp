//Координаты
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

//Угол
void EditAngle(int iClient, int iEntity, char cAxes, float fValue, char type)
{
    if (fValue < -360.0 || fValue > 360.0)
    {
        PrintToChat(iClient, "Вы вышли из области значений");
        return;
    }

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
            fNum = AngleNormalization(temp + fValue);
        }

        case '-':
        {
            fNum = AngleNormalization(temp - fValue);
        }

        case ' ':
        {
            fNum = AngleNormalization(fValue);
        }
    }

    if (fNum != temp)
    {
        fAng[index] = fNum;
        TeleportEntity(iEntity, NULL_VECTOR, fAng, NULL_VECTOR);
    }
}

//Нормализация
float AngleNormalization(float fAngle)
{
    float corner;
    if (fAngle >= 0.0)
    {
        //О да, костыли, ибо view_as не работает -_-
        char szBuf[64];
        FloatToString(fAngle / 360.0, szBuf, sizeof(szBuf));
        int numRev = StringToInt(szBuf);
        corner     = fAngle - (numRev * 360.0);
    }
    else
    {
        corner = AngleNormalization(360.0 - AngleNormalization(FloatAbs(fAngle)));
    }

    return corner;
}

//Прозрачность
void EditVisibility(int iClient, int iEntity, int iValue, char type)
{
    if (iValue < 0 || iValue > 255)
    {
        PrintToChat(iClient, "Вы вышли из области значений");
        return;
    }

    int iColors[4];
    GetEntityRenderColor(iEntity, iColors[0], iColors[1], iColors[2], iColors[3]);

    int iNum = iColors[3];

    switch (type)
    {
        case '+':
        {
            if ((iColors[3] + iValue) > 255)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = iColors[3] + iValue;
        }

        case '-':
        {
            if ((iColors[3] - iValue) < 0)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = iColors[3] - iValue;
        }

        case ' ':
        {
            if (iValue < 0 || iValue > 255)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = iValue;
        }
    }

    if (iNum != iColors[3])
    {
        SetEntityRenderMode(iEntity, RENDER_TRANSCOLOR);
        SetEntityRenderColor(iEntity, iColors[0], iColors[1], iColors[2], iNum);
    }
}

//Цвет
void EditColor(int iClient, int iEntity, char cColor, int iValue, char type)
{
    if (iValue < 0 || iValue > 255)
    {
        PrintToChat(iClient, "Вы вышли из области значений");
        return;
    }

    int iColors[4];
    GetEntityRenderColor(iEntity, iColors[0], iColors[1], iColors[2], iColors[3]);

    int temp;
    int index;

    switch (cColor)
    {
        case 'r':
        {
            index = 0;
            temp  = iColors[0];
        }
        case 'g':
        {
            index = 1;
            temp  = iColors[1];
        }
        case 'b':
        {
            index = 2;
            temp  = iColors[2];
        }
        case 'h':
        {
            int hex, r, g, b;
            HexToRGB(hex, r, g, b);

            if (!(iColors[0] == r || iColors[1] == g || iColors[2] == b))
            {
                iColors[0] = r;
                iColors[1] = g;
                iColors[2] = b;
                SetEntityRenderMode(iEntity, RENDER_TRANSCOLOR);
                SetEntityRenderColor(iEntity, iColors[0], iColors[1], iColors[2], iColors[3]);
            }

            return;
        }
    }

    int iNum = temp;

    switch (type)
    {
        case '+':
        {
            if ((temp + iValue) > 255)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = temp + iValue;
        }
        case '-':
        {
            if ((temp - iValue) < 0)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = temp - iValue;
        }
        case ' ':
        {
            if (iValue < 0 || iValue > 255)
                PrintToChat(iClient, "Вы вышли из области значений");
            else
                iNum = iValue;
        }
    }

    if (iNum != temp)
    {
        iColors[index] = iNum;
        SetEntityRenderMode(iEntity, RENDER_TRANSCOLOR);
        SetEntityRenderColor(iEntity, iColors[0], iColors[1], iColors[2], iColors[3]);
    }
}

void HexToRGB(int hex, int &r, int &g, int &b)
{
    r = ((hex >> 16) & 0xFF);
    g = ((hex >> 8) & 0xFF);
    b = (hex & 0xFF);
}
