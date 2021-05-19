local time = Fray.Config.PvPModeTime
hook.Add("EntityTakeDamage", "Fray PvP Mode", function(victim, dmg)
	if victim:IsBot() or not victim:IsPlayer() then
		return
	end

	local attacker = dmg:GetAttacker()
	if not IsValid(attacker) or not attacker:IsPlayer() then
		return
	end

	--[[
		Victim
	]]

	if victim:TimerExists("Fray PvP") then
		victim:RemoveTimer("Fray PvP")
	end

	victim:SetNWBool("Fray PvP", true)
	victim:ChatPrint(Fray.GetPhrase("pvp_entered", victim))
	victim:SetTimer("Fray PvP", time, 1, function()
		victim:SetNWBool("Fray PvP", false)
	end)

	--[[
		Attacker
	]]

	if attacker:TimerExists("Fray PvP") then
		attacker:RemoveTimer("Fray PvP")
	end

	attacker:SetNWBool("Fray PvP", true)
	attacker:ChatPrint(Fray.GetPhrase("pvp_entered", attacker))
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