local active = {}
net.Receive("Fray Broadcast Loot", function()
	active = net.ReadTable()
end)

local dropped = {}
hook.Add("OnEntityCreated", "Fray Halos", function(ent)
	if not Fray.InventoryList[ent:GetClass()] then
		return
	end
	table.insert(dropped, ent)
end)

local inv = nil
local m_rg = Color(153, 66, 69)
hook.Add("PreDrawHalos", "Fray Halos", function()
	halo.Add(active, color_white, 1, 1, 2)
	halo.Add(dropped, color_white, 1, 1, 2)
	halo.Add(ents.FindByClass("prop_ragdoll") , m_rg, 1, 1, 2)
	halo.Add(ents.FindByClass("fray_deliver") , color_white, 1, 1, 2)
end)