local size = 128

surface.CreateFont("fray_pmenu", {
	size = 64,
	weight = 300, 
	antialias = true, 
	extended = true, 
	font = "Roboto"
})

do
	local pMenu = vgui.Create("EditablePanel")
	pMenu:Dock(FILL)
	pMenu:MakePopup()

	pMenu.startTime = SysTime()
	pMenu.Paint = function(self, w, h)
		surface.SetDrawColor(67, 69, 74)
		surface.DrawRect(0, 0, w, h)

		local cin = (math.sin(CurTime()) + 1) / 2
		surface.SetDrawColor(Color(cin * 255, 0, 255 - (cin * 255), math.abs(math.sin(RealTime() * math.pi * 0.3)) * 30))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur(self, self.startTime)

		draw.SimpleText("Fray 1.0", "fray_pmenu", ScrW() / 2, ScrH() / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("by xp with ♥", "xpgui_huge", ScrW() / 2, ScrH() / 2 + 64, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local spawnButton = vgui.Create("XPButton", pMenu)
	spawnButton:SetText("►")
	spawnButton:SetFont("fray_pmenu")
	spawnButton:SetSize(size, 84)
	spawnButton:SetPos(ScrW() - size - 48, ScrH() - size)

	spawnButton.Paint = function(self, w, h)
		if self:IsHovered() then
			self.Color.a = Lerp(0.075, self.Color.a , 35)
		else
			self.Color.a = Lerp(0.075, self.Color.a , 0)
		end
		if self:IsDown() then
			self.Color.a = Lerp(0.075, self.Color.a , 75)
		end
		draw.RoundedBox(6, 0, 0, w, h, self.Color)
	end

	spawnButton.DoClick = function()
		net.Start("Fray Spawn")
		net.SendToServer()
		timer.Simple(0.5, function()
			if IsValid(pMenu) then
				pMenu:Remove()
			end
		end)
	end
end