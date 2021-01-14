include("shared.lua")

local CFG = FBL.Config

local tohide = CFG.HideHUD
hook.Add("HUDShouldDraw", "FBL", function(name)
	if tohide[name] then 
		return false 
	end
end)