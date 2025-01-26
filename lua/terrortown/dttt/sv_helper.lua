function getSteamId(ply)
    return tostring(ply:SteamID64())
end

function getRoundState()
    if gmod.GetGamemode().Name == "TTT2" or gmod.GetGamemode().Name == "TTT2 (Advanced Update)" then
        return GetRoundState()
    end

    return nil
end