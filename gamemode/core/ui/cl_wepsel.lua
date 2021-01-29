local wide, height = ScreenScale(135), ScreenScale(14)

surface.CreateFont("fray_wepsel", {
	font = "Roboto Th",
	size = height,
	weight = 500
})

local function txt(text, x, y, color, xalign, yalign, font, alpha)
	color = color or color_white
	return draw.TextShadow({
		text = text,
		font = "fray_wepsel",
		pos = {x, y},
		color = color,
		xalign = xalign or TEXT_ALIGN_LEFT,
		yalign = yalign or TEXT_ALIGN_LEFT
	}, 1, alpha or (color.a * 0.575))
end

local wepsel = {}
wepsel.index = wepsel.index or 1
wepsel.deltaIndex = wepsel.deltaIndex or wepsel.index
wepsel.infoAlpha = wepsel.infoAlpha or 0
wepsel.alpha = wepsel.alpha or 0
wepsel.alphaDelta = wepsel.alphaDelta or wepsel.alpha
wepsel.fadeTime = wepsel.fadeTime or 0
wepsel.weapons = wepsel.weapons or {}

local color, _color
hook.Add("HUDPaint", "Fray Weapon Selector", function()
	local ft = FrameTime()
	wepsel.alphaDelta = Lerp(ft * 10, wepsel.alphaDelta, wepsel.alpha)

	local fraction = wepsel.alphaDelta
	if fraction > 0.01 then
		local x, y = ScrW() / 2, ScrH() * 0.4
		local spacing = ScrH() / 380
		local radius = 240 * wepsel.alphaDelta
		local shift = ScrW() * 0.02

		wepsel.deltaIndex = Lerp(ft * 12, wepsel.deltaIndex, wepsel.index)
		local index = wepsel.deltaIndex
		if not wepsel.weapons[wepsel.index] then
			wepsel.index = #wepsel.weapons
		end

		for i = 1, #wepsel.weapons do
			local theta = (i - index) * 0.1
			local color = i == wepsel.index and Color(117, 77, 113, 120) or Color(40, 40, 40, 200)
			color.a = (color.a - math.abs(theta * 3) * color.a) * fraction

			local text = i == wepsel.index and 10 + math.sin(CurTime() * 4) * 5 or 10
			local lastY = 0

			if wepsel.markup and (i < wepsel.index or i == 1) then
				if wepsel.index ~= 1 then
					local _, h = wepsel.markup:Size()
					lastY = h * fraction
				end
				if i == 1 or i == wepsel.index - 1 then
					wepsel.infoAlpha = Lerp(ft * 3, wepsel.infoAlpha, 255)
					wepsel.markup:Draw(x + 6 + shift, y + 30, 0, 0, wepsel.infoAlpha * fraction)
				end
			end

			surface.SetFont("fray_wepsel")
			if not IsValid(wepsel.weapons[i]) then
				continue
			end
			
			local weaponName = wepsel.weapons[i]:GetPrintName():upper()
			local _, ty = surface.GetTextSize(weaponName)

			local matrix = Matrix()
			matrix:Translate(Vector(shift + x + math.cos(theta * spacing + math.pi) * radius + radius, y + lastY + math.sin(theta * spacing + math.pi) * radius - ty / 2, 1))
			matrix:Scale(Vector(1, 1, 0))

			local _color = ColorAlpha(i == wepsel.index and color_white or color_white, (255 - math.abs(theta * 3) * 255) * fraction)

			cam.PushModelMatrix(matrix)
				txt(weaponName, text, ty / 2 - 1, _color, 0, 1, "fray_wepsel")
				if i > wepsel.index - 4 and i < wepsel.index + 4 then
					surface.SetTexture(surface.GetTextureID("vgui/gradient-l"))
					surface.SetDrawColor(color)
					surface.DrawTexturedRect(0, 0, wide, height)
				end
			cam.PopModelMatrix()
		end

		if wepsel.fadeTime < CurTime() and wepsel.alpha > 0 then
			wepsel.alpha = 0
		end
	elseif #wepsel.weapons > 0 then
		wepsel.weapons = {}
	end
end)

local _pl
function on_ic(weapon)
	wepsel.alpha = 1
	wepsel.fadeTime = CurTime() + 5
	wepsel.markup = nil
	if IsValid(weapon) then
		local instructions = weapon.Instructions
		local text = ""
		local source, pitch = hook.Run("WeaponCycleSound")
		_pl:EmitSound(source or "common/talk.wav", 50, pitch or 180)
	end
end

hook.Add("PlayerBindPress", "Fray Weapon Selector", function(pl, bind, pressed)
	bind = bind:lower()
	if not pressed or not bind:find("invprev") and not bind:find("invnext") and not bind:find("slot") and not bind:find("attack") then
		return
	end

	local currentWeapon = pl:GetActiveWeapon()
	local bValid = IsValid(currentWeapon)
	if pl:InVehicle() or (bValid and currentWeapon:GetClass() == "weapon_physgun" and pl:KeyDown(IN_ATTACK)) then
		return
	end

	local bTool
	if bValid and currentWeapon:GetClass() == "gmod_tool" then
		local tool = pl:GetTool()
		bTool = tool and (tool.Scroll ~= nil)
	end

	wepsel.weapons = {}
	for _, v in pairs(pl:GetWeapons()) do
		wepsel.weapons[#wepsel.weapons + 1] = v
	end

	if bind:find("invprev") and not bTool then
		local oldIndex = wepsel.index
		wepsel.index = math.min(wepsel.index + 1, #wepsel.weapons)
		if (wepsel.alpha == 0 or oldIndex ~= wepsel.index) then
			on_ic(wepsel.weapons[wepsel.index])
		end
		return true
	elseif bind:find("invnext") and not bTool then
		local oldIndex = wepsel.index
		wepsel.index = math.max(wepsel.index - 1, 1)
		if (wepsel.alpha == 0 or oldIndex ~= wepsel.index) then
			on_ic(wepsel.weapons[wepsel.index])
		end
		return true
	elseif (bind:find("slot")) then
		wepsel.index = math.Clamp(tonumber(bind:match("slot(%d)")) or 1, 1, #wepsel.weapons)
		on_ic(wepsel.weapons[wepsel.index])
		return true
	elseif (bind:find("attack") and wepsel.alpha > 0) then
		local weapon = wepsel.weapons[wepsel.index]
		if IsValid(weapon) then
			LocalPlayer():EmitSound("HL2Player.Use")
			input.SelectWeapon(weapon)
			wepsel.alpha = 0
		end
		return true
	end
end)

hook.Add("Think", "Fray Weapon Selector", function()
	_pl = LocalPlayer()
	if not IsValid(_pl) or not _pl:Alive() then
		wepsel.alpha = 0
	end
end)

hook.Add("ScoreboardShow", "Fray Weapon Selector", function()
	wepsel.alpha = 0
end)