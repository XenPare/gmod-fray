AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local CFG = Fray.Config

function GM:Initialize()
	local spawns = CFG.PlayerSpawns
	if not spawns then
		return
	end
	for _, pos in pairs(spawns) do
		local spawn = ents.Create("fray_spawn")
		spawn:SetPos(pos)
		spawn:Spawn()
	end
end

hook.Add("PlayerSelectSpawn", "Fray", function()
	if not CFG.PlayerSpawns then
		return
	end
	local spawns = ents.FindByClass("fray_spawn")
	local random = math.random(#spawns)
	return spawns[random]
end)

hook.Add("PlayerInitialSpawn", "Fray", function(pl)
	pl:SetWalkSpeed(CFG.WalkSpeed)
	pl:SetRunSpeed(CFG.RunSpeed)
	pl:SetJumpPower(CFG.JumpPower)
	pl:SetModel(table.Random(CFG.Playermodels))

	pl:SetSimpleTimer(0.1, function()
		pl:SetTeam(TEAM_SURVIVOR)
	end)
end)

hook.Add("PlayerSpawn", "Fray", function(pl)
	pl:SetWalkSpeed(CFG.WalkSpeed)
	pl:SetRunSpeed(CFG.RunSpeed)
	pl:SetJumpPower(CFG.JumpPower)
end)