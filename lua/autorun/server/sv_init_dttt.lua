include("shared/sh_globals.lua")

-- Create ConVars --

-- Debugging
CreateConVar(CON_VARS.DEBUG_ENABLED, "0", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.DEBUG_LOG_TIMESTAMP_ENABLED, "1", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.DEBUG_LOG_LEVELS, "DEBUG|WARNING|ERROR", {FCVAR_ARCHIVE}, "")

-- Discord
CreateConVar(CON_VARS.BOT_ENDPOINT, "http://localhost:43507", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.BOT_API_KEY, "", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.AUTO_MAP_ID, "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "")

-- Base Logic
CreateConVar(CON_VARS.ENABLE_MUTE_LOGIC, "1", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.ENABLE_CHANNEL_LOGIC, "1", {FCVAR_ARCHIVE}, "")

-- Muting
CreateConVar(CON_VARS.MUTE_DURATION, "5", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.ENABLE_MUTE, "1", {FCVAR_ARCHIVE}, "")
CreateConVar(CON_VARS.ENABLE_UNMUTE, "1", {FCVAR_ARCHIVE}, "")

-- Channel
CreateConVar(CON_VARS.CHANNEL_MOVE_DURATION, "5", {FCVAR_ARCHIVE}, "")

for _, value in pairs(NETWORK.SERVER_SIDE) do
    util.AddNetworkString(value)
end

_G.dttt_id_mapping = {}
_G.dttt_muted_players = {}

include("server/hooks/sv_ttt_hooks.lua")
include("server/commands/sv_dttt_commands.lua")

include("server/discord/sv_discord_id_cache.lua")
loadIdCache()