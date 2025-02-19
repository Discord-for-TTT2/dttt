discord = discord or {}

discord.endpoint = discord.endpoint or ""
discord.api_key = discord.api_key or ""
discord.mappings = discord.mappings or {}
discord.mapping_save_path = discord.mapping_save_path or "discord_mapping_cache"
discord.auto_map_enabled = discord.auto_map_enabled or true
discord.cache_enabled = discord.cache_enabled or true

local function GetRequest(url, params, headers, on_success, on_failure, retries, timeout)
    retries = retries or 3
    timeout = timeout or 60

    local request = {
        ["method"] = "GET",
        ["url"] = url,
        ["parameters"] = params,
        ["headers"] = headers,
        ["timeout"] = timeout,
        ["failed"] = function(err)
            if on_failure ~= nil then
                on_failure(err)
            end

            if retries > 0 then
                GetRequest(url, params, headers, on_success, on_failure, retries - 1, timeout)
            end
        end,
        ["success"] = function(response_code, response_body, response_headers)
            if on_success ~= nil then
                on_success(response_code, response_body, response_headers)
            end
        end
    }

    HTTP(request)
end

local function PostRequest(url, body, headers, on_success, on_failure, content_type, retries, timeout)
    content_type = content_type or "text/plain; charset=utf-8"
    retries = retries or 3
    timeout = timeout or 60

    local request = {
        ["method"] = "POST",
        ["url"] = url,
        ["body"] = body,
        ["headers"] = headers,
        ["timeout"] = timeout,
        ["type"] = content_type,
        ["failed"] = function(err)
            if on_failure ~= nil then
                on_failure(err)
            end

            if retries > 0 then
                PostRequest(url, body, headers, on_success, on_failure, content_type, retries - 1, timeout)
            end
        end,
        ["success"] = function(response_code, response_body, response_headers)
            if on_success ~= nil then
                on_success(response_code, response_body, response_headers)
            end
        end
    }

    HTTP(request)
end

local function GenerateDiscordHeaders()
    return {
        ["Authorization"] = "Basic " .. discord.api_key
    }
end

local function GenerateURL(route)
    return discord.endpoint .. "/" .. route
end

-- CONFIG

function discord.SetEndpoint(endpoint)
    discord.endpoint = endpoint
end

function discord.SetApiKey(api_key)
    discord.api_key = api_key
end

function discord.SetAutomapEnabled(automap_enabled)
    discord.auto_map_enabled = automap_enabled
end

function discord.SetCacheEnabled(cache_enabled)
    discord.cache_enabled = cache_enabled
end

function discord.GetMapping(ply)
    return {
        steam_id = ply:SteamID64String(),
        discord_id = discord.mappings[ply:SteamID64String()]
    }
end

function discord.GetMappings()
    return discord.mappings
end

-- REQUESTS
function discord.GetDiscordId(ply, callback)
    local headers = GenerateDiscordHeaders()
    local url = GenerateURL("id")

    local params = {
        ["nick"] = ply:Nick(),
        ["name"] = ply:Name()
    }

    GetRequest(url, params, headers, callback)
end

function discord.Mute(plys, callback)
    local headers = GenerateDiscordHeaders()
    local url = GenerateURL("mute")

    local body = {}

    if type(plys) ~= "table" then
        plys = {plys}
    end

    for i, ply in ipairs(plys) do
        local mapping = discord.GetMapping(ply)
        local id = mapping.discord_id
        local status = ply:GetMuted()

        if id ~= nil and status ~= nil then
            table.insert(body, {
                ["id"] = id,
                ["status"] = status
            })
        end
    end

    local json_body = util.TableToJSON(body)

    PostRequest(url, json_body, headers, callback, nil, "application/json")
end

function discord.Deafen(plys, callback)
    local headers = GenerateDiscordHeaders()
    local url = GenerateURL("deafen")

    local body = {}

    if type(plys) ~= "table" then
        plys = {plys}
    end

    for i, ply in ipairs(plys) do
        local mapping = discord.GetMapping(ply)
        local id = mapping.discord_id
        local status = ply:GetDeafened()

        if id ~= nil and status ~= nil then
            table.insert(body, {
                ["id"] = id,
                ["status"] = status
            })
        end
    end

    local json_body = util.TableToJSON(body)

    PostRequest(url, json_body, headers, callback, nil, "application/json")
end

function discord.MoveChannel(ply, channelID, callback)
end

function discord.GetMute(ply)
end

function discord.GetDeafen(ply)
end

function discord.GetChannel(ply)
end

-- MAPPER
function discord.Map(ply, discord_id)
    if discord_id == nil then return end

    discord.mappings[ply:SteamID64String()] = discord_id
    discord.SaveMapping()
end

function discord.MapById(steam_id, discord_id)
    if steam_id == nil or discord_id == nil then return end

    discord.mappings[steam_id] = discord_id
    discord.SaveMapping()
end

function discord.Unmap(ply)
    discord.mappings[ply:SteamID64String()] = nil
    discord.SaveMapping()
end

function discord.UnmapById(steam_id)
    discord.mappings[steam_id] = nil
    discord.SaveMapping()
end

function discord.SaveMapping()
    if not discord.cache_enabled then return end

    local json = util.TableToJSON(discord.mappings, true)
    file.Write(discord.mapping_save_path .. ".json", json)
end

function discord.LoadMapping()
    local json_string = file.Read(discord.mapping_save_path .. ".json", "DATA") or "{}"

    discord.mappings = util.JSONToTable(json_string, false, true)
end

function discord.ClearMapping()
    discord.mappings = {}
    discord.SaveMapping()
end

function discord.AutoMap(ply, force)
    if ply:IsBot() then return end

    if not discord.auto_map_enabled and discord.ContainsMapping(ply) and not force then return end

    discord.GetDiscordId(ply, function(code, body, headers)
        local body = util.JSONToTable(body)

        if not body and not body.id then return end

        discord.Map(ply, body.id)
    end)
end

function discord.ContainsMapping(ply)
    return discord.mappings[ply:SteamID64String()] ~= nil
end