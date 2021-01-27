local meta = FindMetaTable("Player")

function meta:SetThirst(n)
	self:SetPData("Thirst", n)
end

function meta:GetThirst()
	return tonumber(self:GetPData("Thirst", 100))
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

local function setThirst(pl, init)
	if init then
		pl:SetThirst(pl:GetThirst())
	else
		pl:SetThirst(100)
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
end

hook.Add("PlayerDeath", "Fray Thirst", setThirst)
hook.Add("PlayerInitialSpawn", "Fray Thirst", function(pl)
	setThirst(pl, true)
end)