local cfg = Fray.Config
local spawns, loot = cfg.LootSpawns, cfg.Loot

util.AddNetworkString("Fray Broadcast Loot")
util.AddNetworkString("Fray Get Loot Table")

Fray.ActiveLoot = {}

local function BroadcastLoot()
	net.Start("Fray Broadcast Loot")
		net.WriteTable(Fray.ActiveLoot)
	net.Broadcast()
end

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

	BroadcastLoot()
end

hook.Add("Initialize", "Fray Loot", function()
	for _, class in pairs(loot) do
		if not string.find(class, "cw_") or not string.find(class, "_wep_") then
			continue
		end
		local ENT = scripted_ents.GetStored(class).t
		function ENT:Use(pl)
			if table.HasValue(Fray.ActiveLoot, self) then
				table.RemoveByValue(Fray.ActiveLoot, self)
				BroadcastLoot()
			end
			pl:AddInventoryItem(self)
		end
	end
	timer.Simple(1, function()
		SpawnLoot()
	end)
end)
timer.Create("Fray Loot Broadcast", 15, 0, BroadcastLoot)
timer.Create("Fray Loot", cfg.LootDelay, 0, SpawnLoot)