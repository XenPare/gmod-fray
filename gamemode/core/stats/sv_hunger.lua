local meta = FindMetaTable("Player")

function meta:SetHunger(n)
	self:SetPData("Hunger", n)
	self:SetNWInt("Hunger", n)
	if n > 5 and self:TimerExists("Hunger") then
		self:RemoveTimer("Hunger")
	end
end

function meta:GetHunger()
	return tonumber(self:GetPData("Hunger", 100))
end

function meta:AddHunger(n)
	if (self:GetHunger() + n) > 100 then
		self:SetHunger(100)
	else
		self:SetHunger(self:GetHunger() + n)
	end
end

function meta:TakeHunger(n)
	if self:GetHunger() <= 0 then
		return
	end
	self:SetHunger(self:GetHunger() - n)
end

local tmr = Fray.Config.HungerDelay
local function setHunger(pl, init)
	if init then
		pl:SetHunger(pl:GetHunger())
	else
		pl:SetHunger(100)
	end

	if pl:TimerExists("Hunger") then
		pl:RemoveTimer("Hunger")
	end

	pl:SetTimer("Hunger", tmr, 0, function()
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
end

hook.Add("PlayerDeath", "Fray Hunger", function(pl)
	setHunger(pl)
end)
hook.Add("PostPlayerSpawn", "Fray Hunger", function(pl)
	setHunger(pl, true)
end)