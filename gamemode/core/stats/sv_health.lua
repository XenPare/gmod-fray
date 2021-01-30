hook.Add("EntityTakeDamage", "Fray Health", function(ent, dmg)
	if not ent:IsPlayer() then
		return
	end
	ent:SetPData("Health", math.Round(ent:Health() - dmg:GetDamage()))
end)

hook.Add("PlayerDeath", "Fray Health", function(pl)
	pl:SetPData("Health", 100)
end)

hook.Add("PostPlayerSpawn", "Fray Health", function(pl)
	pl:SetHealth(tonumber(pl:GetPData("Health", 100)))
end)