if CLIENT then
    EVENT.icon = Material("vgui/ttt/vskin/events/muted.png")
    EVENT.title = "title_event_muted"

    function EVENT:GetText()
        local text = {
            {
                string = "desc_event_muted",
                params = {
                    nick = self.event.ply.nick,
                },
                translateParams = true
            }
        }

        return text
    end
end

if SERVER then
    function EVENT:Trigger(ply)
        self:AddAffectedPlayers({
            { ply:SteamID64() },
            { ply:Nick() }
        })

        return self:Add({
            ply = {
                nick = ply:Nick()
            }
        })
    end
end

function EVENT:Serialize()
    return self.event.ply.nick .. " got muted "
end