Fray.InventoryList = {
	fray_money = {
		label = "money",
		description = "money_description",
		model = "models/props/cs_assault/money.mdl",
		weight = 0.1
	},

	fray_ba_bicep = {
		label = "bicep_armor",
		description = "bicep_armor_description",
		model = "models/snowzgmod/payday2/armour/armourlbicep.mdl",
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
		label = "calf_armor",
		description = "calf_armor_description",
		model = "models/snowzgmod/payday2/armour/armourlcalf.mdl",
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
		label = "forearm_armor",
		description = "forearm_armor_description",
		model = "models/snowzgmod/payday2/armour/armourlforearm.mdl",
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
		label = "thigh_armor",
		description = "thigh_armor_description",
		model = "models/snowzgmod/payday2/armour/armourlthigh.mdl",
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
		label = "vest_armor",
		description = "vest_armor_description",
		model = "models/snowzgmod/payday2/armour/armourvest.mdl",
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
		label = "ammo_9x19",
		description = "ammo_9x19_description",
		model = "models/items/boxsrounds.mdl",
		weight = 4,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(30, "9x19MM", true)
			end
		end
	},

	cw_ammo_50ae = {
		label = "ammo_50ae",
		description = "ammo_50ae_description",
		model = "models/items/boxsrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(7, ".50 AE", true)
			end
		end
	},

	cw_ammo_44magnum = {
		label = "ammo_44magnum",
		description = "ammo_44magnum_description",
		model = "models/items/boxsrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(6, ".44 Magnum", true)
			end
		end
	},

	cw_ammo_338lapua = {
		label = "ammo_338lapua",
		description = "ammo_338lapua_description",
		model = "models/items/boxmrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(5, ".338 Lapua", true)
			end
		end
	},

	cw_ammo_545x39 = {
		label = "ammo_545x39",
		description = "ammo_545x39_description",
		model = "models/items/boxmrounds.mdl",
		weight = 4,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(30, "5.45x39MM", true)
			end
		end
	},

	cw_ammo_556x45 = {
		label = "ammo_556x45",
		description = "ammo_556x45_description",
		model = "models/items/boxmrounds.mdl",
		weight = 4,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(30, "5.56x45MM", true)
			end
		end
	},

	cw_ammo_762x51 = {
		label = "ammo_762x51",
		description = "ammo_762x51_description",
		model = "models/items/boxmrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(20, "7.62x51MM", true)
			end
		end
	},

	cw_ammo_9x17 = {
		label = "ammo_9x17",
		description = "ammo_9x17_description",
		model = "models/items/boxsrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(25, "9x17MM", true)
			end
		end
	},

	cw_ammo_9x39 = {
		label = "ammo_9x39",
		description = "ammo_9x39_description",
		model = "models/items/boxmrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(20, "9x39MM", true)
			end
		end
	},

	cw_ammo_12gauge = {
		label = "ammo_12gauge",
		description = "ammo_12gauge_description",
		model = "models/items/boxmrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(8, "12 Gauge", true)
			end
		end
	},

	cw_ammo_45acp = {
		label = "ammo_45acp",
		description = "ammo_45acp_description",
		model = "models/items/boxsrounds.mdl",
		weight = 3,
		onUse = function(pl)
			if SERVER then
				pl:GiveAmmo(25, ".45 ACP", true)
			end
		end
	}
}