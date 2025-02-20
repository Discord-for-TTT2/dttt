CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "dttt_config_title"
CLGAMEMODESUBMENU.priority = 100


function CLGAMEMODESUBMENU:Initialize()
end

function CLGAMEMODESUBMENU:Populate(parent)
    GetConVars()

    if g_convars.initialized == false then return end

    local debug_form = vgui.CreateTTT2Form(parent, "dttt_config_debug_form")

    debug_form:MakeCheckBox({
        label = "dttt_config_debug_enabled",
        initial = g_convars["dttt_dbg_enabled"].value,
        default = g_convars["dttt_dbg_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_dbg_enabled", value)
            ChangeBoolConVar("dttt_dbg_enabled", value)
        end
    })

    debug_form:MakeCheckBox({
        label = "dttt_config_debug_timestamp_enabled",
        initial = g_convars["dttt_dbg_timestamp_enabled"].value,
        default = g_convars["dttt_dbg_timestamp_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_dbg_timestamp_enabled", value)
            ChangeBoolConVar("dttt_dbg_timestamp_enabled", value)
        end
    })

    local log_level_form = vgui.CreateTTT2Form(debug_form, "dttt_config_log_level_form")

    log_level_form:MakeCheckBox({
        label = "dttt_config_debug_info",
        initial = g_convars["dttt_dbg_log_info"].value,
        default = g_convars["dttt_dbg_log_info"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_dbg_log_info", value)
            ChangeBoolConVar("dttt_dbg_log_info", value)
        end
    })

    log_level_form:MakeCheckBox({
        label = "dttt_config_debug_warning",
        initial = g_convars["dttt_dbg_log_warning"].value,
        default = g_convars["dttt_dbg_log_warning"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_dbg_log_warning", value)
            ChangeBoolConVar("dttt_dbg_log_warning", value)
        end
    })

    log_level_form:MakeCheckBox({
        label = "dttt_config_debug_debug",
        initial = g_convars["dttt_dbg_log_debug"].value,
        default = g_convars["dttt_dbg_log_debug"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_dbg_log_debug", value)
            ChangeBoolConVar("dttt_dbg_log_debug", value)
        end
    })

    log_level_form:MakeCheckBox({
        label = "dttt_config_debug_error",
        initial = g_convars["dttt_dbg_log_error"].value,
        default = g_convars["dttt_dbg_log_error"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_dbg_log_error", value)
            ChangeBoolConVar("dttt_dbg_log_error", value)
        end
    })

    local logic_form = vgui.CreateTTT2Form(parent, "dttt_config_logic")

    logic_form:MakeCheckBox({
        label = "dttt_config_enabled",
        initial = g_convars["dttt_enabled"].value,
        default = g_convars["dttt_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_enabled", value)
            ChangeBoolConVar("dttt_enabled", value)
        end
    })

    logic_form:MakeCheckBox({
        label = "dttt_config_mute_enabled",
        initial = g_convars["dttt_mute_enabled"].value,
        default = g_convars["dttt_mute_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_mute_enabled", value)
            ChangeBoolConVar("dttt_mute_enabled", value)
        end
    })

    logic_form:MakeCheckBox({
        label = "dttt_config_unmute_enabled",
        initial = g_convars["dttt_unmute_enabled"].value,
        default = g_convars["dttt_unmute_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_unmute_enabled", value)
            ChangeBoolConVar("dttt_unmute_enabled", value)
        end
    })

    logic_form:MakeSlider({
        label = "dttt_config_mute_duration",
        initial = g_convars["dttt_mute_duration"].value,
        default = g_convars["dttt_mute_duration"].default,
        min = 0,
        max = 300,
        OnChange = function(obj, value)
            cvars.ChangeServerConVar("dttt_mute_duration", value)
            ChangeConVar("dttt_mute_duration", value)
        end
    })

    logic_form:MakeCheckBox({
        label = "dttt_config_deafen_enabled",
        initial = g_convars["dttt_deafen_enabled"].value,
        default = g_convars["dttt_deafen_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_deafen_enabled", value)
            ChangeBoolConVar("dttt_deafen_enabled", value)
        end
    })

    logic_form:MakeCheckBox({
        label = "dttt_config_undeafen_enabled",
        initial = g_convars["dttt_undeafen_enabled"].value,
        default = g_convars["dttt_undeafen_enabled"].default,
        OnChange = function(obj, value)
            cvars.ChangeBoolServerConVar("dttt_undeafen_enabled", value)
            ChangeBoolConVar("dttt_undeafen_enabled", value)
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
            cvars.ChangeServerConVar("dttt_bot_endpoint", value)
            ChangeConVar("dttt_bot_endpoint", value)
        end
    })

    bot_form:MakeTextEntry({
        label = "dttt_config_bot_api",
        initial = g_convars["dttt_bot_api_key"].value,
        default = g_convars["dttt_bot_api_key"].default,
        OnChange = function(obj, value)
            cvars.ChangeServerConVar("dttt_bot_api_key", value)
            ChangeConVar("dttt_bot_api_key", value)
        end
    })
end