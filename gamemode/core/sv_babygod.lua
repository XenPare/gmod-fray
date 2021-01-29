local time = Fray.Config.BabygodTime
hook.Add("PlayerInitialSpawn", "Fray Babygod", function(pl)
	pl:SetNWBool("Babygod", true)
	pl:SetSimpleTimer(time, function()
		pl:SetNWBool("Babygod", false)
	end)
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