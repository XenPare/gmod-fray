hook.Add("PostGamemodeLoaded", "Fray Attachments", function()
	for att in pairs(scripted_ents.GetList()) do
		if string.find(att, "attpack") then
			Fray.Config.Attachments[att] = scripted_ents.Get(att).attachments
		end
	end
	if SERVER then
		for att in pairs(Fray.Config.Attachments) do
			local ENT = scripted_ents.GetStored(att).t
			function ENT:Use(pl)
				pl:AddInventoryItem(self)
			end
		end
	end
end)