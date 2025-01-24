include("shared/sh_globals.lua")
include("server/sv_globals.lua")
include("server/utils/sv_general.lua")
include("shared/sh_logger.lua")

function pathParamsToString(path_params)
    local param_strings = {}

    local out = ""

    for key, value in pairs(path_params) do
        table.insert(param_strings, key .. "=" .. value)
    end

    for i, value in ipairs(param_strings) do
        if i == 1 then
            out = out .. "?"
        end

        out = out .. value

        if i < #param_strings then
            out = out .. "&"
        end
    end

    return out
end

function discordGetRequest(request, callback, path_params, retries)
    local bot_endpoint = getBotEndpoint()
    local bot_api_key = getBotApiKey()

    local tries = retries or 3

    local url = bot_endpoint .. "/" .. request .. pathParamsToString(path_params)

    logInfo("Trying to send GET request to " .. url)
    http.Fetch(url,

        -- On Success
        function(res_body, res_size, res_headers, res_code)
            logDebug("Request " .. request .. " returned code: " .. tostring(res_code))
            if callback ~= nil then
                callback(res_body, res_size, res_headers, res_code)
            end
        end,

        -- On Failure
        function(err)
            logError("Request Error: " .. tostring(err) .. " | Retrying " .. tostring(tries) .. " more time(s)")
            if tries > 0 then
                discordGetRequest(request, callback, path_params, tries - 1)
            end
        end,

        -- Headers
        {
            ["Authorization"] = "Basic " .. bot_api_key,
        }
    )
end

function discordPostRequest(request, callback, body, retries)
    local bot_endpoint = getBotEndpoint()
    local bot_api_key = getBotApiKey()

    local tries = retries or 3

    local url = bot_endpoint .. "/" .. request

    logInfo("Trying to send POST request to " .. url)
    http.Post(url, body,

        -- On Success
        function (res_body, res_size, res_headers, res_code)
            logDebug("Request " .. request  .. " returned code: " .. tostring(res_code))
            if callback ~= nil then
                callback(res_body, res_size, res_headers, res_code)
            end
        end,

        -- On Failure
        function(err)
            logError("Request Error: " .. tostring(err) .. " | Retrying " .. tostring(tries) .. " more time(s)")
            if tries > 0 then
                discordPostRequest(request, callback, body, tries - 1)
            end
        end,

        -- Headers
        {
            ["Authorization"] = "Basic " .. bot_api_key,
        }
    )
end

function mutePlayerRequest(ply, mute_status, callback)
    local discord_id = getIdMappingByPlayer(ply)

    if tostring(discord_id) == "nil" then
        logDebug("Player " .. ply:Nick() .. " doesnt have an Discord ID yet")
        return
    end

    local body = {
        ["id"] = tostring(discord_id),
        ["status"] = tostring(mute_status)
    }

    discordPostRequest(REQUESTS.MUTE, callback, body)
end

function getDiscordIdRequest(ply, callback)
    local path_params = {
        name = ply:Name(),
        nick = ply:Nick()
    }

    discordGetRequest(REQUESTS.GET_DISCORD_ID, callback, path_params)
end