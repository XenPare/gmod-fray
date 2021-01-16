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
	pl:SetSimpleTimer(0.2, function()
		pl:SetRunSpeed(pl:GetRunSpeed() - pl:CalculateInventoryWeight())
		pl:SetJumpPower(pl:GetJumpPower() - (math.Round(pl:CalculateInventoryWeight() / 2)))
	end)
end)

function meta:CalculateInventoryWeight()
	local weight = 0
	local list = Fray.InventoryList
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
	if not self:Alive() then
		return
	end

	local _class
	if IsEntity(class) then
		_class = class:GetClass()
	else
		_class = class
	end

	local list = Fray.InventoryList
	if not list[_class] or ((self:CalculateInventoryWeight() + list[_class].weight) >= Fray.Config.MaxInventoryWeight) or (list[_class].max and self:CalculateInventoryItemCount(_class) >= list[_class].max or false) then
		return
	end

	if list[_class].onAdd then
		list[_class].onAdd(self)
	end

	table.insert(self.Inventory, _class)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
	self:EmitSound("items/ammocrate_close.wav")
	self:SetRunSpeed(self:GetRunSpeed() - self:CalculateInventoryWeight())
	self:SetJumpPower(self:GetJumpPower() - (math.Round(self:CalculateInventoryWeight() / 2)))

	if IsEntity(class) and IsValid(class) then
		class:Remove()
	end
end

function meta:ClearInventory()
	local list = Fray.InventoryList
	for _, item in pairs(self.Inventory) do
		if list[item].onTake then
			list[item].onTake(self)
		end
	end
	self.Inventory = {}
	self:SetRunSpeed(Fray.Config.RunSpeed)
	self:SetJumpPower(Fray.Config.JumpPower)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
end

function meta:TakeInventoryItem(class)
	local list = Fray.InventoryList
	if not list[class] or not table.HasValue(self.Inventory, class) then
		return
	end

	if list[class].onTake then
		list[class].onTake(self)
	end
	
	table.RemoveByValue(self.Inventory, class)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
	self:SetRunSpeed(self:GetRunSpeed() + self:CalculateInventoryWeight())
	self:SetJumpPower(self:GetJumpPower() + (math.Round(self:CalculateInventoryWeight() / 2)))

	if self:Alive() then
		self:EmitSound("items/ammocrate_open.wav")
	end
end

function meta:HasInventoryItem(class)
	local list = Fray.InventoryList
	if not list[class] then
		return false
	end
	return table.HasValue(self.Inventory, class)
end

net.Receive("Fray Inventory Use", function(_, pl)
	if not pl:Alive() then
		return
	end

	local class = net.ReadString()
	local list = Fray.InventoryList
	if list[class].UseFunc then
		if list[class].UseCondition then
			if not list[class].UseCondition(pl) then
				return
			end
		end
		list[class].UseFunc(pl)
		pl:TakeInventoryItem(class)
	end
end)

net.Receive("Fray Inventory Drop", function(_, pl)
	if not pl:Alive() then
		return
	end

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
	if not pl:Alive() then
		return
	end

	net.Start("Fray Inventory Menu")
		net.WriteTable(pl.Inventory)
	net.Send(pl)
end)