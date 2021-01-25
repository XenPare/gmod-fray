local meta = FindMetaTable("Player")

function meta:CanDeliver()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + (Vector(0, 0, 1) * 16384),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
    return tr.HitSky, tr.HitPos
end