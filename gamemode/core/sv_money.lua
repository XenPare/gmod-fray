local meta, amount = FindMetaTable("Player"), Fray.Config.MoneyPerEntity

function meta:GetMoney()
	return self:CalculateInventoryItemCount("fray_money") * amount
end

function meta:AddMoney(num)
	if num and num > 1 then
		for i = 1, num do
			self:AddInventoryItem("fray_money")
		end
	else
		self:AddInventoryItem("fray_money")
	end
end

function meta:TakeMoney(num)
	if num and num > 1 then
		for i = 1, num do
			self:TakeInventoryItem("fray_money", true)
		end
	else
		self:TakeInventoryItem("fray_money", true)
	end
end

hook.Add("PostPlayerSpawn", "Fray Money", function(pl)
	pl:SetNWInt("Money", pl:GetMoney())
end)

hook.Add("PlayerDeath", "Fray Money", function(pl)
	pl:SetNWInt("Money", 0)
end)