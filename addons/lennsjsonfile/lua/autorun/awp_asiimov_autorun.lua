-- "addons\\lennsjsonfile\\lua\\autorun\\awp_asiimov_autorun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add("awp_asiimov","vgui/hud/awp_asiimov",Color(255,255,255));
end

//these are some variables we need to keep for stuff to work
//that means don't delete them

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end


//AWP Asiimov Sounds
sound.Add({
	name = 			"awp_asiimov.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp1.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_draw.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltback.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltforward.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipout.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipin.wav"
})
sound.Add({
	name = 			"Weapon_awp_cliphit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_cliphit.wav"
})

//this stuff is important, too. It's to prevent DarkRP players from using an exploit to get infinite ammo.
//just leave it be, its fine here as it is.
m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )


-- "addons\\lennsjsonfile\\lua\\autorun\\awp_asiimov_autorun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add("awp_asiimov","vgui/hud/awp_asiimov",Color(255,255,255));
end

//these are some variables we need to keep for stuff to work
//that means don't delete them

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end


//AWP Asiimov Sounds
sound.Add({
	name = 			"awp_asiimov.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp1.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_draw.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltback.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltforward.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipout.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipin.wav"
})
sound.Add({
	name = 			"Weapon_awp_cliphit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_cliphit.wav"
})

//this stuff is important, too. It's to prevent DarkRP players from using an exploit to get infinite ammo.
//just leave it be, its fine here as it is.
m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )


-- "addons\\lennsjsonfile\\lua\\autorun\\awp_asiimov_autorun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add("awp_asiimov","vgui/hud/awp_asiimov",Color(255,255,255));
end

//these are some variables we need to keep for stuff to work
//that means don't delete them

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end


//AWP Asiimov Sounds
sound.Add({
	name = 			"awp_asiimov.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp1.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_draw.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltback.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltforward.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipout.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipin.wav"
})
sound.Add({
	name = 			"Weapon_awp_cliphit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_cliphit.wav"
})

//this stuff is important, too. It's to prevent DarkRP players from using an exploit to get infinite ammo.
//just leave it be, its fine here as it is.
m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )


-- "addons\\lennsjsonfile\\lua\\autorun\\awp_asiimov_autorun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add("awp_asiimov","vgui/hud/awp_asiimov",Color(255,255,255));
end

//these are some variables we need to keep for stuff to work
//that means don't delete them

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end


//AWP Asiimov Sounds
sound.Add({
	name = 			"awp_asiimov.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp1.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_draw.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltback.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltforward.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipout.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipin.wav"
})
sound.Add({
	name = 			"Weapon_awp_cliphit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_cliphit.wav"
})

//this stuff is important, too. It's to prevent DarkRP players from using an exploit to get infinite ammo.
//just leave it be, its fine here as it is.
m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )


-- "addons\\lennsjsonfile\\lua\\autorun\\awp_asiimov_autorun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//this part is for making kill icons
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add("awp_asiimov","vgui/hud/awp_asiimov",Color(255,255,255));
end

//these are some variables we need to keep for stuff to work
//that means don't delete them

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end


//AWP Asiimov Sounds
sound.Add({
	name = 			"awp_asiimov.shot",
	channel = 		CHAN_USER_BASE+10, --see how this is a different channel? Gunshots go here
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp1.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_draw.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltback.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_boltforward.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipout.wav"
})
sound.Add({
	name = 			"WEAPON_ASI.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_clipin.wav"
})
sound.Add({
	name = 			"Weapon_awp_cliphit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/awp_asiimov/awp_cliphit.wav"
})

//this stuff is important, too. It's to prevent DarkRP players from using an exploit to get infinite ammo.
//just leave it be, its fine here as it is.
m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )


