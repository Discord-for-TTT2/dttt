CON_VARS = {
    -- DEBUGGING
    DEBUG_ENABLED = "dttt_debug_enabled",
    DEBUG_LOG_TIMESTAMP_ENABLED = "dttt_debug_timestamp_enabled",
    DEBUG_LOG_LEVELS = "dttt_debug_log_levels",

    -- DISCORD
    BOT_ENDPOINT = "dttt_bot_endpoint",
    BOT_API_KEY = "dttt_bot_api_key",
    AUTO_MAP_ID = "dttt_auto_map_id",

    -- BASE LOGIC
    ENABLE_MUTE_LOGIC = "dttt_enable_mute_logic", -- Enables all mute logic (Mute, Unmute)
    ENABLE_CHANNEL_LOGIC = "dttt_enable_channel_logic", -- Enables all channel logic (Channel Move)

    -- MUTING
    MUTE_DURATION = "dttt_mute_duration", -- Duration the user is muted
    ENABLE_MUTE = "dttt_enable_mute", -- Whether muting is allowed
    ENABLE_UNMUTE = "dttt_enable_unmute", -- Whether muting is not allowed

    -- Channel
    CHANNEL_MOVE_DURATION = "dttt_channel_move_duration",
}

-- Used to communicate with client/server
-- GET = Used to Get something from specified side
-- SET = Used to Set something on specified side
-- REC = Used to Receive something | Used on opposite side of GET
NETWORK = {
    -- Server Receiving
    SERVER_SIDE = {
        -- Setter - Doesnt answer with another request
        SET_DEBUG_ENABLED = "net_sv_di_set_debug_enabled",
        SET_DEBUG_TIMESTAMP_ENABLED = "net_sv_di_set_debug_timestamp_enabled",
        SET_DEBUG_LOG_LEVELS = "net_sv_di_set_debug_log_levels",

        SET_BOT_ENDPOINT = "net_sv_di_set_bot_endpoint",
        SET_BOT_API_KEY = "net_sv_di_set_bot_api_key",

        SET_MUTER_ENABLED = "net_sv_di_set_muter_enabled",
        SET_MUTE_DURATION = "net_sv_di_set_mute_duration",
        SET_AUTO_MAP_ID = "net_sv_di_set_auto_map_id",

        -- Getter - Always answers with another request | GET_CON_VARS -> SEND CON VARS TO CLIENT
        GET_CON_VARS = "net_sv_di_get_con_vars"
    },
    -- Client Receiving
    CLIENT_SIDE = {
        REC_CON_VARS = "net_cl_di_rec_con_vars"
    }
}

-- Used for other addons
HOOKS = {
    -- Hooks that other addons can listen to | Will be ran internally
    PLAYER_MUTED = "DTTTPlayerMuted",
    PLAYER_MOVED = "DTTTPlayerMoved",

    -- Hooks that other addons can run | Will be ran internally
    -- Muting
    MUTE_PLAYER = "DTTTMutePlayer",
    UNMUTE_PLAYER = "DTTTUnmutePlayer",
    MUTE_ALL_PLAYERS = "DTTTMuteAllPlayers",
    UNMUTE_ALL_PLAYERS = "DTTTUnmuteAllPlayers",

    -- Channel
    MOVE_PLAYER = "DTTTMovePlayer", -- ply, channelID
}