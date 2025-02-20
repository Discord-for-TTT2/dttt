CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "dttt_mapping_title"
CLGAMEMODESUBMENU.priority = 99

function CLGAMEMODESUBMENU:Initialize()
end

local function CreatePlayerEntry(form, ply_name, steam_id, discord_id, add_automap_button)
    local data = {
        label = ply_name .. ":" .. steam_id,
        initial = discord_id,
        OnChange = function(obj, value)
            net.Start("dttt_sv_set_mapping")
            net.WriteString(steam_id)
            net.WriteString(value)
            net.SendToServer()
        end
    }

    if add_automap_button then
        data["enableRun"] = true
        data["OnClickRun"] = function()
            net.Start("dttt_sv_map_player")
            net.WriteString(steam_id)
            net.SendToServer()
        end
    end

    form:MakeTextEntry(data)
end

function CLGAMEMODESUBMENU:Populate(parent)
    local config_form = vgui.CreateTTT2Form(parent, "dttt_mapping_config_form")

    config_form:MakeCheckBox({
        label = "dttt_mapping_automap",
        initial = g_convars["dttt_auto_map_ids"].value,
        default = g_convars["dttt_auto_map_ids"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_auto_map_ids", value)
            ChangeBoolConVar("dttt_auto_map_ids", value)
        end
    })

    config_form:MakeCheckBox({
        label = "dttt_mapping_cache",
        initial = g_convars["dttt_cache_mapping"].value,
        default = g_convars["dttt_cache_mapping"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_cache_mapping", value)
            ChangeBoolConVar("dttt_cache_mappings", value)
        end
    })

    local player_mappings = vgui.CreateTTT2Form(parent, "dttt_mapping_form")

    net.Receive("dttt_cl_get_mapping", function()
        local mapping = net.ReadTable()
        local players = player.GetHumans()

        local player_map = {}

        for _, ply in ipairs(players) do
            local steam_id = ply:SteamID64String()

            player_map[steam_id] = ply:Nick()

            if mapping[steam_id] == nil then
                mapping[steam_id] = ""
            end
        end

        for steam_id, discord_id in pairs(mapping) do
            local player_name = player_map[steam_id] or "OFFLINE"
            local add_automap = player_map[steam_id] ~= nil

            CreatePlayerEntry(player_mappings, player_name, steam_id, discord_id or "", add_automap)
        end
    end)

    net.Start("dttt_sv_get_mapping")
    net.SendToServer()
end