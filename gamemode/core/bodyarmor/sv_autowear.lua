local ids = {"vest", "bicep", "forearm", "calf", "thigh"}
hook.Add("PlayerInitialSpawn", "Fray Body Armor", function(pl)
	timer.Simple(0.5, function()
		for _, id in pairs(ids) do
			if pl:HasInventoryItem("fray_ba_" .. id) then 
				pl:SetBodyArmor(id, true)
			end
		end
	end)
end)