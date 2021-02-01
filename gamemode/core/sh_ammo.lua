hook.Add("PostGamemodeLoaded", "Fray Ammo", function()
	local classes = {}
	for class in pairs(Fray.ShopList) do
		if weapons.Get(class) then
			table.insert(classes, class)
		end
	end
	for _, class in pairs(Fray.Config.RandomWeaponLoot) do
		if weapons.Get(class) and not table.HasValue(classes, class) then
			table.insert(classes, class)
		end
	end
	for _, class in pairs(classes) do
		local SWEP = weapons.GetStored(class)
		SWEP.Primary.DefaultClip = 0
	end
end)