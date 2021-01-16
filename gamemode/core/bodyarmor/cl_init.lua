local armor, sides = include("parts.lua"), {"l", "r"}

PrintTable(armor)

net.Receive("Body Armor AddCSModel", function()
	local pl = net.ReadEntity()
	if not IsValid(pl) then
		return
	end

	local part = net.ReadString()
	if pl:GetNWBool("BA #" .. part) then
		if istable(armor[part]) then
			for _, side in pairs(sides) do
				local mdl = ClientsideModel("models/snowzgmod/payday2/armour/armour" .. side .. part .. ".mdl", RENDERGROUP_OPAQUE)
				mdl:SetNoDraw(true)
				pl.BodyArmor[side .. part] = mdl
			end
		else
			local mdl = ClientsideModel("models/snowzgmod/payday2/armour/armour" .. part .. ".mdl", RENDERGROUP_OPAQUE)
			mdl:SetNoDraw(true)
			pl.BodyArmor[part] = mdl
		end
	else
		if istable(armor[part]) then
			for _, side in pairs(sides) do
				if pl.BodyArmor[side .. part] and IsValid(pl.BodyArmor[side .. part]) then
					pl.BodyArmor[side .. part]:Remove()
					pl.BodyArmor[side .. part] = nil
				end
			end
		else
			if pl.BodyArmor[part] and IsValid(pl.BodyArmor[part]) then
				pl.BodyArmor[part]:Remove()
				pl.BodyArmor[part] = nil
			end
		end
	end
end)

hook.Add("PostPlayerDraw", "Fray Body Armor", function(pl)
	if not pl.BodyArmor then
		pl.BodyArmor = {}
	end
	if not IsValid(pl) or not pl:Alive() then 
		return 
	end
	for base, part in pairs(armor) do
		if istable(part) then
			for _, side in pairs(sides) do
				local model = "models/snowzgmod/payday2/armour/armour" .. side .. base .. ".mdl"
				local pos, ang = Vector(), Angle()

				local bone_id = pl:LookupBone(part[side])
				if not bone_id then 
					continue 
				end

				pos, ang = pl:GetBonePosition(bone_id)
				ang:RotateAroundAxis(ang:Up(), -90)

				local mdl = pl.BodyArmor[side .. base]
				if mdl == nil or not mdl then
					continue
				end

				mdl:SetPos(pos)
				mdl:SetAngles(ang)
		
				mdl:SetRenderOrigin(pos)
				mdl:SetRenderAngles(ang)
				
				mdl:SetupBones()
				mdl:DrawModel()
					
				mdl:SetRenderOrigin()
				mdl:SetRenderAngles()
			end
		else
			local model = "models/snowzgmod/payday2/armour/armour" .. base .. ".mdl"
			local pos, ang = Vector(), Angle()

			local bone_id = pl:LookupBone(part)
			if not bone_id then 
				continue 
			end

			pos, ang = pl:GetBonePosition(bone_id)
			pos = pos + (ang:Right() * -3.5) + (ang:Forward() * -10.5)
			ang:RotateAroundAxis(ang:Up(), 90)
			ang:RotateAroundAxis(ang:Forward(), 90)

			local mdl = pl.BodyArmor[base]
			if mdl == nil or not mdl then
				continue
			end

			mdl:SetPos(pos)
			mdl:SetAngles(ang)
	
			mdl:SetModelScale(1)
	
			mdl:SetRenderOrigin(pos)
			mdl:SetRenderAngles(ang)
			
			mdl:SetupBones()
			mdl:DrawModel()
				
			mdl:SetRenderOrigin()
			mdl:SetRenderAngles()
		end
	end
end)