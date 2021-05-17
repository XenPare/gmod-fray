local time = Fray.Config.BabygodTime
hook.Add("PlayerInitialSpawn", "Fray Babygod", function(pl)
	pl:SetPos(Vector(9215.214844 + math.random(-256, 256), -1418.676636 + math.random(-256, 256), -3355.913574 + math.random(-256, 256)))
	if not pl:IsBot() then
		pl:SetNWBool("Babygod", true)
	end
end)

hook.Add("EntityTakeDamage", "Fray Babygod", function(ent, dmg)
	local trump = dmg:GetAttacker()
	if not (ent:IsPlayer() and trump:IsPlayer()) then
		return
	end
	if ent:GetNWBool("Babygod") or trump:GetNWBool("Babygod") then
		dmg:SetDamage(0)
	end
end)