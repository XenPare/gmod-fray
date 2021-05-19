local LANG = {}

LANG.Name = "Українська"
LANG.Author = "KirillGradin(Lyxie)"
LANG.Icon = "resource/localization/uk.png"

LANG.Zones = {
	["Ukraine"] = true
}

local money_amount = Fray.Config.MoneyPerEntity

LANG.Phrases = {
	["languages"] = "Мова",

	["babygod"] = "Народився в сорочці",
	["bleeding"] = "Кровотеча -",

	["pvp_entered"] = "Ви тільки що ввійшли в PvP режим. Ви втратите свої речі при виході з сервера.",

	["can_respawn"] = "Натисніть, щоб продовжити",
	["respawn"] = "Будь ласка, зачекайте ",
	["seconds"] = " секунд",

	["killed"] = " нейтралізував ",

	["yes"] = "Так",
	["no"] = "Нi",

	--[[
		Категории
	]]

	["category_1"] = "Зброя",
	["category_2"] = "Броня",
	["category_3"] = "Патрони",
	["category_4"] = "Витратні матеріали",
	["category_5"] = "Поліпшення",

	--[[
		Команды
	]]

	["teams"] = "Соратники",
	["add_team"] = "Запросити",
	["remove_team"] = "Вийти",
	["invitation"] = " запросив вас в команду, бажаєте приєднатися?",

	--[[
		Ранги
	]]

	["mortal"] = "Смертний",
	["sinner"] = "Грішник",
	["tempter"] = "Звідник",
	["fallen"] = "Падший",
	["demon"] = "Бiс",
	["archdemon"] = "Архі-біс",
	["devil"] = "Дідько",

	--[[
		Магазин
	]]

	["shop"] = "Магазин",
	["buy"] = "Купити",
	["available"] = "доступно",
	["cant_deliver"] = "Не можна доставити сюди ",
	["cant_afford"] = "Немає грошей",

	--[[
		Инвентарь
	]]

	["inventory"] = "Інвентар",
	["limit"] = "Ліміт досягнутий",
	["use"] = "Використовувати",
	["equip"] = "Екіпірувати",
	["unequip"] = "Зняти",
	["drop"] = "Викинути",

	--[[
		Труп
	]]

	["corpse"] = " відкинув ковзани тут",
	["take"] = "Взяти",

	--[[
		Вещи инвентаря
	]]

	["weapon_description"] = "Використовувати за призначенням.",

	["radar"] = "Радар",
	["radar_description"] = "Дає змогу вам засікати людей поблизу.",
	["radar_equipped"] = "Радар включений.",
	["radar_unequipped"] = "Радар вимкнений.",

	["muffler"] = "Глушилка",
	["muffler_description"] = "Глушить сигнал радара поблизу.",

	["medicine"] = "Аптечка",
	["medicine_description"] = "Використовуйте щоб вилікуватися.",

	["bandage"] = "Бинт",
	["bandage_description"] = "Використовуйте щоб зупинити кровотечу.",

	["food"] = "Їжа",
	["food_description"] = "Використовуйте щоб вгамувати голод.",

	["drink"] = "Напій",
	["drink_description"] = "Використовуйте щоб втамувати спрагу.",

	["money"] = "$" .. money_amount,
	["money_description"] = "Звичайні гроші.",

	["shield"] = "Балістичний щит",
	["shield_description"] = "Використовуйте щоб захистити себе.",

	["bicep_armor"] = "Наплічник",
	["bicep_armor_description"] = "Захищає ваші плечі. Володіння цим предметом в інвентарі достатньо для роботи ефекту.",

	["calf_armor"] = "Наколінники",
	["calf_armor_description"] = "Захищає ваші коліна. Володіння цим предметом в інвентарі достатньо для роботи ефекту.",

	["forearm_armor"] = "Нарукавники",
	["forearm_armor_description"] = "Защитите ваши руки. Володіння цим предметом в інвентарі достатньо для роботи ефекту.",

	["thigh_armor"] = "Набедренники",
	["thigh_armor_description"] = "Защитите ваши стегна. Володіння цим предметом в інвентарі достатньо для роботи ефекту.",

	["vest_armor"] = "Бронежилет",
	["vest_armor_description"] = "Захищає вашу грудь. Володіння цим предметом в інвентарі достатньо для роботи ефекту.",

	["ammo_9x19"] = "Патрони 9x19MM",
	["ammo_9x19_description"] = "Вміщує 30 патронів",

	["ammo_50ae"] = "Патрони .50 AE",
	["ammo_50ae_description"] = "Вміщує 7 патронів",

	["ammo_44magnum"] = "Патрони .44 Magnum",
	["ammo_44magnum_description"] = "Вміщує 6 патронів",

	["ammo_338lapua"] = "Патрони .338 Lapua",
	["ammo_338lapua_description"] = "Вміщує 5 патронів",

	["ammo_545x39"] = "Патрони 5.45x39MM",
	["ammo_545x39_description"] = "Вміщує 30 патронів",

	["ammo_556x45"] = "Патрони 5.56x45MM",
	["ammo_556x45_description"] = "Вміщує 30 патронів",

	["ammo_762x51"] = "Патрони 7.62x51MM",
	["ammo_762x51_description"] = "Вміщує 20 патронів",

	["ammo_9x17"] = "Патрони 9x17MM",
	["ammo_9x17_description"] = "Вміщує 25 патронів",

	["ammo_9x39"] = "Патрони 9x39MM",
	["ammo_9x39_description"] = "Вміщує 20 патронів",

	["ammo_12gauge"] = "Патрони 12 Gauge",
	["ammo_12gauge_description"] = "Вміщує 8 патронів",

	["ammo_45acp"] = "Патрони .45 ACP",
	["ammo_45acp_description"] = "Вміщує 25 патронів",
}

return LANG 