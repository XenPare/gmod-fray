local wide = 256
local function CreateVoiceVGUI()
	if IsValid(g_VoicePanelList) then
		g_VoicePanelList:Remove()
	end
	g_VoicePanelList = vgui.Create("DPanel")
	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos(0, 32)
	g_VoicePanelList:SetSize(wide, ScrH() / 2)
	g_VoicePanelList:CenterHorizontal()
	g_VoicePanelList:SetDrawBackground(false)
end

hook.Add("InitPostEntity", "Fray CreateVoiceVGUI", function()
	timer.Simple(0, CreateVoiceVGUI)
end)