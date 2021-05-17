local LANG = {}

LANG.Name = "English"
LANG.Author = "crester"
LANG.Icon = "resource/localization/en.png"

LANG.Zones = {
	["United Kingdom"] = true,
	["United States"] = true
}

local money_amount = Fray.Config.MoneyPerEntity

LANG.Phrases = {
	["languages"] = "Language",

	["babygod"] = "Protected +",
	["bleeding"] = "Bleeding -",

	["can_respawn"] = "Click to respawn",
	["respawn"] = "Please, wait ",
	["seconds"] = " seconds",

	["killed"] = " killed ",

	["yes"] = "Yes",
	["no"] = "No",

	--[[
		Categories
	]]

	["category_1"] = "Weapons",
	["category_2"] = "Armor",
	["category_3"] = "Ammo",
	["category_4"] = "Consumables",
	["category_5"] = "Attachments",

	--[[
		Teams
	]]

	["teams"] = "Teams",
	["add_team"] = "Invite",
	["remove_team"] = "Leave",
	["invitation"] = " has invited you to join his team, would you like to join ?",

	--[[
		Ranks
	]]

	["mortal"] = "Mortal",
	["sinner"] = "Sinner",
	["tempter"] = "Tempter",
	["fallen"] = "Fallen",
	["demon"] = "Demon",
	["archdemon"] = "Archdemon",
	["devil"] = "Devil",

	--[[
		Shop
	]]

	["shop"] = "Shop",
	["buy"] = "Buy",
	["available"] = "available",
	["cant_deliver"] = "Can't be delivered here",
	["cant_afford"] = "You can't afford it",

	--[[
		Inventory
	]]

	["inventory"] = "Inventory",
	["limit"] = "Limit is reached",
	["use"] = "Use",
	["equip"] = "Equip",
	["unequip"] = "Unequip",
	["drop"] = "Drop",

	--[[
		Corpse
	]]

	["corpse"] = "'s corpse",
	["take"] = "Take",

	--[[
		Inventory Items
	]]

	["weapon_description"] = "Use it properly.",

	["radar"] = "Radar",
	["radar_description"] = "Let's you detect people around.",
	["radar_equipped"] = "Equipped a radar.",
	["radar_unequipped"] = "Unequipped a radar.",

	["muffler"] = "Muffler",
	["muffler_description"] = "Muffles radars around.",

	["medicine"] = "Medicine",
	["medicine_description"] = "Use to heal yourself.",

	["bandage"] = "Bandage",
	["bandage_description"] = "Use to stop bleeding.",

	["food"] = "Food",
	["food_description"] = "Use to satisfy your hunger.",

	["drink"] = "Drink",
	["drink_description"] = "Use to satisfy your thirst.",

	["money"] = "$" .. money_amount,
	["money_description"] = "A simple banknote.",

	["shield"] = "Ballistic Shield",
	["shield_description"] = "Use it to protect yourself.",

	["bicep_armor"] = "Bicep Armor",
	["bicep_armor_description"] = "Protect your biceps. Having this item in your inventory is enough to make it work.",

	["calf_armor"] = "Calf Armor",
	["calf_armor_description"] = "Protect your calfs. Having this item in your inventory is enough to make it work.",

	["forearm_armor"] = "Forearm Armor",
	["forearm_armor_description"] = "Protect your forearms. Having this item in your inventory is enough to make it work.",

	["thigh_armor"] = "Thigh Armor",
	["thigh_armor_description"] = "Protect your thighs. Having this item in your inventory is enough to make it work.",

	["vest_armor"] = "Vest",
	["vest_armor_description"] = "Protect your chest. Having this item in your inventory is enough to make it work.",

	["ammo_9x19"] = "9x19MM Ammo",
	["ammo_9x19_description"] = "Contains 30 resupply ammo",

	["ammo_50ae"] = ".50 AE Ammo",
	["ammo_50ae_description"] = "Contains 7 resupply ammo",

	["ammo_44magnum"] = ".44 Magnum Ammo",
	["ammo_44magnum_description"] = "Contains 6 resupply ammo",

	["ammo_338lapua"] = ".338 Lapua Ammo",
	["ammo_338lapua_description"] = "Contains 5 resupply ammo",

	["ammo_545x39"] = "5.45x39MM Ammo",
	["ammo_545x39_description"] = "Contains 30 resupply ammo",

	["ammo_556x45"] = "5.56x45MM Ammo",
	["ammo_556x45_description"] = "Contains 30 resupply ammo",

	["ammo_762x51"] = "7.62x51MM Ammo",
	["ammo_762x51_description"] = "Contains 20 resupply ammo",

	["ammo_9x17"] = "9x17MM Ammo",
	["ammo_9x17_description"] = "Contains 25 resupply ammo",

	["ammo_9x39"] = "9x39MM Ammo",
	["ammo_9x39_description"] = "Contains 20 resupply ammo",

	["ammo_12gauge"] = "12 Gauge Ammo",
	["ammo_12gauge_description"] = "Contains 8 resupply ammo",

	["ammo_45acp"] = ".45 ACP Ammo",
	["ammo_45acp_description"] = "Contains 25 resupply ammo",
}

return LANG 