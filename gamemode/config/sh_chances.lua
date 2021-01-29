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
	addChance(Fray.Config.Loot, "fray_money", 4)
	addChance(Fray.Config.Loot, "fray_food", 3)
	addChance(Fray.Config.Loot, "fray_drink", 3)
	addChance(Fray.Config.Loot, "fray_weapon", 2)
end)