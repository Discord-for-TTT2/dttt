include("dttt/extensions/cvars.lua")
include("dttt/extensions/player.lua")

g_convars = {}

local function add_convar(cvar, value, default)
    g_convars[cvar] = {["value"] = value, ["default"] = default}
end

-- Misc

function GetConVars()
    cvars.ServerConVarGetBool("dttt_dbg_enabled", add_convar)
    cvars.ServerConVarGetBool("dttt_dbg_timestamp_enabled", add_convar)
    cvars.ServerConVarGetString("dttt_dbg_log_levels", add_convar)

    cvars.ServerConVarGetBool("dttt_enabled", add_convar)

    cvars.ServerConVarGetBool("dttt_mute_enabled", add_convar)
    cvars.ServerConVarGetBool("dttt_unmute_enabled", add_convar)
    cvars.ServerConVarGetInt("dttt_mute_duration", add_convar)

    cvars.ServerConVarGetBool("dttt_deafen_enabled", add_convar)
    cvars.ServerConVarGetBool("dttt_undeafen_enabled", add_convar)

    cvars.ServerConVarGetBool("dttt_auto_map_ids", add_convar)
    cvars.ServerConVarGetBool("dttt_cache_mapping", add_convar)

    cvars.ServerConVarGetString("dttt_bot_endpoint", add_convar)
    cvars.ServerConVarGetString("dttt_bot_api_key", add_convar)
end

function ChangeConVar(cvar, value)
    local convar = g_convars[cvar]

    if convar then
        convar.value = value
    end
end

function ChangeBoolConVar(cvar, value)
    local converted = (value == "true" or value == "1")
    ChangeConVar(cvar, converted)
end

GetConVars()