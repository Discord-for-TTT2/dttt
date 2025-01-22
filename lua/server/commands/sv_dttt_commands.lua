include("shared/sh_globals.lua")
include("server/sv_globals.lua")
include("server/discord/sv_discord_id_mapping.lua")

concommand.Add(COMMANDS.HELP, function(ply, cmd, args, argStr)
    for _, value in pairs(COMMANDS) do
        print(value)
    end
end)

concommand.Add(COMMANDS.LIST_CON_VARS, function(ply, cmd, args, argStr)
    for key, value in pairs(CON_VARS) do
        logDebug(value .. " " .. GetConVar(value):GetString())
    end
end)

concommand.Add(COMMANDS.LIST_MUTED_PLAYERS, function(ply, cmd, arg, argStr)
    for key, value in pairs(_G.dttt_muted_players) do
        logDebug(key .. " " .. tostring(value))
    end
end)

concommand.Add(COMMANDS.LIST_ID_MAPPINGS, function(ply, cmd, arg, argStr)
    for key, value in pairs(_G.dttt_id_mapping) do
        logDebug(key .. " " .. value)
    end
end)

concommand.Add(COMMANDS.CLEAR_IDS, function(ply, cmd, arg, argStr)
    clearDiscordIds()
end)

concommand.Add(COMMANDS.RUN_AUTOMAP, function(ply, cmd, arg, argStr)
    local players = player.GetHumans()

    logInfo("Trying to remap all players")
    for _, current_ply in ipairs(players) do
        autoMapId(current_ply)
    end

    logInfo("Mapped all players")
    logTable(_G.dttt_id_mapping, "ID Mappings")
end)

concommand.Add(COMMANDS.MUTE_ALL, function(ply, cmd, arg, argStr)
    hook.Run(HOOKS.MUTE_ALL_PLAYERS)
end)

concommand.Add(COMMANDS.UNMUTE_ALL, function(ply, cmd, arg, argStr)
    hook.Run(HOOKS.UNMUTE_ALL_PLAYERS)
end)