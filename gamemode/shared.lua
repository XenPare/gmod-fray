local GM = GM or GAMEMODE

GM.Name	= "Fray"
GM.Author = "crester"

Fray = Fray or {}
Fray.Config = Fray.Config or {}

XPA.IncludeCompounded("fray/gamemode/config")
XPA.IncludeCompounded("fray/gamemode/lib")
XPA.IncludeCompounded("fray/gamemode/core/*")

TEAM_SURVIVOR = 1
function GM:PreGamemodeLoaded()
	team.SetUp(TEAM_SURVIVOR, "Survivor", Color(106, 171, 121), false)
end

function GM:Move(pl)
	return not pl:Alive()
end