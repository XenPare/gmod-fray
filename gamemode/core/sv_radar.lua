local max_dist = Fray.Config.RadarDistance
local cooldown = Fray.Config.RadarCooldown

local function findLeast(tbl)
	local least = XPA.FindBiggest(tbl)
	for i = 1, #tbl do
		if tbl[i] < least then
			least = tbl[i]
		end
	end
	return least
end

local function findInSphere(pl, target)
	local pos = pl:GetPos()
	if not target then
		local found = {}
		for _, ent in pairs(ents.FindInSphere(pos, max_dist)) do
			if ent:IsPlayer() and ent ~= pl and ent:Health() > 0 then
				if ent:HasInventoryItem("fray_muffler") then
					return nil
				end
				local dist = pos:DistToSqr(ent:GetPos())
				found[dist / dist] = ent
			end
		end
		local distances = {}
		for dist in pairs(found) do
			table.insert(distances, dist)
		end
		local least = findLeast(distances)
		return found[least]
	else
		for _, ent in pairs(ents.FindInSphere(pos, max_dist)) do
			if ent:IsPlayer() and ent ~= pl and ent == target and not ent:HasInventoryItem("fray_muffler") and ent:Health() > 0 then
				return true
			end
		end
		return false
	end
end

local function radarSound(pl)
	local found = findInSphere(pl)
	if pl:TimerExists("Fray Radar Sound") or not IsValid(found) then
		return
	end
	pl:SetTimer("Fray Radar Sound", 0.5, 0, function()
		if not findInSphere(pl, found) or not pl:GetNWBool("Fray Radar") then
			pl:RemoveTimer("Fray Radar Sound")
			return
		end
		pl:EmitSound("ui/buttonclick.wav")
	end)
end

local meta = FindMetaTable("Player")

function meta:AddRadar()
	if self:TimerExists("Fray Radar") or self:TimerExists("Fray Radar Sound") or self:GetNWBool("Fray Radar") then
		return
	end
	self:SetNWBool("Fray Radar", true)
	self:SetTimer("Fray Radar", cooldown, 0, function()
		radarSound(self)
	end)
end

function meta:RemoveRadar()
	if not self:TimerExists("Fray Radar") then
		return
	end
	if self:TimerExists("Fray Radar") or self:TimerExists("Fray Radar Sound") or self:GetNWBool("Fray Radar") then
		self:SetNWBool("Fray Radar", false)
		self:RemoveTimer("Fray Radar")
	end
end