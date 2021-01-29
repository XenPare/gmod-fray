Fray.Config.Loot = {
	"cw_ammo_9x19",
	"cw_ammo_50ae",
	"cw_ammo_44magnum",
	"cw_ammo_338lapua",
	"cw_ammo_545x39",
	"cw_ammo_556x45",
	"cw_ammo_762x51",
	"cw_ammo_9x17",
	"cw_ammo_9x39",
	"cw_ammo_12gauge",
	"cw_ammo_45acp",
	"fray_money",
	"fray_weapon",
	"fray_food",
	"fray_drink",
	"fray_ba_forearm",
	"fray_ba_calf",
	"fray_medicine"
}

Fray.Config.RandomWeaponLoot = {
	"cw_mp5",
	"cw_deagle",
	"cw_fiveseven",
	"cw_mac11",
	"cw_m1911"
}

local function addChance(tbl, class, x)
	if x > 1 then
		for i = 1, x do
			table.insert(tbl, class)
		end
	else
		table.insert(tbl, class)
	end
end

addChance(Fray.Config.Loot, "fray_money", 4)
addChance(Fray.Config.Loot, "fray_food", 3)
addChance(Fray.Config.Loot, "fray_drink", 3)
addChance(Fray.Config.Loot, "fray_weapon", 2)