Fray.Teammates = Fray.Teammates or {}

util.AddNetworkString("Fray Teammates Broadcast")
util.AddNetworkString("Fray Teammates Reopen")

util.AddNetworkString("Fray Teammates Options")
util.AddNetworkString("Fray Teammates Invitation")
util.AddNetworkString("Fray Teammates Accept")
util.AddNetworkString("Fray Teammates Invite")
util.AddNetworkString("Fray Teammates Remove")

local max = Fray.Config.MaxTeams

--[[
	Check
]]

function teamExists(pls)
	return table.HasValue(Fray.Teammates, pls)
end

local function getPlayerTeams(pl)
	local teams = {}
	for _, team in pairs(Fray.Teammates) do
		if table.HasValue(team, pl) then
			table.insert(teams, team)
		end
	end
	return teams
end

--[[
	Create / Remove
]]

local function createTeam(pls)
	if not teamExists(pls) and #getPlayerTeams(pl) < max then
		table.insert(Fray.Teammates, pls)
		net.Start("Fray Teammates Broadcast")
			net.WriteTable(getPlayerTeams(pls[1]))
		net.Send(pls)
	end
end

local function removeTeam(pls)
	if teamExists(pls) then
		table.RemoveByValue(Fray.Teammates, pls)
		net.Start("Fray Teammates Broadcast")
			net.WriteTable(getPlayerTeams(pls[1]))
		net.Send(pls)
	end
end

local function removeTeams(pl)
	for _, team in pairs(getPlayerTeams(pl)) do
		removeTeam(team)
	end
end

local function invitePlayer(pl, teammate)
	teammate:SetNWEntity("LastTeammate", pl)
	net.Start("Fray Teammates Invitation")
		net.WriteEntity(teammate)
	net.Send(pl)
end

--[[
	Network
]]

net.Receive("Fray Teammates Accept", function(_, pl)
	local teammate = net.ReadEntity()
	if pl:GetNWEntity("LastTeammate") == teammate then
		createTeam({pl, teammate})
	end
end)

net.Receive("Fray Teammates Invite", function(_, pl)
	local teammate = net.ReadEntity()
	invitePlayer(pl, teammate)
end)

net.Receive("Fray Teammates Reopen", function(_, pl)
	net.Start("Fray Teammates Options")
		net.WriteTable(getPlayerTeams(pl))
	net.Send(pl)
end)

net.Receive("Fray Teammates Remove", function(_, pl)
	local teammate = net.ReadEntity()
	local found = nil
	for _, team in pairs(Fray.Teammates) do
		if table.HasValue(team, pl) and table.HasValue(team, teammate) then
			found = team
			break
		end
	end
	if found ~= nil then
		removeTeam(found)
	end
end)

--[[
	Hooks
]]

hook.Add("EntityTakeDamage", "Fray Teammates", function(pl, dmg)
	local attacker = dmg:GetAttacker()
	local found = nil
	for _, team in pairs(Fray.Teammates) do
		if table.HasValue(team, pl) and table.HasValue(team, attacker) then
			found = team
			break
		end
	end
	if found ~= nil then
		dmg:SetDamage(0)
	end
end)

hook.Add("ShowTeam", "Fray Teammates", function(pl)
	if #player.GetAll() < 2 then
		return
	end
	net.Start("Fray Teammates Options")
		net.WriteTable(getPlayerTeams(pl))
	net.Send(pl)
end)

hook.Add("PlayerDisconnected", "Fray Teammates", removeTeams)