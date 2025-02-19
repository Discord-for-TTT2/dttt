dttt_logger = dttt_logger or {}

dttt_logger.log_levels = dttt_logger.log_levels or ""
dttt_logger.log_timestamp = dttt_logger.log_timestamp or true
dttt_logger.enabled = dttt_logger.enabled or false

function dttt_logger.SetLogLevels(log_levels)
    dttt_logger.log_levels = log_levels
end

function dttt_logger.SetLogTimestamp(log_timestamp)
    dttt_logger.log_timestamp = log_timestamp
end

function dttt_logger.SetEnabled(enabled)
    dttt_logger.enabled = enabled
end

function dttt_logger.ContainsLogLevel(log_level)
    local log_levels = {}
    for match in (dttt_logger.log_levels .. '|'):gmatch("(.-)" .. '|') do
        log_levels[match] = true
    end

    return log_levels[log_level] ~= nil
end

function dttt_logger.PrintLog(log_level, msg, bypass_checks)
    bypass_checks = bypass_checks or false

    if (not dttt_logger.ContainsLogLevel(log_level) or not dttt_logger.enabled) and not bypass_checks then
        return
    end

    log_message = string.format("[DTTT %s]: %s", log_level, msg)

    if dttt_logger.log_timestamp then
        local current_time = os.date("%Y-%m-%d %H:%M:%S")
        log_message = string.format("[%s] %s", current_time, log_message)
    end

    print(log_message)
end

function dttt_logger.Info(msg)
    dttt_logger.PrintLog("INFO", msg)
end

function dttt_logger.Warning(msg)
    dttt_logger.PrintLog("WARNING", msg)
end

function dttt_logger.Debug(msg)
    dttt_logger.PrintLog("DEBUG", msg)
end

function dttt_logger.Error(msg)
    dttt_logger.PrintLog("ERROR", msg)
end

function dttt_logger.Force(msg)
    dttt_logger.PrintLog("FORCE", msg, true)
end