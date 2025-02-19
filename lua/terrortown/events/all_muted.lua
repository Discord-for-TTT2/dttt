if CLIENT then
    EVENT.icon = Material("vgui/ttt/vskin/events/muted.png")
    EVENT.title = "title_event_all_muted"
end

if SERVER then
    function EVENT:Trigger()
        return self:Add({})
    end
end

function EVENT:Serialize()
    return "All Players got Muted"
end