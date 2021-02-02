local scale = 0.05
local drawables = {}

surface.CreateFont("fray_nick", {
	size = 5 / scale, 
	weight = 350, 
	antialias = true, 
	extended = true, 
	font = "Roboto Condensed"
})

surface.CreateFont("fray_nick_small", {
	size = 3 / scale, 
	weight = 350, 
	antialias = true, 
	extended = true, 
	font = "Roboto Condensed"
})

local function nearest(tbl, num)
    local min, min_i
	for i, y in ipairs(tbl) do
		if tonumber(num) > y or tonumber(num) == y then
			continue
		end
        if not min or (math.abs(num - y) < min) then
            min = math.abs(num - y)
            min_i = i
        end
    end
    return tbl[min_i]
end

local function getNextRank(num)
	local nums = {}
	for rank, data in pairs(Fray.Ranks) do
		table.insert(nums, data.kills)
	end
	return nearest(nums, num)
end

local m_hp = Color(153, 66, 69)
hook.Add("PostDrawTranslucentRenderables", "Fray Nicks", function(depth, sky)
	if depth or sky then 
		return 
	end

	local ang = LocalPlayer():EyeAngles()
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	for pl in pairs(drawables) do
		if not IsValid(pl) or pl == LocalPlayer() or not pl:Alive() then
			return
		end
		if pl:GetPos():DistToSqr(LocalPlayer():GetPos()) > 40000 then
			return
		end

		local eye
		local bone_id = pl:LookupBone("ValveBiped.Bip01_Head1")
		if bone_id then
			eye = pl:GetBonePosition(bone_id)
		else
			eye = pl:GetPos()
		end

		eye.z = eye.z + 22
	
		local name = pl:Name()
		local kills = pl:GetNWString("Kills")
		local rank = Fray.GetPhrase(pl:GetNWString("Rank")) .. " (" .. kills .. "/" .. getNextRank(kills) .. ")"
		
		cam.Start3D2D(eye, Angle(0, ang.y, 90), scale)
			draw.SimpleText(name, "fray_nick", -3, 3, ColorAlpha(color_black, 200), TEXT_ALIGN_CENTER)
			draw.SimpleText(name, "fray_nick", 0, 0, color_white, TEXT_ALIGN_CENTER)

			draw.SimpleText(rank, "fray_nick_small", -3, 103, ColorAlpha(color_black, 200), TEXT_ALIGN_CENTER)
			draw.SimpleText(rank, "fray_nick_small", 0, 100, m_hp, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end)

hook.Add("UpdateAnimation", "Fray Nicks", function(pl)
	if pl == LocalPlayer() and not pl:ShouldDrawLocalPlayer() then
		return 
	end
	drawables[pl] = true
end)