CLGAMEMODEMENU.base = "base_gamemodemenu"

CLGAMEMODEMENU.icon = Material("vgui/ttt/vskin/helpscreen/dttt")
CLGAMEMODEMENU.title =  "dttt"
CLGAMEMODEMENU.description = "dttt_desc"


function CLGAMEMODEMENU:IsAdminMenu()
    return true
end

function CLGAMEMODEMENU:Initialize()
    print("DTTT GAMEMODE INITIALISED")
    hook.Add("TTT2OnHelpSubmenuClear", "DTTTPopulateUI", function (parent, currentMenuId, lastMenuData, submenuClass)
    end)
end