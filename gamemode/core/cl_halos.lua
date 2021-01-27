local usable = {
	"fray_deliver",
	"fray_weapon"
}

local inv = nil
hook.Add("PreDrawHalos", "Fray Halos", function()
	if inv == nil and Fray.InventoryList then		
		inv = Fray.InventoryList
	end
	if inv ~= nil then
		for class in pairs(inv) do
			halo.Add(ents.FindByClass(class), color_white, 1, 1, 2)
		end
	end
	for _, class in pairs(usable) do
		halo.Add(ents.FindByClass(class), color_white, 1, 1, 2)
	end
end)