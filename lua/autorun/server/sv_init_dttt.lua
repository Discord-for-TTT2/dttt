include("shared/sh_globals.lua")

print("DISCORD")

-- Create ConVars --

-- Debugging
CreateConVar(CON_VARS.DEBUG_ENABLED, "0", {FCVAR_ARCHIVE}, "Enables debug logging in the console")
CreateConVar(CON_VARS.DEBUG_LOG_TIMESTAMP_ENABLED, "1", {FCVAR_ARCHIVE}, "Prints the timestamp when logging")
CreateConVar(CON_VARS.DEBUG_LOG_LEVELS, "DEBUG|WARNING|ERROR", {FCVAR_ARCHIVE}, "The log levels that will be logged in the console")

-- Discord
CreateConVar(CON_VARS.BOT_ENDPOINT, "http://localhost:43507", {FCVAR_ARCHIVE}, "The Endpoint of the Discord Bot")
CreateConVar(CON_VARS.BOT_API_KEY, "", {FCVAR_ARCHIVE}, "The Api Key of the Discord Bot")
CreateConVar(CON_VARS.AUTO_MAP_ID, "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Enabled auto assignment of Discord IDs")

-- Base Logic
CreateConVar(CON_VARS.ENABLE_INTERNAL_MUTE_LOGIC, "1", {FCVAR_ARCHIVE}, "Enables the complete mute logic")

-- Muting
CreateConVar(CON_VARS.MUTE_DURATION, "5", {FCVAR_ARCHIVE}, "The duration a player will be muted")
CreateConVar(CON_VARS.ENABLE_INTERNAL_MUTE, "1", {FCVAR_ARCHIVE}, "Enables muting")
CreateConVar(CON_VARS.ENABLE_INTERNAL_UNMUTE, "1", {FCVAR_ARCHIVE}, "Enables unmuting")

-- Channel

for _, value in pairs(NETWORK.SERVER_SIDE) do
    util.AddNetworkString(value)
end

_G.dttt_id_mapping = {}
_G.dttt_muted_players = {}

include("server/hooks/sv_ttt_hooks.lua")
include("server/commands/sv_dttt_commands.lua")

include("server/discord/sv_discord_id_cache.lua")
loadIdCache()

include("shared/sh_logger.lua")
logInfo("Server Loaded")