print("DISCORD STARTING")

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
RegisterConVar("dttt_dbg_enabled", "0", {FCVAR_ARCHIVE})
RegisterConVar("dttt_dbg_timestamp_enabled", "1", {FCVAR_ARCHIVE})
RegisterConVar("dttt_dbg_log_levels", "WARNING|ERROR", {FCVAR_ARCHIVE})

-- Muting
RegisterConVar("dttt_imute_logic_enabled", "1", {FCVAR_ARCHIVE})
RegisterConVar("dttt_imute_enabled", "1", {FCVAR_ARCHIVE})
RegisterConVar("dttt_iunmute_enabled", "1", {FCVAR_ARCHIVE})

-- Durations
RegisterConVar("dttt_mute_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
RegisterConVar("dttt_deafen_duration", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

-- Bot
RegisterConVar("dttt_bot_endpoint", "http://localhost:37405", {FCVAR_ARCHIVE})
RegisterConVar("dttt_bot_api_key", "", {FCVAR_ARCHIVE})

-- Discord
RegisterConVar("dttt_auto_map_ids", "1", {FCVAR_ARCHIVE})
RegisterConVar("dttt_cache_mapping", "1", {FCVAR_ARCHIVE})


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