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

function dttt_logger.Info(msg, log_level_override)
    if not dttt_logger.log_info then return end
    log_level_override = log_level_override or "INFO"

    dttt_logger.PrintLog(log_level_override, msg)
end

function dttt_logger.Warning(msg, log_level_override)
    if not dttt_logger.log_warning then return end
    log_level_override = log_level_override or "WARNING"

    dttt_logger.PrintLog(log_level_override, msg)
end

function dttt_logger.Debug(msg, log_level_override)
    if not dttt_logger.log_debug then return end
    log_level_override = log_level_override or "DEBUG"

    dttt_logger.PrintLog(log_level_override, msg)
end

function dttt_logger.Error(msg, log_level_override)
    if not dttt_logger.log_error then return end
    log_level_override = log_level_override or "ERROR"

    dttt_logger.PrintLog(log_level_override, msg)
end

function dttt_logger.Force(msg, log_level_override)
    log_level_override = log_level_override or "INFO"
    dttt_logger.PrintLog(log_level_override, msg)
end