local ammolist = {}
hook.Add("Initialize", "Fray Ammo Saving", function()
	for class in pairs(Fray.InventoryList) do
		if class:find("cw_ammo") then
			ammolist[class] = true
		end
	end
end)

local function getType(class)
	return scripted_ents.Get(class).Caliber
end

local function getAmount(class)
	return scripted_ents.Get(class).ResupplyAmount
end

local function checkPlayer(pl)
	if pl:GetNWBool("Fray PvP") or not pl:Alive() then
		return
	end
	for tp, cn in pairs(pl:GetAmmo()) do
		local name = game.GetAmmoName(tp)
		for class in pairs(ammolist) do
			if getType(class) == name then
				local bx = math.Round(cn / getAmount(class))
				if bx == 1 then
					pl:AddInventoryItem(class)
				elseif bx > 1 then
					for i = 1, bx do
						pl:AddInventoryItem(class)
					end
				end
				break
			end
		end
	end
end

hook.Add("PlayerDisconnected", "Fray Ammo Saving", checkPlayer)
hook.Add("ShutDown", "Fray Ammo Saving", function()
	for _, pl in pairs(player.GetAll()) do
		checkPlayer(pl)
	end
end)