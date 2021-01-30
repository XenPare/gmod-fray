local ids = {"vest", "bicep", "forearm", "calf", "thigh"}
hook.Add("PostPlayerSpawn", "Fray Body Armor", function(pl)
	for _, id in pairs(ids) do
		if pl:HasInventoryItem("fray_ba_" .. id) then 
			pl:SetBodyArmor(id, true)
		end
	end
end)