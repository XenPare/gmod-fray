local r_time = Fray.Config.RespawnTime

util.AddNetworkString("Fray Respawn")
util.AddNetworkString("Fray Respawn Remove")

hook.Add("PlayerDeath", "Fray Respawn", function(pl)
	pl.DeadTime = RealTime()
	net.Start("Fray Respawn")
	net.Send(pl)
end)

hook.Add("PlayerDeathThink", "Fray Respawn", function(pl)
	if pl.DeadTime and RealTime() - pl.DeadTime < r_time then
		return false
	end
end)

local tries = {0.1, 1.5}
hook.Add("PlayerSpawn", "Fray Respawn", function(pl)
	for _, try in pairs(tries) do
		pl:SetSimpleTimer(try, function()
			net.Start("Fray Respawn Remove")
			net.Send(pl)
		end)
	end	
end)