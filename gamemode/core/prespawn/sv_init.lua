local time = Fray.Config.BabygodTime

util.AddNetworkString("Fray Spawn")

net.Receive("Fray Spawn", function(_, pl)
	pl.Spawned = true
	pl:Spawn()
	pl:SetNWBool("Babygod", true)

	pl:SetSimpleTimer(time, function()
		pl:SetNWBool("Babygod", false)
	end)
	
	pl:SetSimpleTimer(30, function()
		Fray.LanguagePropose(pl)
	end)
end)