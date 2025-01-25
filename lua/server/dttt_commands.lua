local commands = {}

local function addCommand(name, callback)
    table.insert(commands, name)
    concommand.Add(name, callback)
end

addCommand("dttt", function(ply, cmd, args, argStr)
    for _, command in ipairs(commands) do
        forceLog(command)
    end
end)

addCommand("dttt_vars", function(ply, cmd, args, argStr)
    for _, convar in ipairs(g_convars) do
        forceLog(convar:GetName() .. " : " .. convar:GetString())
    end
end)

addCommand("dttt_mappings", function(ply, cmd, args, argStr)
    for key, value in pairs(g_dttt_discord_mapping) do
        forceLog("SteamID:" .. tostring(key) .. " ; DiscordID:" .. tostring(value))
    end
end)

addCommand("dttt_player_states", function(ply, cmd, args, argStr)

    print("")

    forceLog("Muted Players: ")
    for key, value in pairs(g_dttt_player_states.muted) do
        forceLog("SteamID:" .. key .. " ; State:" .. tostring(value))
    end

    print("")

    forceLog("Deafened Players: ")
    for key, value in pairs(g_dttt_player_states.deafened) do
        forceLog("SteamID:" .. key .. " ; State:" .. tostring(value))
    end

    print("")
end)

addCommand("dttt_clear_mapping", function(ply, cmd, args, argStr)
    clearDiscordIds()
end)

addCommand("dttt_run_automapper", function(ply, cmd, args, argStr)
    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        autoMapId(ply)
    end
end)

addCommand("dttt_mute_all", function(ply, cmd, args, argStr)
    hook.Run("DTTTMuteAll")
end)

addCommand("dttt_unmute_all", function(ply, cmd, args, argStr)
    hook.Run("DTTTUnmuteAll")
end)

addCommand("dttt_deafen_all", function(ply, cmd, args, argStr)
    hook.Run("DTTTDeafenAll")
end)

addCommand("dttt_undeafen_all", function(ply, cmd, args, argStr)
    hook.Run("DTTTUndeafenAll")
end)

addCommand("dttt_steam_ids", function(ply, cmd, args, argStr)
    local players = player.GetHumans()

    forceLog("Steam IDs for players:")
    for _, ply in ipairs(players) do
        forceLog(ply:Nick() .. ":" .. playerIdToString(ply))
    end
end)

addCommand("dttt_add_discord_id", function(ply, cmd, args, argStr)
    local player_name = string.lower(args[0])
    local player_id = args[1]

    local players = player.GetHumans()

    forceLog("Manually adding discord ID")
    for _, ply in ipairs(players) do
        local ply_name = string.lower(ply:Nick())

        if ply_name == player_name then
            addDiscordId(ply, player_id)
            return
        end
    end
end)