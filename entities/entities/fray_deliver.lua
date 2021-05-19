AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Deliver"
ENT.Category = "Fray"
ENT.Author = "crester"

ENT.Spawnable = false

if SERVER then
	ENT.Colided = false

	function ENT:Initialize()
		self:SetModel("models/items/item_item_crate.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end

	function ENT:Think(col)
		if not self.Colided then
			local trace = {
				start = self:GetPos(),
				endpos = Vector(0, 0, -100000),
				filter = ent,
				mask = MASK_SOLID_BRUSHONLY
			}

			local tr = util.TraceLine(trace)
			local hitPos = tr.HitPos 
			if self:GetPos():DistToSqr(hitPos) < 5000 then
				self:EmitSound("npc/env_headcrabcanister/explosion.wav", 120, 100)
				self:Unpack()
				self.Colided = true
			end
		end
	end

	local mpe = Fray.Config.MoneyPerEntity
	local comp = Fray.Config.ShopCompensationTime
	function ENT:Unpack()
		local scrap1 = ents.Create("fray_scrap")
		scrap1:SetPos(self:GetPos() + Vector(0, 40, 6))
		scrap1:Spawn()

		local scrap2 = ents.Create("fray_scrap")
		scrap2:SetPos(self:GetPos() + Vector(40, 0, 6))
		scrap2:Spawn()

		local scrap3 = ents.Create("fray_scrap")
		scrap3:SetPos(self:GetPos() + Vector(7, -40, 6))
		scrap3:Spawn()

		local scrap4 = ents.Create("fray_scrap")
		scrap4:SetPos(self:GetPos() + Vector(7, 5, 6))
		scrap4:Spawn()

		local scrap5 = ents.Create("fray_scrap")
		scrap5:SetPos(self:GetPos() + Vector(-40, 0, 6))
		scrap5:Spawn()

		local class = self.Deliver
		if class then
			local deliver = ents.Create(class)
			if self.ContainedWeapon then
				deliver.Weapon = self.ContainedWeapon
			end
			deliver:SetPos(self:GetPos() + Vector(0, 0, 6))
			deliver:Spawn()

			local phys = deliver:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
			end

			local recip = self.Recipient
			deliver:SetSimpleTimer(comp, function()
				recip:AddMoney(Fray.ShopList[class].price / mpe)
				deliver:Remove()
			end)
		end
		self:Remove()
	end

	ENT.Use = ENT.Unpack
end