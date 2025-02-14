local Request = {}

function Request.post(url, body, params, headers, on_success, on_failure, content_type, retries, timeout)
    content_type = content_type or "text/plain; charset=utf-8"
    timeout = timeout or 60
    retries = retries or 3

    logInfo("Sending POST request to " .. url)
    local req = {
        ["failed"] = function(err)
            logError("Request to " .. url .. " failed!")
            if on_failure ~= nil then
                on_failure(err)
            end
            if retries > 0 then
                logDebug("Retrying " .. tostring(retries) .. " more time(s)")
                Request.post(url, body, params, headers, on_success, on_failure, content_type, retries-1, timeout)
            end
        end,
        ["success"] = function(res_code, res_body, res_headers)
            logInfo("Request to " .. url .. " returned code " .. tostring(res_code))
            if on_success ~= nil then
                on_success(res_code, res_body, res_headers)
            end
        end,
        ["method"] = "POST",
        ["url"] = url,
        ["parameters"] = params,
        ["headers"] = headers,
        ["body"] = body,
        ["type"] = content_type,
        ["timeout"] = timeout
    }

    HTTP(req)
end

function Request.get(url, params, headers, on_success, on_failure, retries, timeout)
    timeout = timeout or 60
    retries = retries or 3

    logInfo("Sending GET request to " .. url)
    local req = {
        ["failed"] = function(err)
            logError("Request to " .. url .. " failed!")
            if on_failure ~= nil then
                on_failure(err)
            end
            if retries > 0 then
                logDebug("Retrying " .. tostring(retries) .. " more time(s)")
                Request.get(url, params, headers, on_success, on_failure, retries-1, timeout)
            end
        end,
        ["success"] = function(res_code, res_body, res_headers)
            logInfo("Request to " .. url .. " returned code " .. tostring(res_code))
            if on_success ~= nil then
                on_success(res_code, res_body, res_headers)
            end
        end,
        ["method"] = "GET",
        ["url"] = url,
        ["parameters"] = params,
        ["headers"] = headers,
        ["timeout"] = timeout
    }

    HTTP(req)
end

-- DISCORD REQUESTS --

local DiscordRequests = {}

-- Misc --

function DiscordRequests.generateHeaders()
    return {
        ["Authorization"] = "Basic " .. GetConVar("dttt_bot_api_key"):GetString()
    }
end

function DiscordRequests.generateUrl(route)
    return GetConVar("dttt_bot_endpoint"):GetString() .. "/" .. route
end

-- POST --

function DiscordRequests.mute(plys, callback)
    local headers = DiscordRequests.generateHeaders()
    local url = DiscordRequests.generateUrl("mute")

    local body = {}

    if type(plys) ~= "table" then
        plys = {plys}
    end

    for i, ply in ipairs(plys) do
        local id = g_discord_mapper.getMapping(ply)
        local status = g_player_state_manager.getMuted(ply)

        if id ~= nil and status ~= nil then
            table.insert(body, {
                ["id"] = id,
                ["status"] = status
            })
        end
    end

    local json_body = util.TableToJSON(body)

    Request.post(url, json_body, {}, headers, callback, nil, "application/json")
end

function DiscordRequests.deafen(plys, callback)
    local headers = DiscordRequests.generateHeaders()
    local url = DiscordRequests.generateUrl("deafen")

    local body = {}

    if type(plys) ~= "table" then
        plys = {plys}
    end

    for i, ply in ipairs(plys) do
        local id = g_discord_mapper.getMapping(ply)
        local status = g_player_state_manager.getDeafened(ply)

        if id ~= nil and status ~= nil then
            table.insert(body, {
                ["id"] = id,
                ["status"] = status
            })
        end
    end

    local json_body = util.TableToJSON(body)

    Request.post(url, json_body, {}, headers, callback, nil, "application/json")
end

function DiscordRequests.getDiscordId(ply, callback)
    local headers = DiscordRequests.generateHeaders()
    local url = DiscordRequests.generateUrl("id")
    local params = {
        ["nick"] = ply:Nick(),
        ["name"] = ply:Name()
    }

    Request.get(url, params, headers, callback)
end

return DiscordRequests