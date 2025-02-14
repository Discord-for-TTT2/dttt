CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "dttt_mapping_title"
CLGAMEMODESUBMENU.priority = 99

local function createPlayerEntry(parent, steam_id, discord_id, ply_name)
    ply_name = ply_name or "OFFLINE"

    local ply_entry = vgui.CreateTTT2Form(parent, ply_name .. ":" .. steam_id)

    local btn = ply_entry:MakeButton({
        label="dttt_btn_autorun",
        buttonLabel="dttt_btn_autorun_label",
        OnClick=function(slf)
            net.Start("dttt_run_automapper")
            net.WriteString(steam_id)
            net.SendToServer()
        end
    })

    if ply_name == "OFFLINE" then btn:SetEnabled(false) end

    ply_entry:MakeTextEntry({
        label="Discord ID",
        initial=discord_id,
        OnChange=function(obj, value)
            net.Start("dttt_change_discord_id")
            net.WriteString(steam_id)
            net.WriteString(value)
            net.SendToServer()
        end
    })
end

local function listActivePlayers(parent, mapping)
    local plys = player.GetHumans()

    for _, ply in ipairs(plys) do
        local steam_id = tostring(ply:SteamID64())
        local discord_id = mapping[steam_id] or ""

        createPlayerEntry(parent, steam_id, discord_id, ply:Nick())
    end
end

local function listAllPlayers(parent, mapping)
    local plys = {}

    for _, ply in pairs(player.GetHumans()) do
        plys[ply:SteamID64()] = ply:Nick()
    end

    for steam_id, discord_id in pairs(mapping) do
        discord_id = discord_id or ""

        createPlayerEntry(parent, steam_id, discord_id, plys[steam_id])
    end
end


function CLGAMEMODESUBMENU:Initialize()
end

function CLGAMEMODESUBMENU:Populate(parent)
    local form = vgui.CreateTTT2Form(parent, "dttt_mapping_form")

    form:MakeCheckBox({
        label="dttt_mapping_automap",
        initial=g_convars["dttt_auto_map_ids"].value,
        default=g_convars["dttt_auto_map_ids"].default,
        OnChange=function(obj, value)
            setBoolCVar("dttt_auto_map_ids", value)
            getBoolCVar("dttt_auto_map_ids")
        end
    })

    form:MakeCheckBox({
        label="dttt_mapping_cache",
        initial=g_convars["dttt_cache_mapping"].value,
        default=g_convars["dttt_cache_mapping"].default,
        OnChange=function(obj, value)
            setBoolCVar("dttt_cache_mapping", value)
            getBoolCVar("dttt_cache_mapping")
        end
    })

    local ply_form = vgui.CreateTTT2Form(parent, "dttt_player_form")

    net.Receive("dttt_cl_get_mapping", function()
        local mapping = net.ReadTable()

        listAllPlayers(ply_form, mapping)
        --listActivePlayers(parent, mapping)
    end)

    net.Start("dttt_sv_get_mapping")
    net.SendToServer()
end