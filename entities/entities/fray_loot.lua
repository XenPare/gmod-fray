AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Loot Base"
ENT.Category = "Fray Loot"
ENT.Author = "crester"

ENT.Spawnable = false
ENT.Model = "models/squad/sf_plates/sf_plate1x1.mdl"

if SERVER then
	function ENT:Initialize()
		self:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end

	function ENT:Use(pl)
		if not self.Weapon then
			pl:AddInventoryItem(self)
		else
			pl:Give(self.Weapon)
		end
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end