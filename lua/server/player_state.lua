--- MUTING ---
function mutePlayer(ply, duration)
    if ply:IsBot() then return end

    setMuteState(ply, true)
    postMuteRequest(ply)

    if duration > 0 then
        timer.Simple(duration, function() unmutePlayer(ply) end)
    end
end

function unmutePlayer(ply, duration)
    if ply:IsBot() then return end

    setMuteState(ply, false)
    postMuteRequest(ply)

    if duration > 0 then
        timer.Simple(duration, function() mutePlayer(ply) end)
    end
end

function muteAll(duration)
    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        setMuteState(ply, true)
    end

    postMuteAllRequest(players, function()
        logInfo("MUTED ALL PLAYERS")
    end)

    if duration > 0 then
        timer.Simple(unmuteAll())
    end
end

function unmuteAll(duration)
    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        setMuteState(ply, true)
    end

    postMuteAllRequest(players, function()
        logInfo("UNMUTED ALL PLAYERS")
    end)

    if duration > 0 then
        timer.Simple(muteAll())
    end
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