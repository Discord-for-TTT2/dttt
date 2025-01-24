include("shared/sh_globals.lua")
include("shared/sh_logger.lua")
include("server/utils/sv_general.lua")
include("server/discord/sv_discord_requests.lua")

-- Mute Helper --

function setMuteStatus(ply, mute_status)
    _G.dttt_muted_players[playerIdToString(ply)] = mute_status
    hook.Run(HOOKS.PLAYER_MUTED, ply, mute_status)
end

function getMuteStatus(ply)
    return _G.dttt_muted_players[playeridToString(ply)] or false
end

-- Muting --

function unmutePlayer(ply)
    if ply:IsBot() then return end

    setMuteStatus(ply, false)
    mutePlayerRequest(ply, false)
end

function mutePlayer(ply)
    if ply:IsBot() and isRoundRunning() then return end

    setMuteStatus(ply, true)
    mutePlayerRequest(ply, true)

    if getMuteDuration() > 0 then
        timer.Simple(getMuteDuration(), function() unmutePlayer(ply) end)
    end
end

function muteAllPlayers()
    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        mutePlayer(ply)
    end
end

function unmuteAllPlayers()
    local players = player.GetHumans()

    for _, ply in ipairs(players) do
        unmutePlayer(ply)
    end
end
