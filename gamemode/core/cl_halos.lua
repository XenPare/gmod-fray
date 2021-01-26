local usable = {
	"fray_deliver"
}

local inv = Fray.Config.Loot
local color_green = Color(23, 117, 6)
hook.Add("PreDrawHalos", "Fray Halos", function()
	for _, class in pairs(inv) do
		halo.Add(ents.FindByClass(class), color_white, 1, 1, 2)
	end
	for _, class in pairs(usable) do
		halo.Add(ents.FindByClass(class), color_green, 1, 1, 2)
	end
end)