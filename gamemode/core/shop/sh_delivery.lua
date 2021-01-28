local meta = FindMetaTable("Player")

function meta:CanDeliver()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + (Vector(0, 0, 1) * 16384),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
	if tr.HitSky then
		local additional = tr.HitPos - Vector(0, 0, 200) + VectorRand(-200, 200)
		return util.IsInWorld(additonal), additional
	end
	return false
end