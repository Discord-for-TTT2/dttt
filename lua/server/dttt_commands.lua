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