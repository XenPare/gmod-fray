hook.Add("PlayerInitialSpawn", "Fray Body Armor", function(pl)
	if pl:HasInventoryItem("fray_ba_vest") then
		pl:SetBodyArmor("vest", true)
	end
	if pl:HasInventoryItem("fray_ba_calf") then
		pl:SetBodyArmor("calf", true)
	end
	if pl:HasInventoryItem("fray_ba_bicep") then
		pl:SetBodyArmor("bicep", true)
	end
	if pl:HasInventoryItem("fray_ba_forearm") then
		pl:SetBodyArmor("forearm", true)
	end
	if pl:HasInventoryItem("fray_ba_thigh") then
		pl:SetBodyArmor("thigh", true)
	end
end)