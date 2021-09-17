-- "addons\\lennsjsonfile\\lua\\weapons\\awp_asiimov\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Variables that are used on both client and server
SWEP.Gun = ("awp_asiimov") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "AWP Asiimov" --Category where you will find your weapons
SWEP.Author				= "Alex C"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "AWP Asiimov"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair				= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= true         -- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_asii_awp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "amc_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("awp_asiimov.shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 32		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 30	-- Bullets you start with
SWEP.Primary.KickUp			= 1.0				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .4 		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom		= 2
SWEP.Secondary.UseAWP			= true
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.51
SWEP.ReticleScale 			= 0.6

SWEP.Primary.Damage			= 100000	--base damage per bullet
SWEP.Primary.Spread			= .001	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 		= .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (0, 0, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Vector (0, 0, 0)
SWEP.WElements = {
	["AWP"] = { type = "Model", model = "models/weapons/w_asii_awp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.5, 0.8, 0.409), angle = Angle(-169, 180, -0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- "addons\\lennsjsonfile\\lua\\weapons\\awp_asiimov\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Variables that are used on both client and server
SWEP.Gun = ("awp_asiimov") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "AWP Asiimov" --Category where you will find your weapons
SWEP.Author				= "Alex C"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "AWP Asiimov"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair				= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= true         -- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_asii_awp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "amc_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("awp_asiimov.shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 32		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 30	-- Bullets you start with
SWEP.Primary.KickUp			= 1.0				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .4 		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom		= 2
SWEP.Secondary.UseAWP			= true
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.51
SWEP.ReticleScale 			= 0.6

SWEP.Primary.Damage			= 100000	--base damage per bullet
SWEP.Primary.Spread			= .001	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 		= .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (0, 0, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Vector (0, 0, 0)
SWEP.WElements = {
	["AWP"] = { type = "Model", model = "models/weapons/w_asii_awp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.5, 0.8, 0.409), angle = Angle(-169, 180, -0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- "addons\\lennsjsonfile\\lua\\weapons\\awp_asiimov\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Variables that are used on both client and server
SWEP.Gun = ("awp_asiimov") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "AWP Asiimov" --Category where you will find your weapons
SWEP.Author				= "Alex C"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "AWP Asiimov"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair				= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= true         -- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_asii_awp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "amc_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("awp_asiimov.shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 32		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 30	-- Bullets you start with
SWEP.Primary.KickUp			= 1.0				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .4 		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom		= 2
SWEP.Secondary.UseAWP			= true
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.51
SWEP.ReticleScale 			= 0.6

SWEP.Primary.Damage			= 100000	--base damage per bullet
SWEP.Primary.Spread			= .001	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 		= .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (0, 0, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Vector (0, 0, 0)
SWEP.WElements = {
	["AWP"] = { type = "Model", model = "models/weapons/w_asii_awp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.5, 0.8, 0.409), angle = Angle(-169, 180, -0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- "addons\\lennsjsonfile\\lua\\weapons\\awp_asiimov\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Variables that are used on both client and server
SWEP.Gun = ("awp_asiimov") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "AWP Asiimov" --Category where you will find your weapons
SWEP.Author				= "Alex C"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "AWP Asiimov"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair				= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= true         -- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_asii_awp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "amc_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("awp_asiimov.shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 32		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 30	-- Bullets you start with
SWEP.Primary.KickUp			= 1.0				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .4 		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom		= 2
SWEP.Secondary.UseAWP			= true
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.51
SWEP.ReticleScale 			= 0.6

SWEP.Primary.Damage			= 100000	--base damage per bullet
SWEP.Primary.Spread			= .001	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 		= .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (0, 0, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Vector (0, 0, 0)
SWEP.WElements = {
	["AWP"] = { type = "Model", model = "models/weapons/w_asii_awp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.5, 0.8, 0.409), angle = Angle(-169, 180, -0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- "addons\\lennsjsonfile\\lua\\weapons\\awp_asiimov\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Variables that are used on both client and server
SWEP.Gun = ("awp_asiimov") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "AWP Asiimov" --Category where you will find your weapons
SWEP.Author				= "Alex C"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.PrintName				= "AWP Asiimov"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 4			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.XHair				= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction				= true         -- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_asii_awp.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pistol.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base 				= "amc_scoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE!
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("awp_asiimov.shot")		-- script that calls the primary fire sound
SWEP.Primary.RPM			= 32		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 30	-- Bullets you start with
SWEP.Primary.KickUp			= 1.0				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= .4			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= .4 		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "SniperPenetratedRound"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom		= 2
SWEP.Secondary.UseAWP			= true
SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.ScopeScale 			= 0.51
SWEP.ReticleScale 			= 0.6

SWEP.Primary.Damage			= 100000	--base damage per bullet
SWEP.Primary.Spread			= .001	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy 		= .0001 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector (0, 0, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (0, 0, 0)
SWEP.RunSightsAng = Vector (0, 0, 0)
SWEP.WElements = {
	["AWP"] = { type = "Model", model = "models/weapons/w_asii_awp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.5, 0.8, 0.409), angle = Angle(-169, 180, -0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

