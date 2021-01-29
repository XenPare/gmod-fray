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

local color_red = Color(194, 79, 79)
local color_green = Color(129, 235, 166)
shopPanel = nil
net.Receive("Fray Shop Menu", function()
	if IsValid(shopPanel) then
		shopPanel:Close()
		return
	end

	local toclear = {inventoryPanel, corpsePanel}
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) then
			pnl:Close()
		end
	end

	local inv = net.ReadTable()
	local invlist = Fray.InventoryList

	shopPanel = vgui.Create("XPFrame")
	shopPanel:SetTitle(Fray.GetPhrase("shop"))
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

	for class, item in SortedPairsByMemberValue(items, "category") do
		local colormod = false

		local btn = list:Add("XPButton")
		btn:SetSize(130, 130)

		local model = vgui.Create("ModelImage", btn)
		model:SetSize(96, 96)
		model:SetPos(12, 0)
		model:SetModel(invlist[class].model)
		model:SetCursor("hand")
		model:SetTooltipPanelOverride("XPTooltip")
		model:SetTooltip(Fray.GetPhrase(invlist[class].label) .. " (" .. invlist[class].weight .. " kg):\n" .. Fray.GetPhrase(invlist[class].description))
		btn:SetTooltip(Fray.GetPhrase(invlist[class].label) .. " (" .. invlist[class].weight .. " kg):\n" .. Fray.GetPhrase(invlist[class].description))

		if isLimited(class) then
			model:SetTooltip(Fray.GetPhrase(invlist[class].label) .. " (" .. invlist[class].weight .. " kg):\n" .. Fray.GetPhrase(invlist[class].description) .. " (" .. Fray.GetPhrase("limit") .. ")")
			btn:SetTooltip(Fray.GetPhrase(invlist[class].label) .. " (" .. invlist[class].weight .. " kg):\n" .. Fray.GetPhrase(invlist[class].description) .. " (" .. Fray.GetPhrase("limit") .. ")")
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

			if LocalPlayer():GetNWInt("Money") >= item.price then
				menu:AddOption(Fray.GetPhrase("buy"), function()
					net.Start("Fray Shop Buy")
						net.WriteString(class)
					net.SendToServer()
				end)
			else
				menu:AddOption(Fray.GetPhrase("cant_afford"))
			end

			menu:Open()

			XPGUI.PlaySound("xpgui/sidemenu/sidemenu_click_01.wav")
		end

		btn.DoClick = model.OnMousePressed
		btn.Paint = function(self, w, h)
			if colormod then
				self.Color.a = Lerp(0.075, self.Color.a , 35)
			else
				self.Color.a = Lerp(0.075, self.Color.a , 25)
			end
			draw.RoundedBox(6, 0, 0, w, h, self.Color)
		end

		local price = vgui.Create("DLabel", btn)
		price:Dock(BOTTOM)
		price:SetTall(22)
		price:SetText("$" .. string.Comma(item.price))
		price:SetColor((isLimited(class) or LocalPlayer():GetNWInt("Money") < item.price) and color_red or color_green)
		price:SetFont("xpgui_medium")
		price:SetExpensiveShadow(1, ColorAlpha(color_black, 200))
		price:SetContentAlignment(5)
		price:SetMouseInputEnabled(false)

		local name = vgui.Create("DLabel", btn)
		name:Dock(BOTTOM)
		name:SetTall(18)
		name:SetText(Fray.GetPhrase(invlist[class].label))
		name:SetColor(color_white)
		name:SetFont("xpgui_tiny")
		name:SetExpensiveShadow(1, ColorAlpha(color_black, 200))
		name:SetContentAlignment(5)
		name:SetMouseInputEnabled(false)
	end
end)