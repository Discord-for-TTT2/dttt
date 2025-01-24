include("server/hooks/sv_dttt.lua")
include("server/utils/sv_helper.lua")

-- todo: add checks

-- Unmute all
hook.Add("TTT2PrePrepareRound", "DTTTPrePrepareRound", function(duration)
    if isInternalMuteLogicEnabled() and isInternalUnmuteEnabled() then
        hook.Run("DTTTUnmuteAll")
    end
end)

-- Unmute all
hook.Add("TTT2PreEndRound", "DTTTPreBeginRonud", function(result, duration)
    if isInternalMuteLogicEnabled() and isInternalUnmuteEnabled() then
        hook.Run("DTTTUnmuteAll")
    end
end)

-- Mute Player
hook.Add("TTT2PostPlayerDeath", "DTTTPostPlayerDeath", function(victim, inflictor, attacker)
    if isInternalMuteLogicEnabled() and isInternalMuteEnabled() then
        hook.Run("DTTTMute", GetConVar("dttt_mute_duration"):GetInt())
    end
end)

-- Unmute Player
hook.Add("PlayerSpawn", "DTTTPlayerSpawn", function(ply, transition)
    if isInternalMuteLogicEnabled() and isInternalUnmuteEnabled() then
        hook.Run("DTTTUnmute", ply)
    end
end)


-- Map Discord ID
hook.Add("PlayerInitialSpawn", "DTTTPlayerInitialSpawn", function(ply ,transition)
    -- automap id
end)

-- Try unmute player
hook.Add("PlayerDisconnected", "DTTTPlayerDisconnected", function(ply)
    timer.Simple(0.2, function() hook.Run(HOOKS.UNMUTE_PLAYER, ply) end)
end)