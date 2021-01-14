AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Spawn"
ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl")

		self:PhysicsInit(SOLID_NONE)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_NONE)

		self:SetColor(ColorAlpha(color_white, 0)) 
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	end
end