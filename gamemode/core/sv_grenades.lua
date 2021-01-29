hook.Add("PlayerSwitchWeapon", "Fray Grenades", function(pl, old)
	if not (IsValid(old) and string.find(old:GetClass(), "grenade")) then
		return
	end
	if not old:HasAmmo() then
		pl:StripWeapon(old:GetClass())
	end
end)