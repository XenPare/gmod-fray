hook.Add("PostGamemodeLoaded", "Fray Loot Label", function()
	for _, att in pairs(Fray.Config.Loot) do
		local ENT = scripted_ents.GetStored(att).t
		function ENT:Draw()
			self:DrawModel()
		end
	end
	for att in pairs(Fray.Config.Attachments) do
		local ENT = scripted_ents.GetStored(att).t
		function ENT:Draw()
			self:DrawModel()
		end
	end
end)

local pl, tr
local x, y = ScrW() / 2, ScrH() / 2 + 128
hook.Add("HUDPaint", "Fray Loot Label", function()
	pl = LocalPlayer()
	ent = pl:GetEyeTrace().Entity
	if not IsValid(ent) or ent:GetPos():DistToSqr(pl:GetPos()) > 300000 then
		return
	end
	if Fray.InventoryList[ent:GetClass()] then
		draw.SimpleText(Fray.GetPhrase(Fray.InventoryList[ent:GetClass()].label), "xpgui_huge", x, y + 1, ColorAlpha(color_black, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(Fray.GetPhrase(Fray.InventoryList[ent:GetClass()].label), "xpgui_huge", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)