local base = "pure_skin_element"
DEFINE_BASECLASS(base)
HUDELEMENT.Base = base
if CLIENT then
    local icon = Material("vgui/ttt/vskin/hudelements/deafened.png")
    local padding = 4
    local icon_size = 64
    local const_defaults = {
        basepos = { x = 0, y = 0 },
        size = { w = 64, h = 64 },
        minsize = { w = 64, h = 64 }
    }

    function HUDELEMENT:PreInitialize()
        BaseClass.PreInitialize(self)

        local hud = huds.GetStored("pure_skin")

        if hud then hud:ForceElement(self.id) end

        -- set as fallback default, other skins have to be set to true!
        self.disabledUnlessForced = false
    end

    function HUDELEMENT:Initialize()
        self.scale = 1
        self.basecolor = self:GetHUDBasecolor()
        self.padding = padding * self.scale
        self.icon_size = icon_size * self.scale

        BaseClass.Initialize(self)
    end

    function HUDELEMENT:PerformLayout()
        self.scale = self:GetHUDScale()
        self.basecolor = self:GetHUDBasecolor()
        self.padding = math.Round(padding * self.scale, 0)
        self.icon_size = math.Round(icon_size * self.scale, 0)

        BaseClass.PerformLayout(self)
    end

    function HUDELEMENT:GetDefaults()
        const_defaults["basepos"] = {
            x = 72 + 10 * self.scale,
            y = 10 * self.scale
        }
        return const_defaults
    end

    function HUDELEMENT:IsResizable()
        return false, false
    end

    function HUDELEMENT:ShouldDraw()
        local ply = LocalPlayer()

        if not IsValid(ply) then return false end
        if ply:IsBot(ply) then return false end

        return ply:GetNWBool("discord_deafen", false) or HUDEditor.IsEditing
    end

    function HUDELEMENT:Draw()
        local pos = self:GetPos()
        local size = self:GetSize()
        local x, y = pos.x, pos.y
        local w, h = size.w, size.h

        self:DrawBg(x, y, w, h, self.basecolor)
        self:DrawLines(x, y, w, h, self.basecolor.a)

        local draw_size = self.icon_size - self.padding * 2
        draw.FilteredShadowedTexture(x + self.padding, y + self.padding, draw_size, draw_size, icon, 255, self.basecolor, self.scale)
    end
end