include("shared/sh_globals.lua")
include("server/hooks/sv_dttt_hooks.lua")
include("server/utils/sv_general.lua")
include("server/discord/sv_discord_id_mapping.lua")

-- Entry point for internal muting
-- Outsources to sv_addon_hooks

hook.Add("TTT2PrePrepareRound", "DTTTPrePrepareRound", function(duration)
    if muteLogicEnabled() and unmutingEnabled() then
        hook.Run(HOOKS.UNMUTE_ALL_PLAYERS)
    end
end)

hook.Add("TTT2PreEndRound", "DTTTPreBeginRonud", function(result, duration)
    if muteLogicEnabled() and unmutingEnabled() then
        hook.Run(HOOKS.UNMUTE_ALL_PLAYERS)
    end
end)

hook.Add("TTT2PostPlayerDeath", "DTTTPostPlayerDeath", function(victim, inflictor, attacker)
    local round_won = hook.Run("TTTCheckForWin")

    if tostring(round_won) ~= "1" then
        return
    end

    if muteLogicEnabled() and mutingEnabled() then
        hook.Run(HOOKS.MUTE_PLAYER, victim)
    end
end)

hook.Add("PlayerSpawn", "DTTTPlayerSpawn", function(ply, transition)
    if muteLogicEnabled() and unmutingEnabled() then
        hook.Run(HOOKS.UNMUTE_PLAYER, ply)
    end
end)

hook.Add("PlayerInitialSpawn", "DTTTPlayerInitialSpawn", function(ply ,transition)
    if shouldAutoMapId() then
        autoMapId(ply)
    end

    if muteLogicEnabled() and unmutingEnabled() then
        hook.Run(HOOKS.UNMUTE_PLAYER, ply)
    end
end)

hook.Add("PlayerDisconnected", "DTTTPlayerDisconnected", function(ply)
    timer.Simple(1, function() hook.Run(HOOKS.UNMUTE_PLAYER, ply) end)
end)