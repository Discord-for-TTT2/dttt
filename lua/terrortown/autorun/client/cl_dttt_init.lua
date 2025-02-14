g_convars = {}

-- Getters

function getServerCVar(name, callback)
    cvars.ServerConVarGetValue(name, callback)
end

function getIntCVar(cvar_name)
    cvars.ServerConVarGetValue(cvar_name, function(exists, value, default)
        if not exists then g_convars[cvar_name] = nil end

        g_convars[cvar_name] = {
            ["value"] = tonumber(value),
            ["default"] = tonumber(default)
        }
    end)
end

function getBoolCVar(cvar_name)
    cvars.ServerConVarGetValue(cvar_name, function(exists, value, default)
        if not exists then g_convars[cvar_name] = nil end

        g_convars[cvar_name] = {
            ["value"] = (value == "true" or value == "1"),
            ["default"] = (default == "true" or default == "1")
        }
    end)
end

function getStringCVar(cvar_name)
    cvars.ServerConVarGetValue(cvar_name, function(exists, value, default)
        if not exists then g_convars[cvar_name] = nil end

        g_convars[cvar_name] = {
            ["value"] = value,
            ["default"] = default
        }
    end)
end

-- Setters

function setServerCVar(name, value)
    cvars.ChangeServerConVar(name, value)
end

function setBoolCVar(name, value)
    if value == true or value == "1" then
        value = "1"
    else
        value = "0"
    end

    setServerCVar(name, value)
end

-- Misc

function getCVars()
    getBoolCVar("dttt_dbg_enabled")
    getBoolCVar("dttt_dbg_timestamp_enabled")
    getStringCVar("dttt_dbg_log_levels")

    getBoolCVar("dttt_enabled")

    getBoolCVar("dttt_mute_enabled")
    getBoolCVar("dttt_unmute_enabled")
    getIntCVar("dttt_mute_duration")

    getBoolCVar("dttt_deafen_enabled")
    getBoolCVar("dttt_undeafen_enabled")

    getBoolCVar("dttt_auto_map_ids")
    getBoolCVar("dttt_cache_mapping")

    getStringCVar("dttt_bot_endpoint")
    getStringCVar("dttt_bot_api_key")
end

getCVars()