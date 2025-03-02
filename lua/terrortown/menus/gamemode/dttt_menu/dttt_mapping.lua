CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "dttt_mapping_title"
CLGAMEMODESUBMENU.priority = 99

function CLGAMEMODESUBMENU:Initialize()
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

    local online_player_mappings_form = vgui.CreateDTTTForm(parent, "dttt_online_player_mapping_form")

    local offline_player_mappings_form = vgui.CreateDTTTForm(parent, "dttt_offline_player_mapping_form")

    net.Receive("dttt_cl_get_mapping", function()
        online_player_mappings_form:Clear()
        offline_player_mappings_form:Clear()

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
            local is_online = player_map[steam_id] ~= nil
            local player_name = player_map[steam_id] or "OFFLINE"

            if is_online then
                online_player_mappings_form:MakeDiscordIDEntry({
                    player = {
                        steam_id = steam_id,
                        discord_id = discord_id,
                        name = player_name
                    },
                    automap_enabled = true
                })
            else
                offline_player_mappings_form:MakeDiscordIDEntry({
                    player = {
                        steam_id = steam_id,
                        discord_id = discord_id,
                        name = player_name
                    },
                    add_automap = false
                })
            end
        end
    end)

    net.Start("dttt_sv_get_mapping")
    net.SendToServer()
end