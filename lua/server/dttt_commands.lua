concommand.Add("dttt", function(ply, cmd, args, argStr)
    print(#g_convars)
    for _, convar in ipairs(g_convars) do
        forceLog(convar:GetName() .. " : " .. convar:GetString())
    end
end)