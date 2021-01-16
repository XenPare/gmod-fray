hook.Add("PreDrawHalos", "Fray Halos", function()
	for class, _ in pairs(Fray.InventoryList) do
		halo.Add(ents.FindByClass(class), color_white, 1, 1, 2)
	end
end)