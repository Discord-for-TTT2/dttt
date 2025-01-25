--- MUTE ---
function GM:DTTTPreMute(ply, duration)
    hook.Run("DTTTMute", ply, duration)
end

function GM:DTTTMute(ply, duration)
    duration = duration or 0
    mutePlayer(ply, duration)

    local mute_state = hook.Run("DTTTGetMute", ply)
    hook.Run("DTTTPostMute", ply, duration, mute_state)
end

function GM:DTTTPostMute(ply, duration, mute_state) end

--- UNMUTE ---

function GM:DTTTPreUnmute(ply, duration)
    hook.Run("DTTTUnmute", ply, duration)
end

function GM:DTTTUnmute(ply, duration)
    duration = duration or 0
    unmutePlayer(ply, duration)

    local mute_state = hook.Run("DTTTGetMute", ply)
    hook.Run("DTTTPostUnmute", ply, duration, mute_state)
end

function GM:DTTTPostUnmute(ply, duration, mute_state) end

--- MUTE ALL ---

function GM:DTTTPreMuteAll(duration)
    hook.Run("DTTTMuteAll", duration)
end

function GM:DTTTMuteAll(duration)
    duration = duration or 0
    muteAll(duration)

    hook.Run("DTTTPostMuteAll")
end

function GM:DTTTPostMuteAll() end

--- UNMUTE ALL ---

function GM:DTTTPreUnmuteAll(duration)
    hook.Run("DTTTUnmuteAll", duration)
end

function GM:DTTTUnmuteAll(duration)
    duration = duration or 0
    unmuteAll(duration)

    hook.Run("DTTTPostUnmuteAll")
end

function GM:DTTTPostUnmuteAll(duration) end

--- DEAFEN ---

function GM:DTTTPreDeafen(ply, duration)
    hook.Run("DTTTDeafen", ply, duration)
end

function GM:DTTTDeafen(ply, duration)
    duration = duration or 0
    deafenPlayer(ply, duration)

    local deafen_state = hook.Run("DTTTGetDeafened")
    hook.Run("DTTTPostDeafen", ply, duration, deafen_state)
end

function GM:DTTTPostDeafen(ply, duration, deafen_state) end

--- UNDEAFEN ---

function GM:DTTTPreUndeafen(ply, duration)
    hook.Run("DTTTUndeafen", ply, duration)
end

function GM:DTTTUndeafen(ply, duration)
    duration = duration or 0
    undeafenPlayer(ply, duration)

    local deafen_state = hook.Run("DTTTGetDeafened")
    hook.Run("DTTTPostUndeafen", ply, duration, deafen_state)
end

function GM:DTTTPostUndeafen(ply, duration, deafen_state) end

--- DEAFEN ALL ---

function GM:DTTTPreDeafenAll(duration)
    hook.Run("DTTTDeafenAll", duration)
end

function GM:DTTTDeafenAll(duration)
    duration = duration or 0
    deafenAll(duration)

    hook.Run("DTTTPostDeafenAll")
end

function GM:DTTTPostDeafenAll(duration) end

--- UNDEAFEN ALL ---

function GM:DTTTPreUndeafenAll(duration)
    hook.Run("DTTTUndeafenAll", duration)
end

function GM:DTTTUndeafenAll(duration)
    duration = duration or 0
    undeafenAll(duration)

    hook.Run("DTTTPostUndeafenAll")
end

function GM:DTTTPostUndeafenAll(duration) end

--[[
hook.Add("DTTTMoveToChannel", "dttt_move_to_channel", function(ply)
-- move player to channel
end)
]]

--[[
hook.Add("DTTTMoveAll", "dttt_move_all", function()
-- move all players to channel
end)
]]

hook.Add("DTTTGetAllMuted", "dttt_get_muted", function()
-- return muted players
    return g_dttt_player_states.muted
end)

hook.Add("DTTTGetAllDeafened", "dttt_get_deafened", function()
-- return deafened player
    return g_dttt_player_states.deafened
end)

hook.Add("DTTTGetDiscordIDs", "dttt_get_discord_ids", function()
-- get all discord id mappings
    return g_dttt_discord_mapping
end)

hook.Add("DTTTGetMute", "dttt_get_mute_state", function(ply)
-- get mute state of player
    return getMuteState(ply)
end)

hook.Add("DTTTGetDeafened", "dttt_get_deafened_state", function(ply)
-- get deafen state of player
    return getDeafenState(ply)
end)

hook.Add("DTTTGetDiscordID", "dttt_get_discord_id", function(ply)
-- get discord id mapping of player
    return getMappedId(ply)
end)

PrintTable(hook.GetTable())


--- LOGGING ---