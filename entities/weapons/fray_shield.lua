AddCSLuaFile()

SWEP.PrintName = "Ballistic Shield"
SWEP.Author = "crester"
SWEP.Category = "Fray"

SWEP.Slot = 1
SWEP.SlotPos = 3
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false	

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/arccw_go/v_shield.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shield.mdl"
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "melee2"

function SWEP:Initialize()
	self:SetHoldType(self.HoldType or "normal")
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:PrimaryAttack()
	return
end

function SWEP:SecondaryAttack()
	return
end

function SWEP:Reload()
	return
end

if SERVER then
	function SWEP:Holster()
		if IsValid(self.shield) then 
			self.shield:Remove() 
		end
		return true
	end

	function SWEP:Deploy()
		self.Owner:DrawViewModel(false)
		if IsValid(self.shield) then 
			return 
		end

		self.shield = ents.Create("prop_physics")
		self.shield:SetModel(self.WorldModel)
		self.shield:SetPos(self.Owner:GetPos() + (self.Owner:GetUp() * 58) + (self.Owner:GetRight() * 3) + (self.Owner:GetForward() * 13))
		self.shield:SetAngles(Angle(0, self.Owner:EyeAngles().y, 0))
		self.shield:SetParent(self.Owner)

		self.shield:Fire("SetParentAttachmentMaintainOffset", "eyes", 0.01)
		self.shield:SetCollisionGroup(COLLISION_GROUP_WORLD)

		self.shield:Spawn()
		self.shield:Activate()

		self.shield:SetColor(ColorAlpha(color_white, 0)) 
		self.shield:SetRenderMode(RENDERMODE_TRANSCOLOR)

		return true
	end

	function SWEP:OnDrop()
		if IsValid(self.shield) then 
			self.shield:Remove() 
		end
	end

	function SWEP:OnRemove()
		if IsValid(self.shield) then 
			self.shield:Remove() 
		end
	end
end

if CLIENT then
	local mdl = ClientsideModel(SWEP.WorldModel)
	mdl:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if IsValid(owner) then
			local att_id = owner:LookupAttachment("eyes")
			if not att_id then 
				return 
			end

			local att = owner:GetAttachment(att_id)
			if not att then 
				return 
			end

			local pos, ang = att.Pos, att.Ang
			pos = pos + (ang:Forward() * 5) + (ang:Up() * 3)

			mdl:SetPos(pos)
			mdl:SetAngles(ang)

			mdl:SetupBones()
		else
			mdl:SetPos(self:GetPos())
			mdl:SetAngles(self:GetAngles())
		end
		mdl:DrawModel()
	end
end