concommand.Add("dttt", function(ply, cmd, args, argStr)
    for _, convarName in ipairs(engine.GetConsoleCommands()) do
        local convar = GetConVar(convarName)
        if not convar then
            return
        end

        -- Check if the ConVar name starts with a certain prefix
        if string.StartWith(convarName, "dttt_") then
            forceLog(convar:GetName() .. " : " .. convar:GetString())
        end
    end
end)