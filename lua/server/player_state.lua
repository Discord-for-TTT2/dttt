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
    local players = player.GetHumans()

    local mute_tbl = {}

    for _, ply in ipairs(players) do
        setMuteState(ply, true)

        if hasMappedId(ply) then
            local player_map = {["id"]=getMappedId(ply), ["status"]=tostring("true")}
            table.insert(mute_tbl, player_map)
        end
    end

    postMuteAllRequest(mute_tbl, function()
        logInfo("MUTED ALL PLAYERS")
    end)
end

function unmuteAll(duration)
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
end

function undeafenAll(duration)
end