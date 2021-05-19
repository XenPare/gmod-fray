local teams = teams or nil
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
				if team[1]:Alive() then
					table.insert(mates, team[1])
				end
			elseif team[2] ~= _pl then
				if team[2]:Alive() then
					table.insert(mates, team[2])
				end
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

local wide, tall = ScreenScale(80), ScreenScale(20)
local b_tall = ScreenScale(4)
local b_offset = b_tall + ScreenScale(7)

local offset = tall + 12

local m_hp = Color(153, 66, 69)

local function _draw(y, color, stat)
	draw.RoundedBox(4, 36, y, wide - 8, b_tall + 6, ColorAlpha(color_black, 180))
	draw.RoundedBox(3, 36 + 3, y + 3, stat * (wide / 100) - 14, b_tall, color)
end

hook.Add("HUDPaint", "Fray Teammates", function()
	if teams == nil then
		return
	end

	local count = 0
	for _, pl in SortedPairs(getTeammates(teams), true) do
		count = count + 1
		local _offset = offset * count

		draw.RoundedBox(6, 32, _offset, wide, tall, XPGUI.BGColor)

		local name = IsValid(pl) and pl:Name() or "Unknown"
		draw.SimpleText(name, "fray_kf", 32 + (wide / 2), _offset + 2 + 1, ColorAlpha(color_black, 220), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText(name, "fray_kf", 32 + (wide / 2), _offset + 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

		local hp = IsValid(pl) and pl:Health() or 100
		local hp_max = IsValid(pl) and pl:GetMaxHealth() or 100
 		_draw(_offset + b_offset, m_hp, math.Clamp(hp, 0, hp_max))
	end
end)