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

local function broadcastRank(pl, killed)
	local kills = pl:GetPData("Kills", 0)
	if killed then
		pl:SetPData("Kills", kills + 1)
	end
	pl:SetNWInt("Kills", kills)
	pl:SetNWString("Rank", pl:GetRank())

	net.Start("Fray Ranks Broadcast")
		net.WriteEntity(pl)
	net.Broadcast()
end

hook.Add("PlayerInitialSpawn", "Fray Ranks", broadcastRank)
hook.Add("PlayerDeath", "Fray Ranks", function(victim, _, killer)
	if victim:IsPlayer() and killer:IsPlayer() and not victim == killer then
		broadcastRank(killer, true)
	end
end)