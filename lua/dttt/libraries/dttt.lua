dttt = dttt or {}

dttt.enabled = dttt.enabled or true
dttt.mute_enabled = dttt.mute_enabled or true
dttt.unmute_enabled = dttt.unmute_enabled or true
dttt.deafen_enabled = dttt.deafen_enabled or true
dttt.undeafen_enabled = dttt.undeafen_enabled or true

dttt.mute_duration = dttt.mute_duration or 5

local function ConvertDuration(duration, default)
    duration = duration or default
    return duration
end

local function CheckDuration(duration)
    return duration ~= nil and duration > 0
end

local function SetSidebarStatus(id, ply, should_apply)
    if should_apply then
        STATUS:AddStatus(ply, id)
    else
        STATUS:RemoveStatus(ply, id)
    end
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
    if not dttt.MuteEnabled() or ply:IsBot() then return end

    dttt_logger.Info("Muting player " .. ply:Nick())

    local state_different = ply:SetMuted(true)
    if not state_different then return end

    discord.Mute(ply)
    duration = ConvertDuration(duration, dttt.mute_duration)

    SetSidebarStatus("dttt_muted", ply, ply:GetMuted())
    events.Trigger(EVENT_MUTED, ply)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Unmute(ply, 0) end)
    end
end

function dttt.Unmute(ply, duration)
    if not dttt.UnmuteEnabled() or ply:IsBot() then return end

    dttt_logger.Info("Unmuting player " .. ply:Nick())

    local state_different = ply:SetMuted(false)
    if not state_different then return end

    discord.Mute(ply)
    duration = ConvertDuration(duration, dttt.mute_duration)

    SetSidebarStatus("dttt_muted", ply, ply:GetMuted())
    events.Trigger(EVENT_UNMUTED, ply)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Mute(ply, 0) end)
    end
end

function dttt.MuteAll(duration)
    if not dttt.MuteEnabled() then return end

    dttt_logger.Info("Muting all players")

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetMuted(true)
        SetSidebarStatus("dttt_muted", ply, ply:GetMuted())
    end

    discord.Mute(players)
    duration = ConvertDuration(duration, dttt.mute_duration)
    events.Trigger(EVENT_ALL_MUTED)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.UnmuteAll(0) end)
    end
end

function dttt.UnmuteAll(duration)
    if not dttt.UnmuteEnabled() then return end

    dttt_logger.Info("Unmuting all players")

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetMuted(false)
        SetSidebarStatus("dttt_muted", ply, ply:GetMuted())
    end

    discord.Mute(players)
    duration = ConvertDuration(duration, dttt.mute_duration)
    events.Trigger(EVENT_ALL_UNMUTED)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.MuteAll(0) end)
    end
end

function dttt.Deafen(ply, duration)
    if not dttt.DeafenEnabled() or ply:IsBot() then return end
    dttt_logger.Info("Deafen player " .. ply:Nick())

    local state_different = ply:SetDeafened(true)
    if not state_different then return end

    discord.deafen(ply)
    duration = ConvertDuration(duration, 0)

    SetSidebarStatus("dttt_deafened", ply, ply:GetDeafened())
    events.Trigger(EVENT_DEAFENED, ply)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Undeafen(ply, 0) end)
    end
end

function dttt.Undeafen(ply, duration)
    if not dttt.UndeafenEnabled() or ply:IsBot() then return end
    dttt_logger.Info("Undeafen player " .. ply:Nick())

    local state_different = ply:SetDeafened(false)
    if not state_different then return end

    discord.Deafen(ply)
    duration = ConvertDuration(duration, 0)
    events.Trigger(EVENT_UNDEAFENED, ply)

    SetSidebarStatus("dttt_deafened", ply, ply:GetDeafened())

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.Deafen(ply, 0) end)
    end
end

function dttt.DeafenAll(duration)
    if not dttt.DeafenEnabled() then return end
    dttt_logger.Info("Deafen all players")

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetDeafened(true)
        SetSidebarStatus("dttt_deafened", ply, ply:GetDeafened())
    end

    discord.Deafen(players)
    duration = ConvertDuration(duration, 0)
    events.Trigger(EVENT_ALL_DEAFENED)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.UndeafenAll(0) end)
    end
end

function dttt.UndeafenAll(duration)
    if not dttt.UndeafenEnabled() then return end
    dttt_logger.Info("Undeafen all players")

    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        ply:SetDeafened(false)
        SetSidebarStatus("dttt_deafened", ply, ply:GetDeafened())
    end

    discord.Deafen(players)
    duration = ConvertDuration(duration, 0)
    events.Trigger(EVENT_ALL_UNDEAFENED)

    if CheckDuration(duration) then
        timer.Simple(duration, function() dttt.DeafenAll(0) end)
    end
end

-- TODO
function dttt.MovePlayer()
end