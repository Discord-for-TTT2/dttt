util.AddNetworkString("dttt_cl_get_mapping")
util.AddNetworkString("dttt_cl_get_states")

local function addReceiver(name, callback)
    util.AddNetworkString(name)
    net.Receive(name, function(len, ply) callback(len, ply) end)
end

local function isSuperAdmin(ply)
    return ply:IsSuperAdmin() and not ply:IsBot()
end

addReceiver("dttt_sv_get_mapping", function(len, ply)
    if not isSuperAdmin(ply) then return end

    net.Start("dttt_cl_get_mapping")
    net.WriteTable(discord.GetMappings())
    net.Send(ply)
end)

addReceiver("dttt_sv_map_player", function(len, ply)
    local steam_id = net.ReadString()
    if not steam_id then return end

    local map_ply = player.GetBySteamID64(steam_id)

    if not map_ply then return end

    discord.AutoMap(map_ply, true)
end)

addReceiver("dttt_sv_set_mapping", function(len, ply)
    if not isSuperAdmin(ply) then return end

    local steam_id = net.ReadString()
    local discord_id = net.ReadString()

    discord.MapById(steam_id, discord_id)
end)