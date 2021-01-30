AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Scrap"
ENT.Category = "Fray"
ENT.Author = "crester"

ENT.Spawnable = false

local scrap = {
	"models/items/item_item_crate_chunk09.mdl",
	"models/items/item_item_crate_chunk08.mdl",
	"models/items/item_item_crate_chunk05.mdl",
	"models/items/item_item_crate_chunk07.mdl",
	"models/items/item_item_crate_chunk01.mdl",
	"models/items/item_item_crate_chunk02.mdl"
}

if SERVER then
	function ENT:Initialize()
		self:SetModel(table.Random(scrap))
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
		end

		self:SetSimpleTimer(10, function()
			self:Remove()
		end)
	end

	function ENT:OnTakeDamage()
		self:Remove()
	end
end