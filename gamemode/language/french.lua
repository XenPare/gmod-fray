local LANG = {}

LANG.Name = "French"
LANG.Author = "nocturni"
LANG.Icon = "resource/localization/fr.png"

LANG.Zones = {
	["France"] = true,
	["Canada"] = true
}

local money_amount = Fray.Config.MoneyPerEntity

LANG.Phrases = {
	["languages"] = "Language",

	["babygod"] = "Protégé +",
	["bleeding"] = "Saignement -",

	["pvp_entered"] = "Vous venez d'entrer en mode PvP. Vous perdrez le contenu de votre inventaire après avoir quitté le serveur.",

	["can_respawn"] = "Cliquez pour ressusciter",
	["respawn"] = "S'il vous plaît, patientez ",
	["seconds"] = " secondes",

	["killed"] = " a tué ",

	["yes"] = "Oui",
	["no"] = "Non",

	--[[
		Categories
	]]

	["category_1"] = "Armes",
	["category_2"] = "Équipement",
	["category_3"] = "Munitions",
	["category_4"] = "Nourriture",
	["category_5"] = "Accessoires",

	--[[
		Teams
	]]

	["teams"] = "Teams",
	["add_team"] = "Inviter",
	["remove_team"] = "Quitter",
	["invitation"] = " vous a invité à rejoindre sa team, souhaitez vous le rejoindre ?",

	--[[
		Ranks
	]]

	["mortal"] = "Mortel",
	["sinner"] = "Pécheur",
	["tempter"] = "Tentateur",
	["fallen"] = "Déchu",
	["demon"] = "Démon",
	["archdemon"] = "Archidémon",
	["devil"] = "Diable",

	--[[
		Shop
	]]

	["shop"] = "Boutique",
	["buy"] = "Acheter",
	["available"] = "disponible(s)",
	["cant_deliver"] = "Ne peut pas être livré ici",
	["cant_afford"] = "Vous n'avez pas assez",

	--[[
		Inventory
	]]

	["inventory"] = "Inventaire",
	["limit"] = "Limite atteinte",
	["use"] = "Utiliser",
	["equip"] = "Équiper",
	["unequip"] = "Déséquiper",
	["drop"] = "Jeter",

	--[[
		Corpse
	]]

	["corpse"] = "Cadavre de ",
	["take"] = "Prendre",

	--[[
		Inventory Items
	]]

	["weapon_description"] = "Utilisez-la correctement.",

	["radar"] = "Radar",
	["radar_description"] = "Vous permets de détecter les gens autour.",
	["radar_equipped"] = "Radar équipé.",
	["radar_unequipped"] = "Radar déséquipé.",

	["muffler"] = "Silencieux",
	["muffler_description"] = "Rends les radars autour de vous silencieux.",

	["medicine"] = "Médicament",
	["medicine_description"] = "Utilisez pour vous guérir.",

	["bandage"] = "Bandage",
	["bandage_description"] = "Utilisez pour arrêter un saignement.",

	["food"] = "Nourriture",
	["food_description"] = "Utilisez pour vous rassasier.",

	["drink"] = "Boissons",
	["drink_description"] = "Utilisez pour vous désaltérer.",

	["money"] = "$" .. money_amount,
	["money_description"] = "Un simple billet.",

	["shield"] = "Bouclier Balistique",
	["shield_description"] = "Utilisez le pour vous protéger.",

	["bicep_armor"] = "Armure pour Biceps",
	["bicep_armor_description"] = "Protégez vos biceps. Avoir cet objet dans votre inventaire est suffisant pour qu'il fonctionne.",

	["calf_armor"] = "Armure pour Mollets",
	["calf_armor_description"] = "Protégez vos mollets. Avoir cet objet dans votre inventaire est suffisant pour qu'il fonctionne.",

	["forearm_armor"] = "Armure pour Avant-bras",
	["forearm_armor_description"] = "Protégez vos avant-bras. Avoir cet objet dans votre inventaire est suffisant pour qu'il fonctionne.",

	["thigh_armor"] = "Armure pour Cuisses",
	["thigh_armor_description"] = "Protégez vos cuisses. Avoir cet objet dans votre inventaire est suffisant pour qu'il fonctionne.",

	["vest_armor"] = "Gilet Pare-Balles",
	["vest_armor_description"] = "Protégez votre poitrine. Avoir cet objet dans votre inventaire est suffisant pour qu'il fonctionne.",

	["ammo_9x19"] = "Munitions 9x19MM",
	["ammo_9x19_description"] = "Contient 30 munitions de réapprovisionnement",

	["ammo_50ae"] = "Munitions .50 AE",
	["ammo_50ae_description"] = "Contient 7 munitions de réapprovisionnement",

	["ammo_44magnum"] = "Munitions .44 Magnum",
	["ammo_44magnum_description"] = "Contient 6 munitions de réapprovisionnement",

	["ammo_338lapua"] = "Munitions .338 Lapua",
	["ammo_338lapua_description"] = "Contient 5 munitions de réapprovisionnement",

	["ammo_545x39"] = "Munitions 5.45x39MM",
	["ammo_545x39_description"] = "Contient 30 munitions de réapprovisionnement",

	["ammo_556x45"] = "Munitions 5.56x45MM",
	["ammo_556x45_description"] = "Contient 30 munitions de réapprovisionnement",

	["ammo_762x51"] = "Munitions 7.62x51MM",
	["ammo_762x51_description"] = "Contient 20 munitions de réapprovisionnement",

	["ammo_9x17"] = "Munitions 9x17MM",
	["ammo_9x17_description"] = "Contient 25 munitions de réapprovisionnement",

	["ammo_9x39"] = "Munitions 9x39MM",
	["ammo_9x39_description"] = "Contient 20 munitions de réapprovisionnement",

	["ammo_12gauge"] = "Munitions Calibre 12",
	["ammo_12gauge_description"] = "Contient 8 munitions de réapprovisionnement",

	["ammo_45acp"] = "Munitions .45 ACP",
	["ammo_45acp_description"] = "Contient 25 munitions de réapprovisionnement",
}

return LANG 