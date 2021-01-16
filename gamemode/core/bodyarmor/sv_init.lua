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
		local res = 0.85
		if pl:GetNWBool("BA #bicep") then
			res = res - 0.2
		end
		if pl:GetNWBool("BA #forearm") then
			res = res - 0.2
		end
		dmg:ScaleDamage(res)
	end
	if hit == HITGROUP_LEFTLEG or hit == HITGROUP_RIGHTLEG then
		local res = 0.75
		if pl:GetNWBool("BA #calf") then
			res = res - 0.2
		end
		if pl:GetNWBool("BA #thigh") then
			res = res - 0.2
		end
		dmg:ScaleDamage(res)
	end
end)