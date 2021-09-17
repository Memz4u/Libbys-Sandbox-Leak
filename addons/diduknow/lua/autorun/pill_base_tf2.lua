-- "addons\\diduknow\\lua\\autorun\\pill_base_tf2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--------------------------
-- BOOTSTRAP CODE START --
--------------------------

if !pcall(require,"pk_pills") then
	if SERVER then
		hook.Add("PlayerInitialSpawn","pk_pill_extfail_cl",function(ply)
			if game.SinglePlayer() || ply:IsListenServerHost() then
				ply:SendLua('notification.AddLegacy("One or more pill extensions failed to load. Did you forget to install Parakeet\'s Pill Pack?",NOTIFY_ERROR,30)')
			end
		end)
		hook.Add("Initialize","pk_pill_extfail_sv",function(ply)
			print("[ALERT] One or more pill extensions failed to load. Did you forget to install Parakeet's Pill Pack?")
		end)
	end
	return
end

------------------------
-- BOOTSTRAP CODE END --
------------------------

AddCSLuaFile()

if SERVER then
	resource.AddWorkshop("258248317")
end

game.AddParticles("particles/explosion.pcf")
PrecacheParticleSystem("ExplosionCore_MidAir")

game.AddParticles("particles/bigboom.pcf")
PrecacheParticleSystem("fireSmokeExplosion")

game.AddParticles("particles/dirty_explode.pcf")
PrecacheParticleSystem("cinefx_goldrush")

game.AddParticles("particles/eyeboss.pcf")
PrecacheParticleSystem("eyeboss_projectile")

game.AddParticles("particles/rockettrail.pcf")
PrecacheParticleSystem("critical_rocket_red")
PrecacheParticleSystem("critical_rocket_blue")

game.AddParticles("particles/medicgun_beam.pcf")
PrecacheParticleSystem("medicgun_beam_blue")
PrecacheParticleSystem("medicgun_beam_red")

game.AddParticles("particles/flamethrower.pcf")
PrecacheParticleSystem("_flamethrower_real")
PrecacheParticleSystem("flamethrower_underwater")

game.AddParticles("particles/nailtrails.pcf")
PrecacheParticleSystem("nailtrails_medic_red")
PrecacheParticleSystem("nailtrails_medic_blue")

game.AddParticles("particles/stickybomb.pcf")
PrecacheParticleSystem("stickybombtrail_red")
PrecacheParticleSystem("stickybombtrail_blue")
PrecacheParticleSystem("pipebombtrail_red")
PrecacheParticleSystem("pipebombtrail_blue")
PrecacheParticleSystem("stickybomb_pulse_red")
PrecacheParticleSystem("stickybomb_pulse_blue")

pk_pills.packStart("Team Fortress 2","tf2","games/16/tf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_sentry.lua")
include("include/pill_tf_robots.lua")
include("include/pill_tf_spooky.lua")

include("include/pill_tf_classes.lua")

pk_pills.packStart("TF2 - Fun","tf2-fun","pack_icon_funtf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_cutouts.lua")
include("include/pill_tf_fun.lua")

-- "addons\\diduknow\\lua\\autorun\\pill_base_tf2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--------------------------
-- BOOTSTRAP CODE START --
--------------------------

if !pcall(require,"pk_pills") then
	if SERVER then
		hook.Add("PlayerInitialSpawn","pk_pill_extfail_cl",function(ply)
			if game.SinglePlayer() || ply:IsListenServerHost() then
				ply:SendLua('notification.AddLegacy("One or more pill extensions failed to load. Did you forget to install Parakeet\'s Pill Pack?",NOTIFY_ERROR,30)')
			end
		end)
		hook.Add("Initialize","pk_pill_extfail_sv",function(ply)
			print("[ALERT] One or more pill extensions failed to load. Did you forget to install Parakeet's Pill Pack?")
		end)
	end
	return
end

------------------------
-- BOOTSTRAP CODE END --
------------------------

AddCSLuaFile()

if SERVER then
	resource.AddWorkshop("258248317")
end

game.AddParticles("particles/explosion.pcf")
PrecacheParticleSystem("ExplosionCore_MidAir")

game.AddParticles("particles/bigboom.pcf")
PrecacheParticleSystem("fireSmokeExplosion")

game.AddParticles("particles/dirty_explode.pcf")
PrecacheParticleSystem("cinefx_goldrush")

game.AddParticles("particles/eyeboss.pcf")
PrecacheParticleSystem("eyeboss_projectile")

game.AddParticles("particles/rockettrail.pcf")
PrecacheParticleSystem("critical_rocket_red")
PrecacheParticleSystem("critical_rocket_blue")

game.AddParticles("particles/medicgun_beam.pcf")
PrecacheParticleSystem("medicgun_beam_blue")
PrecacheParticleSystem("medicgun_beam_red")

game.AddParticles("particles/flamethrower.pcf")
PrecacheParticleSystem("_flamethrower_real")
PrecacheParticleSystem("flamethrower_underwater")

game.AddParticles("particles/nailtrails.pcf")
PrecacheParticleSystem("nailtrails_medic_red")
PrecacheParticleSystem("nailtrails_medic_blue")

game.AddParticles("particles/stickybomb.pcf")
PrecacheParticleSystem("stickybombtrail_red")
PrecacheParticleSystem("stickybombtrail_blue")
PrecacheParticleSystem("pipebombtrail_red")
PrecacheParticleSystem("pipebombtrail_blue")
PrecacheParticleSystem("stickybomb_pulse_red")
PrecacheParticleSystem("stickybomb_pulse_blue")

pk_pills.packStart("Team Fortress 2","tf2","games/16/tf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_sentry.lua")
include("include/pill_tf_robots.lua")
include("include/pill_tf_spooky.lua")

include("include/pill_tf_classes.lua")

pk_pills.packStart("TF2 - Fun","tf2-fun","pack_icon_funtf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_cutouts.lua")
include("include/pill_tf_fun.lua")

-- "addons\\diduknow\\lua\\autorun\\pill_base_tf2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--------------------------
-- BOOTSTRAP CODE START --
--------------------------

if !pcall(require,"pk_pills") then
	if SERVER then
		hook.Add("PlayerInitialSpawn","pk_pill_extfail_cl",function(ply)
			if game.SinglePlayer() || ply:IsListenServerHost() then
				ply:SendLua('notification.AddLegacy("One or more pill extensions failed to load. Did you forget to install Parakeet\'s Pill Pack?",NOTIFY_ERROR,30)')
			end
		end)
		hook.Add("Initialize","pk_pill_extfail_sv",function(ply)
			print("[ALERT] One or more pill extensions failed to load. Did you forget to install Parakeet's Pill Pack?")
		end)
	end
	return
end

------------------------
-- BOOTSTRAP CODE END --
------------------------

AddCSLuaFile()

if SERVER then
	resource.AddWorkshop("258248317")
end

game.AddParticles("particles/explosion.pcf")
PrecacheParticleSystem("ExplosionCore_MidAir")

game.AddParticles("particles/bigboom.pcf")
PrecacheParticleSystem("fireSmokeExplosion")

game.AddParticles("particles/dirty_explode.pcf")
PrecacheParticleSystem("cinefx_goldrush")

game.AddParticles("particles/eyeboss.pcf")
PrecacheParticleSystem("eyeboss_projectile")

game.AddParticles("particles/rockettrail.pcf")
PrecacheParticleSystem("critical_rocket_red")
PrecacheParticleSystem("critical_rocket_blue")

game.AddParticles("particles/medicgun_beam.pcf")
PrecacheParticleSystem("medicgun_beam_blue")
PrecacheParticleSystem("medicgun_beam_red")

game.AddParticles("particles/flamethrower.pcf")
PrecacheParticleSystem("_flamethrower_real")
PrecacheParticleSystem("flamethrower_underwater")

game.AddParticles("particles/nailtrails.pcf")
PrecacheParticleSystem("nailtrails_medic_red")
PrecacheParticleSystem("nailtrails_medic_blue")

game.AddParticles("particles/stickybomb.pcf")
PrecacheParticleSystem("stickybombtrail_red")
PrecacheParticleSystem("stickybombtrail_blue")
PrecacheParticleSystem("pipebombtrail_red")
PrecacheParticleSystem("pipebombtrail_blue")
PrecacheParticleSystem("stickybomb_pulse_red")
PrecacheParticleSystem("stickybomb_pulse_blue")

pk_pills.packStart("Team Fortress 2","tf2","games/16/tf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_sentry.lua")
include("include/pill_tf_robots.lua")
include("include/pill_tf_spooky.lua")

include("include/pill_tf_classes.lua")

pk_pills.packStart("TF2 - Fun","tf2-fun","pack_icon_funtf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_cutouts.lua")
include("include/pill_tf_fun.lua")

-- "addons\\diduknow\\lua\\autorun\\pill_base_tf2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--------------------------
-- BOOTSTRAP CODE START --
--------------------------

if !pcall(require,"pk_pills") then
	if SERVER then
		hook.Add("PlayerInitialSpawn","pk_pill_extfail_cl",function(ply)
			if game.SinglePlayer() || ply:IsListenServerHost() then
				ply:SendLua('notification.AddLegacy("One or more pill extensions failed to load. Did you forget to install Parakeet\'s Pill Pack?",NOTIFY_ERROR,30)')
			end
		end)
		hook.Add("Initialize","pk_pill_extfail_sv",function(ply)
			print("[ALERT] One or more pill extensions failed to load. Did you forget to install Parakeet's Pill Pack?")
		end)
	end
	return
end

------------------------
-- BOOTSTRAP CODE END --
------------------------

AddCSLuaFile()

if SERVER then
	resource.AddWorkshop("258248317")
end

game.AddParticles("particles/explosion.pcf")
PrecacheParticleSystem("ExplosionCore_MidAir")

game.AddParticles("particles/bigboom.pcf")
PrecacheParticleSystem("fireSmokeExplosion")

game.AddParticles("particles/dirty_explode.pcf")
PrecacheParticleSystem("cinefx_goldrush")

game.AddParticles("particles/eyeboss.pcf")
PrecacheParticleSystem("eyeboss_projectile")

game.AddParticles("particles/rockettrail.pcf")
PrecacheParticleSystem("critical_rocket_red")
PrecacheParticleSystem("critical_rocket_blue")

game.AddParticles("particles/medicgun_beam.pcf")
PrecacheParticleSystem("medicgun_beam_blue")
PrecacheParticleSystem("medicgun_beam_red")

game.AddParticles("particles/flamethrower.pcf")
PrecacheParticleSystem("_flamethrower_real")
PrecacheParticleSystem("flamethrower_underwater")

game.AddParticles("particles/nailtrails.pcf")
PrecacheParticleSystem("nailtrails_medic_red")
PrecacheParticleSystem("nailtrails_medic_blue")

game.AddParticles("particles/stickybomb.pcf")
PrecacheParticleSystem("stickybombtrail_red")
PrecacheParticleSystem("stickybombtrail_blue")
PrecacheParticleSystem("pipebombtrail_red")
PrecacheParticleSystem("pipebombtrail_blue")
PrecacheParticleSystem("stickybomb_pulse_red")
PrecacheParticleSystem("stickybomb_pulse_blue")

pk_pills.packStart("Team Fortress 2","tf2","games/16/tf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_sentry.lua")
include("include/pill_tf_robots.lua")
include("include/pill_tf_spooky.lua")

include("include/pill_tf_classes.lua")

pk_pills.packStart("TF2 - Fun","tf2-fun","pack_icon_funtf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_cutouts.lua")
include("include/pill_tf_fun.lua")

-- "addons\\diduknow\\lua\\autorun\\pill_base_tf2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--------------------------
-- BOOTSTRAP CODE START --
--------------------------

if !pcall(require,"pk_pills") then
	if SERVER then
		hook.Add("PlayerInitialSpawn","pk_pill_extfail_cl",function(ply)
			if game.SinglePlayer() || ply:IsListenServerHost() then
				ply:SendLua('notification.AddLegacy("One or more pill extensions failed to load. Did you forget to install Parakeet\'s Pill Pack?",NOTIFY_ERROR,30)')
			end
		end)
		hook.Add("Initialize","pk_pill_extfail_sv",function(ply)
			print("[ALERT] One or more pill extensions failed to load. Did you forget to install Parakeet's Pill Pack?")
		end)
	end
	return
end

------------------------
-- BOOTSTRAP CODE END --
------------------------

AddCSLuaFile()

if SERVER then
	resource.AddWorkshop("258248317")
end

game.AddParticles("particles/explosion.pcf")
PrecacheParticleSystem("ExplosionCore_MidAir")

game.AddParticles("particles/bigboom.pcf")
PrecacheParticleSystem("fireSmokeExplosion")

game.AddParticles("particles/dirty_explode.pcf")
PrecacheParticleSystem("cinefx_goldrush")

game.AddParticles("particles/eyeboss.pcf")
PrecacheParticleSystem("eyeboss_projectile")

game.AddParticles("particles/rockettrail.pcf")
PrecacheParticleSystem("critical_rocket_red")
PrecacheParticleSystem("critical_rocket_blue")

game.AddParticles("particles/medicgun_beam.pcf")
PrecacheParticleSystem("medicgun_beam_blue")
PrecacheParticleSystem("medicgun_beam_red")

game.AddParticles("particles/flamethrower.pcf")
PrecacheParticleSystem("_flamethrower_real")
PrecacheParticleSystem("flamethrower_underwater")

game.AddParticles("particles/nailtrails.pcf")
PrecacheParticleSystem("nailtrails_medic_red")
PrecacheParticleSystem("nailtrails_medic_blue")

game.AddParticles("particles/stickybomb.pcf")
PrecacheParticleSystem("stickybombtrail_red")
PrecacheParticleSystem("stickybombtrail_blue")
PrecacheParticleSystem("pipebombtrail_red")
PrecacheParticleSystem("pipebombtrail_blue")
PrecacheParticleSystem("stickybomb_pulse_red")
PrecacheParticleSystem("stickybomb_pulse_blue")

pk_pills.packStart("Team Fortress 2","tf2","games/16/tf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_sentry.lua")
include("include/pill_tf_robots.lua")
include("include/pill_tf_spooky.lua")

include("include/pill_tf_classes.lua")

pk_pills.packStart("TF2 - Fun","tf2-fun","pack_icon_funtf.png")
pk_pills.packRequireGame("Team Fortress 2",440)

include("include/pill_tf_cutouts.lua")
include("include/pill_tf_fun.lua")

