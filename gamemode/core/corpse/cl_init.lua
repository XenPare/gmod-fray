local function countItems(tbl, class)
	local count = 0
	for _, item in pairs(tbl) do
		if item == class then
			count = count + 1
		end
	end
	return count
end

corpsePanel = nil
net.Receive("Fray Corpse", function()
	if IsValid(corpsePanel) then
		return
	end

	local toclear = XPGUI.Opened
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) and pnl ~= corpsePanel then
			pnl:Remove()
		end
	end

	local corpse = net.ReadEntity()
	local name = net.ReadString()
	local items = net.ReadTable()
	local myitems = net.ReadTable()
	local invlist = Fray.InventoryList

	corpsePanel = vgui.Create("XPFrame")
	corpsePanel:SetTitle(name .. Fray.GetPhrase("corpse"))
	corpsePanel:SetKeyboardInputEnabled(false)

	local scroll = vgui.Create("XPScrollPanel", corpsePanel)
	scroll:Dock(FILL)
	scroll:DockMargin(3, 3, 3, 3)

	local list = vgui.Create("DIconLayout", scroll)
	list:Dock(FILL)
	list:SetSpaceY(3)
	list:SetSpaceX(3)

	for _, item in pairs(items) do
		local colormod = false

		local btn = list:Add("XPButton")
		btn:SetSize(84, 84)

		local model = vgui.Create("ModelImage", btn)
		model:SetSize(84, 84)
		model:SetPos(0, 0)
		model:SetModel(invlist[item].model)
		model:SetCursor("hand")
		model:SetTooltipPanelOverride("XPTooltip")
		model:SetTooltip(Fray.GetPhrase(invlist[item].label) .. " (" .. invlist[item].weight .. " kg):\n" .. Fray.GetPhrase(invlist[item].description))

		local limited = false
		if invlist[item].max and countItems(myitems, item) >= invlist[item].max then
			limited = true
			model:SetTooltip(Fray.GetPhrase(invlist[item].label) .. " (" .. invlist[item].weight .. " kg):\n" .. Fray.GetPhrase(invlist[item].description) .. "\n(Limit is reached)")
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

			if not limited then
				menu:AddOption(Fray.GetPhrase("take"), function()
					net.Start("Fray Corpse Take")
						net.WriteEntity(corpse)
						net.WriteString(item)
					net.SendToServer()
					btn:Remove()
				end)
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
	end
end)