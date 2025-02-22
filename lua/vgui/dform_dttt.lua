local PANEL = {}

DEFINE_BASECLASS("DFormTTT2")

---
-- @accessor boolean
-- @realm client
AccessorFunc(PANEL, "m_bSizeToContents", "AutoSize", FORCE_BOOL)

---
-- @accessor number
-- @realm client
AccessorFunc(PANEL, "m_iSpacing", "Spacing")

---
-- @accessor number
-- @realm client
AccessorFunc(PANEL, "m_Padding", "Padding")

local material_automap = Material("vgui/ttt/vskin/icon_run")
local material_delete = Material("vgui/ttt/vskin/icon_delete.png")
local material_copy = Material("vgui/ttt/vskin/icon_copy.png")

local material_mute = {
    Material("vgui/ttt/vskin/states/unmuted.png"),
    Material("vgui/ttt/vskin/states/muted.png")
}

local material_deafen = {
    Material("vgui/ttt/vskin/states/undeafened.png"),
    Material("vgui/ttt/vskin/states/deafened.png")
}

local mute_colors = {
    Color(1, 153, 30, 255),
    Color(153, 1, 0, 255)
}

---
-- @ignore
function PANEL:Init()
    self.items = {}

    self:SetSpacing(4)
    self:SetPadding(10)

    self:SetPaintBackground(true)

    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
end

---
-- @param string name
-- @realm client
function PANEL:SetName(name)
    self:SetLabel(name)
end


function PANEL.MakeSizeToContent(parent)
    local panel = vgui.Create("DSizeToContents", parent)

    panel:SetSizeX(false)
    panel:Dock(TOP)
    panel:DockPadding(10, 10, 10, 0)
    panel:InvalidateLayout()

    return panel
end

function PANEL.MakeTextEntry(parent, data)
    local text_entry = vgui.Create("DTextEntryTTT2", parent)

    text_entry:SetUpdateOnType(false)
    text_entry:SetHeightMult(1)

    text_entry:SetDefaultValue(data.default)
    text_entry:SetConVar(data.convar)
    text_entry:SetServerConVar(data.serverConvar)

    text_entry.OnGetFocus = function(slf)
        util.getHighestPanelParent(parent):SetKeyboardInputEnabled(true)
    end

    text_entry.OnLoseFocus = function(slf)
        util.getHighestPanelParent(parent):SetKeyboardInputEnabled(false)
    end

    if not data.convar and not data.serverConvar and data.initial then
        text_entry:SetValue(data.initial)
    end

    text_entry.OnValueChanged = function(slf, value)
        if isfunction(data.OnChange) then
            data.OnChange(slf, value)
        end
    end

    return text_entry
end

function PANEL.MakeLabel(parent, data)
    local label = vgui.Create("DLabelTTT2", parent)

    label:SetText(data.label)

    label.Paint = function(slf, w, h)
        derma.SkinHook("Paint", "FormLabelTTT2", slf, w, h)
        return true
    end

    return label
end

function PANEL.MakeButton(parent, data)
    local button = vgui.Create("DButtonTTT2", parent)

    button:SetText(data.button_label or "")
    button:SetSize(32, 32)

    button.iconMaterial = data.icon or button.iconMaterial
    button.roundedCorner = data.rounded_corner or button.roundedCorner
    button.colorBackground = data.color_background or button.colorBackground

    button.Paint = function(slf, w, h)
        derma.SkinHook("Paint", "FormButtonIconTTT2", slf, w, h)
        return true
    end

    if isfunction(data.DoClick) then
        button.DoClick = data.DoClick
    end

    return button
end

function PANEL.MakeToggleButton(parent, data)
    local toggle_button = PANEL.MakeButton(parent, data)

    toggle_button.state = data.initial_state or 1
    toggle_button.iconMaterial = data.icons or {}
    toggle_button.colorBackground = data.colors or {}

    toggle_button.DoClick = function(slf)
        slf.state = slf.state + 1

        if slf.state >= #slf.iconMaterial then
            slf.state = 1
        end

        if isfunction(data.DoClick) then
            data.DoClick(slf, slf.state)
        end
    end

    return toggle_button
end

-------------------------------------------

function PANEL:AddCustomElement(element)
    self.items[#self.items + 1] = element
end

function PANEL:MakeDiscordIDEntry(data)
    local copy_button = self.MakeButton(self, {
        DoClick = function(obj)
            SetClipboardText(data.player.steam_id)
        end,
        icon = material_copy,
        rounded_corner = true
    })

    local delete_button = self.MakeButton(self, {
        DoClick = function(obj)
            net.Start("dttt_sv_set_mapping")
            net.WriteString(data.player.steam_id)
            net.WriteString("")
            net.SendToServer()

            net.Start("dttt_sv_get_mapping")
            net.SendToServer()
        end,
        icon = material_delete
    })

    local automap_button = self.MakeButton(self, {
        DoClick = function(obj)
            net.Start("dttt_sv_map_player")
            net.WriteString(data.player.steam_id)
            net.SendToServer()

            net.Start("dttt_sv_get_mapping")
            net.SendToServer()
        end,
        icon = material_automap
    })

    local label = self.MakeLabel(self, {
        label = data.player.name
    })

    local entry = self.MakeTextEntry(self, {
        default = "",
        initial = data.player.discord_id,
        OnChange = function(obj, value)
            net.Start("dttt_sv_set_mapping")
            net.WriteString(data.player.steam_id)
            net.WriteString(value)
            net.SendToServer()

            net.Start("dttt_sv_get_mapping")
            net.SendToServer()
        end
    })

    entry:SetTall(32)
    entry:Dock(TOP)

    self:InvalidateLayout()

    local panel = self.MakeSizeToContent(self)

    label:SetParent(panel)
    label:Dock(LEFT)
    label:InvalidateLayout(true)
    label:SetSize(350, 20)

    copy_button:SetParent(panel)
    copy_button:SetSize(32, 32)
    copy_button:SetText("")
    copy_button:Dock(RIGHT)
    copy_button:InvalidateLayout(true)

    delete_button:SetParent(panel)
    delete_button:SetSize(32, 32)
    delete_button:SetText("")
    delete_button:Dock(RIGHT)
    delete_button:InvalidateLayout(true)

    automap_button:SetParent(panel)
    automap_button:SetSize(32, 32)
    automap_button:SetText("")
    automap_button:Dock(RIGHT)

    if data.automap_enabled == false then
        automap_button:SetEnabled(false)
    end

    automap_button:InvalidateLayout(true)

    entry:SetParent(panel)
    entry:SetPos(350, 0)
    entry:InvalidateLayout(true)

    self:AddCustomElement(panel)
end

function PANEL:MakeMuteStateEntry(data)
    local mute_button = self.MakeToggleButton(self, {
        icons = material_mute,
        initial_state = data.player.is_muted and 2 or 1,
        colors = data.colors or mute_colors,
        DoClick = function(obj, state)
            net.Start("dttt_sv_mute_player")
            net.WriteString(data.player.steam_id)
            net.WriteBool(state ~= 1)
            net.SendToServer()
        end
    })

    local deafen_button = self.MakeToggleButton(self, {
        icons = material_deafen,
        initial_state = data.player.is_deafened and 2 or 1,
        colors = data.colors or mute_colors,
        rounded_corner = true,
        DoClick = function(obj, state)
            net.Start("dttt_sv_deafen_player")
            net.WriteString(data.player.steam_id)
            net.WriteBool(state ~= 1)
            net.SendToServer()
        end
    })

    local label = self.MakeLabel(self, {
        label = data.player.name
    })

    self:InvalidateLayout()

    local panel = self.MakeSizeToContent(self)

    local inner_content = vgui.Create("DPanelTTT2", self)

    inner_content:SetParent(panel)
    inner_content:SetTall(32)
    inner_content:Dock(TOP)

    label:SetParent(inner_content)
    label:Dock(LEFT)
    label:InvalidateLayout(true)
    label:SetSize(700, 32)

    deafen_button:SetParent(inner_content)
    deafen_button:SetSize(32, 32)
    deafen_button:Dock(RIGHT)
    deafen_button:InvalidateLayout(true)

    mute_button:SetParent(inner_content)
    mute_button:SetSize(32, 32)
    mute_button:Dock(RIGHT)
    mute_button:InvalidateLayout(true)

    self:AddCustomElement(panel)
end

derma.DefineControl("DFormDTTT", "", PANEL, "DFormTTT2")

function vgui.CreateDTTTForm(parent, name)
    local form = vgui.Create("DFormDTTT", parent, name)

    form:SetName(name)
    form:Dock(TOP)

    return form
end