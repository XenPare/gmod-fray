local armor, sides = include("parts.lua"), {"l", "r"}

net.Receive("Body Armor AddCSModel", function()
	local pl = net.ReadEntity()
	if not IsValid(pl) then
		return
	end

	if not pl.BodyArmor then
		pl.BodyArmor = {}
	end

	local id = net.ReadString()
	if istable(armor[id]) then
		for _, side in pairs(sides) do
			local mdl = ClientsideModel("models/snowzgmod/payday2/armour/armour" .. side .. id .. ".mdl", RENDERGROUP_OPAQUE)
			mdl:SetNoDraw(true)
			pl.BodyArmor[side .. id] = mdl
		end
	else
		local mdl = ClientsideModel("models/snowzgmod/payday2/armour/armour" .. id .. ".mdl", RENDERGROUP_OPAQUE)
		mdl:SetNoDraw(true)
		pl.BodyArmor[id] = mdl
	end
end)

net.Receive("Body Armor RemoveCSModel", function()
	local pl = net.ReadEntity()
	if not IsValid(pl) then
		return
	end

	if not pl.BodyArmor then
		pl.BodyArmor = {}
	end

	local id = net.ReadString()
	if istable(armor[id]) then
		for _, side in pairs(sides) do
			if pl.BodyArmor[side .. id] and IsValid(pl.BodyArmor[side .. id]) then
				pl.BodyArmor[side .. id]:Remove()
				pl.BodyArmor[side .. id] = nil
			end
		end
	else
		if pl.BodyArmor[id] and IsValid(pl.BodyArmor[id]) then
			pl.BodyArmor[id]:Remove()
			pl.BodyArmor[id] = nil
		end
	end
end)

hook.Add("PostPlayerDraw", "Fray Body Armor", function(pl)
	if not IsValid(pl) or not pl:Alive() or not pl.BodyArmor then
		return 
	end
	for base, id in pairs(armor) do
		if istable(id) then
			for _, side in pairs(sides) do
				local pos, ang = Vector(), Angle()

				local bone_id = pl:LookupBone(id[side])
				if not bone_id then 
					continue 
				end

				pos, ang = pl:GetBonePosition(bone_id)
				ang:RotateAroundAxis(ang:Up(), -90)

				local mdl = pl.BodyArmor[side .. base]
				if not IsValid(mdl) or mdl == nil then
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
			local pos, ang = Vector(), Angle()

			local bone_id = pl:LookupBone(id)
			if not bone_id then 
				continue 
			end

			pos, ang = pl:GetBonePosition(bone_id)
			pos = pos + (ang:Right() * -3.5) + (ang:Forward() * -10.5)
			ang:RotateAroundAxis(ang:Up(), 90)
			ang:RotateAroundAxis(ang:Forward(), 90)

			local mdl = pl.BodyArmor[base]
			if not IsValid(mdl) or mdl == nil then
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
	end
end)