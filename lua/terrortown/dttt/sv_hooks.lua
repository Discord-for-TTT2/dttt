function GM:DTTTPreMuteLogic() end
function GM:DTTTPreDeafenLogic() end

function GM:DTTTPreLogic() end


local function CheckPlayer()
    return not ply:IsBot() and ply:IsActive()
end 
---

function GM:DTTTPreMute(ply, duration)
    if hook.Run("DTTTPreMuteLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTMute", ply, duration)
end

function GM:DTTTMute(ply, duration)
    dttt.Mute(ply, duration)

    hook.Run("DTTTPostMute", ply, duration)
end

function GM:DTTTPostMute(ply, duration) end

---

function GM:DTTTPreUnmute(ply, duration)
    if hook.Run("DTTTPreMuteLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTUnmute", ply, duration)
end

function GM:DTTTUnmute(ply, duration)
    dttt.Unmute(ply, duration)

    hook.Run("DTTTPostUnmute", ply, duration)
end

function GM:DTTTPostUnmute(ply, duration) end

---

function GM:DTTTPreMuteAll(duration)
    if hook.Run("DTTTPreMuteLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTMuteAll", duration)
end

function GM:DTTTMuteAll(duration)
    dttt.MuteAll(duration)

    hook.Run("DTTTPostMuteAll", duration)
end

function GM:DTTTPostMuteAll(duration) end

---

function GM:DTTTPreUnmuteAll(duration)
    if hook.Run("DTTTPreMuteLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTUnmuteAll", duration)
end

function GM:DTTTUnmuteAll(duration)
    dttt.UnmuteAll(duration)

    hook.Run("DTTTPostUnmuteAll", duration)
end

function GM:DTTTPostUnmuteAll(duration) end

---
---
---

function GM:DTTTPreDeafen(ply, duration)
    if hook.Run("DTTTPreDeafenLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTDeafen", ply, duration)
end

function GM:DTTTDeafen(ply, duration)
    dttt.Deafen(ply, duration)

    hook.Run("DTTTPostDeafen", ply, duration)
end

function GM:DTTTPostDeafen(ply, duration) end

---

function GM:DTTTPreUndeafen(ply, duration)
    if hook.Run("DTTTPreDeafenLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTUndeafen", ply, duration)
end

function GM:DTTTUndeafen(ply, duration)
    dttt.Undeafen(ply, duration)

    hook.Run("DTTTPostUndeafen", ply, duration)
end

function GM:DTTTPostUndeafen(ply, duration) end

---

function GM:DTTTPreDeafenAll(duration)
    if hook.Run("DTTTPreDeafenLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTDeafenAll", duration)
end

function GM:DTTTDeafenAll(duration)
    dttt.DeafenAll(duration)

    hook.Run("DTTTPostDeafenAll", duration)
end

function GM:DTTTPostDeafenAll(duration) end

---

function GM:DTTTPreUndeafenAll(duration)
    if hook.Run("DTTTPreDeafenLogic") ~= nil or hook.Run("DTTTPreLogic") ~= nil then return end
    if not CheckPlayer() then return end

    hook.Run("DTTTUndeafenAll", duration)
end

function GM:DTTTUndeafenAll(duration)
    dttt.UndeafenAll(duration)

    hook.Run("DTTTPostUndeafenAll", duration)
end

function GM:DTTTPostUndeafenAll(duration) end

---
---
---

-- TODO CHANNEL MOVE

---
---
---

function GM:DTTTGetDiscordIDs()
    return discord.GetMappings()
end

function GM:DTTTGetID(ply)
    return discord.GetMapping(ply)
end

---
---
---

local function muteWithChat(ply)
    timer.Simple(0.2, function()
        local can_use_text_chat = hook.Run("TTT2AvoidGeneralChat", ply, "")
        local can_use_voice_chat = hook.Run("TTT2CanUseVoiceChat", ply, false)

        if (can_use_text_chat == false or can_use_voice_chat == false) and getRoundState() == 3 then
            hook.Run("DTTTPreMute", ply)
        else
            hook.Run("DTTTPreUnmute", ply)
        end
    end)
end

hook.Add("TTT2PrePrepareRound", "DTTTPrePrepareRound", function(duration)
    if hook.Run("DTTTPreInternalLogic") ~= nil then return end

    hook.Run("DTTTPreUnmuteAll")
end)

hook.Add("TTT2PreEndRound", "DTTTPreBeginRonud", function(result, duration)
    if hook.Run("DTTTPreInternalLogic") ~= nil then return end

    hook.Run("DTTTPreUnmuteAll")
end)

hook.Add("TTT2PostPlayerDeath", "DTTTPostPlayerDeath", function(victim, inflictor, attacker)
    if hook.Run("DTTTPreInternalLogic") ~= nil then return end

    if getRoundState() ~= 3 then return end

    if victim:GetMuted() == nil and victim:GetDeafened() == nil then return end

    hook.Run("DTTTPreMute", victim, GetConVar("dttt_mute_duration"):GetInt())
end)

hook.Add("PlayerSpawn", "DTTTPlayerSpawn", function(ply, transition)
    if hook.Run("DTTTPreInternalLogic") ~= nil then return end
    muteWithChat(ply)
end)

hook.Add("PlayerInitialSpawn", "DTTTPlayerInitialSpawn", function(ply ,transition)
    ply:SetMuted(false)
    ply:SetDeafened(false)

    discord.AutoMap(ply)
end)

hook.Add("PlayerDisconnected", "DTTTPlayerDisconnected", function(ply)
    ply:SetMuted(nil)
    ply:SetDeafened(nil)
end)