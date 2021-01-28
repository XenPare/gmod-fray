net.Receive("Fray Ranks Broadcast", function()
	local pl = net.ReadEntity()
	local rank = pl:GetNWString("Rank")
	if Fray.Ranks[rank] then
		local mdl = Fray.Ranks[rank].mask
		if pl.Mask and IsValid(pl.Mask) and pl.Mask:GetModel() ~= mdl then
			pl.Mask:Remove()
		end

		local mask = ClientsideModel(mdl, RENDERGROUP_OPAQUE)
		mask:SetNoDraw(true)
		pl.Mask = mask
	end
end)

hook.Add("PostPlayerDraw", "Fray Ranks", function(pl)
	if not IsValid(pl) or not pl:Alive() or not pl.Mask then
		return 
	end

	local att_id = pl:LookupAttachment("eyes")
	if not att_id then 
		return 
	end
			
	local att = pl:GetAttachment(att_id)
	if not att then 
		return 
	end

	local pos, ang = att.Pos, att.Ang
	local model = pl.Mask

	model:SetPos(pos)
	model:SetAngles(ang)

	model:SetRenderOrigin(pos)
	model:SetRenderAngles(ang)

	model:SetupBones()
	model:DrawModel()

	model:SetRenderOrigin()
	model:SetRenderAngles()
end)