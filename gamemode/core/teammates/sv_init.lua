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

local function teamExists(pls)
	local found = nil
	for _, team in pairs(Fray.Teammates) do
		local pl, mate = pls[1], pls[2]
		if table.HasValue(team, pl) and table.HasValue(team, mate) then
			found = team
			break
		end
	end
	return found ~= nil, found
end

local function getPlayerTeams(pl)
	local teams = {}
	if istable(pl) then
		for _, team in pairs(Fray.Teammates) do
			local ex, t = teamExists(team)
			if ex and table.HasValue(t, team[1]) and table.HasValue(t, team[2]) then
				table.insert(teams, t)
			end
		end
	else
		for _, team in pairs(Fray.Teammates) do
			if table.HasValue(team, pl) then
				local _, t = teamExists(team)
				table.insert(teams, t)
			end
		end
	end
	return teams
end

--[[
	Create / Remove
]]

local function createTeam(pls)
	if not teamExists(pls) and #getPlayerTeams(pls[1]) < max and #getPlayerTeams(pls[2]) < max then
		table.insert(Fray.Teammates, pls)
	end

	PrintTable(getPlayerTeams(pls))

	net.Start("Fray Teammates Broadcast")
		net.WriteTable(getPlayerTeams(pls))
	net.Send(pls)
end

local function removeTeam(pls)
	local exists, team = teamExists(pls)
	if exists then
		table.RemoveByValue(Fray.Teammates, team)
	end
	net.Start("Fray Teammates Broadcast")
		net.WriteTable(getPlayerTeams(pls))
	net.Send(pls)
end

local function removeTeams(pl)
	for _, team in pairs(getPlayerTeams(pl)) do
		removeTeam(team)
	end
end

local function invitePlayer(pl, mate)
	mate:SetNWEntity("LastTeammate", pl)
	net.Start("Fray Teammates Invitation")
		net.WriteEntity(mate)
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
	local mate = net.ReadEntity()
	local team = {pl, mate}
	if teamExists(team) then
		removeTeam(team)
	end
end)

--[[
	Hooks
]]

hook.Add("EntityTakeDamage", "Fray Teammates", function(pl, dmg)
	local attacker = dmg:GetAttacker()
	if teamExists({attacker, pl}) then
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