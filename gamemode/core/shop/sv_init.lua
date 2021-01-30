util.AddNetworkString("Fray Shop Menu")
util.AddNetworkString("Fray Shop Buy")

local shop_tbl = Fray.ShopList
local inv_tbl = Fray.InventoryList
local money_amount = Fray.Config.MoneyPerEntity
net.Receive("Fray Shop Buy", function(_, pl)
	local item = net.ReadString()
	local price = shop_tbl[item].price
	if pl:GetMoney() < price then
		return
	end

	if not pl:CanDeliver() then
		pl:ChatPrint(Fray.GetPhrase("cant_deliver", pl))
		return
	end

	local max = inv_tbl[item].max
	if max and pl:CalculateInventoryItemCount(item) >= max then
		return
	end

	local amount = price / money_amount
	pl:TakeMoney(amount)
	Fray.ShopDeliver(pl, item)
end)

hook.Add("PlayerSwitchFlashlight", "Fray Shop", function(pl)
	if pl:Health() <= 0 then
		return
	end
	net.Start("Fray Shop Menu")
		net.WriteTable(pl.Inventory)
	net.Send(pl)
	return false
end)