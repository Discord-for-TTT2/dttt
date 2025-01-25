--- MUTING ---
function mutePlayer(ply, duration)
    if ply:IsBot() then return end

    logInfo("Trying to mute player " .. ply:Nick())

    setMuteState(ply, true)
    postMuteRequest(ply)

    if duration ~= nil and duration > 0 then
        timer.Simple(duration, function() unmutePlayer(ply) end)
    end
end

function unmutePlayer(ply, duration)
    if ply:IsBot() then return end

    logInfo("Trying to unmute player " .. ply:Nick())

    setMuteState(ply, false)
    postMuteRequest(ply)

    if duration ~= nil and duration > 0 then
        timer.Simple(duration, function() mutePlayer(ply) end)
    end
end

function muteAll(duration)
    local players = player.GetHumans()

    logInfo("Trying to mute all players")

    for _, ply in ipairs(players) do
        setMuteState(ply, true)
    end

    postMuteRequest(players)

    if duration ~= nil and duration > 0 then
        timer.Simple(unmuteAll())
    end
end

function unmuteAll(duration)
    local players = player.GetHumans()

    logInfo("Trying to unmute all players")

    for _, ply in ipairs(players) do
        setMuteState(ply, false)
    end

    postMuteRequest(players)

    if duration ~= nil and duration > 0 then
        timer.Simple(duration, function() muteAll() end)
    end
end

--- DEAFEN ---

function deafenPlayer(ply, duration)
    if ply:IsBot() then return end

    logInfo("Trying to deafen player " .. ply:Nick())

    setDeafenState(ply, true)
    postDeafenRequest(ply)

    if duration ~= nil and duration > 0 then
        timer.Simple(duration, function() undeafenPlayer(ply) end)
    end
end

function undeafenPlayer(ply, duration)
    if ply:IsBot() then return end

    logInfo("Trying to undeafen player " .. ply:Nick())

    setDeafenState(ply, false)
    postDeafenRequest(ply)

    if duration ~= nil and duration > 0 then
        timer.Simple(duration, function() deafenPlayer(ply) end)
    end
end

function deafenAll(duration)
    local players = player.GetHumans()

    logInfo("Trying to deafen all players")


    for _, ply in ipairs(players) do
        setDeafenState(ply, true)
    end

    postDeafenRequest(players)

    if duration ~= nil and duration > 0 then
        timer.Simple(undeafenAll())
    end
end

function undeafenAll(duration)
    local players = player.GetHumans()

    logInfo("Trying to undeafen all players")

    for _, ply in ipairs(players) do
        setDeafenState(ply, false)
    end

    postDeafenRequest(players)

    if duration ~= nil and duration > 0 then
        timer.Simple(deafenAll())
    end
end