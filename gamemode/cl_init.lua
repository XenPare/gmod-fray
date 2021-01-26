include("shared.lua")
include("lang.lua")

local CFG = Fray.Config

local tohide = CFG.HideHUD
hook.Add("HUDShouldDraw", "Fray", function(name)
	if tohide[name] then 
		return false 
	end
end)