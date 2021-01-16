AddCSLuaFile("parts.lua")

util.AddNetworkString("Body Armor AddCSModel")

local pl = FindMetaTable("Player")
function pl:SetBodyArmor(part, bool)
	self:SetNWBool("BA #" .. part, bool)
	timer.Simple(0.1, function()
		if not IsValid(self) then
			return
		end
		net.Start("Body Armor AddCSModel")
			net.WriteEntity(self)
			net.WriteString(part)
		net.Broadcast()
		self:SetBodyArmor(part, bool)
	end)
end

hook.Add("ScalePlayerDamage", "Fray Body Armor", function(pl, hit, dmg)
	if (hit == HITGROUP_CHEST or hit == HITGROUP_STOMACH) and pl:GetNWBool("BA #chest") then
		dmg:ScaleDamage(0.4)
	end
	if hit == HITGROUP_LEFTARM or hit == HITGROUP_RIGHTARM then
		local protect = 1
		if pl:GetNWBool("BA #bicep") then
			protect = protect - 0.3
		end
		if pl:GetNWBool("BA #forearm") then
			protect = protect - 0.3
		end
		dmg:ScaleDamage(protect)
	end
	if hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
		local protect = 1
		if pl:GetNWBool("BA #calf") then
			protect = protect - 0.3
		end
		if pl:GetNWBool("BA #thigh") then
			protect = protect - 0.3
		end
		dmg:ScaleDamage(protect)
	end
end)