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

    http.Post(url, body,
        -- On Success
        function(res_body, res_size, res_headers, res_code)
            if callback ~= nil then
                callback(res_body, res_size, res_headers, res_code)
            end
        end,

        -- On Failure
        function(err)
            if retries > 0 then
                POSTRequest(url, body, headers, callback, retries - 1)
            end
        end,

        headers
    )
end

function GETRequest(url, path_param_tbl, headers, callback, retries)
    retries = retries - 1

    local path_param_str = tableToParams(path_param_tbl)

    if path_param_str then
        url = url .. "?" .. path_param_str
    end

    http.Fetch(url,
        -- On Success
        function(res_body, res_size, res_headers, res_code)
            if callback ~= nil then
                callback(res_body, res_size, res_headers, res_code)
            end
        end,

        -- On Failure
        function(err)
            if retries > 0 then
                GETRequest(url, path_param_tbl, headers, callback, retries - 1)
            end
        end,

        headers
    )
end
