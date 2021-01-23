local lng_base = Fray.Config.BaseLanguage

CreateClientConVar("fray_lang", lng_base, true, true, "The default language gamemode should use")

Fray.Languages = Fray.Languages or {}

if CLIENT then
	function Fray.GetPhrase(str)
		return Fray.Languages[LocalPlayer():GetInfo("fray_lang") or lng_base]["Phrases"][str]
	end
end

if SERVER then
	function Fray.GetPhrase(str, pl)
		if not IsValid(pl) then
			return Fray.Languages[lng_base]["Phrases"][str]
		end
		return Fray.Languages[pl:GetInfo("fray_lang")]["Phrases"][str]
	end
end

local files = file.Find(GM.FolderName .. "/gamemode/language/*", "LUA")
for _, lng in pairs(files) do
	AddCSLuaFile(GM.FolderName .. "/gamemode/language/" .. lng)
	local code = string.StripExtension(lng)
	Fray.Languages[code] = include("language/" .. lng)
end