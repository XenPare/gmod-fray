util.AddNetworkString("Fray Ranks Broadcast")

local meta = FindMetaTable("Player")

function meta:GetRank()
	local _rank = "mortal"
	for rank, data in SortedPairsByMemberValue(Fray.Ranks, "kills") do
		if tonumber(self:GetPData("Kills", 0)) >= data.kills then
			_rank = rank
		end
	end
	return _rank
end

local function broadcastRank(pl)
	net.Start("Fray Ranks Broadcast")
		net.WriteEntity(pl)
		net.WriteString(pl:GetRank())
		net.WriteInt(pl:GetPData("Kills", 0), 16)
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