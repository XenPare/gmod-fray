local items = Fray.ShopList

local function countItems(tbl, class)
	local count = 0
	for _, item in pairs(tbl) do
		if item == class then
			count = count + 1
		end
	end
	return count
end

shopPanel = nil
hook.Add("PlayerBindPress", "Fray Shop", function(pl, bind, pressed)
	if string.find(bind, "+menu_context") then
		if not IsValid(shopPanel) then
			RunConsoleCommand("fray_shop")
		end
		return true
	end
end)

local color_red = Color(255, 0, 0)
net.Receive("Fray Shop Menu", function()
	if IsValid(inventoryPanel) or IsValid(corpsePanel) or IsValid(shopPanel) then
		return
	end

	local money = net.ReadInt(16)
	local inv = net.ReadTable()
	local invlist = Fray.InventoryList

	shopPanel = vgui.Create("XPFrame")
	shopPanel:SetTitle(Fray.GetPhrase("shop") .. " ($" .. money .. " " .. Fray.GetPhrase("available") .. ")")
	shopPanel:SetKeyboardInputEnabled(false)

	local scroll = vgui.Create("XPScrollPanel", shopPanel)
	scroll:Dock(FILL)
	scroll:DockMargin(3, 3, 3, 3)

	local list = vgui.Create("DIconLayout", scroll)
	list:Dock(FILL)
	list:SetSpaceY(3)
	list:SetSpaceX(3)

	local function isLimited(class)
		return invlist[class].max and countItems(inv, class) >= invlist[class].max or false
	end

	for class, item in pairs(items) do
		local colormod = false

		local btn = list:Add("XPButton")
		btn:SetSize(84, 84)

		local model = vgui.Create("ModelImage", btn)
		model:SetSize(84, 84)
		model:SetPos(0, 0)
		model:SetModel(invlist[class].model)
		model:SetTooltipPanelOverride("XPTooltip")
		model:SetTooltip(Fray.GetPhrase(invlist[class].label) .. " (" .. invlist[class].weight .. " kg)\n" .. Fray.GetPhrase(invlist[class].description))

		if isLimited(class) then
			model:SetTooltip(Fray.GetPhrase(invlist[class].label) .. " (" .. invlist[class].weight .. " kg)\n" .. Fray.GetPhrase(invlist[class].description) .. "\n(" .. Fray.GetPhrase("limit") .. ")")
		end

		model.OnCursorEntered = function()
			colormod = true
		end

		model.OnCursorExited = function()
			colormod = false
		end

		model.OnMousePressed = function()
			local menu = vgui.Create("XPMenu")
			menu:SetPos(input.GetCursorPos())

			if LocalPlayer():CanDeliver() then
				if money >= item.price then
					menu:AddOption(Fray.GetPhrase("buy"), function()
						net.Start("Fray Shop Buy")
							net.WriteString(class)
						net.SendToServer()

						money = money - item.price
						shopPanel.Title:SetTitle(Fray.GetPhrase("shop") .. " ($" .. money .. " " .. Fray.GetPhrase("available") .. ")")
					end)
				else
					menu:AddOption(Fray.GetPhrase("cant_afford"))
				end
			else
				menu:AddOption(Fray.GetPhrase("cant_deliver"))
			end

			menu:Open()
		end
		
		btn.Paint = function(self, w, h)
			if colormod then
				self.Color.a = Lerp(0.075, self.Color.a , 35)
			else
				self.Color.a = Lerp(0.075, self.Color.a , 25)
			end
			draw.RoundedBox(6, 0, 0, w, h, self.Color)
		end

		local price = vgui.Create("DLabel", model)
		price:Dock(BOTTOM)
		price:SetTall(24)
		price:SetText("$" .. item.price)
		price:SetColor((isLimited(class) or money < item.price) and color_red or color_white)
		price:SetFont("xpgui_medium")
		price:SetExpensiveShadow(1, ColorAlpha(color_black, 200))
		price:SetContentAlignment(5)
	end
end)