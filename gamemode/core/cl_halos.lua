local active = {}
net.Receive("Fray Broadcast Loot", function()
	active = net.ReadTable()
end)

local usable = {
	"fray_deliver",
	"fray_weapon"
}

local inv = nil
local m_rg = Color(153, 66, 69)
hook.Add("PreDrawHalos", "Fray Halos", function()
	halo.Add(active, color_white, 1, 1, 2)
	halo.Add(ents.FindByClass("prop_ragdoll") , m_rg, 1, 1, 2)
	for _, class in pairs(usable) do
		halo.Add(ents.FindByClass(class), color_white, 1, 1, 2)
	end
end)