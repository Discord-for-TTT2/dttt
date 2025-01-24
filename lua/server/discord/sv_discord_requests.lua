include("server/utils/sv_requests.lua")
include("server/utils/sv_helper.lua")

local function generateDiscordHeaders()
    local bot_api_key = GetConVar("dttt_bot_api_key"):GetString()

    return {
        ["Authorization"] = "Basic " .. bot_api_key,
    }
end

local function generateUrl(request)
    local bot_endpoint = GetConVar("dttt_bot_endpoint"):GetString()

    return bot_endpoint .. "/" .. request
end

function postMuteRequest(ply, mute_status, callback)
    local discord_id = getMappedId(ply)

    if discord_id == nil or mute_status == nil then
        return
    end

    local headers = generateDiscordHeaders()
    local body = {
        ["id"] = discord_id,
        ["status"] = tostring(mute_status)
    }

    local url = generateUrl("mute")

    POSTRequest(url, body, headers, callback)
end

function postMuteAllRequest(tbl, status, callback)
end

function getIdRequest(ply, callback)
    local params = {
        name = ply:Name(),
        nick = ply:Nick()
    }

    local headers = generateDiscordHeaders()
    local url = generateUrl("id")

    GETRequest(url, params, headers, callback)
end