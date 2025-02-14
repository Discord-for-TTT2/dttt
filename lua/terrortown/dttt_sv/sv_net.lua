util.AddNetworkString("dttt_cl_get_mapping")
util.AddNetworkString("dttt_cl_get_states")

local function addReceiver(name, callback)
    util.AddNetworkString(name)
    net.Receive(name, function(len, ply) callback(len, ply) end)
end

local function isSuperAdmin(ply)
    return ply:IsSuperAdmin() and not ply:IsBot()
end

addReceiver("dttt_sv_change_discord_id", function(len, ply)
    if not isSuperAdmin(ply) then return end

    local steam_id = net.ReadString()
    local discord_id = net.ReadString()

    g_discord_mapper.addMappingById(steam_id, discord_id)
end)

addReceiver("dttt_sv_run_automapper", function(len, ply)
    if not isSuperAdmin(ply) then return end

    local steam_id = net.ReadString()

    local ply = player.GetBySteamID64(steam_id)

    if ply then
        g_discord_mapper.autoMap(ply, true)
    end
end)

addReceiver("dttt_sv_get_mapping", function(len, ply)
    if not isSuperAdmin(ply) then return end

    net.Start("dttt_cl_get_mapping")
    net.WriteTable(g_discord_mapper.getAllMappings())
    net.Send(ply)
end)

addReceiver("dttt_sv_get_states", function(len, ply)
    if not isSuperAdmin(ply) then return end

    net.Start("dttt_cl_get_states")
    net.WriteTable({
        muted = g_player_state_manager.getAllMuted(),
        deafened = g_player_state_manager.getAllMuted()
    })
    net.Send(ply)
end)