local function countItems(tbl)
	local count = 0
	for _, item in pairs(tbl) do
		if item == class then
			count = count + 1
		end
	end
	return count
end

local fr
net.Receive("Fray Corpse", function()
	if IsValid(fr) then
		return
	end

	local corpse = net.ReadEntity()
	local name = net.ReadString()
	local items = net.ReadTable()
	local myitems = net.ReadTable()
	local invlist = Fray.InventoryList

	fr = vgui.Create("XPFrame")
	fr:SetTitle(name .. "'s corpse")
	fr:SetKeyboardInputEnabled(false)

	local scroll = vgui.Create("XPScrollPanel", fr)
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
		model:SetTooltipPanelOverride("XPTooltip")
		model:SetTooltip(invlist[item].label .. "\n" .. invlist[item].description)

		local limited = false
		if invlist[item].max and countItems(myitems) >= invlist[item].max then
			limited = true
			model:SetTooltip(invlist[item].label .. "\n" .. invlist[item].description .. "\n(Limit is reached)")
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

			menu:AddOption("Take", function()
				if limited then
					return
				end
				net.Start("Fray Corpse Take")
					net.WriteEntity(corpse)
					net.WriteString(item)
				net.SendToServer()
				btn:Remove()
			end)

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