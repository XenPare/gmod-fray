local LANG = {}

LANG.Name = "Русский"
LANG.Author = "crester"
LANG.Icon = "resource/localization/ru.png"

LANG.Zones = {
    ["Russia"] = true,
    ["Ukraine"] = true,
    ["Belarus"] = true
}

local money_amount = Fray.Config.MoneyPerEntity

LANG.Phrases = {
	["languages"] = "Язык",

	["babygod"] = "Защищён + ",

	["can_respawn"] = "Кликните чтобы возродиться",
	["respawn"] = "Пожалуйста, подождите ",
	["seconds"] = " секунд",

	["killed"] = " нейтрализовал ",

	["yes"] = "Да",
	["no"] = "Нет",

	--[[
		Категории
	]]

	["category_1"] = "Оружие",
	["category_2"] = "Броня",
	["category_3"] = "Патроны",
	["category_4"] = "Потребляемое",
	["category_5"] = "Улучшения",

	--[[
		Команды
	]]

	["teams"] = "Команды",
	["add_team"] = "Пригласить",
	["remove_team"] = "Уйти",
	["invitation"] = " пригласил вас в команду, желаете присоединиться ?",
	
	--[[
		Ранги
	]]

	["mortal"] = "Смертный",
	["sinner"] = "Грешник",
	["tempter"] = "Искуситель",
	["fallen"] = "Падший",
	["demon"] = "Демон",
	["archdemon"] = "Архидемон",
	["devil"] = "Дьявол",

	--[[
		Магазин
	]]

	["shop"] = "Магазин",
	["buy"] = "Купить",
	["available"] = "доступно",
	["cant_deliver"] = "Не может быть доставлено сюда",
	["cant_afford"] = "Недостаточно средств",

    --[[
		Инвентарь
    ]]
    
    ["inventory"] = "Инвентарь",
    ["limit"] = "Лимит достигнут",
	["use"] = "Использовать",
	["equip"] = "Надеть",
	["unequip"] = "Снять",
    ["drop"] = "Выбросить",
	
	--[[
		Труп
	]]

	["corpse"] = " испустил дух в этом теле",
	["take"] = "Взять",

    --[[
		Вещи инвентаря
    ]]
	
	["weapon_description"] = "Использовать по назначению.",

	["radar"] = "Радар",
	["radar_description"] = "Позволяет вам засекать игроков поблизости.",
	["radar_equipped"] = "Радар уже экипирован.",

	["muffler"] = "Глушитель",
	["muffler_description"] = "Глушит радары поблизости.",

	["medicine"] = "Аптечка",
	["medicine_description"] = "Используйте чтобы вылечиться.",

	["food"] = "Еда",
	["food_description"] = "Используйте чтобы утолить голод.",

	["drink"] = "Напиток",
	["drink_description"] = "Используйте чтобы утолить жажду.",

	["money"] = "$" .. money_amount,
	["money_description"] = "Обычная купюра.",

	["shield"] = "Баллистический щит",
	["shield_description"] = "Используйте чтобы защитить себя.",

	["bicep_armor"] = "Наплечники",
	["bicep_armor_description"] = "Защитите ваши плечи. Владение этим предметом в инвентаре достаточно для работы эффекта.",

	["calf_armor"] = "Наколенники",
	["calf_armor_description"] = "Защитите ваши колени. Владение этим предметом в инвентаре достаточно для работы эффекта.",

	["forearm_armor"] = "Нарукавники",
	["forearm_armor_description"] = "Защитите ваши руки. Владение этим предметом в инвентаре достаточно для работы эффекта.",

	["thigh_armor"] = "Набедренники",
	["thigh_armor_description"] = "Защитите ваши бёдра. Владение этим предметом в инвентаре достаточно для работы эффекта.",

	["vest_armor"] = "Бронежилет",
	["vest_armor_description"] = "Защитите вашу грудь. Владение этим предметом в инвентаре достаточно для работы эффекта.",

	["ammo_9x19"] = "Патроны 9x19MM",
	["ammo_9x19_description"] = "Содержит 30 патронов",

	["ammo_50ae"] = "Патроны .50 AE",
	["ammo_50ae_description"] = "Содержит 7 патронов",
	
	["ammo_44magnum"] = "Патроны .44 Magnum",
	["ammo_44magnum_description"] = "Содержит 6 патронов",

	["ammo_338lapua"] = "Патроны .338 Lapua",
	["ammo_338lapua_description"] = "Содержит 5 патронов",

	["ammo_545x39"] = "Патроны 5.45x39MM",
	["ammo_545x39_description"] = "Содержит 30 патронов",

	["ammo_556x45"] = "Патроны 5.56x45MM",
	["ammo_556x45_description"] = "Содержит 30 патронов",

	["ammo_762x51"] = "Патроны 7.62x51MM",
	["ammo_762x51_description"] = "Содержит 20 патронов",

	["ammo_9x17"] = "Патроны 9x17MM",
	["ammo_9x17_description"] = "Содержит 25 патронов",

	["ammo_9x39"] = "Патроны 9x39MM",
	["ammo_9x39_description"] = "Содержит 20 патронов",

	["ammo_12gauge"] = "Патроны 12 Gauge",
	["ammo_12gauge_description"] = "Содержит 8 патронов",

	["ammo_45acp"] = "Патроны .45 ACP",
	["ammo_45acp_description"] = "Содержит 25 патронов",
}

return LANG 