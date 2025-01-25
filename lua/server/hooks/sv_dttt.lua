function GM:DTTTPreMuteLogic() end

--- MUTE ---
function GM:DTTTPreMute(ply, duration)
    local run_logic = hook.Run("DTTTPreMuteLogic")

    if run_logic == true then
        return
    end

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
    local run_logic = hook.Run("DTTTPreMuteLogic")

    if run_logic == true then
        return
    end

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
    local run_logic = hook.Run("DTTTPreMuteLogic")

    if run_logic == true then
        return
    end

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
    local run_logic = hook.Run("DTTTPreMuteLogic")

    if run_logic == true then
        return
    end

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

function GM:DTTTGetAllMuted()
    return g_dttt_player_states.muted
end

function GM:DTTTGetAllDeafened()
    return g_dttt_player_states.deafened
end

function GM:DTTTGetDiscordIDs()
    return g_dttt_discord_mapping
end

function GM:DTTTGetMute(ply)
    return getMuteState(ply)
end

function GM:DTTTGetDeafened(ply)
    return getDeafenState(ply)
end

function GM:DTTTGetDiscordID(ply)
    return getMappedId(ply)
end

--- LOGGING ---