include("shared/sh_globals.lua")
include("server/utils/sv_general.lua")
include("server/utils/sv_muter.lua")

-- Runs muting logic

hook.Add(HOOKS.MUTE_PLAYER, "DiscordMutePlayer", function(ply)
    mutePlayer(ply)
end)

hook.Add(HOOKS.UNMUTE_PLAYER, "DiscordUnmutePlayer", function(ply)
    unmutePlayer(ply)
end)

hook.Add(HOOKS.MUTE_ALL_PLAYERS, "DiscordMuteAllPlayers", function()
    muteAllPlayers()
end)

hook.Add(HOOKS.UNMUTE_ALL_PLAYERS, "DiscordUnmuteAllPlayers", function()
    unmuteAllPlayers()
end)

hook.Add(HOOKS.GET_DISCORD_IDS, "DTTTGetDiscordIDs", function()
    return _G.dttt_id_mapping
end)

hook.Add(HOOKS.GET_MUTED_PLAYERS, "DTTTGetMutedPlayers", function()
    return _G.dttt_muted_players
end)

hook.Add(HOOKS.GET_DISCORD_ID, "DTTTGetDiscordID", function(ply)
    local discord_id = _G.dttt_muted_players[playerIdToString(ply)]
    return discord_id
end)

hook.Add(HOOKS.GET_MUTE_STATUS, "DTTTGetMuteStatus", function(ply)
    return getMuteStatus(ply)
end)

hook.Add(HOOKS.SET_INTERNAL_MUTE_LOGIC, "DTTTSetInternalMuteLogic", function(enabled)
    setInternalMuteLogicEnabled(enabled)
end)