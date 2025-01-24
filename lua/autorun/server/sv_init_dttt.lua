print("DISCORD STARTING")

--- Create Globals ---

g_dttt_player_states = {
    muted = {},
    deafened = {}
}

g_dttt_discord_mapping = {}


--- Create Con Vars ---

-- Debug
CreateConVar("dttt_dbg_enabled", "0", {FCVAR_ARCHIVE})
CreateConVar("dttt_dbg_timestamp_enabled", "1", {FCVAR_ARCHIVE})
CreateConVar("dttt_dbg_log_levels", "WARNING|ERROR", {FCVAR_ARCHIVE})

-- Muting
CreateConVar("dttt_imute_logic_enabled", "1", {FCVAR_ARCHIVE})
CreateConVar("dttt_imute_enabled", "1", {FCVAR_ARCHIVE})
CreateConVar("dttt_iunmute_enabled", "1", {FCVAR_ARCHIVE})

-- Durations
CreateConVar("dttt_mute_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("dttt_deafen_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

-- Bot
CreateConVar("dttt_bot_endpoint", "http://localhost:43507", {FCVAR_ARCHIVE})
CreateConVar("dttt_bot_api_key", "", {FCVAR_ARCHIVE})

-- Discord
CreateConVar("dttt_auto_map_ids", "1", {FCVAR_ARCHIVE})
CreateConVar("dttt_cache_mapping", "1", {FCVAR_ARCHIVE})


--- Include needed files ---

-- Load All Helpers
include("sh_logger.lua")
include("server/utils/sv_helper.lua")
include("server/player_state.lua")
include("server/id_mapping.lua")

-- Load TTT Hooks
include("server/hooks/sv_ttt.lua")

-- Load Commands
include("server/dttt_commands.lua")

logInfo("DTTT Started")