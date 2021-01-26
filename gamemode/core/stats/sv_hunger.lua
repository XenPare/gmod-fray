local meta = FindMetaTable("Player")

function meta:SetHunger(n)
	self:SetNWInt("Hunger", n)
end

function meta:GetHunger()
	return self:GetNWInt("Hunger")
end

function meta:AddHunger(n)
	if (self:GetHunger() + n) > 100 then
		self:SetHunger(100)
	else
		self:SetHunger(n)
	end
end

function meta:TakeHunger(n)
	if self:GetHunger() <= 0 then
		return
	end
	self:SetHunger(self:GetHunger() - n)
end

local function saveHunger(pl)
	file.Write("fray/stats/hunger/" .. pl:SteamID64() .. ".txt", tostring(pl:GetHunger()))
end

local function setHunger(pl, init)
	if init then
		local path = "fray/stats/hunger/" .. pl:SteamID64() .. ".txt"
		local exists = file.Exists(path, "DATA")
		if not exists then
			file.Write(path, "100")
		end
		pl:SetNWInt("Hunger", tonumber(file.Read(path)))
	else
		pl:SetNWInt("Hunger", 100)
	end

	if pl:TimerExists("Hunger") then
		pl:RemoveTimer("Hunger")
	end

	pl:SetTimer("Hunger", 85, 0, function()
		if pl:GetHunger() <= 5 then
			local dmg = DamageInfo()
			dmg:SetDamage(8)
			dmg:SetInflictor(pl)
			dmg:SetAttacker(pl)
			dmg:SetDamageType(bit.bor(DMG_DISSOLVE, DMG_NERVEGAS))
			pl:TakeDamageInfo(dmg)
		else
			pl:TakeHunger(1)
		end
	end)

	pl:SetTimer("Hunger Save", 120, 0, function()
		saveHunger(pl)
	end)
end

hook.Add("PlayerDisconnected", "Fray Hunger", saveHunger)
hook.Add("PlayerSpawn", "Fray Hunger", setHunger)
hook.Add("PlayerInitialSpawn", "Fray Hunger", function(pl)
	setHunger(pl, true)
end)