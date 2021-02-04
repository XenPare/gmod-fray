local items = Fray.ShopList

local optf = ScreenScale(8)

surface.CreateFont("fray_shop", {
	font = "Roboto Condensed",
	size = optf,
	weight = 400,
	extended = true,
	antialias = true
})

local function countItems(tbl, class)
	local count = 0
	for _, item in pairs(tbl) do
		if item == class then
			count = count + 1
		end
	end
	return count
end

local enabled = {true, false, true, false, false}

local color_red = Color(194, 79, 79)
local color_green = Color(129, 235, 166)
shopPanel = nil
net.Receive("Fray Shop Menu", function()
	if IsValid(shopPanel) then
		shopPanel:Close()
		return
	end

	local toclear = XPGUI.Opened
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) and pnl ~= shopPanel then
			pnl:Remove()
		end
	end

	local inv = net.ReadTable()
	local invlist = Fray.InventoryList

	shopPanel = vgui.Create("XPFrame")
	shopPanel:SetTitle(Fray.GetPhrase("shop"))
	shopPanel:SetKeyboardInputEnabled(false)
	shopPanel:SetWide(ScreenScale(285), ScreenScale(135))
	shopPanel:Center()

	local cb_w = ScreenScale(9.6)
	local ex_w = ScreenScale(6.4)

	local cats = vgui.Create("EditablePanel", shopPanel)
	cats:Dock(TOP)
	cats:DockMargin(1, 1, 1, 1)
	cats:SetTall(cb_w)

	surface.SetFont("fray_shop")

	local fillItems

	for i = 1, 5 do
		local txt = Fray.GetPhrase("category_" .. i)
		local txt_w = surface.GetTextSize(txt) + cb_w + ex_w

		local cat = vgui.Create("EditablePanel", cats)
		cat:Dock(LEFT)
		cat:SetWide(txt_w)

		local cb = vgui.Create("XPCheckBox", cat)
		cb:Dock(LEFT)
		cb:SetValue(enabled[i])
		cb:SetWide(cb_w)

		cb.OnChange = function()
			enabled[i] = not enabled[i]
			fillItems()
		end

		local name = vgui.Create("DLabel", cat)
		name:Dock(LEFT)
		name:DockMargin(3, 0, 0, 0)
		name:SetFont("fray_shop")
		name:SetText(txt)
		name:SetWide(txt_w + 6)
	end

	local icon_w = shopPanel:GetWide() / 5 - 36

	local scroll = vgui.Create("XPScrollPanel", shopPanel)
	scroll:Dock(FILL)
	scroll:DockMargin(3, 3, 3, 3)

	local list
	list = vgui.Create("DIconLayout", scroll)
	list:Dock(FILL)
	list:SetSpaceY(3)
	list:SetSpaceX(3)

	local function isLimited(class)
		return invlist[class].max and countItems(inv, class) >= invlist[class].max or false
	end

	fillItems = function()
		list:Clear()

		list = vgui.Create("DIconLayout", scroll)
		list:Dock(FILL)
		list:SetSpaceY(3)
		list:SetSpaceX(3)

		for class, item in SortedPairsByMemberValue(items, "category") do
			if not enabled[invlist[class].category] then 
				continue
			end

			local colormod = false
	
			local btn = list:Add("XPButton")
			btn:SetSize(icon_w, icon_w)
	
			local model = vgui.Create("ModelImage", btn)
			model:SetSize(icon_w - 34, icon_w - 34)
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
	end

	fillItems()
end)