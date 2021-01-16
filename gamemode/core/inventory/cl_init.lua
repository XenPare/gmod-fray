local invlist = include("list.lua")

local fr
hook.Add("PlayerBindPress", "Fray Inventory", function(pl, bind, pressed)
	if string.find(bind, "impulse 100") then
		if not IsValid(fr) then
			RunConsoleCommand("fray_inventory")
		end
		return true
	end
end)

net.Receive("Fray Inventory Menu", function()
	local items = net.ReadTable()

	fr = vgui.Create("XPFrame")
	fr:SetTitle("Inventory")
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
				menu:AddOption("Use", function()
					net.Start("Fray Inventory Use")
						net.WriteString(item)
					net.SendToServer()
					btn:Remove()
				end)
			end

			menu:AddOption("Drop", function()
				net.Start("Fray Inventory Drop")
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