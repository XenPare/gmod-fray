net.Receive("Fray Language Propose", function()
	local current = net.ReadString()
	local supposed = net.ReadString()

	surface.SetFont("xpgui_big")
	local title = "Would you like to change " .. Fray.Languages[current].Name .. " language to " .. Fray.Languages[supposed].Name .. " ?"
	local title_w = surface.GetTextSize(title)

	local fr = vgui.Create("XPFrame")
    fr:SetTitle(title)
    fr:SetSize(title_w + 15, 115)
    fr:Center()

	local yes = vgui.Create("XPButton", fr)
	yes:Dock(TOP)
	yes:SetText("Yes")
	yes.DoClick = function()
		RunConsoleCommand("fray_lang", supposed)
		fr:Remove()
	end

	local no = vgui.Create("XPButton", fr)
	no:Dock(TOP)
	no:SetText("No")
	no.DoClick = function()
		fr:Remove()
	end
end)