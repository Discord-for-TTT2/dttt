local PlayerStateManager = {
    muted = {},
    deafened = {}
}

local function isPlayerValid(ply)
    return IsValid(ply) and ply:IsBot() == false
end

local function convertDuration(duration)
    duration = duration or 0
end

local function checkDuration(duration)
    return duration ~= nil and duration > 0
end

-- Init

function PlayerStateManager.initPlayer(ply)
    if not isPlayerValid(ply) then return end

    logInfo("Initializing player states for " .. ply:Nick())

    if not PlayerStateManager.containsMuted(ply) then
        PlayerStateManager.muted[getSteamId(ply)] = false
    end

    if not PlayerStateManager.containsDeafened(ply) then
        PlayerStateManager.deafened[getSteamId(ply)] = false
    end
end

function PlayerStateManager.deinitPlayer(ply)
    if not isPlayerValid(ply) then return end

    logInfo("Deinitializing player states for " .. ply:Nick())

    PlayerStateManager.muted[getSteamId(ply)] = nil
    PlayerStateManager.deafened[getSteamId(ply)] = nil
end

-- General

function PlayerStateManager.mute(ply, duration)
    if not isPlayerValid(ply) or PlayerStateManager.containsMuted(ply) == false then return end

    logInfo("Trying to mute player " .. ply:Nick())

    PlayerStateManager.setMutedState(ply, true)
    g_discord_requests.mute(ply)

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.unmute(ply) end)
    end
end

function PlayerStateManager.unmute(ply, duration)
    if not isPlayerValid(ply) or not PlayerStateManager.containsMuted(ply) then return end

    PlayerStateManager.setMutedState(ply, false)
    g_discord_requests.mute(ply)

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.mute(ply) end)
    end
end

function PlayerStateManager.muteAll(duration)
    PlayerStateManager.setAllMuted(true)

    g_discord_requests.mute(player.GetHumans())

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.unmuteAll(ply) end)
    end
end

function PlayerStateManager.unmuteAll(duration)
    PlayerStateManager.setAllMuted(false)

    g_discord_requests.mute(player.GetHumans())

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.muteAll(ply) end)
    end
end

---
---
---

function PlayerStateManager.deafen(ply, duration)
    if not isPlayerValid(ply) and not PlayerStateManager.containsDeafened(ply) then return end

    PlayerStateManager.setDeafenedState(ply, true)

    -- Send request

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.undeafen(ply) end)
    end
end

function PlayerStateManager.undeafen(ply, duration)
    if not isPlayerValid(ply) and not PlayerStateManager.containsDeafened(ply) then return end

    PlayerStateManager.setDeafenedState(ply, false)
    -- Send request

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.deafen(ply) end)
    end
end

function PlayerStateManager.deafenAll(duration)
    PlayerStateManager.setAllDeafened(true)

    -- Send request

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.undeafenAll(ply) end)
    end
end

function PlayerStateManager.undeafenAll(duration)
    PlayerStateManager.setAllDeafened(false)

    -- Send request

    duration = convertDuration(duration)
    if checkDuration(duration) then
        timer.Simple(duration, function() PlayerStateManager.deafenAll(ply) end)
    end
end


-- Getter

function PlayerStateManager.getMuted(ply)
    return PlayerStateManager.muted[getSteamId(ply)]
end

function PlayerStateManager.getAllMuted()
    return PlayerStateManager.muted
end

function PlayerStateManager.getDeafened(ply)
    return PlayerStateManager.deafened[getSteamId(ply)]
end

function PlayerStateManager.getAllDeafened()
    return PlayerStateManager.deafened
end

-- Setter --

-- Mute
function PlayerStateManager.setMutedState(ply, state)
    PlayerStateManager.muted[getSteamId(ply)] = state
end

function PlayerStateManager.setAllMuted(state)
    for _, ply in ipairs(player.GetHumans()) do
        if PlayerStateManager.containsMuted(ply) then
            PlayerStateManager.muted[getSteamId(ply)] = state
        end
    end
end

-- Deafen
function PlayerStateManager.setDeafenedState(ply, state)
    PlayerStateManager.deafened[getSteamId(ply)] = state
end

function PlayerStateManager.setAllDeafened(state)
    for _, ply in ipairs(player.GetHumans()) do
        if PlayerStateManager.containsDeafened(ply) then
            PlayerStateManager.deafened[getSteamId(ply)] = state
        end
    end
end

-- Checks --

function PlayerStateManager.containsMuted(ply)
    return PlayerStateManager.muted[getSteamId(ply)] ~= nil
end

function PlayerStateManager.containsDeafened(ply)
    return PlayerStateManager.deafened[getSteamId(ply)] ~= nil
end

return PlayerStateManager