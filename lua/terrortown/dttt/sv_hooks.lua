function GM:DTTTPreLogic() end -- Runs before any logic in DTTT happens

function GM:DTTTPreMuteLogic() end -- Runs before any Mute Logic thats related to discord

function GM:DTTTPreChatSync() end -- Runs before the ingame chat gets tired to sync to the mute state
function GM:DTTTPreVoiceSync() end -- Runs before the ingame voice chat gets tried to sync to the mute state

-- Runs before the Player gets muted
function GM:DTTTPreMute(ply, duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreMuteLogic") ~= nil then return end

    hook.Run("DTTTMute", ply, duration)
end

-- Used to actually run mute logic on the player
-- Changing Mute state, sending discord request
function GM:DTTTMute(ply, duration)
    dttt.Mute(ply, duration)

    hook.Run("DTTTPostMute", ply, duration)
end


-- Ran after internal mute logic ran
-- Can be used to check states or do other things
function GM:DTTTPostMute(ply, duration) end

-------

-- Runs before player gets unmuted
-- All player checks should be completed before this point
function GM:DTTTPreUnmute(ply, duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreMuteLogic") ~= nil then return end

    hook.Run("DTTTUnmute", ply, duration)
end

-- Used to actually run unmute logic on the player
function GM:DTTTUnmute(ply, duration)
    dttt.Unmute(ply, duration)

    hook.Run("DTTTPostUnmute", ply, duration)
end

-- Runs after everything is completed
function GM:DTTTPostUnmute(ply, duration) end

---------

-- Should mute every human player in the lobby
function GM:DTTTMuteAll(duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreMuteLogic") ~= nil then return end

    hook.Run("DTTTMuteAll", duration)
end

function GM:DTTTMuteAll(duration)
    dttt.MuteAll(duration)

    hook.Run("DTTTPostMuteAll", duration)
end

function GM:DTTTPostMuteAll(duration) end

---------

function GM:DTTTPreUnmuteAll(duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreMuteLogic") ~= nil then return end

    hook.Run("DTTTUnmuteAll", duration)
end

function GM:DTTTUnmuteAll(duration)
    dttt.UnmuteAll(duration)

    hook.Run("DTTTPostUnmuteAll", duration)
end

function GM:DTTTPostUnmuteAll(duration) end


--------

-- Should Deafen the player
-- Runs DTTTPreDeafen first and checks if it returns anything

function GM:DTTTPreUndeafen(ply, duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreDeafenLogic") ~= nil then return end

    hook.Run("DTTTDeafen", ply, duration)
end

function GM:DTTTDeafen(ply, duration)
    dttt.Deafen(ply, duration)

    hook.Run("DTTTPostDeafen", ply, duration)
end

function GM:DTTTPostDeafen(ply, duration) end

-------------

function GM:DTTTPreUndeafen(ply, duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreDeafenLogic") ~= nil then return end

    hook.Run("DTTTUndeafen", ply, duration)
end

function GM:DTTTUndeafen(ply, duration)
    dttt.Undeafen(ply, duration)

    hook.Run("DTTTPostUndeafen", ply, duration)
end

function GM:DTTTPostUndeafen(ply, duration) end

-------------

function GM:DTTTDeafenAll(duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreDeafenLogic") ~= nil then return end

    dttt.DeafenAll(duration)

    hook.Run("DTTTPostDeafenAll", duration)
end

function GM:DTTTPostDeafenAll(duration) end

--------

function GM:DTTTUndeafenAll(duration)
    if hook.Run("DTTTPreLogic") ~= nil then return end
    if hook.Run("DTTTPreDeafenLogic") ~= nil then return end

    dttt.UndeafenAll(duration)

    hook.Run("DTTTPostUndeafenAll", duration)
end

function GM:DTTTPostUndeafenAll(duration) end


---------------
---------------
---------------

local function PlayerChatBlocked(ply)
    local ply_mute_state = ply:GetMuted()

    ply:SetMuted(false)

    if hook.Run("TTT2AvoidGeneralChat", ply, "") == false then return true end
    if hook.Run("TTTPlayerRadioCommand", ply, "","quick_nobody") == true then return true end
    if hook.Run("TTT2CanUseVoiceChat", ply, false) == false then return true end

    ply:SetMuted(ply_mute_state)

    return false
end

local function VoiceChatBlocked(ply)
    local ply_deafen_state = ply:GetDeafened()

    ply:SetDeafened(false)

    if hook.Run("TTT2CanSeeChat", ply, ply, false) == false then return true end
    if hook.Run("TTT2CanHearVoiceChat", ply, ply, false) == false then return true end

    ply:SetDeafened(ply_deafen_state)

    return false
end

local function SyncGameChat(ply)
    timer.Simple(0.2, function()
        if PlayerChatBlocked(ply) == false then
            hook.Run("DTTTPreUnmute", ply)
        else
            hook.Run("DTTTPreMute", ply)
        end
    end)
end

local function SyncGameVoice(ply)
    timer.Simple(0.2, function()
        if VoiceChatBlocked(ply) == false then
            hook.Run("DTTTPreUndeafen", ply)
        else
            hook.Run("DTTTPreDeafen", ply)
        end
    end)
end

hook.Add("TTT2PrePrepareRound", "DTTTPrePrepareRound", function(duration)
    hook.Run("DTTTPreUnmuteAll")
end)

hook.Add("TTT2PreEndRound", "DTTTPreBeginRonud", function(result, duration)
    hook.Run("DTTTPreUnmuteAll")
end)

hook.Add("TTT2PostPlayerDeath", "DTTTPostPlayerDeath", function(victim, inflictor, attacker)
    -- Mute player if the Round is running, only when Mute/Deafen is initialized
    if getRoundState() ~= 3 then return end

    if victim:GetMuted() == nil and victim:GetDeafened() == nil then return end

    hook.Run("DTTTPreMute", victim, GetConVar("dttt_mute_duration"):GetInt())
end)

hook.Add("PlayerSpawn", "DTTTPlayerSpawn", function(ply, transition)
    -- Unmute Player if they are actually active in the round again
    -- This should take into account the Voice/Text state of the Player

    if not ply:IsActive() then return end

    SyncGameChat(ply)
    SyncGameVoice(ply)
end)

hook.Add("PlayerInitialSpawn", "DTTTPlayerInitialSpawn", function(ply ,transition)
    -- Should initialize Mute/Deafen states of player

    ply:SetMuted(false)
    ply:SetDeafened(false)

    discord.AutoMap(ply)
end)

hook.Add("PlayerDisconnected", "DTTTPlayerDisconnected", function(ply)
    -- Should deinitialize Mute/Deafen states of player

    ply:SetMuted(nil)
    ply:SetDeafened(nil)
end)


--- TODO: Add more checks and convars
--- Chat Syncing

hook.Add("TTT2AvoidGeneralChat", "DTTTAvoidGeneralChat", function(ply, message)
    -- Make Player unable to chat if they are Muted
    -- Should only happen if the player is Active

    if hook.Run("DTTTPreChatSync") ~= nil then return end

    if not ply:IsActive() then return end

    if ply:GetMuted() then return false end
end)

hook.Add("TTT2CanSeeChat", "DTTTCanSeeChat", function(reader, sender, isTeam)
    -- Make Player unable to see chat if they are Deafened
    -- Should only happen if the player is active

    if hook.Run("DTTTPreChatSync") ~= nil then return end

    if not reader:IsActive() then return end

    if reader:GetDeafened() then return false end
end)

hook.Add("TTT2PlayerRadioCommand", "DTTTPlayerRadioCommand", function(ply, msgName, msgTarget)
    -- Make Player unable to chat if they are Muted
    -- Should only happen if the player is active

    if hook.Run("DTTTPreChatSync") ~= nil then return end

    if not ply:IsActive() then return end

    if ply:GetMuted() then return true end
end)

--- InGame Voice Chat

hook.Add("TTT2CanUseVoiceChat", "DTTTCanUseVoiceChat", function(listener, isTeam)
    -- Make Player unable to use voice chat if they are Muted
    -- Should only happen if the player is active

    if hook.Run("DTTTPreVoiceSync") ~= nil then return end

    if not listener:IsActive() then return end

    if listener:GetMuted() then return false end
end)

hook.Add("TTT2CanHearVoiceChat", "DTTTCanHearVoiceChat", function(listener, speaker, isTeam)
    if hook.Run("DTTTPreVoiceSync") ~= nil then return end

    if not listener:IsActive() then return end

    if listener:GetDeafened() then return false end
end)