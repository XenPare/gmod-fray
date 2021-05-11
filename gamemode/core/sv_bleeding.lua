timer.Create("Fray Bleeding", 3, 0, function()
	for _, pl in pairs(player.GetAll()) do
		if pl:GetNWBool("Fray Bleeding") then
			pl:TakeDamage(math.random(1, 3), pl)
		end
	end
end)

local chance = Fray.Config.BleedingChance
hook.Add("EntityTakeDamage", "Fray Bleeding", function(pl, inf)
	if not pl:IsPlayer() or not (inf:IsDamageType(DMG_BULLET) or inf:IsExplosionDamage()) then
		return
	end
	if math.random(1, 100) <= chance and not pl:GetNWBool("Fray Bleeding") then
		pl:SetNWBool("Fray Bleeding", true)
	end
end)