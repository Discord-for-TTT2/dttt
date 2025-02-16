local commands = {}

local function addCommand(name, callback)
    table.insert(commands, name)
    concommand.Add(name, callback)
end

addCommand("dttt", function(ply, cmd, args, argStr)
    for _, command in ipairs(commands) do
        dttt_logger.Force(command)
    end
end)

addCommand("dttt_vars", function(ply, cmd, args, argStr)
    for _, convar in ipairs(g_convars) do
        dttt_logger.Force(convar:GetName() .. " : " .. convar:GetString())
    end
end)

addCommand("dttt_mappings", function(ply, cmd, args, argStr)
    for key, value in pairs(discord.GetMappings()) do
        dttt_logger.Force(key .. ":" .. value)
    end
end)

addCommand("dttt_player_states", function(ply, cmd, args, argStr)
    print("")

    for _, ply in ipairs(player.GetHumans()) do
        dttt_logger.Force(ply:Nick() .. ":")
        dttt_logger.Force("Muted: " .. tostring(ply:GetMuted()))
        dttt_logger.Force("Deafened: " .. tostring(ply:GetDeafened()))
        print("")
    end
end)

addCommand("dttt_clear_mapping", function(ply, cmd, args, argStr)
    discord.ClearMapping()
end)

addCommand("dttt_run_automapper", function(ply, cmd, args, argStr)
    for _, ply in ipairs(player.GetHumans()) do
        discord.AutoMap(ply)
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