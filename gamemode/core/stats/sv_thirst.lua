local meta = FindMetaTable("Player")

function meta:SetThirst(n)
	self:SetNWInt("Thirst", n)
end

function meta:GetThirst()
	return self:GetNWInt("Thirst")
end

function meta:AddThirst(n)
	if (self:GetThirst() + n) > 100 then
		self:SetThirst(100)
	else
		self:SetThirst(n)
	end
end

function meta:TakeThirst(n)
	if self:GetThirst() <= 0 then
		return
	end
	self:SetThirst(self:GetThirst() - n)
end

local function saveThirst(pl)
	file.Write("fray/stats/thirst/" .. pl:SteamID64() .. ".txt", tostring(pl:GetThirst()))
end

local function setThirst(pl, init)
	if init then
		local path = "fray/stats/thirst/" .. pl:SteamID64() .. ".txt"
		local exists = file.Exists(path, "DATA")
		if not exists then
			file.Write(path, "100")
		end
		pl:SetNWInt("Thirst", tonumber(file.Read(path)))
	else
		pl:SetNWInt("Thirst", 100)
	end

	if pl:TimerExists("Thirst") then
		pl:RemoveTimer("Thirst")
	end

	pl:SetTimer("Thirst", 75, 0, function()
		if pl:GetThirst() <= 5 then
			local dmg = DamageInfo()
			dmg:SetDamage(5)
			dmg:SetInflictor(pl)
			dmg:SetAttacker(pl)
			dmg:SetDamageType(bit.bor(DMG_DISSOLVE, DMG_NERVEGAS))
			pl:TakeDamageInfo(dmg)
		else
			pl:TakeThirst(1)
		end
	end)

	pl:SetTimer("Thirst Save", 120, 0, function()
		saveThirst(pl)
	end)
end

hook.Add("PlayerDisconnected", "Fray Thirst", saveThirst)
hook.Add("PlayerSpawn", "Fray Thirst", setThirst)
hook.Add("PlayerInitialSpawn", "Fray Thirst", function(pl)
	setThirst(pl, true)
end)