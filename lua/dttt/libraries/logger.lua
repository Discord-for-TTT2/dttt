dttt_logger = dttt_logger or {}

dttt_logger.log_timestamp = dttt_logger.log_timestamp or true
dttt_logger.enabled = dttt_logger.enabled or false

dttt_logger.log_info = dttt_logger.log_info or false
dttt_logger.log_warning = dttt_logger.log_warning or false
dttt_logger.log_debug = dttt_logger.log_debug or true
dttt_logger.log_error = dttt_logger.log_error or true

function dttt_logger.SetLogTimestamp(log_timestamp)
    dttt_logger.log_timestamp = log_timestamp
end

function dttt_logger.SetEnabled(enabled)
    dttt_logger.enabled = enabled
end

function dttt_logger.PrintLog(log_level, msg, bypass_checks)
    bypass_checks = bypass_checks or false

    if not dttt_logger.enabled and not bypass_checks then
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
    if not dttt_logger.log_info then return end
    dttt_logger.PrintLog("INFO", msg)
end

function dttt_logger.Warning(msg)
    if not dttt_logger.log_warning then return end
    dttt_logger.PrintLog("WARNING", msg)
end

function dttt_logger.Debug(msg)
    if not dttt_logger.log_debug then return end
    dttt_logger.PrintLog("DEBUG", msg)
end

function dttt_logger.Error(msg)
    if not dttt_logger.log_error then return end
    dttt_logger.PrintLog("ERROR", msg)
end

function dttt_logger.Force(msg)
    dttt_logger.PrintLog("FORCE", msg, true)
end