--- MUTE ---
hook.Add("DTTTPreMute", "dttt_pre_mute", function(ply, duration)
    hook.Run("DTTTMute", ply, duration)
end)

hook.Add("DTTTMute", "dttt_mute", function(ply, duration)
    duration = duration or 0
    mutePlayer(ply, duration)

    local mute_state = hook.Run("DTTTGetMute", ply)
    hook.Run("DTTTPostMute", ply, duration, mute_state)
end)

hook.Add("DTTTPostMute", "dttt_post_mute", function(ply, duration, mute_state)
end)

--- UNMUTE ---

hook.Add("DTTTPreUnmute", "dttt_pre_unmute", function(ply, duration)
    --hook.Run("DTTTUnmute", ply, duration)
    logInfo("SERVER PRE UNMUTE")
    return true
end)

hook.Add("DTTTUnmute", "dttt_unmute", function(ply, duration)
    duration = duration or 0
    unmutePlayer(ply, duration)

    local mute_state = hook.Run("DTTTGetMute", ply)
    hook.Run("DTTTPostUnmute", ply, duration, mute_state)
end)

hook.Add("DTTTPostUnmute", "dttt_post_unmute", function(ply, duration, mute_state)
end)

--- MUTE ALL ---

hook.Add("DTTTPreMuteAll", "dttt_pre_mute_all", function(duration)
    hook.Run("DTTTMuteAll", duration)
end)

hook.Add("DTTTMuteAll", "dttt_mute_all", function(duration)
    duration = duration or 0
    muteAll(duration)

    hook.Run("DTTTPostMuteAll")
end)

hook.Add("DTTTPostMuteAll", "dttt_post_mute_all", function()
end)

--- UNMUTE ALL ---

hook.Add("DTTTPreUnmuteAll", "dttt_pre_unmute_all", function(duration)
    return true
end)

hook.Add("DTTTUnmuteAll", "dttt_unmute_all", function(duration)
    duration = duration or 0
    unmuteAll(duration)

    hook.Run("DTTTPostUnmuteAll")
end)

hook.Add("DTTTPostUnmuteAll", "dttt_post_unmute_all", function()
end)

--- DEAFEN ---

hook.Add("DTTTPreDeafend", "dttt_pre_deafen", function(ply, duration)
    hook.Run("DTTTDeafen", ply, duration)
end)

hook.Add("DTTTDeafen", "dttt_deafen", function(ply, duration)
    duration = duration or 0
    deafenPlayer(ply, duration)

    local deafen_state = hook.Run("DTTTGetDeafened")
    hook.Run("DTTTPostDeafen", ply, duration, deafen_state)
end)

hook.Add("DTTTPostDeafen", "dttt_post_deafen", function(ply, duration, deafen_state)
end)

--- UNDEAFEN ---

hook.Add("DTTTPreUndeafen", "dttt_pre_undeafen", function(ply, duration)
    hook.Run("DTTTUndeafen", ply, duration)
end)

hook.Add("DTTTUndeafen", "dttt_undeafen", function(ply, duration)
    duration = duration or 0
    undeafenPlayer(ply, duration)

    local deafen_state = hook.Run("DTTTGetDeafened")
    hook.Run("DTTTPostUndeafen", ply, duration, deafen_state)
end)

hook.Add("DTTTPostUndeafen", "dttt_post_undeafen", function(ply, duration, deafen_state)
end)

--- DEAFEN ALL ---

hook.Add("DTTTPreDeafenAll", "dttt_pre_deafen_all", function(duration)
    hook.Run("DTTTDeafenAll", duration)
end)

hook.Add("DTTTDeafenAll", "dttt_deafen_all", function(duration)
    duration = duration or 0
    deafenAll(duration)

    hook.Run("DTTTPostDeafenAll")
end)

hook.Add("DTTTPostDeafenAll", "dttt_post_deafen_all", function(duration)
end)

--- UNDEAFEN ALL ---

hook.Add("DTTTPreUndeafenAll", "dttt_pre_undeafen_all", function(duration)
    hook.Run("DTTTUndeafenAll", duration)
end)

hook.Add("DTTTUndeafenAll", "dttt_undeafen_all", function(duration)
-- undeafen all
    duration = duration or 0
    undeafenAll(duration)

    hook.Run("DTTTPostUndeafenAll")
end)

hook.Add("DTTTPostUndeafenAll", "dttt_post_undeafen_all", function(duration)
end)

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