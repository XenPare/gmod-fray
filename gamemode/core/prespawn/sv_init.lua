local time = Fray.Config.BabygodTime

util.AddNetworkString("Fray Spawn")

net.Receive("Fray Spawn", function(_, pl)
	if pl.Spawned then
		return
	end

	pl.Spawned = true
	pl:Spawn()
	pl:SetNWBool("Babygod", true)

	hook.Call("PostPlayerSpawn", GAMEMODE, pl)

	pl:SetSimpleTimer(time, function()
		pl:SetNWBool("Babygod", false)
	end)
	
	pl:SetSimpleTimer(30, function()
		Fray.LanguagePropose(pl)
	end)
end)