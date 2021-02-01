local scale = 0.05

surface.CreateFont("fray_nick", {
	size = 5 / scale, 
	weight = 350, 
	antialias = true, 
	extended = true, 
	font = "Roboto Condensed"
})

hook.Add("PostPlayerDraw", "Fray Nicks", function(pl)
	if not IsValid(pl) or pl == LocalPlayer() or not pl:Alive() then
		return
	end
	if pl:GetPos():DistToSqr(LocalPlayer():GetPos()) > 40000 then
		return
	end

	local ang = LocalPlayer():EyeAngles()
 
	local eye
	local bone_id = pl:LookupBone("ValveBiped.Bip01_Head1")
	if bone_id then
		eye = pl:GetBonePosition(bone_id)
	else
		eye = pl:GetPos()
	end

	eye.z = eye.z + 18
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
 
	cam.Start3D2D(eye, Angle(0, ang.y, 90), scale)
		draw.SimpleText(pl:GetName(), "fray_nick", -3, 3, ColorAlpha(color_black, 200), TEXT_ALIGN_CENTER)
		draw.SimpleText(pl:GetName(), "fray_nick", 0, 0, color_white, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end)