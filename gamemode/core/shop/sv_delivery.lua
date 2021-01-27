function Fray.ShopDeliver(pl, class)
	local canDeliver, hitPos = pl:CanDeliver()
	if not canDeliver then
		return
	end

	local endPos = hitPos - Vector(0, 0, 200) + VectorRand(-200, 200)
	
	local iscw20wep = weapons.Get(class) and weapons.Get(class).CW20Weapon or false
	local ent = ents.Create("fray_deliver")
	ent:SetPos(endPos)
	if iscw20wep then
		ent.Deliver = "fray_weapon"
		ent.ContainedWeapon = class
	else
		ent.Deliver = class
	end
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()

		local tr = util.QuickTrace(endPos, pl:GetPos(), self)
		phys:SetVelocity(tr.Normal * -10000)
	end
end