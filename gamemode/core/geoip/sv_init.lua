local service = "http://ip-api.com/json/"

function Fray.SetCountry(pl)
	local ip = string.Explode(":", pl:IPAddress())[1]
	http.Fetch(service .. ip, function(body)
		local data = util.JSONToTable(body)
		pl:SetNWString("Country", data.country)
	end)
end

util.AddNetworkString("Fray Language Propose")
function Fray.LanguagePropose(pl)
	local current = pl:GetInfo("fray_lang")
	local country = pl:GetNWString("Country")

	local supposed = nil
	for code, lang in pairs(Fray.Languages) do
		if lang.Zones[country] then
			supposed = code
		end
	end

	if supposed == nil then
		supposed = Fray.Config.BaseLanguage
	end

	if current ~= supposed then
		net.Start("Fray Language Propose")
			net.WriteString(current)
			net.WriteString(supposed)
		net.Send(pl)
	end
end