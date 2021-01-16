local cfg = Fray.Config
local spawns, loot, active = cfg.LootSpawns, cfg.Loot, {}

local function SpawnLoot()
	if not loot or #loot == 0 then
		return
	end

	if #active ~= 0 then
		for _, ent in pairs(active) do
			if IsValid(ent) then
				ent:Remove()
			end
		end
		table.Empty(active)
	end

	local mod = #player.GetAll() > (math.Round(game.MaxPlayers()) / 2) and 2 or 1
	local required = #spawns / mod

	local used, i = {}, 1
	while #used ~= required do
		i = i + 1
		local pos = spawns[i]
		if not table.HasValue(used, pos) then
			table.insert(used, pos)
		end
	end

	for i = 1, required do
		local ent = ents.Create(table.Random(loot))
		ent:SetPos(used[i])
		ent:Spawn()
		table.insert(active, ent)
	end
end

hook.Add("InitPostEntity", "Fray", SpawnLoot)
timer.Create("Fray Loot", cfg.LootDelay, 0, SpawnLoot)