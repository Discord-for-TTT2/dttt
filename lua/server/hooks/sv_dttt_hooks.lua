include("shared/sh_globals.lua")
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