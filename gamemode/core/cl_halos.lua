local active = {}
net.Receive("Fray Broadcast Loot", function()
	active = net.ReadTable()
end)

local white, red = {
	["fray_deliver"] = true
}, {
	["prop_ragdoll"] = true
}
local post, _post = {}, {}
hook.Add("OnEntityCreated", "Fray Halos", function(ent)
	if ent:IsWeapon() or table.HasValue(active, ent) then
		return
	end
	if white[ent:GetClass()] or table.HasValue(Fray.Config.Loot, ent:GetClass()) or Fray.InventoryList[ent:GetClass()] or Fray.ShopList[ent:GetClass()] then
		table.insert(post, ent)
	end
	if red[ent:GetClass()] then
		table.insert(_post, ent)
	end
end)

hook.Add("EntityRemoved", "Fray Halos", function(ent)
	if not (white[ent:GetClass()] or red[ent:GetClass()]) then
		return
	end
	if table.HasValue(post, ent) then
		table.RemoveByValue(post, ent)
	end
	if table.HasValue(_post, ent) then
		table.RemoveByValue(_post, ent)
	end
end)

timer.Create("Fray Delete NULL Halos", 15, 0, function()
	for i = 1, #post do
		if not IsValid(post[i]) then
			post[i] = nil
		end
	end
	for i = 1, #_post do
		if not IsValid(_post[i]) then
			_post[i] = nil
		end
	end
end)

local color_red = Color(153, 66, 69)
hook.Add("PreDrawHalos", "Fray Halos", function()
	halo.Add(active, color_white, 1, 1, 2)
	halo.Add(post, color_white, 1, 1, 2)
	halo.Add(_post, color_red, 1, 1, 2)
end)