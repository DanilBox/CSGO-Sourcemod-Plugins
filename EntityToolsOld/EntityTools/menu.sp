//Главное меню
void MainMenu(int iClient)
{
    Menu hMenu = new Menu(MainMenuItem);

    hMenu.ExitButton = true;
    hMenu.SetTitle("EntityTools Menu");

    hMenu.AddItem("", "Изменить координаты");
    hMenu.AddItem("", "Изменить угол наклона");
    hMenu.AddItem("", "Изменить видимость");

    hMenu.Display(iClient, MENU_TIME_FOREVER);
}

public int MainMenuItem(Menu hMenu, MenuAction action, int iClient, int iItem)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            switch (iItem)
            {
                case 0:
                    EditCoordMenu(iClient);
                case 1:
                    EditAngleMenu(iClient);
                case 2:
                    EditVisibilityMenu(iClient);
            }
        }
        case MenuAction_End:
            delete hMenu;
    }
}

//Меню изменения координат
void EditCoordMenu(int iClient)
{
    Menu hMenu = new Menu(EditCoordItem);

    hMenu.ExitBackButton = true;
    hMenu.SetTitle("Меню изменения координат");

    hMenu.AddItem("", "по X");
    hMenu.AddItem("", "по Y");
    hMenu.AddItem("", "по Z");

    hMenu.Display(iClient, MENU_TIME_FOREVER);
}

public int EditCoordItem(Menu hMenu, MenuAction action, int iClient, int iItem)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            switch (iItem)
            {
                case 0:
                    delete hMenu;
                case 1:
                    delete hMenu;
            }
        }
        case MenuAction_Cancel:
            if (iItem == MenuCancel_ExitBack)
                MainMenu(iClient);
        case MenuAction_End:
            delete hMenu;
    }
}

//Меню изменения угла наклона
void EditAngleMenu(int iClient)
{
    Menu hMenu = new Menu(EditAngleItem);

    hMenu.ExitBackButton = true;
    hMenu.SetTitle("Меню изменения угла наклона");

    hMenu.AddItem("", "по X");
    hMenu.AddItem("", "по Y");
    hMenu.AddItem("", "по Z");

    hMenu.Display(iClient, MENU_TIME_FOREVER);
}

public int EditAngleItem(Menu hMenu, MenuAction action, int iClient, int iItem)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            switch (iItem)
            {
                case 0:
                    delete hMenu;
                case 1:
                    delete hMenu;
            }
        }
        case MenuAction_Cancel:
            if (iItem == MenuCancel_ExitBack)
                MainMenu(iClient);
        case MenuAction_End:
            delete hMenu;
    }
}

//Меню изменения видимости
void EditVisibilityMenu(int iClient)
{
    Menu hMenu = new Menu(EditVisibilityItem);

    hMenu.ExitBackButton = true;

    hMenu.SetTitle("Меню изменения видимости");

    hMenu.AddItem("custom", "Установить");
    hMenu.AddItem("", "0");
    hMenu.AddItem("", "51");
    hMenu.AddItem("", "102");
    hMenu.AddItem("", "153");
    hMenu.AddItem("", "204");
    hMenu.AddItem("", "255");

    hMenu.Display(iClient, MENU_TIME_FOREVER);
}

public int EditVisibilityItem(Menu hMenu, MenuAction action, int iClient, int iItem)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            char szID[16];
            hMenu.GetItem(iItem, szID, sizeof(szID));

            if (strcmp(szID, "custom") == 0)
            {
                g_bWaitChat = true;
                DisplayCustomChatMenu(iClient);
                return;
            }

            int iNum;

            switch (iItem)
            {
                case 1:
                    iNum = 0;
                case 2:
                    iNum = 51;
                case 3:
                    iNum = 102;
                case 4:
                    iNum = 153;
                case 5:
                    iNum = 204;
                case 6:
                    iNum = 255;
            }

            int iEntity = GetClientAimTarget(iClient, false);
            if (iEntity <= 0)
            {
                PrintToChat(iClient, "Entity не найден");
            }
            else
                EditVisibility(iClient, iEntity, iNum, ' ');

            EditVisibilityMenu(iClient);
        }
        case MenuAction_Cancel:
            if (iItem == MenuCancel_ExitBack)
                MainMenu(iClient);
        case MenuAction_End:
            delete hMenu;
    }
}

//Меню ввода для изменения видимости
void DisplayCustomChatMenu(int iClient, const char[] szArgs = "")
{
    Menu hMenu           = CreateMenu(DisplayCustomChatMenuItem);
    hMenu.ExitBackButton = true;
    hMenu.SetTitle("Введите значение в чате");

    if (szArgs[0])
    {
        char szBuffer[128];
        FormatEx(szBuffer, sizeof(szBuffer), "Принять \"%s\"", szArgs);
        hMenu.AddItem(szArgs, szBuffer);

        hMenu.AddItem("", "Повторно");
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
    }
    else
    {
        hMenu.AddItem("", "Установить", ITEMDRAW_DISABLED);

        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
        hMenu.AddItem("", "", ITEMDRAW_NOTEXT);
    }

    hMenu.Display(iClient, MENU_TIME_FOREVER);
}

public int DisplayCustomChatMenuItem(Menu hMenu, MenuAction action, int iClient, int iItem)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            switch (iItem)
            {
                case 0:
                {
                    char szBuffer[128];
                    hMenu.GetItem(iItem, szBuffer, sizeof(szBuffer));

                    int iNum    = StringToInt(szBuffer);

                    int iEntity = GetClientAimTarget(iClient, false);
                    if (iEntity <= 0)
                    {
                        PrintToChat(iClient, "Entity не найден");
                    }
                    else
                        EditVisibility(iClient, iEntity, iNum, ' ');

                    EditVisibilityMenu(iClient);
                }

                case 1:
                {
                    g_bWaitChat = true;
                    DisplayCustomChatMenu(iClient);
                }
            }
        }
        case MenuAction_Cancel:
        {
            if (iItem == MenuCancel_ExitBack)
                EditVisibilityMenu(iClient);

            if (iItem == MenuCancel_Disconnected || iItem == MenuCancel_Interrupted || iItem == MenuCancel_NoDisplay || iItem == MenuCancel_Timeout)
                g_bWaitChat = false;
        }
        case MenuAction_End:
        {
            if (iItem == MenuCancel_Exit)
                delete hMenu;

            if (iItem == MenuEnd_Cancelled)
                g_bWaitChat = false;
        }
    }
}
