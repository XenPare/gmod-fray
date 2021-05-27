local meta = FindMetaTable("Player")

function meta:CanDeliver()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + (Vector(0, 0, 1) * 16384),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
	if tr.HitSky then
		local additional = tr.HitPos - (Vector(0, 0, 120) + VectorRand(200, 200))
		return self:GetPos().z > -2300, additional
	end
	return false
end

local mpe = Fray.Config.MoneyPerEntity
local comp = Fray.Config.ShopCompensationTime
function Fray.ShopDeliver(pl, class)
	local canDeliver, hitPos = pl:CanDeliver()
	if not canDeliver then
		return
	end

	local iswep = weapons.Get(class)
	if not iswep and not scripted_ents.Get(class) then
		return
	end

	local ent = ents.Create("fray_deliver")
	ent:SetPos(hitPos)
	ent:SetAngles(Angle(AngleRand()))
	ent.Recipient = pl
	if iswep then
		ent.Deliver = "fray_weapon"
		ent.ContainedWeapon = class
	else
		ent.Deliver = class
	end
	ent:Spawn()
	ent:EmitSound("npc/env_headcrabcanister/launch.wav", 80, 100)

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		local tr = util.QuickTrace(hitPos, pl:GetPos(), self)
		phys:AddVelocity(tr.Normal * Vector(1, 1, -100000))
	end

	pl.stopCompensation = false
	ent:SetSimpleTimer(comp, function()
		if pl.stopCompensation then
			return
		end
		pl:AddMoney(Fray.ShopList[class].price / mpe)
		ent:Remove()
	end)
end