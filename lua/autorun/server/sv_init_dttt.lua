--- Create Globals ---

g_dttt_player_states = {
    muted = {},
    deafened = {}
}

g_dttt_discord_mapping = {}

g_convars = {}

--- Create Con Vars ---

local function RegisterConVar(name, value, flags, description)
    local convar = CreateConVar(name, value, flags, description)
    table.insert(g_convars, convar)
    return convar
end

-- Debug
RegisterConVar("dttt_dbg_enabled", "0", {FCVAR_ARCHIVE}, "Enabled DTTT Logging to the Console")
RegisterConVar("dttt_dbg_timestamp_enabled", "1", {FCVAR_ARCHIVE}, "If enabled adds a timestamp to log messages")
RegisterConVar("dttt_dbg_log_levels", "WARNING|ERROR", {FCVAR_ARCHIVE}, "Sets the log message levels. Available: INFO,DEBUG,WARNING,ERROR")

-- Muting
RegisterConVar("dttt_imute_logic_enabled", "1", {FCVAR_ARCHIVE}, "If disabled the internal all mute logic needs to be handled manually (Muting/Unmuting)")
RegisterConVar("dttt_imute_enabled", "1", {FCVAR_ARCHIVE}, "If disabled internal muting does not work and needs to be handled manually")
RegisterConVar("dttt_iunmute_enabled", "1", {FCVAR_ARCHIVE}, "If disabled internal unmuting does not work and needs to be handled manually")

-- Durations
RegisterConVar("dttt_mute_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The duration a player is muted. Use 0 to mute for the entire round")
RegisterConVar("dttt_deafen_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The duration a player is deafened. Use 0 to deafen for the entire round")

-- Bot
RegisterConVar("dttt_bot_endpoint", "http://localhost:37405", {FCVAR_ARCHIVE}, "The endpoint of the bot")
RegisterConVar("dttt_bot_api_key", "", {FCVAR_ARCHIVE}, "The api key for the bot, will be sent in the Authorization Header")

-- Discord
RegisterConVar("dttt_auto_map_ids", "1", {FCVAR_ARCHIVE}, "If disabled dttt wont try to automatically get the discord ids for players")
RegisterConVar("dttt_cache_mapping", "1", {FCVAR_ARCHIVE}, "If disabled dttt wont cache the discord ids, this means the ids need to get added again after a restart")


--- Include needed files ---

-- Load All Helpers


hook.Add("Initialize", "DTTTInitialize", function()
    -- Load TTT Hooks
    include("sh_logger.lua")
    include("server/utils/sv_helper.lua")
    include("server/player_state.lua")
    include("server/id_mapping.lua")
    include("server/hooks/sv_ttt.lua")
end)

-- Load Commands
include("server/dttt_commands.lua")

logInfo("DTTT Started")