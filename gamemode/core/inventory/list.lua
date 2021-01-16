return {
	fray_ba_bicep = {
		label = "Bicep Armor",
		model = "models/snowzgmod/payday2/armour/armourlbicep.mdl",
		description = "Protect your biceps. Having this item in your inventory is enough to make it work.",
		weight = 2,
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
		weight = 2,
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
}