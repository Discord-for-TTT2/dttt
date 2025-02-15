local plymeta = FindMetaTable("Player")

local function IsStateDifferent(old_state, new_state)
    if old_state ~= new_state then
        return true
    end
    return false
end

function plymeta:SetMuted(state)
    state = state or false

    local is_state_different = IsStateDifferent(self.discord_mute, state)

    self.discord_mute = state
    return is_state_different
end

function plymeta:SetDeafened(state)
    state = state or false

    local is_state_different = IsStateDifferent(self.discord_deafen, state)

    self.discord_deafen = state
    return is_state_different
end

function plymeta:GetMuted()
    return self.discord_mute or false
end

function plymeta:GetDeafened()
    return self.discord_deafen or false
end

function plymeta:SteamID64String()
    return tostring(self:SteamID64())
end