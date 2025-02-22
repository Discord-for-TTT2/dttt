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

local material_run = Material("vgui/ttt/vskin/icon_run")
local material_delete = Material("vgui/ttt/vskin/icon_delete.png")
local material_copy = Material("vgui/ttt/vskin/icon_copy.png")

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

---
-- @realm client
function PANEL:Clear()
    for i = 1, #self.items do
        local item = self.items[i]

        if not IsValid(item) then
            continue
        end

        item:Remove()
    end

    self.items = {}
end

function MakeSizeToContent(parent)
    local panel = vgui.Create("DSizeToContents", parent)

    panel:SetSizeX(false)
    panel:Dock(TOP)
    panel:DockPadding(10, 10, 10, 0)
    panel:InvalidateLayout()

    return panel
end

local function MakeButton(parent, data)
    local button = vgui.Create("DButtonTTT2", parent)

    button:SetText("button_default")
    button:SetSize(32, 32)

    button.Paint = function(slf, w, h)
        derma.SkinHook("Paint", "FormButtonIconTTT2", slf, w, h)
        return true
    end

    if isfunction(data.DoClick) then
        button.DoClick = data.DoClick
    end

    return button
end

local function MakeLabel(parent, data)
    local label = vgui.Create("DLabelTTT2", parent)

    label:SetText(data.label)

    label.Paint = function(slf, w, h)
        derma.SkinHook("Paint", "FormLabelTTT2", slf, w, h)
        return true
    end

    return label
end

local function MakeTextEntry(parent, data)
    local text_entry = vgui.Create("DTextEntryTTT2", parent)

    text_entry:SetUpdateOnType(false)
    text_entry:SetHeightMult(1)

    text_entry.OnGetFocus = function(slf)
        util.getHighestPanelParent(parent):SetKeyboardInputEnabled(true)
    end

    text_entry.OnLoseFocus = function(slf)
        util.getHighestPanelParent(parent):SetKeyboardInputEnabled(false)
    end

    text_entry:SetDefaultValue(data.default)
    text_entry:SetConVar(data.convar)
    text_entry:SetServerConVar(data.serverConvar)

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

-------------------------------------------

function PANEL:AddCustomElement(element)
    self.items[#self.items + 1] = element
end

function PANEL:MakePlayerEntry(data)
    local copy_button = MakeButton(self, {
        DoClick = function(obj)
            SetClipboardText(data.player.steam_id)
        end
    })

    local delete_button = MakeButton(self, {
        DoClick = function(obj)
            net.Start("dttt_sv_set_mapping")
            net.WriteString(data.player.steam_id)
            net.WriteString("")
            net.SendToServer()

            net.Start("dttt_sv_get_mapping")
            net.SendToServer()
        end
    })

    local label = MakeLabel(self, {
        label = data.player.name
    })

    local automap_button = MakeButton(self, {
        DoClick = function(obj)
            net.Start("dttt_sv_map_player")
            net.WriteString(data.player.steam_id)
            net.SendToServer()

            net.Start("dttt_sv_get_mapping")
            net.SendToServer()
        end
    })

    local entry = MakeTextEntry(self, {
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

    entry:SetUpdateOnType(false)
    entry:SetHeightMult(1)
    entry:SetValue(data.player.discord_id)
    entry:SetTall(32)
    entry:Dock(TOP)

    self:InvalidateLayout()

    local panel = MakeSizeToContent(self)

    label:SetParent(panel)
    label:Dock(LEFT)
    label:InvalidateLayout(true)
    label:SetSize(350, 20)

    copy_button:SetParent(panel)
    copy_button:SetSize(32, 32)
    copy_button:SetText("")
    copy_button:Dock(RIGHT)
    copy_button.iconMaterial = material_copy
    copy_button:InvalidateLayout(true)

    delete_button:SetParent(panel)
    delete_button:SetSize(32, 32)
    delete_button:SetText("")
    delete_button:Dock(RIGHT)
    delete_button.iconMaterial = material_delete
    delete_button:InvalidateLayout(true)

    automap_button:SetParent(panel)
    automap_button:SetSize(32, 32)
    automap_button:SetText("")
    automap_button:Dock(RIGHT)
    automap_button.iconMaterial = material_run

    if data.automap_enabled == false then
        automap_button:SetEnabled(false)
    end

    automap_button:InvalidateLayout(true)

    entry:SetParent(panel)
    entry:SetPos(350, 0)
    entry:InvalidateLayout(true)

    self:AddCustomElement(panel)
end

derma.DefineControl("DFormDTTT", "", PANEL, "DFormTTT2")

function vgui.CreateDTTTForm(parent, name)
    local form = vgui.Create("DFormDTTT", parent, name)

    form:SetName(name)
    form:Dock(TOP)

    return form
end