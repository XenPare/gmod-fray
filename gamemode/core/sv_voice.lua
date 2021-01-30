
local voiceDistance = 550
local canHear = {}

for _, pl in pairs(player.GetHumans()) do
    canHear[pl] = {}
end

local function isInRoom(listenerShootPos, talkerShootPos, talker)
    local tracedata = {}
    tracedata.start = talkerShootPos
    tracedata.endpos = listenerShootPos
	tracedata.filter = talker
	
    local trace = util.TraceLine(tracedata)
    return not trace.HitWorld
end

local function CanHearPlayerVoice(listener)
	if not IsValid(listener) then 
		return 
	end

    canHear[listener] = canHear[listener] or {}
	if listener:IsBot() then 
		return
	end
	
    local shootPos = listener:GetShootPos()
    for _, talker in ipairs(player.GetHumans()) do
        local talkerShootPos = talker:GetShootPos()
        canHear[listener][talker] = shootPos:DistToSqr(talkerShootPos) < voiceDistance and isInRoom(shootPos, talkerShootPos, talker)
    end
end

hook.Add("PlayerInitialSpawn", "DarkRPCanHearVoice", function(pl)
    CanHearPlayerVoice(pl)
	if pl:IsBot() then 
		return 
	end
	pl:SetTimer("Fray Calc Voice", 0.5, 0, function()
		CanHearPlayerVoice(pl)
	end)
end)

hook.Add("PlayerDisconnected", "DarkRPCanHearVoice", function(pl)
    canHear[pl] = nil
	if pl:IsBot() then 
		return 
	end
    for _, v in ipairs(player.GetHumans()) do
		if not canHear[v] then 
			continue 
		end
        canHear[v][pl] = nil
    end
end)

function GM:PlayerCanHearPlayersVoice(listener, talker)
	if not talker:Alive() then 
		return false 
	end
    return canHear[listener][talker], true
end