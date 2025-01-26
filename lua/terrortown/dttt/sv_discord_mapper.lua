local DiscordMapper = {
    player_mapping = {}, -- K: SteamID V:DiscordID
    CACHE_FILE_NAME = "discord_mapping_cache"
}

local function isPlayerValid(ply)
    return IsValid(ply) and not ply:IsBot()
end

-- Checks --

function DiscordMapper.containsMapping(ply)
    return DiscordMapper.containsMappingById(getSteamId(ply))
end

function DiscordMapper.containsMappingById(steam_id)
    return DiscordMapper.player_mapping[steam_id] ~= nil
end

-- Mapping --

function DiscordMapper.addMapping(ply, discord_id)
    if not isPlayerValid(ply) or discord_id == nil then return end

    logInfo("Mapping ID " .. tostring(discord_id) .. " to player " .. ply:Nick())

    DiscordMapper.player_mapping[getSteamId(ply)] = discord_id
    DiscordMapper.writeCache()
end

function DiscordMapper.removeMapping(ply)
    if not isPlayerValid(ply) then return end

    DiscordMapper.player_mapping[getSteamId(ply)] = nil
    DiscordMapper.writeCache()
end

function DiscordMapper.clearMapping()
    DiscordMapper.player_mapping = {}
    DiscordMapper.writeCache()
end

function DiscordMapper.autoMap(ply)
    if not isPlayerValid(ply) or GetConVar("dttt_auto_map_ids"):GetBool() == false then return end

    logInfo("Running automapper for player " .. ply:Nick())

    if DiscordMapper.containsMapping(ply) then return end

    g_discord_requests.getDiscordId(ply, function(res_code, res_body, res_headers)
        local body = util.JSONToTable(res_body)

        if not body then
            logError("Returned body in automapper is nil!")
        end

        DiscordMapper.addMapping(ply, body.id)
    end)
end

-- Caching --

function DiscordMapper.writeCache()
    if not GetConVar("dttt_cache_mapping"):GetBool() then return end 

    local json = util.TableToJSON(DiscordMapper.player_mapping, true)

    file.Write(DiscordMapper.getFileName(), json)
end

function DiscordMapper.readCache()
    local json_data = file.Read(DiscordMapper.getFileName(), "DATA")

    if json_data then
        return json_data
    end

    return "{}"
end

function DiscordMapper.loadCache()
    logInfo("Loading Cached Mappings")
    local cache = DiscordMapper.readCache()

    DiscordMapper.player_mapping = util.JSONToTable(cache, false, true)
    for key, value in pairs(DiscordMapper.player_mapping) do
        logInfo(key .. ":" .. value)
    end
end

function DiscordMapper.backupCache()
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")

    local file_name = DiscordMapper.CACHE_FILE_NAME .. "-" .. timestamp .. ".json"
    local json = util.TableToJSON(DiscordMapper.player_mapping, true)

    file.Write(file_name, json)
end

-- Getter --

function DiscordMapper.getMapping(ply)
    if not isPlayerValid(ply) then
        return nil
    end

    return DiscordMapper.player_mapping[getSteamId(ply)]
end

function DiscordMapper.getAllMappings()
    return DiscordMapper.player_mapping
end

-- Misc --

function DiscordMapper.getFileName()
    return DiscordMapper.CACHE_FILE_NAME .. ".json"
end

DiscordMapper.loadCache()

return DiscordMapper