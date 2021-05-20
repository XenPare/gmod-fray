local function countItems(tbl, class)
	local count = 0
	for _, item in pairs(tbl) do
		if item == class then
			count = count + 1
		end
	end
	return count
end

local function calculateWeight(tbl)
	local weight = 0
	local list = Fray.InventoryList
	for _, item in pairs(tbl) do
		local data = list[item]
		if not data or not data.weight then
			continue
		end
		weight = weight + data.weight
	end
	return weight
end

inventoryPanel = nil
hook.Add("ScoreboardShow", "Fray Inventory", function()
	if not IsValid(inventoryPanel) then
		RunConsoleCommand("fray_inventory")
	else
		inventoryPanel:Close()
	end
	return true
end)

local maxWeight = Fray.Config.MaxInventoryWeight
net.Receive("Fray Inventory Menu", function()
	if IsValid(inventoryPanel) then
		return
	end

	local toclear = XPGUI.Opened --{shopPanel, corpsePanel}
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) and pnl ~= inventoryPanel then
			pnl:Remove()
		end
	end

	local items = net.ReadTable()
	local invlist = Fray.InventoryList

	inventoryPanel = vgui.Create("XPFrame")
	inventoryPanel:SetTitle(Fray.GetPhrase("inventory") .. " (" .. calculateWeight(items) .. "/" .. maxWeight .. " kg)")
	inventoryPanel:SetKeyboardInputEnabled(false)
	inventoryPanel:SetWide(ScreenScale(285), ScreenScale(135))
	inventoryPanel:Center()

	local icon_w = inventoryPanel:GetWide() / 6 - 26

	local scroll = vgui.Create("XPScrollPanel", inventoryPanel)
	scroll:Dock(FILL)
	scroll:DockMargin(3, 3, 3, 3)

	local list = vgui.Create("DIconLayout", scroll)
	list:Dock(FILL)
	list:SetSpaceY(3)
	list:SetSpaceX(3)

	for _, item in pairs(items) do
		local colormod = false

		local btn = list:Add("XPButton")
		btn:SetSize(icon_w, icon_w)

		local model = vgui.Create("ModelImage", btn)
		model:SetSize(icon_w, icon_w)
		model:SetPos(0, 0)
		model:SetModel(invlist[item].model)
		model:SetCursor("hand")
		model:SetTooltipPanelOverride("XPTooltip")
		model:SetTooltip("[" .. countItems(items, item) .. "x] " .. Fray.GetPhrase(invlist[item].label) .. " (" .. invlist[item].weight .. " kg)" .. ":\n" .. Fray.GetPhrase(invlist[item].description))

		if invlist[item].max and countItems(items, item) >= invlist[item].max then
			model:SetTooltip("[" .. countItems(items, item) .. "x] " .. Fray.GetPhrase(invlist[item].label) .. " (" .. invlist[item].weight .. " kg):\n" .. Fray.GetPhrase(invlist[item].description) .. "\n(" .. Fray.GetPhrase("limit") .. ")")
		end

		local name = vgui.Create("DLabel", model)
		name:Dock(BOTTOM)
		name:SetTall(18)
		name:SetText(Fray.GetPhrase(invlist[item].label))
		name:SetColor(color_white)
		name:SetFont("xpgui_tiny")
		name:SetExpensiveShadow(1, ColorAlpha(color_black, 200))
		name:SetContentAlignment(5)

		model.OnCursorEntered = function()
			colormod = true
		end

		model.OnCursorExited = function()
			colormod = false
		end

		model.OnMousePressed = function()
			local menu = vgui.Create("XPMenu")
			menu:SetPos(input.GetCursorPos())

			if invlist[item].UseFunc then
				menu:AddOption(Fray.GetPhrase("use"), function()
					if not IsValid(inventoryPanel) then
						return
					end

					net.Start("Fray Inventory Use")
						net.WriteString(item)
					net.SendToServer()

					btn:Remove()
					table.RemoveByValue(items, item)
					inventoryPanel.Title:SetText(Fray.GetPhrase("inventory") .. " (" .. calculateWeight(items) .. "/" .. maxWeight .. " kg)")
				end)
			end

			if invlist[item].EquipFunc then
				local canEquip = false
				if invlist[item].IsEquipped then
					canEquip = not invlist[item].IsEquipped(LocalPlayer())
				else
					canEquip = not LocalPlayer():HasWeapon(item)
				end
				if canEquip then
					menu:AddOption(Fray.GetPhrase("equip"), function()
						if not IsValid(inventoryPanel) then
							return
						end
						net.Start("Fray Inventory Equip")
							net.WriteString(item)
						net.SendToServer()
					end)
				else
					if invlist[item].UnequipFunc then 
						menu:AddOption(Fray.GetPhrase("unequip"), function()
							if not IsValid(inventoryPanel) then
								return
							end
							net.Start("Fray Inventory Unequip")
								net.WriteString(item)
							net.SendToServer()
						end)
					end
				end
			end

			menu:AddOption(Fray.GetPhrase("drop"), function()
				if not IsValid(inventoryPanel) then
					return
				end

				net.Start("Fray Inventory Drop")
					net.WriteString(item)
				net.SendToServer()
				
				btn:Remove()
				table.RemoveByValue(items, item)
				inventoryPanel.Title:SetText(Fray.GetPhrase("inventory") .. " (" .. calculateWeight(items) .. "/" .. maxWeight .. " kg)")
			end)

			menu:Open()
			XPGUI.PlaySound("xpgui/sidemenu/sidemenu_click_01.wav")
		end
		
		btn.Paint = function(self, w, h)
			if colormod then
				self.Color.a = Lerp(0.075, self.Color.a , 35)
			else
				self.Color.a = Lerp(0.075, self.Color.a , 25)
			end
			draw.RoundedBox(6, 0, 0, w, h, self.Color)
		end
	end
end)