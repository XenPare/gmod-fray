local teams = nil
net.Receive("Fray Teammates Broadcast", function()
	teams = net.ReadTable()
end)

local function getTeammates(teams)
	local mates = {}
	for _, team in pairs(teams) do
		if table.HasValue(team, LocalPlayer()) then
			local mate
			if team[1] == pl then
				mate = team[2]
			elseif team[2] == pl then
				mate = team[1]
			end
			table.insert(mates, mate)
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

local offset = 38
local c_dead, c_alive = Color(153, 66, 69), Color(66, 163, 57)
hook.Add("HUDPaint", "Fray Teammates", function()
	if teams == nil then
		return
	end

	surface.SetFont("fray_kf")
	local done, count = {}, 0
	for k, pl in SortedPairs(getTeammates(teams), true) do
		if table.HasValue(done, key) then
			continue
		end

		table.insert(done, k)
		count = count + 1
		local _offset = offset * count

		local name = "- " .. pl:Name()
		draw.SimpleText(name, "fray_kf", 32, _offset + 2, ColorAlpha(color_black, 220), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(name, "fray_kf", 32, _offset, pl:Alive() and c_alive or c_dead, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end)