gameevent.Listen("player_hurt")

local shouldHitmarker = false
local stopMarkingTime = CurTime()
local newhp

hook.Add("HUDPaint", "Fray Hit Markers", function()
	if shouldHitmarker then
		draw.SimpleTextOutlined(newhp, "CW_HUD24", ScrW() / 2, ScrH() / 2, Color(170, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 0.5, color_black)
	end
	if CurTime() >= stopMarkingTime then
		shouldHitmarker = false
	end
end)

hook.Add("player_hurt", "Fray Hit Markers", function(data)
	local attacker = Player(data.attacker)
	local hp = data.health
	if (IsValid(attacker) and attacker:Alive() and attacker == LocalPlayer()) then
		newhp = hp
		if hp == 0 then
			surface.PlaySound("npc/vort/foot_hit.wav")
		end
		shouldHitmarker = true
		stopMarkingTime = CurTime() + 0.8
	end
end)