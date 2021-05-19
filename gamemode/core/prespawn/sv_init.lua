local time = Fray.Config.BabygodTime

local def_run = Fray.Config.RunSpeed
local def_jump = Fray.Config.JumpPower

util.AddNetworkString("Fray Spawn")

net.Receive("Fray Spawn", function(_, pl)
	if pl.Spawned then
		return
	end

	pl.Spawned = true
	pl:Spawn()
	pl:SetNWBool("Babygod", true)

	pl:SetRunSpeed(def_run - pl:CalculateInventoryWeight())
	pl:SetJumpPower(def_jump - (math.Round(pl:CalculateInventoryWeight() / 2)))

	hook.Call("PostPlayerSpawn", GAMEMODE, pl)

	pl:SetSimpleTimer(time, function()
		pl:SetNWBool("Babygod", false)
	end)
	
	pl:SetSimpleTimer(30, function()
		Fray.LanguagePropose(pl)
	end)
end)