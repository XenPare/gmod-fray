AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Forearm"
ENT.Category = "Fray Body Armor"
ENT.Author = "crester"

ENT.Spawnable = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/snowzgmod/payday2/armour/armourlforearm.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
end