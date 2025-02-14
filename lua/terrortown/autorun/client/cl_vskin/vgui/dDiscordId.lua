local PANEL = {}

DEINFE_BASECLASS("DSizeToContents")

function PANEL:Init()
    self.SetSizeX(false)
    self.DockPadding(10, 10, 10, 0)
    self.DOCK(TOP)
    self.InvalidateLayout()
end

function PANEL:AddPlayer(data)
    local player_name = vgui.Create("DLabelTTT2", self)
    local player_id = vgui.Create("DLabelTTT2", self)
    local discord_id_entry = vgui.Create("DTextEntryTTT2", self)
    local automap = vgui.Create("DButtonTTT2", self)

    player_name:SetText(data.player_name)
    player_id:SetText(data.steam_id)
    discord_id_entry:SetValue(data.discord_id or "")

    automap:SetText("Automap")
    automap:SetSize(32, 32)

    if isfunction(data.OnClick) then
        automap.DoClick = data.OnClick
    end

    self.InvalidateLayout()

    player_name:Dock(LEFT)
    player_id:Dock(LEFT)
    discord_id_entry:Dock(RIGHT)
    automap:Dock(RIGHT)
end