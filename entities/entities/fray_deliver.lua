AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Deliver"
ENT.Category = "Fray"
ENT.Author = "crester"

ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/items/item_item_crate.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end

	function ENT:Use(caller)
		local scrap1 = ents.Create("fray_scrap")
		scrap1:SetPos(self:GetPos() + Vector(0, 40, 20))
		scrap1:Spawn()

		local scrap2 = ents.Create("fray_scrap")
		scrap2:SetPos(self:GetPos() + Vector(40, 0, 20))
		scrap2:Spawn()

		local scrap3 = ents.Create("fray_scrap")
		scrap3:SetPos(self:GetPos() + Vector(7, -40, 20))
		scrap3:Spawn()

		local scrap4 = ents.Create("fray_scrap")
		scrap4:SetPos(self:GetPos() + Vector(7, 5, 40))
		scrap4:Spawn()

		local scrap5 = ents.Create("fray_scrap")
		scrap5:SetPos(self:GetPos() + Vector(-40, 0, 20))
		scrap5:Spawn()

		if self.Deliver then
			local deliver = ents.Create(self.Deliver)
			if self.ContainedWeapon then
				deliver.Weapon = self.ContainedWeapon
			end
			deliver:SetPos(self:GetPos() + Vector(0, 0, 15))
			deliver:Spawn()

			local phys = deliver:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
			end
		end

		self:EmitSound("physics/concrete/boulder_impact_hard4.wav", 80, 100)
		self:Remove()
	end
end