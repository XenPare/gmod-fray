net.Receive("Fray Ranks Broadcast", function()
	local pl = net.ReadEntity()
	local rank = net.ReadString()
	local kills = net.ReadInt(16)
	pl.Rank = rank
	pl.Kills = kills
end)