util.AddNetworkString("Fray Ranks Broadcast")

local meta = FindMetaTable("Player")

function meta:GetRank()
	local _rank
	for rank, data in pairs(Fray.Ranks) do
		if self:GetPData("Kills", 0) > data.kills then
			_rank = rank
		end
	end
	return _rank
end

local function broadcastRank(pl)
	net.Start("Fray Ranks Broadcast")
		net.WriteEntity(pl)
		net.WriteString(pl:GetRank())
		net.WriteInt(self:GetPData("Kills", 0), 16)
	net.Broadcast()
end

hook.Add("PlayerInitialSpawn", "Fray Ranks", broadcastRank)
hook.Add("PlayerDeath", "Fray Ranks", function(victim, _, killer)
	if not (victim:IsPlayer() and killer:IsPlayer()) then
		return
	end
	killer:SetPData("Kills", killer:GetPData("Kills", 0) + 1)
	broadcastRank(killer)
end)