hook.Add("InitPostEntity", "Fray", function()
	for _, ent in pairs(ents.GetAll()) do
		if ent:GetClass() == "prop_physics" then
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableMotion(false)
			end
		end
	end
end)

hook.Add("EntityTakeDamage", "Fray", function(target, dmg)
	if target:GetClass() == "prop_physics" then
		dmg:SetDamage(0)
	end
end)