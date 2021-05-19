util.AddNetworkString("Fray Corpse")
util.AddNetworkString("Fray Corpse Take")

local DeathRagdolls, CleanTime = {}, Fray.Config.CorpseCleanTime

net.Receive("Fray Corpse Take", function(_, pl)
	local corpse = net.ReadEntity()
	local class = net.ReadString()

	if not IsValid(corpse) or not corpse.PlayerRag or pl:GetPos():DistToSqr(corpse:GetPos()) > 40000 then
		return
	end

	if (IsValid(corpse:GetNWEntity("LootingEntity")) and corpse:GetNWEntity("LootingEntity") ~= pl) or not table.HasValue(corpse.Inventory, class) then
		return
	end

	local list = Fray.InventoryList
	if not list[class] or ((pl:CalculateInventoryWeight() + list[class].weight) >= Fray.Config.MaxInventoryWeight) or (list[class].max and pl:CalculateInventoryItemCount(class) >= list[class].max or false) then
		return
	end

	table.RemoveByValue(corpse.Inventory, class)
	pl:AddInventoryItem(class)

	corpse:SetNWEntity("LootingEntity", pl)
	if corpse:TimerExists("Looting") then
		corpse:RemoveTimer("LootingEntity")
	end
	corpse:SetTimer("Looting", 10, 1, function()
		corpse:SetNWEntity("LootingEntity", nil)
	end)
end)

local function createRagdoll(pl)
	local _ragdoll = pl:GetRagdollEntity()
	if _ragdoll and IsValid(_ragdoll) then 
		_ragdoll:Remove() 
	end

	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetModel(pl:GetModel())
	ragdoll:SetPos(pl:GetPos())

	for _, v in pairs(pl:GetBodyGroups()) do
		ragdoll:SetBodygroup(v.id, pl:GetBodygroup(v.id))
	end

	ragdoll:Spawn()
	ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local plyvel = pl:GetVelocity()
	for id = 0, ragdoll:GetPhysicsObjectCount() - 1 do
		local physbone = ragdoll:GetPhysicsObjectNum(id)
		if IsValid(physbone) then
			local pos, ang = pl:GetBonePosition(ragdoll:TranslatePhysBoneToBone(id))
			physbone:SetPos(pos)
			physbone:SetAngles(ang)
			physbone:AddVelocity(plyvel)
		end
	end

	ragdoll.CanConstrain = true
	ragdoll.GravGunPunt = true
	ragdoll.PhysgunDisabled = false
	ragdoll.Name = pl:Name()
	ragdoll.RagColor = pl:GetPlayerColor()
	ragdoll:SetCreator(nil)
	ragdoll.PlayerRag = true

	pl:SetNWEntity("Ragdoll", ragdoll)

	for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
		local phys = ragdoll:GetPhysicsObjectNum(i)
		phys:SetMaterial("gmod_silent")
	end

	timer.Simple(CleanTime, function() 
		if IsValid(ragdoll) then 
			ragdoll:Remove() 
		end 
	end)

	return ragdoll
end

Fray.CreateRagdoll = createRagdoll

hook.Add("PlayerUse", "Fray Corpse", function(pl, ent)
	if not ent.PlayerRag or (IsValid(ent:GetNWEntity("LootingEntity")) and ent:GetNWEntity("LootingEntity") ~= pl) then
		return
	end
	net.Start("Fray Corpse")
		net.WriteEntity(ent)
		net.WriteString(ent.Name)
		net.WriteTable(ent.Inventory)
		net.WriteTable(pl.Inventory)
	net.Send(pl)
end)

local hasntRespawned = {}
hook.Add("PlayerDeath", "Fray Corpse", function(pl)
	hasntRespawned[pl] = true

	local ragdoll = createRagdoll(pl)
	if not IsValid(ragdoll) then 
		return 
	end

	ragdoll.Inventory = table.Copy(pl.Inventory)
	pl:ClearInventory()

	DeathRagdolls[pl] = DeathRagdolls[pl] or {}
	DeathRagdolls[pl][#DeathRagdolls[pl] + 1] = ragdoll
end)

hook.Add("PlayerSpawn", "Fray Corpse", function(pl)
	hasntRespawned[pl] = nil
	DeathRagdolls[pl] = DeathRagdolls[pl] or {}
end)

hook.Add("PlayerDisconnected", "Fray Corpse", function(pl)
	hasntRespawned[pl] = nil
	for _, v in pairs(DeathRagdolls[pl] or {}) do
		if IsValid(v) and v then 
			v:Remove() 
		end
	end
	DeathRagdolls[pl] = nil
end)