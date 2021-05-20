Fray.Config.BleedingChance = 35

local function addChance(tbl, class, x)
	if x > 1 then
		for i = 1, x do
			table.insert(tbl, class)
		end
	else
		table.insert(tbl, class)
	end
end

hook.Add("Initialize", "Fray Chances", function()
	addChance(Fray.Config.Loot, "fray_money", 7)
	addChance(Fray.Config.Loot, "fray_food", 4)
	addChance(Fray.Config.Loot, "fray_drink", 4)
	addChance(Fray.Config.Loot, "fray_weapon", 7)
	addChance(Fray.Config.Loot, "fray_bandage", 6)
end)