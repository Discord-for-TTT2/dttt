local ID_CACHE_FILE_NAME = "discord_connection_cache"

function getFullFileName()
    return ID_CACHE_FILE_NAME .. ".json"
end

function writeIdCache()
    local json_str = util.TableToJSON(_G.dttt_id_mapping, true)

    file.Write(getFullFileName(), json_str)

    local written_connections = readIdCache()

    if written_connections == util.TableToJSON(_G.dttt_id_mapping, true) then
        logInfo("ID Cache written to " .. getFullFileName())
    else
        logError("Written Cache and current Mappings dont match!")
    end
end

function readIdCache()
    local json_str = file.Read(getFullFileName(), "DATA")

    if not json_str then
        logError("Something went wrong while reading " .. getFullFileName())
        return "{}"
    end

    return json_str
end

function loadIdCache()
    local cache = readIdCache()
    _G.dttt_id_mapping = util.JSONToTable(cache, false, true)

    logTable(_G.dttt_id_mapping, "Discord ID Cache")
end

function backupIdCache()
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")

    local file_name = ID_CACHE_FILE_NAME .. "-" .. timestamp .. ".json"
    local json_str = util.TableToJSON(_G.dttt_id_mapping, true)

    file.Write(file_name, json_str)
end