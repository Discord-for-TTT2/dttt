g_convars = {}

local function RegisterConVar(name, value, flags, description)
    local convar = CreateConVar(name, value, flags, description)
    table.insert(g_convars, convar)
    return convar
end

-- Debug
RegisterConVar("dttt_dbg_enabled", "0", {FCVAR_ARCHIVE}, "Enabled DTTT Logging to the Console")
RegisterConVar("dttt_dbg_timestamp_enabled", "1", {FCVAR_ARCHIVE}, "If enabled adds a timestamp to log messages")
RegisterConVar("dttt_dbg_log_levels", "WARNING|ERROR", {FCVAR_ARCHIVE}, "Sets the log message levels. Available: INFO,DEBUG,WARNING,ERROR")

RegisterConVar("dttt_enabled", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE}, "Enabled or disables DTTT")

-- Muting
RegisterConVar("dttt_mute_enabled", "1", {FCVAR_ARCHIVE}, "If disabled muting will be disabled completely")
RegisterConVar("dttt_unmute_enabled", "1", {FCVAR_ARCHIVE}, "If disabled unmuting will be disabled completely")
RegisterConVar("dttt_mute_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The duration a player is muted. Use 0 to mute for the entire round")

-- Deafen
RegisterConVar("dttt_deafen_enabled", "1", {FCVAR_ARCHIVE}, "If disabled deafening will be disabled completely")
RegisterConVar("dttt_undeafen_enabled", "1", {FCVAR_ARCHIVE}, "If disabled undeafening will be disabled completely")

-- Bot
RegisterConVar("dttt_bot_endpoint", "http://localhost:37405", {FCVAR_ARCHIVE}, "The endpoint of the bot")
RegisterConVar("dttt_bot_api_key", "", {FCVAR_ARCHIVE}, "The api key for the bot, will be sent in the Authorization Header")

-- Discord
RegisterConVar("dttt_auto_map_ids", "1", {FCVAR_ARCHIVE}, "If disabled dttt wont try to automatically get the discord ids for players")
RegisterConVar("dttt_cache_mapping", "1", {FCVAR_ARCHIVE}, "If disabled dttt wont cache the discord ids, this means the ids need to get added again after a restart")



include("terrortown/dttt_sv/sv_logger.lua")
include("terrortown/dttt_sv/sv_helper.lua")

g_player_state_manager = include("terrortown/dttt_sv/sv_player_state.lua")
g_discord_mapper = include("terrortown/dttt_sv/sv_discord_mapper.lua")
g_discord_requests = include("terrortown/dttt_sv/sv_requests.lua")

include("terrortown/dttt_sv/sv_hooks.lua")
include("terrortown/dttt_sv/sv_commands.lua")
include("terrortown/dttt_sv/sv_net.lua")