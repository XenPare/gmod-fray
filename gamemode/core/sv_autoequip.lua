hook.Add("PostPlayerSpawn", "Fray Autoequip", function(pl)
	for _, class in pairs(pl.Inventory) do
		if Fray.InventoryList[class].category == FRAY_CATEGORY_WEAPONS and Fray.InventoryList[class].EquipFunc then
			Fray.InventoryList[class].EquipFunc(pl)
		end
	end
end)