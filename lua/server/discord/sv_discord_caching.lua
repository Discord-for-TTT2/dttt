local ID_CACHE_FILE = "discord_connection_cache"

local function getFileName()
    return ID_CACHE_FILE .. ".json"
end

function writeIdCache()
    local json_str = util.TableToJSON(g_dttt_discord_mapping, true)

    file.Write(getFileName(), json_str)

    local written_connections = readIdCache()

    if written_connections == util.TableToJSON(g_dttt_discord_mapping, true) then
        print("ID Cache written to " .. getFileName())
    else
        print("Written Cache and current Mappings dont match!")
    end
end

function readIdCache()
    local json_str = file.Read(getFileName(), "DATA")

    if not json_str then
        print("Something went wrong while reading " .. getFileName())
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