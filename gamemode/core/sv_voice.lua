hook.Add("PlayerCanHearPlayersVoice", "Fray Voice", function(listener, talker)
	return listener:GetPos():DistToSqr(talker:GetPos()) < 450000, true
end)