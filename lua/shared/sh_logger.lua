include("shared/sh_globals.lua")

function containsLogLevel(log_level)
    local log_level_string = getDebugLogLevels()

    local log_levels = {}
    for match in (log_level_string .. '|'):gmatch("(.-)" .. '|') do
        log_levels[match] = true
    end

    return log_levels[log_level] ~= nil
end

function printLog(log_level, msg)
    if not containsLogLevel(log_level) or not debugEnabled() then
        return
    end

    log_message = string.format("[DTTT %s]: %s", log_level, msg)

    if debugTimestampEnabled() then
        local current_time = os.date("%Y-%m-%d %H:%M:%S")
        log_message = string.format("[%s] %s", current_time, log_message)
    end

    print(log_message)
end

function logInfo(msg)
    printLog("INFO", msg)
end

function logWarning(msg)
    printLog("WARNING", msg)
end

function logDebug(msg)
    printLog("DEBUG", msg)
end

function logError(msg)
    printLog("ERROR", msg)
end

function logTable(tbl, tbl_name)
    if not debugEnabled() then
        return
    end

    logDebug("Printing table: " .. tbl_name)
    PrintTable(tbl)
end
