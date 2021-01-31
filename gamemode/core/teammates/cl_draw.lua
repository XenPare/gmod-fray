teams = teams or nil
net.Receive("Fray Teammates Broadcast", function()
	teams = net.ReadTable()
end)

local _pl
local function getTeammates(teams)
	local mates = {}
	_pl = LocalPlayer()
	for _, team in pairs(teams) do
		if table.HasValue(team, _pl) then
			if team[1] ~= _pl then
				table.insert(mates, team[1])
			elseif team[2] ~= _pl then
				table.insert(mates, team[2])
			end
		end
	end
	for k, mate in pairs(mates) do
		if mate == _pl then
			mates[k] = nil
		end
	end
	return mates
end

local c_bl = Color(47, 83, 181)
hook.Add("PreDrawHalos", "Fray Teammates", function()
	if teams ~= nil then
		halo.Add(getTeammates(teams), c_bl, 1, 1, 3, true, true)
	end
end)

local wide, tall = ScreenScale(80), ScreenScale(40)

local offset = tall + 12

local m_hp = Color(153, 66, 69)
local m_hg = Color(189, 153, 111)
local m_th = Color(53, 114, 143)

local function _draw(y, color, stat)
	draw.RoundedBox(4, 36, y, wide - 8, 14, ColorAlpha(color_black, 180))
	draw.RoundedBox(3, 36 + 3, y + 3, stat * (wide / 100) - 14, 8, color)
end

hook.Add("HUDPaint", "Fray Teammates", function()
	if teams == nil then
		return
	end

	surface.SetFont("fray_kf")
	local count = 0
	for _, pl in SortedPairs(getTeammates(teams), true) do
		count = count + 1
		local _offset = offset * count

		draw.RoundedBox(6, 32, _offset, wide, tall, XPGUI.BGColor)

		local name = pl:Name()
		draw.SimpleText(name, "fray_kf", 32 + (wide / 2), _offset + 2 + 1, ColorAlpha(color_black, 220), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText(name, "fray_kf", 32 + (wide / 2), _offset + 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

		_draw(_offset + 32, m_hp, pl:Health())
		_draw(_offset + 52, m_hg, pl:GetNWInt("Hunger"))
		_draw(_offset + 72, m_th, pl:GetNWInt("Thirst"))
	end
end)