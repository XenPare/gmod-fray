AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Weapon"
ENT.Category = "Fray Weapons"
ENT.Author = "crester"

ENT.Spawnable = false
ENT.Model = "models/weapons/w_pist_fiveseven.mdl"

if SERVER then
	function ENT:Initialize()
		self.Weapon = self.Weapon or table.Random(Fray.Config.RandomWeaponLoot)
		self:SetNWString("WeaponClass", self.Weapon)
		self:SetModel(weapons.GetStored(self.Weapon).WorldModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end

	function ENT:Use(pl)
		pl:AddInventoryItem(self.Weapon)
		self:Remove()
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end