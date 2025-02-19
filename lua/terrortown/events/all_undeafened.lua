if CLIENT then
    EVENT.icon = Material("vgui/ttt/vskin/events/deafened.png")
    EVENT.title = "title_event_all_undeafened"
end

if SERVER then
    function EVENT:Trigger()
        return self:Add({})
    end
end

function EVENT:Serialize()
    return "All Players got Undeafened"
end