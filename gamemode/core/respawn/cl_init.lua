local r_time = Fray.Config.RespawnTime

local function addText(str, font, x, y, color, align_x, align_y)
	draw.SimpleText(str, font, x, y + 1, ColorAlpha(color_black, 240), align_x or TEXT_ALIGN_LEFT, align_y or TEXT_ALIGN_TOP)
	draw.SimpleText(str, font, x, y, color, align_x or TEXT_ALIGN_LEFT, align_y or TEXT_ALIGN_TOP)
end

local col_face = color_white
local col_shadow = color_black
local col_half_shadow = ColorAlpha(color_black, 200)
local matBlurScreen = Material("pp/blurscreen")

local view = {
	origin = Vector(0, 0, 0),
	angles = Angle(0, 0, 0),
	fov = 90,
	znear = 1
}

hook.Add("CalcView", "Fray Respawn", function(pl, origin, angles, fov)
	if pl:Health() > 0 then 
		return 
	end

	local ragdoll = pl:GetNWEntity("Ragdoll")
	if not IsValid(ragdoll) then 
		return 
	end

	local head = ragdoll:LookupAttachment("eyes")
	head = ragdoll:GetAttachment(head)
	if not head or not head.Pos then 
		return
	end

	if not ragdoll.BonesRattled then
		ragdoll.BonesRattled = true

		ragdoll:InvalidateBoneCache()
		ragdoll:SetupBones()

		local matrix
		for bone = 0, (ragdoll:GetBoneCount() or 1) do
			if ragdoll:GetBoneName(bone):lower():find("head") then
				matrix = ragdoll:GetBoneMatrix(bone)
				break
			end
		end

		if IsValid(matrix) then
			matrix:SetScale(Vector(0, 0, 0))
		end
	end

	view.origin = head.Pos + head.Ang:Up() * 8
	view.angles = head.Ang

	return view
end)

local dead, txt = nil
local hidden = true
local c_bg = Color(153, 66, 69)
hook.Add("HUDPaint", "Fray Respawn", function()
	if LocalPlayer():Health() > 0 or hidden then
		return
	end 

	render.SetScissorRect(0, 0, ScrW(), ScrH(), true)
		surface.SetMaterial(matBlurScreen)
		surface.SetDrawColor(ColorAlpha(color_black))
		for i = 0.33, 1, 0.33 do
			matBlurScreen:SetFloat("$blur", 5 * i)
			matBlurScreen:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
		end
		surface.SetDrawColor(ColorAlpha(color_black, 140))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	render.SetScissorRect(0, 0, 0, 0, false)		
	
	surface.SetDrawColor(ColorAlpha(c_bg, 30))
	surface.DrawRect(0, 0, ScrW(), ScrH())

	if dead ~= nil then
		txt = Fray.GetPhrase("respawn") .. math.Round(r_time - RealTime() + dead) .. Fray.GetPhrase("seconds")
	end

	addText(txt, "xpgui_huge", ScrW() / 2, ScrH() * 0.9, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

net.Receive("Fray Respawn", function()
	dead, hidden = RealTime(), false
	timer.Simple(r_time, function()
		txt = Fray.GetPhrase("can_respawn")
		dead = nil
	end)
	system.FlashWindow()
end)

net.Receive("Fray Respawn Remove", function()
	hidden = true
end)