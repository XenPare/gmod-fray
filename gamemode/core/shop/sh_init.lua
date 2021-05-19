Fray.ShopList = {
	fray_radar = {
		price = 300,
		max = 1,
		category = FRAY_CATEGORY_CONSUMED
	},
	fray_muffler = {
		price = 300,
		max = 1,
		category = FRAY_CATEGORY_CONSUMED
	},
	fray_ba_bicep = {
		price = 200,
		max = 1,
		category = FRAY_CATEGORY_ARMOR
	},
	fray_ba_calf = {
		price = 200,
		max = 1,
		category = FRAY_CATEGORY_ARMOR
	},
	fray_ba_forearm = {
		price = 200,
		max = 1,
		category = FRAY_CATEGORY_ARMOR
	},
	fray_ba_thigh = {
		price = 200,
		max = 1,
		category = FRAY_CATEGORY_ARMOR
	},
	fray_ba_vest = {
		price = 300,
		max = 1,
		category = FRAY_CATEGORY_ARMOR
	},
	fray_shield = {
		price = 300,
		category = FRAY_CATEGORY_ARMOR
	},
	fray_drink = {
		price = 100,
		category = FRAY_CATEGORY_CONSUMED
	},
	fray_food = {
		price = 100,
		category = FRAY_CATEGORY_CONSUMED
	},
	fray_medicine = {
		price = 100,
		category = FRAY_CATEGORY_CONSUMED
	},
	fray_bandage = {
		price = 100,
		category = FRAY_CATEGORY_CONSUMED
	},
	cw_ak74 = {
		price = 400,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_l115 = {
		price = 600,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_frag_grenade = {
		price = 300,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_smoke_grenade = {
		price = 100,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_flash_grenade = {
		price = 100,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_ar15 = {
		price = 400,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_deagle = {
		price = 300,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_ump45 = {
		price = 300,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_mac11 = {
		price = 200,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_l85a2 = {
		price = 400,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_m3super90 = {
		price = 500,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_m249_official = {
		price = 600,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_scarh = {
		price = 400,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_vss = {
		price = 400,
		category = FRAY_CATEGORY_WEAPONS
	},
	cw_ammo_9x19 = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_50ae = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_44magnum = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_338lapua = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_545x39 = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_556x45 = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_762x51 = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_9x17 = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_9x39 = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_12gauge = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	},
	cw_ammo_45acp = {
		price = 100,
		category = FRAY_CATEGORY_AMMO
	}
}

hook.Add("Initialize", "Fray Shop", function()
	for att in pairs(Fray.Config.Attachments) do
		Fray.ShopList[att] = {
			price = 500,
			category = FRAY_CATEGORY_ATTACHMENTS
		}
	end
end)