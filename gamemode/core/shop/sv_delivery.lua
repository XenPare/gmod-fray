local meta = FindMetaTable("Player")

function meta:CanDeliver()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + (Vector(0, 0, 1) * 16384),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
	if tr.HitSky then
		local additional = tr.HitPos - Vector(0, 0, 400) + VectorRand(-200, 200)
		return self:GetPos().z > -2300, additional
	end
	return false
end

function Fray.ShopDeliver(pl, class)
	local canDeliver, hitPos = pl:CanDeliver()
	if not canDeliver then
		return
	end

	local iswep = tobool(weapons.Get(class))
	local ent = ents.Create("fray_deliver")
	ent:SetPos(hitPos)
	ent:SetAngles(Angle(AngleRand()))
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
		phys:SetVelocity(tr.Normal * -10000)
	end
end