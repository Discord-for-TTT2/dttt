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