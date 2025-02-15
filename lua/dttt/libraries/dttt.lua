dttt = dttt or {}

dttt.enabled = dttt.enabled or true
dttt.mute_enabled = dttt.mute_enabled or true
dttt.unmute_enabled = dttt.unmute_enabled or true
dttt.deafen_enabled = dttt.deafen_enabled or true
dttt.undeafen_enabled = dttt.undeafen_enabled or true

dttt.mute_duration = dttt.mute_duration or 5

local function ConvertDuration(duration)
    duration = duration or 0
    return
end

local function CheckDuration(duration)
    return duration ~= nil and duration > 0
end

function dttt.MuteEnabled()
    return dttt.enabled and dttt.mute_enabled
end

function dttt.UnmuteEnabled()
    return dttt.enabled and dttt.unmute_enabled
end

function dttt.DeafenEnabled()
    return dttt.enabled and dttt.deafen_enabled
end

function dttt.UndeafenEnabled()
    return dttt.enabled and dttt.undeafen_enabled
end

-- Setter
function dttt.SetEnabled(enabled)
    dttt.enabled = enabled
end

function dttt.SetMuteEnabled(enabled)
    dttt.mute_enabled = enabled
end

function dttt.SetUnmuteEnabled(enabled)
    dttt.unmute_enabled = enabled
end

function dttt.SetDeafenEnabled(enabled)
    dttt.deafen_enabled = enabled
end

function dttt.SetUndeafenEnabled(enabled)
    dttt.undeafen_enabled = enabled
end

function dttt.SetMuteDuration(duration)
    dttt.mute_duration = duration
end

-- Logic
function dttt.Mute(ply, duration)
    if not dttt.MuteEnabled() then return end

    local state_different = ply:SetMuted(true)
    if not state_different then return end

    discord.Mute(ply)
    duration = ConvertDuration(duration)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Unmute(ply) end)
    end
end

function dttt.Unmute(ply, duration)
    if not dttt.UnmuteEnabled() then return end

    local state_different = ply:SetMuted(false)
    if not state_different then return end

    discord.Mute(ply)
    duration = ConvertDuration(duration)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Mute(ply) end)
    end
end

function dttt.MuteAll(duration)
    if not dttt.MuteEnabled() then return end

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetMuted(true)

        -- TODO: ADD/REMOVE STATUS
    end
    discord.Mute(players)

    duration = ConvertDuration(duration)
    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.UnmuteAll() end)
    end
end

function dttt.UnmuteAll(duration)
    if not dttt.UnmuteEnabled() then return end

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetMuted(false)

        -- TODO: ADD/REMOVE STATUS
    end
    discord.Mute(players)

    duration = ConvertDuration(duration)
    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.MuteAll() end)
    end
end

function dttt.Deafen(ply, duration)
    if not dttt.DeafenEnabled() then return end

    local state_different = ply:SetDeafened(true)
    if not state_different then return end

    discord.deafen(ply)
    duration = ConvertDuration(duration)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Undeafen(ply) end)
    end
end

function dttt.Undeafen(ply, duration)
    if not dttt.UndeafenEnabled() then return end

    local state_different = ply:SetDeafened(false)
    if not state_different then return end

    discord.Deafen(ply)
    duration = ConvertDuration(duration)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Deafen(ply) end)
    end
end

function dttt.DeafenAll(duration)
    if not dttt.DeafenEnabled() then return end

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetDeafened(true)

        -- TODO: ADD/REMOVE STATUS
    end
    discord.Deafen(players)

    duration = ConvertDuration(duration)
    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.UndeafenAll() end)
    end
end

function dttt.UndeafenAll(duration)
    if not dttt.UndeafenEnabled() then return end

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetDeafened(false)

        -- TODO: ADD/REMOVE STATUS
    end
    discord.Deafen(players)

    duration = ConvertDuration(duration)
    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.DeafenAll() end)
    end
end

-- TODO
function dttt.MovePlayer()
end