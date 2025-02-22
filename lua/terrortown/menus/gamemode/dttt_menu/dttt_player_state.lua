CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "dttt_state_title"
CLGAMEMODESUBMENU.priority = 99

function CLGAMEMODESUBMENU:Initialize()
end

function CLGAMEMODESUBMENU:Populate(parent)
    local config_form = vgui.CreateTTT2Form(parent, "dttt_state_config_form")

    config_form:MakeButton({
        label = "Mute all Players",
        buttonLabel = "Mute",
        OnClick = function(obj)
            net.Start("dttt_sv_mute_all")
            net.WriteBool(true)
            net.SendToServer()
        end
    })

    config_form:MakeButton({
        label = "Unmute all Players",
        buttonLabel = "Unmute",
        OnClick = function(obj)
            net.Start("dttt_sv_mute_all")
            net.WriteBool(false)
            net.SendToServer()
        end
    })

    config_form:MakeButton({
        label = "Deafen all Players",
        buttonLabel = "Deafen",
        OnClick = function(obj)
            net.Start("dttt_sv_deafen_all")
            net.WriteBool(true)
            net.SendToServer()
        end
    })

    config_form:MakeButton({
        label = "Undeafen all Players",
        buttonLabel = "Undeafen",
        OnClick = function(obj)
            net.Start("dttt_sv_deafen_all")
            net.WriteBool(false)
            net.SendToServer()
        end
    })

    local player_state_form = vgui.CreateDTTTForm(parent, "dttt_player_state_form")

    for _, ply in ipairs(player.GetHumans()) do
        player_state_form:MakeMuteStateEntry({
            player = {
                name = ply:Nick(),
                steam_id = ply:SteamID64String(),
                is_muted = ply:GetNWBool("discord_mute"),
                is_deafened = ply:GetNWBool("discord_deafen")
            }
        })
    end
end