AddCSLuaFile("list.lua")
local list = include("list.lua")

file.CreateDir("fray/inventory")

util.AddNetworkString("Fray Inventory Menu")
util.AddNetworkString("Fray Inventory Use")
util.AddNetworkString("Fray Inventory Drop")

local meta = FindMetaTable("Player")

hook.Add("PlayerInitialSpawn", "Fray Inventory", function(pl)
	local path = "fray/inventory/" .. pl:SteamID64() .. ".json"
	local exists = file.Exists(path, "DATA")
	if not exists then
		file.Write(path, util.TableToJSON({}))
	end

	pl.Inventory = util.JSONToTable(file.Read(path))
end)

function meta:CalculateInventoryWeight()
	local weight = 0
	for _, item in pairs(self.Inventory) do
		local data = list[item]
		if not data or not data.weight then
			continue
		end
		weight = weight + data.weight
	end
	return weight
end

function meta:CalculateInventoryItemCount(class)
	local count = 0
	for _, item in pairs(self.Inventory) do
		if item == class then
			count = count + 1
		end
	end
	return count
end

function meta:AddInventoryItem(class)
	local ent
	if IsValid(class) then
		ent = class
		class = class:GetClass()
	end

	if not list[class] or ((self:CalculateInventoryWeight() + list[class].weight) >= Fray.Config.MaxInventoryWeight) or self:CalculateInventoryItemCount(class) >= list[class].max then
		return
	end

	if list[class].onAdd then
		list[class].onAdd(self)
	end

	table.insert(self.Inventory, class)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
	self:EmitSound("items/ammocrate_close.wav")

	if IsValid(ent) then
		ent:Remove()
	end
end

function meta:TakeInventoryItem(class)
	if not list[class] or not table.HasValue(self.Inventory, class) then
		return
	end

	if list[class].onTake then
		list[class].onTake(self)
	end
	
	table.RemoveByValue(self.Inventory, class)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
	self:EmitSound("items/ammocrate_open.wav")
end

function meta:HasInventoryItem(class)
	if not list[class] then
		return false
	end
	return table.HasValue(self.Inventory, class)
end

net.Receive("Fray Inventory Use", function(_, pl)
	local class = net.ReadString()
	if list[class].UseFunc then
		list[class].UseFunc(pl)
		pl:TakeInventoryItem(class)
	end
end)

net.Receive("Fray Inventory Drop", function(_, pl)
	local class = net.ReadString()
	pl:TakeInventoryItem(class)

	local tr = pl:GetEyeTrace()
	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 10)
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end)

concommand.Add("fray_inventory", function(pl)
	net.Start("Fray Inventory Menu")
		net.WriteTable(pl.Inventory)
	net.Send(pl)
end)