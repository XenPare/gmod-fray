hook.Add("EntityTakeDamage", "Fray Health", function(ent, dmg)
	if not ent:IsPlayer() then
		return
	end
	ent:SetPData("Health", ent:Health() - dmg:GetDamage())
end)

hook.Add("PlayerDeath", "Fray Health", function(pl)
	pl:SetPData("Health", 100)
end)

hook.Add("PlayerInitialSpawn", "Fray Health", function(pl)
	pl:SetSimpleTimer(1, function()
		pl:SetHealth(tonumber(pl:GetPData("Health", 100)))
	end)
end)