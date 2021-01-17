Fray.InventoryList = {
	fray_ba_bicep = {
		label = "Bicep Armor",
		model = "models/snowzgmod/payday2/armour/armourlbicep.mdl",
		description = "Protect your biceps. Having this item in your inventory is enough to make it work.",
		weight = 3,
		max = 1,
		onAdd = function(pl)
			if SERVER then
				pl:SetBodyArmor("bicep", true)
			end
		end,
		onTake = function(pl)
			if SERVER then
				pl:SetBodyArmor("bicep", false)
			end
		end
	},

	fray_ba_calf = {
		label = "Calf Armor",
		model = "models/snowzgmod/payday2/armour/armourlcalf.mdl",
		description = "Protect your calfs. Having this item in your inventory is enough to make it work.",
		weight = 2,
		max = 1,
		onAdd = function(pl)
			if SERVER then
				pl:SetBodyArmor("calf", true)
			end
		end,
		onTake = function(pl)
			if SERVER then
				pl:SetBodyArmor("calf", false)
			end
		end
	},

	fray_ba_forearm = {
		label = "Forearm Armor",
		model = "models/snowzgmod/payday2/armour/armourlforearm.mdl",
		description = "Protect your forearms. Having this item in your inventory is enough to make it work.",
		weight = 2,
		max = 1,
		onAdd = function(pl)
			if SERVER then
				pl:SetBodyArmor("forearm", true)
			end
		end,
		onTake = function(pl)
			if SERVER then
				pl:SetBodyArmor("forearm", false)
			end
		end
	},

	fray_ba_thigh = {
		label = "Thigh Armor",
		model = "models/snowzgmod/payday2/armour/armourlthigh.mdl",
		description = "Protect your thighs. Having this item in your inventory is enough to make it work.",
		weight = 3,
		max = 1,
		onAdd = function(pl)
			if SERVER then
				pl:SetBodyArmor("thigh", true)
			end
		end,
		onTake = function(pl)
			if SERVER then
				pl:SetBodyArmor("thigh", false)
			end
		end
	},

	fray_ba_vest = {
		label = "Vest",
		model = "models/snowzgmod/payday2/armour/armourvest.mdl",
		description = "Protect your chest. Having this item in your inventory is enough to make it work.",
		weight = 5,
		max = 1,
		onAdd = function(pl)
			if SERVER then
				pl:SetBodyArmor("vest", true)
			end
		end,
		onTake = function(pl)
			if SERVER then
				pl:SetBodyArmor("vest", false)
			end
		end
	},

	cw_ammo_9x19 = {
		label = "9x19MM Ammo",
		model = "models/items/boxsrounds.mdl",
		description = "Contains 30 resupply ammo",
		weight = 4,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(30, "9x19MM", true)
			end
		end
	},

	cw_ammo_50ae = {
		label = ".50 AE Ammo",
		model = "models/items/boxsrounds.mdl",
		description = "Contains 7 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(7, ".50 AE", true)
			end
		end
	},

	cw_ammo_44magnum = {
		label = ".44 Magnum Ammo",
		model = "models/items/boxsrounds.mdl",
		description = "Contains 6 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(6, ".44 Magnum", true)
			end
		end
	},

	cw_ammo_338lapua = {
		label = ".338 Lapua Ammo",
		model = "models/items/boxmrounds.mdl",
		description = "Contains 5 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(5, ".338 Lapua", true)
			end
		end
	},

	cw_ammo_545x39 = {
		label = "5.45x39MM Ammo",
		model = "models/items/boxmrounds.mdl",
		description = "Contains 30 resupply ammo",
		weight = 4,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(30, "5.45x39MM", true)
			end
		end
	},

	cw_ammo_556x45 = {
		label = "5.56x45MM Ammo",
		model = "models/items/boxmrounds.mdl",
		description = "Contains 30 resupply ammo",
		weight = 4,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(30, "5.56x45MM", true)
			end
		end
	},

	cw_ammo_762x51 = {
		label = "7.62x51MM Ammo",
		model = "models/items/boxmrounds.mdl",
		description = "Contains 20 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(20, "7.62x51MM", true)
			end
		end
	},

	cw_ammo_9x17 = {
		label = "9x17MM Ammo",
		model = "models/items/boxsrounds.mdl",
		description = "Contains 25 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(25, "9x17MM", true)
			end
		end
	},

	cw_ammo_9x39 = {
		label = "9x39MM Ammo",
		model = "models/items/boxmrounds.mdl",
		description = "Contains 20 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(20, "9x39MM", true)
			end
		end
	},

	cw_ammo_12gauge = {
		label = "12 Gauge Ammo",
		model = "models/items/boxmrounds.mdl",
		description = "Contains 8 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(8, "12 Gauge", true)
			end
		end
	},

	cw_ammo_45acp = {
		label = ".45 ACP Ammo",
		model = "models/items/boxsrounds.mdl",
		description = "Contains 25 resupply ammo",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(25, ".45 ACP", true)
			end
		end
	}
}