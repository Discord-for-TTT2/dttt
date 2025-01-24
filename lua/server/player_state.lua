--- MUTING ---

function setMuteState(ply, state)
    g_dttt_player_states.muted[playerIdToString(ply)] = state
end

function mutePlayer(ply, duration)
    if ply:IsBot() then return end

    setMuteState(ply, true)
    postMuteRequest(ply, true)

    if duration > 0 then
        timer.Simple(duration, function() unmutePlayer(ply) end)
    end
end

function unmutePlayer(ply, duration)
    if ply:IsBot() then return end

    setMuteState(ply, false)
    postMuteRequest(ply, false)

    if duration > 0 then
        timer.Simple(duration, function() mutePlayer(ply) end)
    end
end

function muteAll(duration)
    if ply:IsBot() then return end

    local players = player.GetHumans()

    -- postMuteAll({}, true)

end

function unmuteAll(duration)
    if ply:IsBot() then return end

    local players = player.GetHumans()

    -- postUnmuteAll({}, false)

end

--- DEAFEN ---

function deafenPlayer(ply, duration)
    if ply:IsBot() then return end
end

function undeafenPlayer(ply, duration)
    if ply:IsBot() then return end
end

function deafenAll(duration)
    if ply:IsBot() then return end
end

function undeafenAll(duration)
    if ply:IsBot() then return end
end