local BetterHttp = {}


--[[
    onFailed - func
    onSuccess - func
    url - str
    headers - tbl
    body - str
    type - str
]]
BetterHttp.POST = function(url, body, onSuccess, onFailed, headers)

    local body_json = util.TableToJSON(body)
    logInfo(body_json)

    local http_tbl = {
        ["failed"] = onFailed,
        ["success"] = onSuccess,
        ["method"] = "POST",
        ["url"] = url,
        ["body"] = body_json,
        ["paramters"] = {},
        ["headers"] = headers,
        ["type"] = "application/json",
        ["timeout"] = 60
    }

    HTTP(http_tbl)
end




local function urlEncode(str)
    str = string.gsub(str, "([%%&=?+#<>\" ])", function(character)
        return string.format("%%%02X", string.byte(character))
    end)
    return str
end

local function tableToParams(tbl)
    if next(tbl) == nil or tbl == nil then
        return nil
    end

    local params = {}
    for key, value in pairs(tbl) do
        table.insert(params, urlEncode(key) .. "=" .. urlEncode(value))
    end
    return table.concat(params, "&")
end


function POSTRequest(url, body, headers, callback, retries)
    retries = retries or 3

    BetterHttp.POST(url, body,
        -- On Success
        function(res_code, res_body, res_headers)
            logInfo("POST Request to " .. url .. " returned code: " .. tostring(res_code))

            if res_code < 200 or res_code >= 300 then
                logWarning("Body: " .. res_body)
            end
            if callback ~= nil then
                callback(res_code, res_body, res_headers)
            end
        end,

        -- On Failure
        function(err)
            logError("POST Request to " .. url .. " failed! Retrying " .. retries .. " more time(s)")
            if retries > 0 then
                POSTRequest(url, body, headers, callback, retries - 1)
            end
        end,

        headers
    )
end

function GETRequest(url, path_param_tbl, headers, callback, retries)
    retries = retries or 3

    local path_param_str = tableToParams(path_param_tbl)

    local real_url = url

    if path_param_str then
        real_url = url .. "?" .. path_param_str
    end

    http.Fetch(real_url,
        -- On Success
        function(res_body, res_size, res_headers, res_code)
            logInfo("GET Request to " .. url .. " returned code: " .. tostring(res_code))
            if res_code < 200 or res_code >= 300 then
                logWarning("Body: " .. res_body)
            end
            if callback ~= nil then
                callback(res_body, res_size, res_headers, res_code)
            end
        end,

        -- On Failure
        function(err)
            logError("GET Request to " .. real_url .. " failed! Retrying " .. retries .. " more time(s)")
            if retries > 0 then
                GETRequest(url, path_param_tbl, headers, callback, retries - 1)
            end
        end,

        headers
    )
end
