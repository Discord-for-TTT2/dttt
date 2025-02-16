include("dttt/extensions/player.lua")

include("dttt/libraries/discord.lua")
include("dttt/libraries/logger.lua")
include("dttt/libraries/dttt.lua")

AddCSLuaFile("dttt/extensions/cvars.lua")
AddCSLuaFile("dttt/extensions/player.lua")

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

cvars.AddChangeCallback("dttt_dbg_enabled", function(name, old, new)
    dttt_logger.SetEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_dbg_timestamp_enabled", function(name, old, new)
    dttt_logger.SetLogTimestamp(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_dbg_log_levels", function(name, old, new)
    dttt_logger.SetLogLevels(GetConVar(name):GetString())
end)

cvars.AddChangeCallback("dttt_enabled", function(name, old, new)
    dttt.SetEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_mute_enabled", function(name, old, new)
    dttt.SetMuteEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_unmute_enabled", function(name, old, new)
    dttt.SetUnmuteEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_mute_duration", function(name, old, new)
    dttt.SetMuteDuration(GetConVar(name):GetInt())
end)

cvars.AddChangeCallback("dttt_deafen_enabled", function(name, old, new)
    dttt.SetDeafenEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_undeafen_enabled", function(name, old, new)
    dttt.SetUndeafenEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_bot_endpoint", function(name, old, new)
    discord.SetEndpoint(GetConVar(name):GetString())
end)

cvars.AddChangeCallback("dttt_bot_api_key", function(name, old, new)
    discord.SetApiKey(GetConVar(name):GetString())
end)

cvars.AddChangeCallback("dttt_auto_map_ids", function(name, old, new)
    discord.SetAutomapEnabled(GetConVar(name):GetBool())
end)

cvars.AddChangeCallback("dttt_cache_mapping", function(name, old, new)
    discord.SetCacheEnabled(GetConVar(name):GetBool())
end)


-- Setup dttt
dttt.SetEnabled(GetConVar("dttt_enabled"):GetBool())
dttt.SetMuteEnabled(GetConVar("dttt_mute_enabled"):GetBool())
dttt.SetUnmuteEnabled(GetConVar("dttt_unmute_enabled"):GetBool())
dttt.SetDeafenEnabled(GetConVar("dttt_deafen_enabled"):GetBool())
dttt.SetUndeafenEnabled(GetConVar("dttt_undeafen_enabled"):GetBool())
dttt.SetMuteDuration(GetConVar("dttt_mute_duration"):GetInt())

-- Setup Default Discord Settings
discord.SetApiKey(GetConVar("dttt_bot_api_key"):GetString())
discord.SetEndpoint(GetConVar("dttt_bot_endpoint"):GetString())
discord.SetAutomapEnabled(GetConVar("dttt_auto_map_ids"):GetBool())

discord.LoadMapping()

-- Setup Default Logger Settings
dttt_logger.SetEnabled(GetConVar("dttt_dbg_enabled"):GetBool())
dttt_logger.SetLogLevels(GetConVar("dttt_dbg_log_levels"):GetString())
dttt_logger.SetLogTimestamp(GetConVar("dttt_dbg_timestamp_enabled"):GetBool())


include("terrortown/dttt/sv_helper.lua")
include("terrortown/dttt/sv_hooks.lua")
include("terrortown/dttt/sv_commands.lua")
include("terrortown/dttt/sv_net.lua")


resource.AddFile("materials/vgui/ttt/vskin/helpscreen/logo.vmt")
resource.AddFile("materials/vgui/ttt/muted.vmt")
resource.AddFile("materials/vgui/ttt/deafened.vmt")