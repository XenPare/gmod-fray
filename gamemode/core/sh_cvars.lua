local cl_cvars = {
	["gmod_mcore_test"] = 1,
	["mat_queue_mode"] = -1,
	["cl_threaded_bone_setup"] = 1,
	["cw_crosshair"] = 0
}

local sv_cvars = {
	["cw_att_bg_ak74_rpkbarrel"] = 0,
	["cw_att_bg_ak74_ubarrel"] = 0,
	["cw_att_bg_ak74foldablestock"] = 0,
	["cw_att_bg_ak74heavystock"] = 0,
	["cw_att_bg_ak74rpkmag"] = 0,
	["cw_att_bg_ar1560rndmag"] = 0,
	["cw_att_bg_ar15heavystock"] = 0,
	["cw_att_bg_ar15sturdystock"] = 0,
	["cw_att_bg_bipod"] = 0,
	["cw_att_bg_deagle_compensator"] = 0,
	["cw_att_bg_deagle_extendedbarrel"] = 0,
	["cw_att_bg_foldsight"] = 0,
	["cw_att_bg_longbarrel"] = 0,
	["cw_att_bg_longbarrelmr96"] = 0,
	["cw_att_bg_longris"] = 0,
	["cw_att_bg_magpulhandguard"] = 0,
	["cw_att_bg_mp530rndmag"] = 0,
	["cw_att_bg_mp5_kbarrel"] = 0,
	["cw_att_bg_mp5_sdbarrel"] = 0,
	["cw_att_bg_nostock"] = 0,
	["cw_att_bg_regularbarrel"] = 0,
	["cw_att_bg_retractablestock"] = 0,
	["cw_att_bg_ris"] = 0,
	["cw_att_bg_sg1scope"] = 0,
	["cw_att_md_acog"] = 0,
	["cw_att_md_aimpoint"] = 0,
	["cw_att_md_anpeq15"] = 0,
	["cw_att_md_bipod"] = 0,
	["cw_att_md_cobram2"] = 0,
	["cw_att_md_eotech"] = 0,
	["cw_att_md_foregrip"] = 0,
	["cw_att_md_insight_x2"] = 0,
	["cw_att_md_kobra"] = 0,
	["cw_att_md_m203"] = 0,
	["cw_att_md_microt1"] = 0,
	["cw_att_md_nightforce_nxs"] = 0,
	["cw_att_md_pbs1"] = 0,
	["cw_att_md_pso1"] = 0,
	["cw_att_md_rmr"] = 0,
	["cw_att_md_saker"] = 0,
	["cw_att_md_schmidt_shortdot"] = 0,
	["cw_att_md_tundra9mm"] = 0,
	["cw_att_am_flechetterounds"] = 0,
	["cw_att_am_magnum"] = 0,
	["cw_att_am_matchgrade"] = 0,
	["cw_att_am_slugrounds"] = 0,
	["cw_att_bg_mac11_extended_barrel"] = 0,
	["cw_att_bg_mac11_unfolded_stock"] = 0,
	["cw_att_bg_asval_20rnd"] = 0,
	["cw_att_bg_asval_30rnd"] = 0,
	["cw_att_bg_asval"] = 0,
	["cw_att_bg_sr3m"] = 0,
	["cw_att_bg_vss_foldable_stock"] = 0,
	["cw_att_bg_makarov_extmag"] = 0,
	["cw_att_bg_makarov_pb6p9"] = 0,
	["cw_att_bg_makarov_pb_suppressor"] = 0,
	["cw_att_bg_makarov_pm_suppressor"] = 0,
	["cw_att_am_sp7"] = 0
}

if SERVER then
	for cvar, num in pairs(sv_cvars) do
		RunConsoleCommand(cvar, num)
	end
else
	for cvar, num in pairs(cl_cvars) do
		RunConsoleCommand(cvar, num)
	end
end