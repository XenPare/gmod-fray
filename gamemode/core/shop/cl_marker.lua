local cl = Color(108, 235, 118)
hook.Add("HUDPaint", "Fray Delivery Markers", function()
	for _, ent in pairs(ents.GetAll()) do
		if not IsValid(ent:GetNWEntity("Recipient")) or ent:GetNWEntity("Recipient") ~= LocalPlayer() then
			continue
		end

		local pos = (ent:GetPos() + ent:OBBCenter()):ToScreen()
		draw.SimpleText("▼", "xpgui_huge", pos.x, pos.y + 1 + (math.sin(CurTime() * 15) * 2), ColorAlpha(color_black, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("▼", "xpgui_huge", pos.x, pos.y + (math.sin(CurTime() * 15) * 2), cl, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)