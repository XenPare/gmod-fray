local optf, kf = ScreenScale(10), {}

surface.CreateFont("fray_kf", {
	font = "Roboto Condensed",
	size = optf,
	weight = 400,
	extended = true,
	antialias = true
})

net.Receive("Fray KillFeed", function()
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()
	local tbl = {
		victim = victim,
		attacker = attacker
	}
	table.insert(kf, tbl)
	timer.Simple(10, function()
		table.RemoveByValue(kf, tbl)
	end)
end)

local offset = 24
local color_attacker, color_victim = Color(153, 66, 69), Color(0, 161, 255)
hook.Add("HUDPaint", "Fray KillFeed", function()
	surface.SetFont("fray_kf")
	local done, count = {}, 0
	for key, data in SortedPairs(kf, true) do
		if table.HasValue(done, key) or count >= 3 then
			continue
		end

		table.insert(done, key)
		count = count + 1
		local _offset = offset * count

		local attacker = IsValid(data.attacker) and ("(" .. Fray.GetPhrase(data.attacker:GetNWString("Rank")) .. ") " .. data.attacker:Name()) or "World "

		local victim = IsValid(data.victim) and ("(" .. Fray.GetPhrase(data.victim:GetNWString("Rank")) .. ") " .. data.victim:Name()) or "World"
		local victim_w = surface.GetTextSize(victim)

		local killed = Fray.GetPhrase("killed")
		local killed_w = surface.GetTextSize(killed)

		draw.SimpleText(attacker, "fray_kf", ScrW() - 32 - 5 - victim_w - 5 - killed_w, _offset + 2, ColorAlpha(color_black, 220), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText(attacker, "fray_kf", ScrW() - 32 - 5 - victim_w - 5 - killed_w, _offset, color_attacker, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
	
		draw.SimpleText(killed, "fray_kf", ScrW() - 32 - 5 - victim_w, _offset + 2, ColorAlpha(color_black, 220), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText(killed, "fray_kf", ScrW() - 32 - 5 - victim_w, _offset, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

		draw.SimpleText(victim, "fray_kf", ScrW() - 32, _offset + 2, ColorAlpha(color_black, 220), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		draw.SimpleText(victim, "fray_kf", ScrW() - 32, _offset, color_victim, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
	end
end)

hook.Add("DrawDeathNotice", "Fray KillFeed", function()
	return 0, 0
end)