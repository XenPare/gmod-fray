local meta, amount = FindMetaTable("Player"), Fray.Config.MoneyPerEntity

function meta:GetMoney()
	return self:CalculateInventoryItemCount("fray_money") * amount
end

function meta:AddMoney(amount)
	if amount and amount > 1 then
		for i = 1, amount do
			self:AddInventoryItem("fray_money")
		end
	else
		self:AddInventoryItem("fray_money")
	end
end

function meta:TakeMoney(amount)
	if amount and amount > 1 then
		for i = 1, amount do
			self:TakeInventoryItem("fray_money", true)
		end
	else
		self:TakeInventoryItem("fray_money", true)
	end
end