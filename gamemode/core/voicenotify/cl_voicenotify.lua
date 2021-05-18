local distance = 3
local threshold = 0.6

local tall = 26

local PANEL = {}

surface.CreateFont("fray_voice", {
	font = "Roboto Condensed",
	size = 24,
	weight = 400,
	shadow = true,
	extended = true,
	antialias = true
})

function PANEL:Init()
	self.LabelName = vgui.Create("DLabel", self)
	self.LabelName:SetFont("fray_voice")
	self.LabelName:Dock(FILL)
	self.LabelName:DockMargin(8, 0, 0, 0)
	self.LabelName:SetTextColor(color_white)
	self.LabelName:SetContentAlignment(5)

	self:SetTall(tall)
	self:DockPadding(3, 3, 3, 3)
	self:DockMargin(0, 2, 0, 8)
	self:Dock(TOP)
end

function PANEL:Setup(pl)
	surface.SetFont("fray_voice")
	self.pl = pl
	self.LabelName:SetText(pl:Name())
	self:InvalidateLayout()
end

function PANEL:Paint(w, h)
	if not self.pl:IsValid() then 
		return 
	end
	draw.RoundedBox(6, 0, 0, w, h, XPGUI.BGColor)	
end

function PANEL:Think()
	if self.fadeAnim then
		self.fadeAnim:Run()
	elseif IsValid(self.pl) then
		local distance = math.Round(LocalPlayer():GetPos():Distance(self.pl:GetPos()))
		self.LabelName:SetText(self.pl:Name() .. (distance > 0 and " (" .. distance .. " m)" or ""))
	end
end

function PANEL:FadeOut(anim, delta)
	if anim.Finished then
		self:Remove()
	else
		self:SetAlpha(255 - 255 * delta * 2)
	end
end

vgui.Register("VoiceNotify", PANEL, "DPanel")