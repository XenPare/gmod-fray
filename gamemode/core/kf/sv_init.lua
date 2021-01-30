util.AddNetworkString("Fray KillFeed")

hook.Add("PlayerDeath", "Fray KillFeed", function(victim, _, attacker)
	if not victim:IsPlayer() or not attacker:IsPlayer() then
		return
	end
	net.Start("Fray KillFeed")
		net.WriteEntity(victim)
		net.WriteEntity(attacker)
	net.Broadcast()
end)