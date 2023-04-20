#pragma semicolon 1
#pragma newdecls required

#include <sdktools>

#include "EntityTools/cmds.sp"
#include "EntityTools/util.sp"

public Plugin myinfo =
{
    name    = "EntityTools",
    author  = "Danil42Russia",
    version = "0.1",
    url     = "http://vk.com/danil42russia"
}

/*
    sm_et_ep <[x/y/z]> <величина>
    sm_et_ep <[x/y/z]> <[+/-]> <величина>

    sm_et_ea <[x/y/z]> <величина [0..360]>
    sm_et_ea <[x/y/z]> <[+/-]> <величина [0..360]>

    sm_et_ev <величина [0..255]>
    sm_et_ev <[+/-]> <величина [0..255]>

    sm_et_ec <hex>
    sm_et_ec <[r/g/b]> <величина [0..255]>
    sm_et_ec <[r/g/b]> <[+/-]> <величина [0..255]>
*/

public void OnPluginStart() {
    RegAdminCmd("sm_et_ep", EtEditPositionCmd, ADMFLAG_ROOT, "sm_et_ep <[x/y/z]> <[+/-] величина>");
    RegAdminCmd("sm_et_ea", EtEditAngleCmd, ADMFLAG_ROOT, "sm_et_ea <[x/y/z]> <[+/-] величина [-360..360]>");
    RegAdminCmd("sm_et_ev", EtEditVisibilityCmd, ADMFLAG_ROOT, "sm_et_ev <[+/-] величина [0..255]>");
    RegAdminCmd("sm_et_ec", EtEditColorCmd, ADMFLAG_ROOT, "sm_et_ec <[r/g/b]> <[+/-] величина [0..255]>");
}
