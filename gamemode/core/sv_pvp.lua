local time = Fray.Config.PvPModeTime
hook.Add("EntityTakeDamage", "Fray PvP Mode", function(victim, dmg)
	if not IsValid(victim) or not victim:IsPlayer() or victim:IsBot() or victim:GetNWBool("Babygod") then
		return
	end

	local attacker = dmg:GetAttacker()
	if not IsValid(attacker) or not attacker:IsPlayer() or attacker:GetNWBool("Babygod") then
		return
	end

	--[[
		Victim
	]]

	if victim:TimerExists("Fray PvP") then
		victim:RemoveTimer("Fray PvP")
	end

	if not victim:GetNWBool("Fray PvP") then
		victim:ChatPrint(Fray.GetPhrase("pvp_entered", victim))
	end
	
	victim:SetNWBool("Fray PvP", true)
	victim:SetTimer("Fray PvP", time, 1, function()
		victim:SetNWBool("Fray PvP", false)
	end)

	--[[
		Attacker
	]]

	if attacker:TimerExists("Fray PvP") then
		attacker:RemoveTimer("Fray PvP")
	end

	if not attacker:GetNWBool("Fray PvP") then
		attacker:ChatPrint(Fray.GetPhrase("pvp_entered", attacker))
	end

	attacker:SetNWBool("Fray PvP", true)
	attacker:SetTimer("Fray PvP", time, 1, function()
		attacker:SetNWBool("Fray PvP", false)
	end)
end)

hook.Add("PlayerDeath", "Fray PvP Mode", function(pl)
	pl:SetNWBool("Fray PvP", false)
end)

hook.Add("PlayerDisconnected", "Fray PvP Mode", function(pl)
	if not pl:GetNWBool("Fray PvP") or not pl:Alive() then
		return
	end
	
	if pl:TimerExists("Fray PvP") then
		pl:RemoveTimer("Fray PvP")
	end

	local rg = Fray.CreateRagdoll(pl)
	rg.Inventory = table.Copy(pl.Inventory)

	pl:ClearInventory()
	pl:SetThirst(100)
	pl:SetHunger(100)
	pl:SetPData("Health", 100)
end)