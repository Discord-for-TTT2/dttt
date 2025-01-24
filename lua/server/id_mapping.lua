include("server/discord/sv_discord_requests.lua")

function addDiscordId(ply, discord_id)
    local current_discord_id = getMappedId(ply)

    if tostring(current_discord_id) == "nil" then
        g_dttt_discord_mapping[playerIdToString(ply)] = tostring(discord_id)
        writeIdCache()
    else
        logDebug("Player " .. ply:Nick() .. " already exists with Discord ID " .. tostring(current_discord_id))
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

    getIdRequest(ply, function(res_body, res_size, res_headers, res_code)
        local body = util.JSONToTable(res_body)
        local discord_id = body.id

        if discord_id == nil then
            logError("Returned discord id is not valid!")
            return
        end
        addDiscordId(ply, discord_id)

        logDebug("Set discord id for player " .. ply:Nick() .. " to " .. tostring(discord_id))
    end)
end


--- CACHE MAPPING --- 

local ID_CACHE_FILE = "discord_connection_cache"

local function getFileName()
    return ID_CACHE_FILE .. ".json"
end

function writeIdCache()
    local json_str = util.TableToJSON(g_dttt_discord_mapping, true)

    file.Write(getFileName(), json_str)

    local written_connections = readIdCache()

    if written_connections == util.TableToJSON(g_dttt_discord_mapping, true) then
        logInfo("ID Cache written to " .. getFileName())
    else
        logInfo("Written Cache and current Mappings dont match!")
    end
end

function readIdCache()
    local json_str = file.Read(getFileName(), "DATA")

    if not json_str then
        logError("Something went wrong while reading " .. getFileName())
        return "{}"
    end

    return json_str
end

function loadIdCache()
    local cache = readIdCache()
    g_dttt_discord_mapping = util.JSONToTable(cache, false, true)
end

function backupIdCache()
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")

    local file_name = ID_CACHE_FILE .. "-" .. timestamp .. ".json"
    local json_str = util.TableToJSON(g_dttt_discord_mapping, true)

    file.Write(file_name, json_str)
end

loadIdCache()