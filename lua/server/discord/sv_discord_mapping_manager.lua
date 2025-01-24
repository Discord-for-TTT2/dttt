include("server/utils/sv_helper.lua")
include("server/discord/sv_discord_caching.lua")


function addDiscordId(ply, discord_id)
    local current_discord_id = getMappedId(ply)

    if tostring(current_discord_id) == "nil" then
        g_dttt_discord_mapping[playerIdToString(ply)] = tostring(discord_id)
        writeIdCache()
    else
        print("Player " .. ply:Nick() .. " already exists with Discord ID " .. tostring(current_discord_id))
    end
end

function removeDiscordId(ply)
    addDiscordId(ply, nil)
end

function clearDiscordIds()
    g_dttt_discord_mapping = {}
    writeIdCache()
end

function loadDiscordIds()
    loadIdCache()
end

function autoMapId(ply)
    if ply:IsBot() or not shouldAutoMapId() then
        return
    end

    getDiscordIdRequest(ply, function(res_body, res_size, res_headers, res_code)
        local body = util.JSONToTable(res_body)
        local discord_id = body.id

        if discord_id == nil then
            logError("Returned discord id is not valid!")
        end
        addDiscordId(ply, discord_id)

        logDebug("Set discord id for player " .. ply:Nick() .. " to " .. tostring(discord_id))
    end)
end