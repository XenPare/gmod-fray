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
local wep
hook.Add("HUDPaint", "Fray Loot Label", function()
	pl = LocalPlayer()
	ent = pl:GetEyeTrace().Entity
	if not IsValid(ent) or ent:GetPos():DistToSqr(pl:GetPos()) > 22500 then
		return
	end

	wep = ent:GetNWString("WeaponClass")
	if Fray.InventoryList[ent:GetClass()] then
		draw.SimpleText(Fray.GetPhrase(Fray.InventoryList[ent:GetClass()].label), "xpgui_huge", x, y + 1 + (math.sin(CurTime() * 15) * 2), ColorAlpha(color_black, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(Fray.GetPhrase(Fray.InventoryList[ent:GetClass()].label), "xpgui_huge", x, y + (math.sin(CurTime() * 15) * 2), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif tobool(wep) and wep:find("cw") then
		draw.SimpleText(weapons.GetStored(wep).PrintName, "xpgui_huge", x, y + 1 + (math.sin(CurTime() * 15) * 2), ColorAlpha(color_black, 240), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(weapons.GetStored(wep).PrintName, "xpgui_huge", x, y + (math.sin(CurTime() * 15) * 2), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)