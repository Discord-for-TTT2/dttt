local plymeta = FindMetaTable("Player")

function plymeta:SetMute(state)
    state = state or false

    self.discord_mute = state
end

function plymeta:SetDeafen(state)
    state = state or false

    self.discord_deafen = state
end

function plymeta:GetMute()
    return self.discord_mute or false
end

function plymeta:GetDeafen()
    return self.discord_deafen or false
end

function plymeta:SteamID64String()
    return tostring(self:SteamID64())
end