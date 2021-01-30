local max = Fray.Config.MaxTeams

local function isInTeams(pl, teams)
	for _, team in pairs(teams) do
		if table.HasValue(team, pl) then
			return true
		end
	end
	return false
end

net.Receive("Fray Teammates Invitation", function()
	local mate = net.ReadEntity()

	surface.SetFont("xpgui_big")
	local title = mate:Name() .. Fray.GetPhrase("invitation")
	local title_w = surface.GetTextSize(title)

	local fr = vgui.Create("XPFrame")
	fr:SetTitle(title)
	fr:SetSize(title_w + 15, 115)
	fr:Center()

	local yes = vgui.Create("XPButton", fr)
	yes:Dock(TOP)
	yes:SetText(Fray.GetPhrase("yes"))
	yes.DoClick = function()
		net.Start("Fray Teammates Accept")
			net.WriteEntity(mate)
		net.SendToServer()
		fr:Remove()
	end

	local no = vgui.Create("XPButton", fr)
	no:Dock(TOP)
	no:SetText(Fray.GetPhrase("no"))
	no.DoClick = function()
		fr:Remove()
	end
end)

teamPanel = nil
net.Receive("Fray Teammates Options", function()
	if IsValid(teamPanel) then
		teamPanel:Close()
		return
	end

	local teams = net.ReadTable()

	local toclear = XPGUI.Opened
	for _, pnl in pairs(toclear) do
		if IsValid(pnl) and pnl ~= teamPanel then
			pnl:Remove()
		end
	end

	teamPanel = vgui.Create("XPFrame")
	teamPanel:SetTitle(Fray.GetPhrase("teams"))
	teamPanel:SetKeyboardInputEnabled(false)
	teamPanel:SetSize(ScreenScale(80), (#teams > 0 and #teams < max) and 113 or 73)
	teamPanel:Center()

	if #teams < max then
		local add = vgui.Create("XPButton", teamPanel)
		add:SetText(Fray.GetPhrase("add_team"))
		add:Dock(TOP)

		add.DoClick = function()
			local menu = vgui.Create("XPMenu")
			menu:SetPos(input.GetCursorPos())
			for _, pl in pairs(player.GetAll()) do
				if pl == LocalPlayer() or isInTeams(pl, teams) then
					continue
				end
				menu:AddOption(pl:Name() .. ((pl:GetFriendStatus() == "friend") and (" (" .. Fray.GetPhrase("friend") .. ")") or ""), function()
					if not IsValid(pl) then
						return
					end

					net.Start("Fray Teammates Invite")
						net.WriteEntity(pl)
					net.SendToServer()

					teamPanel:Remove()
					net.Start("Fray Teammates Reopen")
					net.SendToServer()
				end)
			end
			menu:Open()
		end
	end

	if #teams > 0 then
		local remove = vgui.Create("XPButton", teamPanel)
		remove:SetText(Fray.GetPhrase("remove_team"))
		remove:Dock(TOP)
		
		remove.DoClick = function()
			local menu = vgui.Create("XPMenu")
			menu:SetPos(input.GetCursorPos())

			for i = 1, #teams do
				local members = teams[i]
				for _, pl in pairs(members) do
					if pl == LocalPlayer() then
						continue
					end
					menu:AddOption(pl:Name() .. ((pl:GetFriendStatus() == "friend") and (" (" .. Fray.GetPhrase("friend") .. ")") or ""), function()
						if not IsValid(pl) then
							return
						end

						net.Start("Fray Teammates Remove")
							net.WriteEntity(pl)
						net.SendToServer()

						teamPanel:Remove()
						net.Start("Fray Teammates Reopen")
						net.SendToServer()
					end)
				end
			end
			menu:Open()
		end
	end
end)