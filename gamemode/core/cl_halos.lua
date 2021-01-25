local usable = {
	["fray_deliver"] = true
}

local inv = nil
local color_green = Color(23, 117, 6)
hook.Add("PreDrawHalos", "Fray Halos", function()
	if inv == nil and Fray.InventoryList then
		inv = Fray.InventoryList
	end
	if inv ~= nil then
		for class in pairs(inv) do
			halo.Add(ents.FindByClass(class), color_white, 1, 1, 2)
		end
	end
	for class in pairs(usable) do
		halo.Add(ents.FindByClass(class), color_green, 1, 1, 2)
	end
end)