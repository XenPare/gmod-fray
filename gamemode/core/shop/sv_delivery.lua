function Fray.ShopDeliver(pl, class)
	local canDeliver, hitPos = pl:CanDeliver()
	if not canDeliver then
		return
	end

	local endPos = hitPos - Vector(0, 0, 60) + VectorRand(-200, 200)
	
	local ent = ents.Create("fray_deliver")
	ent:SetPos(endPos)
	ent.Deliver = class
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()

		local tr = util.QuickTrace(endPos, pl:GetPos(), self)
		phys:SetVelocity(tr.Normal * -10000)
	end
end