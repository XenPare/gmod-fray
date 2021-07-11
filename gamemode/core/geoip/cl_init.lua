local c_sl = Color(86, 184, 101)

proposePanel = nil
net.Receive("Fray Language Propose", function()
	if IsValid(proposePanel) then
		proposePanel:Close()
		return
	end
	
	local current = net.ReadString()
	local supposed = net.ReadString()

	local toclear = XPGUI.Opened
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) and pnl ~= proposePanel then
			pnl:Remove()
		end
	end

	surface.SetFont("xpgui_big")
	local title = "Would you like to change " .. Fray.Languages[current].Name .. " language to " .. Fray.Languages[supposed].Name .. " ?"
	local title_w = surface.GetTextSize(title)

	proposePanel = vgui.Create("XPFrame")
    proposePanel:SetTitle(title)
    proposePanel:SetSize(title_w + 15, 115)
    proposePanel:Center()

	proposePanel.OnClose = function()
		proposePanel:SetMouseInputEnabled(false)
	end

	local yes = vgui.Create("XPButton", proposePanel)
	yes:Dock(TOP)
	yes:SetText("Yes")
	yes.DoClick = function()
		RunConsoleCommand("fray_lang", supposed)
		proposePanel:Remove()
	end

	local no = vgui.Create("XPButton", proposePanel)
	no:Dock(TOP)
	no:SetText("No")
	no.DoClick = function()
		proposePanel:Remove()
	end
end)

langPanel = nil
net.Receive("Fray Language Menu", function()
	if IsValid(langPanel) then
		langPanel:Close()
		return
	end

	local current = LocalPlayer():GetInfo("fray_lang")

	local toclear = XPGUI.Opened
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) and pnl ~= langPanel then
			pnl:Remove()
		end
	end

	langPanel = vgui.Create("XPFrame")
	langPanel:SetTitle(Fray.GetPhrase("languages"))
	langPanel:SetKeyboardInputEnabled(false)
	langPanel:SetSize(ScreenScale(80), ScreenScale(80))
	langPanel:Center()

	local scroll = vgui.Create("XPScrollPanel", langPanel)
	scroll:Dock(FILL)

	local selected
	for lng in pairs(Fray.Languages) do
		local btn = vgui.Create("XPButton", scroll)
		btn:SetText(Fray.Languages[lng].Name)
		if current == lng then
			selected = btn
			btn:SetColor(c_sl)
		end
		btn:Dock(TOP)
		btn:SetTooltip("By " .. Fray.Languages[lng].Author)
		btn.DoClick = function()
			if selected ~= btn then
				selected:SetColor(color_white)
				btn:SetColor(c_sl)
				selected = btn
			end
			RunConsoleCommand("fray_lang", lng)
		end
	end
end)