include("server/utils/sv_requests.lua")

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

function postMuteRequest(player_tbl, callback)
    local headers = generateDiscordHeaders()
    local url = generateUrl("mute")
    local body = {}

    logInfo("MUTE PLAYER TABLE")
    logInfo(type(player_tbl))

    if type(player_tbl) == "table" then
        logInfo("PLAYER_TBL IS TABLE")
        for i, ply in ipairs(player_tbl) do
            logInfo(ply:Nick())
            local id = getMappedId(ply)
            local status = getMuteState(ply)

            table.insert(body, {
                ["id"] = tostring(id),
                ["status"] = tostring(status)
            })

            print(#body)
            PrintTable(body[i])
        end
    else
        logInfo("SINGLE PLAYER")
        local id = getMappedId(player_tbl)
        local status = getMuteState(player_tbl)

        table.insert(body, {
            ["id"] = tostring(id),
            ["status"] = tostring(status)
        })
    end

    PrintTable(body)

    POSTRequest(url, body, headers, callback)
end

function postDeafenRequest(player_tbl, callback)

    local headers = generateDiscordHeaders()
    local url = generateUrl("deafen")
    local body = {}

    if type(player_tbl) == "table" then
        for _, ply in ipairs(player_tbl) do
            local id = getMappedId(ply)
            local status = getMuteState(ply)

            table.insert(body, {
                ["id"] = tostring(id),
                ["status"] = tostring(status)
            })
        end
    else
        local id = getMappedId(player_tbl)
        local status = getMuteState(player_tbl)

        table.insert(body, {
            ["id"] = tostring(id),
            ["status"] = tostring(status)
        })
    end

    POSTRequest(url, body, headers, callback)
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

function postSyncRequest()
    local headers = generateDiscordHeaders()
    local url = generateUrl("mute")
end