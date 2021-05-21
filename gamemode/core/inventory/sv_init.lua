file.CreateDir("fray/inventory")

util.AddNetworkString("Fray Inventory Menu")
util.AddNetworkString("Fray Inventory Use")
util.AddNetworkString("Fray Inventory Equip")
util.AddNetworkString("Fray Inventory Unequip")
util.AddNetworkString("Fray Inventory Drop")

local meta = FindMetaTable("Player")

local cfg = Fray.Config
local def_run = cfg.RunSpeed
local def_jump = cfg.JumpPower
local def_equip = cfg.BaseEquipment
local drp_cltime = cfg.DroppedCleanTime

hook.Add("PlayerInitialSpawn", "Fray Inventory", function(pl)
	local path = "fray/inventory/" .. pl:SteamID64() .. ".json"
	local exists = file.Exists(path, "DATA")
	if not exists then
		file.Write(path, util.TableToJSON({}))
	end

	pl.Inventory = util.JSONToTable(file.Read(path))
	pl:SetSimpleTimer(0.2, function()
		if not exists then
			for _, class in pairs(def_equip) do
				pl:AddInventoryItem(class)
			end
		end
		pl:SetRunSpeed(def_run - pl:CalculateInventoryWeight())
		pl:SetJumpPower(def_jump - (math.Round(pl:CalculateInventoryWeight() / 2)))
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
		return false
	end

	local _class
	if IsEntity(class) then
		_class = class:GetClass()
	else
		_class = class
	end

	local list = Fray.InventoryList
	if not list[_class] or ((self:CalculateInventoryWeight() + list[_class].weight) >= Fray.Config.MaxInventoryWeight) then
		return false
	end

	if list[_class].max then
		if self:CalculateInventoryItemCount(_class) >= list[_class].max then
			self:ChatPrint(Fray.GetPhrase("limit", self))
			return false
		end
	end

	if list[_class].onAdd then
		list[_class].onAdd(self)
	end

	table.insert(self.Inventory, _class)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
	self:EmitSound("items/ammocrate_close.wav")
	self:SetRunSpeed(def_run - self:CalculateInventoryWeight())
	self:SetJumpPower(def_jump - (math.Round(self:CalculateInventoryWeight() / 2)))

	if IsEntity(class) and IsValid(class) then
		class:Remove()
	end

	return true
end

function meta:ClearInventory()
	local list = Fray.InventoryList
	for _, item in pairs(self.Inventory) do
		if list[item].onTake then
			list[item].onTake(self)
		end
	end
	self.Inventory = {}
	self:SetRunSpeed(def_run)
	self:SetJumpPower(def_jump)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
end

function meta:TakeInventoryItem(class, silent)
	local list = Fray.InventoryList
	if not list[class] or not table.HasValue(self.Inventory, class) then
		return
	end

	if list[class].onTake then
		list[class].onTake(self)
	end
	
	table.RemoveByValue(self.Inventory, class)
	file.Write("fray/inventory/" .. self:SteamID64() .. ".json", util.TableToJSON(self.Inventory, true))
	self:SetRunSpeed(def_run - self:CalculateInventoryWeight())
	self:SetJumpPower(def_jump - (math.Round(self:CalculateInventoryWeight() / 2)))

	if silent then
		if self:Alive() then
			self:EmitSound("items/ammocrate_open.wav")
		end
	end
end

function meta:HasInventoryItem(class)
	local list = Fray.InventoryList
	if not list[class] then
		return false
	end
	local count = 0
	for _, item in pairs(self.Inventory) do
		if item == class then
			count = count + 1 
		end
	end
	return count > 0, count
end

net.Receive("Fray Inventory Use", function(_, pl)
	if not pl:Alive() then
		return
	end

	local class = net.ReadString()
	local list = Fray.InventoryList
	if not list[class] or not table.HasValue(pl.Inventory, class) then
		return
	end

	if list[class].UseFunc then
		list[class].UseFunc(pl)
		pl:TakeInventoryItem(class)
	end
end)

net.Receive("Fray Inventory Equip", function(_, pl)
	if not pl:Alive() then
		return
	end

	local class = net.ReadString()
	local list = Fray.InventoryList
	if list[class].EquipFunc then
		list[class].EquipFunc(pl)
	end
end)

net.Receive("Fray Inventory Unequip", function(_, pl)
	if not pl:Alive() then
		return
	end

	local class = net.ReadString()
	local list = Fray.InventoryList
	if list[class].UnequipFunc then
		list[class].UnequipFunc(pl)
	end
end)

net.Receive("Fray Inventory Drop", function(_, pl)
	if not pl:Alive() then
		return
	end

	local class = net.ReadString()
	if not Fray.InventoryList[class] or not table.HasValue(pl.Inventory, class) then
		return
	end

	pl:TakeInventoryItem(class)

	local att_id = pl:LookupAttachment("eyes")
	if not att_id then
		return
	end
	
	local att = pl:GetAttachment(att_id)
	if not att then
		return
	end

	local pos = att.Pos
	local iswep = weapons.Get(class)
	local ent = ents.Create(iswep and "fray_weapon" or class)
	if iswep then
		ent.Weapon = class
	end
	ent:SetPos(pos)
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end

	ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	ent:SetSimpleTimer(drp_cltime, function()
		ent:Remove()
	end)
end)

concommand.Add("fray_inventory", function(pl)
	if not pl:Alive() then
		return
	end

	if not pl.att_inited then
		for pack, atts in pairs(Fray.Config.Attachments) do
			if pl:HasInventoryItem(pack) and not CustomizableWeaponry:hasSpecifiedAttachments(pl, atts) then 
				CustomizableWeaponry.giveAttachments(pl, atts)
			end
		end
		pl.att_inited = true
	end

	net.Start("Fray Inventory Menu")
		net.WriteTable(pl.Inventory)
	net.Send(pl)
end)