local music = "https://xenpare.com/assets/phantasmagoria.mp3"
local soundStream = nil
local closeMenu = false

surface.CreateFont("fray_pmenu", {
	size = 64,
	weight = 300, 
	antialias = true, 
	extended = true, 
	font = "Roboto"
})

do
	if music ~= "" then
		sound.PlayURL(music, "", function(station)
			if not IsValid(station) then 
				return 
			end

			station:SetVolume(0.5)
			station:Play()

			soundStream = station
		end)
	end
end

local lerpval = -256
local bsize = 128
local logo = Material("fray/xp_logo.png")
local bg, bga = Material("fray/xp_bg.jpg"), 100

local pMenu
hook.Add("InitPostEntity", "Fray PreSpawn Menu", function()
	system.FlashWindow()

	pMenu = vgui.Create("DPanel")
	pMenu:Dock(FILL)
	pMenu:MakePopup()

	pMenu.Paint = function(self, w, h)
		surface.SetDrawColor(67, 69, 74)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(ColorAlpha(color_white, bga))
		surface.SetMaterial(bg)
		surface.DrawTexturedRect(0, 0, w, h)

		local cin = (math.sin(CurTime()) + 1) / 2
		surface.SetDrawColor(Color(cin * 255, 0, 255 - (cin * 255), math.abs(math.sin(RealTime() * math.pi * 0.3)) * 30))
		surface.DrawRect(0, 0, w, h)

		lerpval = Lerp(0.0015, lerpval, 256)
		render.SetScissorRect(ScrW() * 0.5 - 256, ScrH() * 0.5 - 256, ScrW() * 0.5 + 256, ScrH() * 0.5 + lerpval, true)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(logo)
			surface.DrawTexturedRect((ScrW() - 512) / 2, (ScrH() - 512) / 2, 512, 512)
		render.SetScissorRect(ScrW() * 0.5 - 256, ScrH() * 0.5 - 256, ScrW() * 0.5 + 256, ScrH() * 0.5 + lerpval, false)
	end

	local leaveButton = vgui.Create("XPButton", pMenu)
	leaveButton:SetText("↩")
	leaveButton:SetFont("fray_pmenu")
	leaveButton:SetSize(bsize, 84)
	leaveButton:SetPos(48, ScrH() - bsize)

	leaveButton.Color = Color(184, 84, 84)
	leaveButton.Paint = function(self, w, h)
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

	leaveButton.DoClick = function()
		RunConsoleCommand("disconnect")
	end

	local spawnButton = vgui.Create("XPButton", pMenu)
	spawnButton:SetText("↪")
	spawnButton:SetFont("fray_pmenu")
	spawnButton:SetSize(bsize, 84)
	spawnButton:SetPos(ScrW() - bsize - 48, ScrH() - bsize)

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

		closeMenu = true
		spawnButton:SetEnabled(false)

		timer.Simple(0.7, function()
			if IsValid(pMenu) then
				pMenu:Remove()
			end
		end)
	end
end)

hook.Add("Think", "Fray PreSpawn Menu Music Remover", function()
	if IsValid(pMenu) and closeMenu then
		bga = math.max(0, bga - FrameTime() * 130)
	end
	if IsValid(soundStream) and closeMenu then
		if soundStream:GetVolume() <= 0 then
			soundStream:Stop()
			soundStream = nil
			hook.Remove("Think", "Fray PreSpawn Menu Music Remover")
		else
			soundStream:SetVolume(math.max(0, soundStream:GetVolume() - FrameTime() / 5))
		end
	end
end)