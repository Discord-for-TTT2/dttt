CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "dttt_config_title"
CLGAMEMODESUBMENU.priority = 100


function CLGAMEMODESUBMENU:Initialize()
end

function CLGAMEMODESUBMENU:Populate(parent)
    getCVars()

    local debug_form = vgui.CreateTTT2Form(parent, "dttt_config_debug_form")

    debug_form:MakeCheckBox({
        label = "dttt_config_debug_enabled",
        initial = g_convars["dttt_dbg_enabled"].value,
        default = g_convars["dttt_dbg_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_dbg_enabled", value)
            getBoolCVar("dttt_dbg_enabled")
        end
    })

    debug_form:MakeCheckBox({
        label = "dttt_config_debug_timestamp_enabled",
        initial = g_convars["dttt_dbg_timestamp_enabled"].value,
        default = g_convars["dttt_dbg_timestamp_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_dbg_timestamp_enabled", value)
            getBoolCVar("dttt_dbg_timestamp_enabled")
        end
    })

    debug_form:MakeTextEntry({
        label = "dttt_config_debug_levels",
        initial = g_convars["dttt_dbg_log_levels"].value,
        default = g_convars["dttt_dbg_log_levels"].default,
        OnChange = function(obj, value)
            setServerCVar("dttt_dbg_log_levels", value)
            getStringCVar("dttt_dbg_log_levels")
        end
    })

    local logic_form = vgui.CreateTTT2Form(parent, "dttt_config_logic")

    logic_form:MakeCheckBox({
        label = "dttt_config_enabled",
        initial = g_convars["dttt_enabled"].value,
        default = g_convars["dttt_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_enabled", value)
            getBoolCVar("dttt_enabled")
        end
    })

    local mute_form = vgui.CreateTTT2Form(logic_form, "dttt_config_mute_form")

    mute_form:MakeCheckBox({
        label = "dttt_config_mute_enabled",
        initial = g_convars["dttt_mute_enabled"].value,
        default = g_convars["dttt_mute_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_mute_enabled", value)
            getBoolCVar("dttt_mute_enabled")
        end
    })

    mute_form:MakeCheckBox({
        label = "dttt_config_unmute_enabled",
        initial = g_convars["dttt_unmute_enabled"].value,
        default = g_convars["dttt_unmute_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_unmute_enabled", value)
            getBoolCVar("dttt_unmute_enabled")
        end
    })

    mute_form:MakeSlider({
        label = "dttt_config_mute_duration",
        initial = g_convars["dttt_mute_duration"].value,
        default = g_convars["dttt_mute_duration"].default,
        min = 0,
        max = 300,
        OnChange = function(obj, value)
            setServerCVar("dttt_mute_duration", value)
            getIntCVar("dttt_mute_duration")
        end
    })

    local deafen_form = vgui.CreateTTT2Form(logic_form, "dttt_config_deafen_form")

    deafen_form:MakeCheckBox({
        label = "dttt_config_deafen_enabled",
        initial = g_convars["dttt_deafen_enabled"].value,
        default = g_convars["dttt_deafen_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_deafen_enabled", value)
            getBoolCVar("dttt_deafen_enabled")
        end
    })

    deafen_form:MakeCheckBox({
        label = "dttt_config_undeafen_enabled",
        initial = g_convars["dttt_undeafen_enabled"].value,
        default = g_convars["dttt_undeafen_enabled"].default,
        OnChange = function(obj, value)
            setBoolCVar("dttt_undeafen_enabled", value)
            getBoolCVar("dttt_undeafen_enabled")
        end
    })

    ---
    ---
    ---

    local bot_form = vgui.CreateTTT2Form(parent, "dttt_config_bot_form")

    bot_form:MakeTextEntry({
        label = "dttt_config_bot_endpoint",
        initial = g_convars["dttt_bot_endpoint"].value,
        default = g_convars["dttt_bot_endpoint"].default,
        OnChange = function(obj, value)
            setServerCVar("dttt_bot_endpoint", value)
            getStringCVar("dttt_bot_endpoint")
        end
    })

    bot_form:MakeTextEntry({
        label = "dttt_config_bot_api",
        initial = g_convars["dttt_bot_api_key"].value,
        default = g_convars["dttt_bot_api_key"].default,
        OnChange = function(obj, value)
            setServerCVar("dttt_bot_api_key", value)
            getStringCVar("dttt_bot_api_key")
        end
    })

end