local function saveHealth(pl)
	file.Write("fray/stats/health/" .. pl:SteamID64() .. ".txt", tostring(pl:Health()))
end

hook.Add("PlayerInitialSpawn", "Fray Health", function(pl)
	local path = "fray/stats/health/" .. pl:SteamID64() .. ".txt"
	local exists = file.Exists(path, "DATA")
	if not exists then
		file.Write(path, "100")
	end
	pl:SetHealth(tonumber(file.Read(path)))
	pl:SetTimer("Health Save", 120, 0, function()
		saveHealth(pl)
	end)
end)
hook.Add("PlayerDisconnected", "Fray Health", saveHealth)