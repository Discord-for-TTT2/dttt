hook.Add("DTTTMute", "dttt_mute", function(ply, duration)
-- mute player
    duration = duration or 0
    mutePlayer(ply, duration)
end)

hook.Add("DTTTUnmute", "dttt_unmute", function(ply, duration)
-- unmute player
    duration = duration or 0
    unmutePlayer(ply, duration)
end)

hook.Add("DTTTMuteAll", "dttt_mute_all", function(state, duration)
    -- mute all
    duration = duration or 0
    muteAll(duration)
end)

hook.Add("DTTTUnmuteAll", "dttt_unmute_all", function(duration)
-- unmute all
    duration = duration or 0
    unmuteAll(duration)
end)

hook.Add("DTTTDeafen", "dttt_deafen", function(ply, duration)
-- deafen player
    duration = duration or 0
    deafenPlayer(ply, duration)
end)

hook.Add("DTTTUndeafen", "dttt_undeafen", function(ply, duration)
-- undeafen player
    duration = duration or 0
    undeafenPlayer(ply, duration)
end)

hook.Add("DTTTDeafenAll", "dttt_deafen_all", function(duration)
-- deafen all
    duration = duration or 0
    deafenAll(duration)
end)

hook.Add("DTTTUndeafenAll", "dttt_undeafen_all", function(duration)
-- undeafen all
    duration = duration or 0
    undeafenAll(duration)
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

hook.Add("DTTTGetMuted", "dttt_get_muted", function()
-- return muted players
end)

hook.Add("DTTTGetDeafened", "dttt_get_deafened", function()
-- return deafened player
end)

hook.Add("DTTTGetDiscordIDs", "dttt_get_discord_ids", function()
-- get all discord id mappings
end)

hook.Add("DTTTGetMuteState", "dttt_get_mute_state", function(ply)
-- get mute state of player
end)

hook.Add("DTTTGetDeafenedState", "dttt_get_deafened_state", function(ply)
-- get deafen state of player
end)

hook.Add("DTTTGetDiscordID", "dttt_get_discord_id", function(ply)
-- get discord id mapping of player
end)

hook.Add("DTTTPlayerMuted", "dttt_player_muted", function()
-- run when player got muted
end)

hook.Add("DTTTPlayerDefened", "dttt_player_defened", function()
-- run when player got deafened
end)

hook.Add("DTTTPlayerMoved", "dttt_player_moved", function()
-- run when player got moved
end)