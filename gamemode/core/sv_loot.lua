local cfg = Fray.Config
local spawns, loot = cfg.LootSpawns, cfg.Loot

Fray.ActiveLoot = {}

local function SpawnLoot()
	if #spawns == 0 or #loot == 0 then
		return
	end

	if #Fray.ActiveLoot ~= 0 then
		for _, ent in pairs(Fray.ActiveLoot) do
			if IsValid(ent) then
				ent:Remove()
			end
		end
		table.Empty(Fray.ActiveLoot)
	end

	local mod = #player.GetAll() > (math.Round(game.MaxPlayers()) / 2) and 1 or 2
	local required = #spawns / mod

	for i = 1, required do
		local ent = ents.Create(table.Random(loot))
		ent:SetPos(spawns[i])
		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
		end
		
		table.insert(Fray.ActiveLoot, ent)
	end
end

timer.Simple(5, function()
	for _, class in pairs(loot) do
		local ENT = scripted_ents.GetStored(class).t
		function ENT:Use(pl)
			pl:AddInventoryItem(self)
		end
	end
	SpawnLoot()
end)
timer.Create("Fray Loot", cfg.LootDelay, 0, SpawnLoot)