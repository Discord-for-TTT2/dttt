function cvars.ServerConVarGetInt(cvar, callback)
    cvars.ServerConVarGetValue(cvar, function(exists, value, defualt)
        if not exists then callback(nil) end

        callback(cvar, tonumber(value), tonumber(default))
    end)
end

function cvars.ServerConVarGetBool(cvar, callback)
    cvars.ServerConVarGetValue(cvar, function(exsits, value, default)
        if not exsits then callback(nil) end

        local converted = (value == "true" or value == "1")
        local converted_default = (default == "true" or default == "1")
        callback(cvar, converted, converted_default)
    end)
end

function cvars.ServerConVarGetString(cvar, callback)
    cvars.ServerConVarGetValue(cvar, function(exsits, value, default)
        if not exsits then callback(nil) end

        callback(cvar, tostring(value), tostring(default))
    end)
end

function cvars.ServerConVarReset(cvar)
    cvars.ServerconVarGetValue(cvar, function(exists, value, default)
        if not exists then return end

        cvars.ChangeServerConVar(cvar, default)
    end)
end

function cvars.ChangeBoolServerConVar(cvar, value)
    if value then
        value = "1"
    else
        value = "0"
    end

    cvars.ChangeServerConVar(cvar, value)
end