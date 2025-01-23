include("shared/sh_globals.lua")

function playerIdToString(ply)
    return tostring(ply:SteamID64())
end

function getIdMappingByPlayer(ply)
    return _G.dttt_id_mapping[playerIdToString(ply)]
end

function isSuperAdmin(ply)
    return ply:IsSuperAdmin()
end

function getRoundState()
    if gmod.GetGamemode().Name == "TTT2" or gmod.GetGamemode().Name == "TTT2 (Advanced Update)" then
        return GetRoundState()
    end

    return nil
end

function isRoundRunning()
    return getRoundState() == 3
end

function boolToString(value)
    local bool_string = "0"

    if value == true then
        bool_string = "1"
    else
        bool_string = "0"
    end
    return bool_string
end

-- Con Vars --

-- Getter
function debugEnabled()
    return GetConVar(CON_VARS.DEBUG_ENABLED):GetBool()
end

function debugTimestampEnabled()
    return GetConVar(CON_VARS.DEBUG_LOG_TIMESTAMP_ENABLED):GetBool()
end

function getDebugLogLevels()
    return GetConVar(CON_VARS.DEBUG_LOG_LEVELS):GetString()
end

function getBotEndpoint()
    return GetConVar(CON_VARS.BOT_ENDPOINT):GetString()
end

function getBotApiKey()
    return GetConVar(CON_VARS.BOT_API_KEY):GetString()
end

function shouldAutoMapId()
    return GetConVar(CON_VARS.AUTO_MAP_ID):GetBool()
end

function internalMuteLogicEnabled()
    return GetConVar(CON_VARS.ENABLE_INTERNAL_MUTE_LOGIC):GetBool()
end

function getMuteDuration()
    return GetConVar(CON_VARS.MUTE_DURATION):GetInt()
end

function internalMutingEnabled()
    return GetConVar(CON_VARS.ENABLE_INTERNAL_MUTE):GetBool()
end

function internalUnmutingEnabled()
    return GetConVar(CON_VARS.ENABLE_INTERNAL_UNMUTE):GetBool()
end

-- Setter
function setDebugEnabled(debug_enabled) -- use bool
    RunConsoleCommand(CON_VARS.DEBUG_ENABLED, boolToString(debug_enabled))
end

function setDebugTimestampEnabled(timestamp_enabled)
    RunConsoleCommand(CON_VARS.DEBUG_LOG_TIMESTAMP_ENABLED, boolToString(timestamp_enabled))
end

function setDebugLogLevels(log_levels)
    RunConsoleCommand(CON_VARS.DEBUG_LOG_LEVELS, log_levels)
end

function setBotEndpoint(bot_endpoint)
    RunConsoleCommand(CON_VARS.BOT_ENDPOINT, bot_endpoint)
end

function setBotApiKey(api_key)
    RunConsoleCommand(CON_VARS.BOT_API_KEY, api_key)
end

function setAutoMapId(auto_map_id)
    RunConsoleCommand(CON_VARS.AUTO_MAP_ID, boolToString(auto_map_id))
end

function setInternalMuteLogicEnabled(mute_logic_enabled)
    RunConsoleCommand(CON_VARS.ENABLE_INTERNAL_MUTE_LOGIC, boolToString(mute_logic_enabled))
end

function setMuteDuration(mute_duration)
    RunConsoleCommand(CON_VARS.MUTE_DURATION, mute_duration)
end

function setInternalMuteEnabled(mute_enabled)
    RunConsoleCommand(CON_VARS.ENABLE_INTERNAL_MUTE, boolToString(mute_enabled))
end

function setInternalUnmuteEnabled(unmute_enabled)
    RunConsoleCommand(CON_VARS.ENABLE_INTERNAL_UNMUTE, unmute_enabled)
end