--- Create Globals ---
g_dttt_player_states = {
    muted = {},
    deafened = {}
}

g_dttt_discord_mapping = {}

--- Create Con Vars ---

-- Debug
CreateConVar("dttt_dbg_enabled", "0")
CreateConVar("dttt_dbg_timestamp_enabled", "1")
CreateConVar("dttt_dbg_log_levels", "WARNING|ERROR")

-- Muting
CreateConVar("dttt_imute_logic_enabled", "1")
CreateConVar("dttt_imute_enabled", "1")
CreateConVar("dttt_iunmute_enabled", "1")

-- Durations
CreateConVar("dttt_mute_duration", "5")
CreateConVar("dttt_deafen_duration", "5")

-- Bot
CreateConVar("dttt_bot_endpoint", "http://localhost:43507")
CreateConVar("dttt_bot_api_key", "")

-- Discord
CreateConVar("dttt_auto_map_ids", "1")
CreateConVar("dttt_cache_mapping", "1")

--- Include needed files ---

-- Load TTT Hooks
include("server/hooks/sv_ttt.lua")

include("server/discord/sv_discord_caching.lua")
loadIdCache()