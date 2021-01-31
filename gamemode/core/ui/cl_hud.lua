local pl
local hp, ar, hg, th
local _hp, _ar, _hg, _th
local kills, rank, money
local babygod
local x, y, br, placed = 0, 0, 0
local tall = 40

local f_h = "xpgui_medium"
local f_a = "xpgui_huge"

local m_hp = Color(153, 66, 69)
local m_ar = Color(66, 82, 153)
local m_hg = Color(189, 153, 111)
local m_th = Color(53, 114, 143)
local m_rnk = Color(227, 148, 141)
local m_mn = Color(106, 171, 121)
local m_pr = Color(194, 167, 79)

local function txt(str, font, x, y, color, align_x, align_y)
	draw.SimpleText(str, font, x, y + 1, ColorAlpha(color_black, 240), align_x or TEXT_ALIGN_LEFT, align_y or TEXT_ALIGN_TOP)
	draw.SimpleText(str, font, x, y, color, align_x or TEXT_ALIGN_LEFT, align_y or TEXT_ALIGN_TOP)
	return tall
end

local scaled = ScreenScale(76)
local function _draw(x, y, color, num, max, anim)
	local _x = x + (tall / 3)

	local _txt = math.Round(Lerp(30 * FrameTime(), num, max)) .. "%"
	surface.SetFont(f_h)
	local w = surface.GetTextSize(_txt)
	_x = _x + w

	txt(_txt, f_h, x, y - 3, color_white)

	draw.RoundedBox(4, _x, y, scaled + 6, 14, ColorAlpha(color_black, 180))
	draw.RoundedBox(3, _x + 3, y + 3, max * (scaled / 100), 8, color)

	return tall
end

local function set(h)
	y = y - h
	br = math.max(br, h)
end

local hud = {}

local function place(...)
	table.insert(hud, {...})
end

local function nearest(tbl, num)
    local min, min_i
	for i, y in ipairs(tbl) do
		if tonumber(num) > y or tonumber(num) == y then
			continue
		end
        if not min or (math.abs(num - y) < min) then
            min = math.abs(num - y)
            min_i = i
        end
    end
    return tbl[min_i]
end

local function getNextRank(num)
	local nums = {}
	for rank, data in pairs(Fray.Ranks) do
		table.insert(nums, data.kills)
	end
	return nearest(nums, num)
end

place(
	function()
		if math.Round(_ar) > 0 then
			set(_draw(x, y, m_ar, ar, math.Clamp(_ar, 0, pl:GetMaxArmor()), _ar))
		end
	end,
	function()
		set(_draw(x, y, m_th, th, math.Clamp(_th, 0, 100), _th))
	end,
	function()
		set(_draw(x, y, m_hg, hg, math.Clamp(_hg, 0, 100), _hg))
	end,
	function()
		set(_draw(x, y, m_hp, hp, math.Clamp(_hp, 0, pl:GetMaxHealth()), _hp))
	end, 
	function()
		x, y = ScrW() - 32, ScrH() - 32
		if babygod then
			set(txt(Fray.GetPhrase("babygod"), f_a, x, y, m_pr, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER))
		end
		set(txt(Fray.GetPhrase(rank), f_a, x, y, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER))
		set(txt(kills .. "/" .. getNextRank(kills), f_h, x, y, m_rnk, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER))
		set(txt(money, f_h, x, y, m_mn, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER))
	end
)

hook.Add("HUDPaint", "Fray HUD", function()
	pl = LocalPlayer()
	if not pl:Alive() then
		return
	end

	hp, ar, hg, th = pl:Health(), pl:Armor(), pl:GetNWInt("Hunger"), pl:GetNWInt("Thirst")
	_hp = Lerp(5 * FrameTime(), _hp or 0, hp or 0)
	_ar = Lerp(5 * FrameTime(), _ar or 0, ar or 0)
	_hg = Lerp(5 * FrameTime(), _hg or 0, hg or 0)
	_th = Lerp(5 * FrameTime(), _th or 0, th or 0)

	kills, rank = pl:GetNWString("Kills"), pl:GetNWString("Rank")
	money = "$" .. string.Comma(pl:GetNWInt("Money"))
	babygod = pl:GetNWBool("Babygod")

	local offy, offx = ScrH() - 48, 32
	x, y = offx, offy

	for _, row in pairs(hud) do
		for _, fn in pairs(row) do
			xpcall(fn, Error)
		end
	
		offy = offy - br
		br = 0
		
		y = offy
		x = offx
	end
end)