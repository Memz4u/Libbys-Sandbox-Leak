-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_spooky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_hhh",{
	printName="HHH",
	type="ply",
	model="models/bots/headless_hatman.mdl",
	side="wild",
	//modelScale=1.75,
	attachments={"models/weapons/c_models/c_bigaxe/c_bigaxe.mdl"},
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	duckBy=30,
	anims={
		default={
			idle="stand_item1",
			walk="run_item1",
			crouch="crouch_item1",
			crouch_walk="crouch_walk_item1",
			glide="airwalk_item1",
			g_melee="attackstand_item1"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boss/knight_laugh0#.mp3",4),
		//vo/halloween_boss/knight_laugh01.mp3
		melee=pk_pills.helpers.makeList("vo/halloween_boss/knight_attack0#.mp3",4),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_boss/knight_death02.mp3"
	},
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=200
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_skeleton_king",{
	parent="tf_hhh",
	printName="Skeleton King",
	model="models/bots/skeleton_sniper_boss/skeleton_sniper_boss.mdl",
	modelScale=1.75,
	attachments={"models/player/items/demo/crown.mdl"},
	default_rp_cost=8000,
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	anims={
		default={
			g_melee="melee_swing"
		}
	},
	skin=2,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_giant_0#.wav",3),
		melee="weapons/knife_swing.wav",
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		die="misc/halloween/skeleton_break.wav"
	},
	attack={
		dmg=50
	},
	noragdoll=true,
	health=1000
})

pk_pills.register("tf_skeleton",{
	parent="tf_skeleton_king",
	printName="Skeleton",
	model="models/bots/skeleton_sniper/skeleton_sniper.mdl",
	modelScale=false,
	attachments=false,
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,60),
		dist=100
	},
	hull=Vector(30,30,80),
	duckBy=20,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_medium_0#.wav",7)
	},
	attack={
		range=30,
		dmg=25
	},
	moveSpeed={
		walk=150,
		run=300
	},
	jumpPower=200,
	health=150
})

pk_pills.register("tf_skeleton_tiny",{
	parent="tf_skeleton",
	printName="Tiny Skeleton",
	modelScale=.5,
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,30),
		dist=75
	},
	hull=Vector(30,30,50),
	duckBy=10,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_small_0#.wav",9)
	},
	attack={
		dmg=10
	},
	health=75
})

pk_pills.register("tf_ghost",{
	printName="Ghost",
	type="ply",
	side="wild",
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,60),
		dist=200
	},
	hull=Vector(30,30,80),
	options=function() return {
		{model="models/props_halloween/ghost.mdl"},
		{model="models/props_halloween/ghost_no_hat.mdl"}
	} end,
	anims={
		default={
			idle="idle"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boo#.mp3",7)
	},
	muteSteps=true,
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	moveSpeed={
		walk=200,
		run=400
	},
	noFallDamage=true,
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*400+Vector(0,0,200))
		end
	end
	//health=3000
})

pk_pills.register("tf_eye",{
	printName="MONOCULUS",
	side="wild",
	type="phys",
	model="models/props_halloween/halloween_demoeye.mdl",
	sphericalPhysics=50,
	default_rp_cost=20000,
	driveType="fly",
	driveOptions={
		speed=10
	},
	camera={
		dist=300
	},
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	skin=0,
	aim={
		xPose="left_right",
		yPose="up_down"
	},
	attack={
		mode="auto",
		delay=.5,
		func=function(ply,ent)
			ent:PillSound("shoot",true)
			ent:PillAnim("firing1",true)
			ent:SetCycle(.5)

			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/props_halloween/eyeball_projectile.mdl")
			rocket:SetPos(ent:GetPos())
			rocket:SetAngles(ply:EyeAngles())
			rocket.speed=330
			rocket.dmgmod=3
			//rocket.shooter=ent
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			if ent:GetSkin()==2 then
				rocket:SetParticle("critical_rocket_red")
			elseif ent:GetSkin()==3 then
				rocket:SetParticle("critical_rocket_blue")
			else
				rocket:SetParticle("eyeboss_projectile")
			end
			rocket:Spawn()
			rocket:SetOwner(ply)
		end
	},
	attack2={
		mode= "trigger",
		func=function(ply,ent)
			ent:PillSound("laugh")
			ent:PillAnim("laugh",true)
		end
	},
	seqInit="general_noise",
	health=10000,
	sounds={
		die="vo/halloween_eyeball/eyeball_boss_pain01.mp3",
		shoot = "weapons/rocket_shoot_crit.wav",
		laugh= pk_pills.helpers.makeList("vo/halloween_eyeball/eyeball_laugh0#.mp3",3)
	}
})

pk_pills.register("tf_wizard",{
	printName="Merasmus",
	type="ply",
	model="models/bots/merasmus/merasmus.mdl",
	side="wild",
	//modelScale=1.75,
	default_rp_cost=25000,
	camera={
		offset=Vector(0,0,120),
		dist=200
	},
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	hull=Vector(50,50,140),
	aim={},
	anims={
		default={
			idle="stand_melee",
			walk="run_melee",
			glide="airwalk_melee",
			g_melee="melee_swing",

			g_throw="item1_fire",

			teleport="teleport_in"
		}
	},
	sounds={
		throw="misc/halloween/merasmus_spell.wav",
		melee=pk_pills.helpers.makeList("vo/halloween_merasmus/sf12_attacks0#.mp3",3,9),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_merasmus/sf12_defeated12.mp3",
		teleport="misc/halloween/merasmus_appear.wav",
		hide="misc/halloween/merasmus_hiding_explode.wav"
	},
	muteSteps=true,
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=50
	},
	attack2={
		mode="auto",
		delay=1,
		func=function(ply,ent)
			ent:PillSound("throw")
			ent:PillGesture("throw")

			local bomb = ents.Create("pill_proj_bomb")
			bomb:SetModel("models/props_lakeside_event/bomb_temp.mdl")
			bomb:SetPos(ply:EyePos()+ply:EyeAngles():Forward()*100)
			bomb:SetAngles(ply:EyeAngles())
			bomb.tf2=true
			bomb:Spawn()
			bomb:SetPhysicsAttacker(ply)
			bomb:SetOwner(ply)
		end
	},
	reload=function(ply,ent)
		local tracein={}
		tracein.maxs=Vector(25,25,140)
		tracein.mins=Vector(-25,-25,0)
		tracein.start=ply:EyePos()
		tracein.endpos=ply:EyePos()+ply:EyeAngles():Forward()*9999
		tracein.filter = {ply,ent,ent:GetPuppet()}

		local traceout= util.TraceHull(tracein)
		ply:SetPos(traceout.HitPos)
		ent:PillSound("teleport")
		ent:PillAnim("teleport",true)
	end,
	flashlight=function(ply,ent)
		ent:PillSound("hide")
		local h = ply:Health()
		local s = ent:GetPuppet():GetSkin()
		local p = pk_pills.apply(ply,"tf_wizard_hidden")
		p.wizard_health=h
		p.wizard_skin=s
		//models/props_lakeside_event/bomb_temp.mdl
	end,
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_wizard_hidden",{
	type="phys",
	camera={
		dist=200
	},
	options=function() return {
		{model="models/props_2fort/chimney003.mdl"},
		{model="models/props_2fort/trainwheel002.mdl"},
		{model="models/props_2fort/metalbucket001.mdl"},
		{model="models/props_2fort/fire_extinguisher.mdl"},
		{model="models/props_2fort/tire001.mdl"},
		{model="models/props_badlands/barrel01.mdl"},
		{model="models/props_farm/oilcan01.mdl"},
		{model="models/props_farm/wooden_barrel.mdl"},
		{model="models/props_gameplay/ball001.mdl"},
		{model="models/props_gameplay/orange_cone001.mdl"},
		{model="models/props_halloween/pumpkin_01.mdl"},
		{model="models/props_halloween/jackolantern_02.mdl"},
		{model="models/props_hydro/dumptruck.mdl"},
		{model="models/props_manor/chair_01.mdl"},
		{model="models/props_soho/trashbag001.mdl"},
		{model="models/props_well/computer_cart01.mdl"},
		{model="models/props_vehicles/mining_car_metal.mdl"}
	} end,
	attack={
		mode="trigger",
		func=function(ply,ent)
			local p = pk_pills.apply(ply,"tf_wizard")
			p:PillSound("hide")
			ply:SetHealth(ent.wizard_health)
			p:GetPuppet():SetSkin(ent.wizard_skin)
		end
	},
	health=100
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_spooky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_hhh",{
	printName="HHH",
	type="ply",
	model="models/bots/headless_hatman.mdl",
	side="wild",
	//modelScale=1.75,
	attachments={"models/weapons/c_models/c_bigaxe/c_bigaxe.mdl"},
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	duckBy=30,
	anims={
		default={
			idle="stand_item1",
			walk="run_item1",
			crouch="crouch_item1",
			crouch_walk="crouch_walk_item1",
			glide="airwalk_item1",
			g_melee="attackstand_item1"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boss/knight_laugh0#.mp3",4),
		//vo/halloween_boss/knight_laugh01.mp3
		melee=pk_pills.helpers.makeList("vo/halloween_boss/knight_attack0#.mp3",4),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_boss/knight_death02.mp3"
	},
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=200
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_skeleton_king",{
	parent="tf_hhh",
	printName="Skeleton King",
	model="models/bots/skeleton_sniper_boss/skeleton_sniper_boss.mdl",
	modelScale=1.75,
	attachments={"models/player/items/demo/crown.mdl"},
	default_rp_cost=8000,
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	anims={
		default={
			g_melee="melee_swing"
		}
	},
	skin=2,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_giant_0#.wav",3),
		melee="weapons/knife_swing.wav",
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		die="misc/halloween/skeleton_break.wav"
	},
	attack={
		dmg=50
	},
	noragdoll=true,
	health=1000
})

pk_pills.register("tf_skeleton",{
	parent="tf_skeleton_king",
	printName="Skeleton",
	model="models/bots/skeleton_sniper/skeleton_sniper.mdl",
	modelScale=false,
	attachments=false,
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,60),
		dist=100
	},
	hull=Vector(30,30,80),
	duckBy=20,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_medium_0#.wav",7)
	},
	attack={
		range=30,
		dmg=25
	},
	moveSpeed={
		walk=150,
		run=300
	},
	jumpPower=200,
	health=150
})

pk_pills.register("tf_skeleton_tiny",{
	parent="tf_skeleton",
	printName="Tiny Skeleton",
	modelScale=.5,
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,30),
		dist=75
	},
	hull=Vector(30,30,50),
	duckBy=10,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_small_0#.wav",9)
	},
	attack={
		dmg=10
	},
	health=75
})

pk_pills.register("tf_ghost",{
	printName="Ghost",
	type="ply",
	side="wild",
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,60),
		dist=200
	},
	hull=Vector(30,30,80),
	options=function() return {
		{model="models/props_halloween/ghost.mdl"},
		{model="models/props_halloween/ghost_no_hat.mdl"}
	} end,
	anims={
		default={
			idle="idle"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boo#.mp3",7)
	},
	muteSteps=true,
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	moveSpeed={
		walk=200,
		run=400
	},
	noFallDamage=true,
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*400+Vector(0,0,200))
		end
	end
	//health=3000
})

pk_pills.register("tf_eye",{
	printName="MONOCULUS",
	side="wild",
	type="phys",
	model="models/props_halloween/halloween_demoeye.mdl",
	sphericalPhysics=50,
	default_rp_cost=20000,
	driveType="fly",
	driveOptions={
		speed=10
	},
	camera={
		dist=300
	},
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	skin=0,
	aim={
		xPose="left_right",
		yPose="up_down"
	},
	attack={
		mode="auto",
		delay=.5,
		func=function(ply,ent)
			ent:PillSound("shoot",true)
			ent:PillAnim("firing1",true)
			ent:SetCycle(.5)

			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/props_halloween/eyeball_projectile.mdl")
			rocket:SetPos(ent:GetPos())
			rocket:SetAngles(ply:EyeAngles())
			rocket.speed=330
			rocket.dmgmod=3
			//rocket.shooter=ent
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			if ent:GetSkin()==2 then
				rocket:SetParticle("critical_rocket_red")
			elseif ent:GetSkin()==3 then
				rocket:SetParticle("critical_rocket_blue")
			else
				rocket:SetParticle("eyeboss_projectile")
			end
			rocket:Spawn()
			rocket:SetOwner(ply)
		end
	},
	attack2={
		mode= "trigger",
		func=function(ply,ent)
			ent:PillSound("laugh")
			ent:PillAnim("laugh",true)
		end
	},
	seqInit="general_noise",
	health=10000,
	sounds={
		die="vo/halloween_eyeball/eyeball_boss_pain01.mp3",
		shoot = "weapons/rocket_shoot_crit.wav",
		laugh= pk_pills.helpers.makeList("vo/halloween_eyeball/eyeball_laugh0#.mp3",3)
	}
})

pk_pills.register("tf_wizard",{
	printName="Merasmus",
	type="ply",
	model="models/bots/merasmus/merasmus.mdl",
	side="wild",
	//modelScale=1.75,
	default_rp_cost=25000,
	camera={
		offset=Vector(0,0,120),
		dist=200
	},
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	hull=Vector(50,50,140),
	aim={},
	anims={
		default={
			idle="stand_melee",
			walk="run_melee",
			glide="airwalk_melee",
			g_melee="melee_swing",

			g_throw="item1_fire",

			teleport="teleport_in"
		}
	},
	sounds={
		throw="misc/halloween/merasmus_spell.wav",
		melee=pk_pills.helpers.makeList("vo/halloween_merasmus/sf12_attacks0#.mp3",3,9),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_merasmus/sf12_defeated12.mp3",
		teleport="misc/halloween/merasmus_appear.wav",
		hide="misc/halloween/merasmus_hiding_explode.wav"
	},
	muteSteps=true,
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=50
	},
	attack2={
		mode="auto",
		delay=1,
		func=function(ply,ent)
			ent:PillSound("throw")
			ent:PillGesture("throw")

			local bomb = ents.Create("pill_proj_bomb")
			bomb:SetModel("models/props_lakeside_event/bomb_temp.mdl")
			bomb:SetPos(ply:EyePos()+ply:EyeAngles():Forward()*100)
			bomb:SetAngles(ply:EyeAngles())
			bomb.tf2=true
			bomb:Spawn()
			bomb:SetPhysicsAttacker(ply)
			bomb:SetOwner(ply)
		end
	},
	reload=function(ply,ent)
		local tracein={}
		tracein.maxs=Vector(25,25,140)
		tracein.mins=Vector(-25,-25,0)
		tracein.start=ply:EyePos()
		tracein.endpos=ply:EyePos()+ply:EyeAngles():Forward()*9999
		tracein.filter = {ply,ent,ent:GetPuppet()}

		local traceout= util.TraceHull(tracein)
		ply:SetPos(traceout.HitPos)
		ent:PillSound("teleport")
		ent:PillAnim("teleport",true)
	end,
	flashlight=function(ply,ent)
		ent:PillSound("hide")
		local h = ply:Health()
		local s = ent:GetPuppet():GetSkin()
		local p = pk_pills.apply(ply,"tf_wizard_hidden")
		p.wizard_health=h
		p.wizard_skin=s
		//models/props_lakeside_event/bomb_temp.mdl
	end,
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_wizard_hidden",{
	type="phys",
	camera={
		dist=200
	},
	options=function() return {
		{model="models/props_2fort/chimney003.mdl"},
		{model="models/props_2fort/trainwheel002.mdl"},
		{model="models/props_2fort/metalbucket001.mdl"},
		{model="models/props_2fort/fire_extinguisher.mdl"},
		{model="models/props_2fort/tire001.mdl"},
		{model="models/props_badlands/barrel01.mdl"},
		{model="models/props_farm/oilcan01.mdl"},
		{model="models/props_farm/wooden_barrel.mdl"},
		{model="models/props_gameplay/ball001.mdl"},
		{model="models/props_gameplay/orange_cone001.mdl"},
		{model="models/props_halloween/pumpkin_01.mdl"},
		{model="models/props_halloween/jackolantern_02.mdl"},
		{model="models/props_hydro/dumptruck.mdl"},
		{model="models/props_manor/chair_01.mdl"},
		{model="models/props_soho/trashbag001.mdl"},
		{model="models/props_well/computer_cart01.mdl"},
		{model="models/props_vehicles/mining_car_metal.mdl"}
	} end,
	attack={
		mode="trigger",
		func=function(ply,ent)
			local p = pk_pills.apply(ply,"tf_wizard")
			p:PillSound("hide")
			ply:SetHealth(ent.wizard_health)
			p:GetPuppet():SetSkin(ent.wizard_skin)
		end
	},
	health=100
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_spooky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_hhh",{
	printName="HHH",
	type="ply",
	model="models/bots/headless_hatman.mdl",
	side="wild",
	//modelScale=1.75,
	attachments={"models/weapons/c_models/c_bigaxe/c_bigaxe.mdl"},
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	duckBy=30,
	anims={
		default={
			idle="stand_item1",
			walk="run_item1",
			crouch="crouch_item1",
			crouch_walk="crouch_walk_item1",
			glide="airwalk_item1",
			g_melee="attackstand_item1"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boss/knight_laugh0#.mp3",4),
		//vo/halloween_boss/knight_laugh01.mp3
		melee=pk_pills.helpers.makeList("vo/halloween_boss/knight_attack0#.mp3",4),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_boss/knight_death02.mp3"
	},
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=200
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_skeleton_king",{
	parent="tf_hhh",
	printName="Skeleton King",
	model="models/bots/skeleton_sniper_boss/skeleton_sniper_boss.mdl",
	modelScale=1.75,
	attachments={"models/player/items/demo/crown.mdl"},
	default_rp_cost=8000,
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	anims={
		default={
			g_melee="melee_swing"
		}
	},
	skin=2,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_giant_0#.wav",3),
		melee="weapons/knife_swing.wav",
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		die="misc/halloween/skeleton_break.wav"
	},
	attack={
		dmg=50
	},
	noragdoll=true,
	health=1000
})

pk_pills.register("tf_skeleton",{
	parent="tf_skeleton_king",
	printName="Skeleton",
	model="models/bots/skeleton_sniper/skeleton_sniper.mdl",
	modelScale=false,
	attachments=false,
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,60),
		dist=100
	},
	hull=Vector(30,30,80),
	duckBy=20,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_medium_0#.wav",7)
	},
	attack={
		range=30,
		dmg=25
	},
	moveSpeed={
		walk=150,
		run=300
	},
	jumpPower=200,
	health=150
})

pk_pills.register("tf_skeleton_tiny",{
	parent="tf_skeleton",
	printName="Tiny Skeleton",
	modelScale=.5,
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,30),
		dist=75
	},
	hull=Vector(30,30,50),
	duckBy=10,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_small_0#.wav",9)
	},
	attack={
		dmg=10
	},
	health=75
})

pk_pills.register("tf_ghost",{
	printName="Ghost",
	type="ply",
	side="wild",
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,60),
		dist=200
	},
	hull=Vector(30,30,80),
	options=function() return {
		{model="models/props_halloween/ghost.mdl"},
		{model="models/props_halloween/ghost_no_hat.mdl"}
	} end,
	anims={
		default={
			idle="idle"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boo#.mp3",7)
	},
	muteSteps=true,
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	moveSpeed={
		walk=200,
		run=400
	},
	noFallDamage=true,
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*400+Vector(0,0,200))
		end
	end
	//health=3000
})

pk_pills.register("tf_eye",{
	printName="MONOCULUS",
	side="wild",
	type="phys",
	model="models/props_halloween/halloween_demoeye.mdl",
	sphericalPhysics=50,
	default_rp_cost=20000,
	driveType="fly",
	driveOptions={
		speed=10
	},
	camera={
		dist=300
	},
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	skin=0,
	aim={
		xPose="left_right",
		yPose="up_down"
	},
	attack={
		mode="auto",
		delay=.5,
		func=function(ply,ent)
			ent:PillSound("shoot",true)
			ent:PillAnim("firing1",true)
			ent:SetCycle(.5)

			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/props_halloween/eyeball_projectile.mdl")
			rocket:SetPos(ent:GetPos())
			rocket:SetAngles(ply:EyeAngles())
			rocket.speed=330
			rocket.dmgmod=3
			//rocket.shooter=ent
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			if ent:GetSkin()==2 then
				rocket:SetParticle("critical_rocket_red")
			elseif ent:GetSkin()==3 then
				rocket:SetParticle("critical_rocket_blue")
			else
				rocket:SetParticle("eyeboss_projectile")
			end
			rocket:Spawn()
			rocket:SetOwner(ply)
		end
	},
	attack2={
		mode= "trigger",
		func=function(ply,ent)
			ent:PillSound("laugh")
			ent:PillAnim("laugh",true)
		end
	},
	seqInit="general_noise",
	health=10000,
	sounds={
		die="vo/halloween_eyeball/eyeball_boss_pain01.mp3",
		shoot = "weapons/rocket_shoot_crit.wav",
		laugh= pk_pills.helpers.makeList("vo/halloween_eyeball/eyeball_laugh0#.mp3",3)
	}
})

pk_pills.register("tf_wizard",{
	printName="Merasmus",
	type="ply",
	model="models/bots/merasmus/merasmus.mdl",
	side="wild",
	//modelScale=1.75,
	default_rp_cost=25000,
	camera={
		offset=Vector(0,0,120),
		dist=200
	},
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	hull=Vector(50,50,140),
	aim={},
	anims={
		default={
			idle="stand_melee",
			walk="run_melee",
			glide="airwalk_melee",
			g_melee="melee_swing",

			g_throw="item1_fire",

			teleport="teleport_in"
		}
	},
	sounds={
		throw="misc/halloween/merasmus_spell.wav",
		melee=pk_pills.helpers.makeList("vo/halloween_merasmus/sf12_attacks0#.mp3",3,9),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_merasmus/sf12_defeated12.mp3",
		teleport="misc/halloween/merasmus_appear.wav",
		hide="misc/halloween/merasmus_hiding_explode.wav"
	},
	muteSteps=true,
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=50
	},
	attack2={
		mode="auto",
		delay=1,
		func=function(ply,ent)
			ent:PillSound("throw")
			ent:PillGesture("throw")

			local bomb = ents.Create("pill_proj_bomb")
			bomb:SetModel("models/props_lakeside_event/bomb_temp.mdl")
			bomb:SetPos(ply:EyePos()+ply:EyeAngles():Forward()*100)
			bomb:SetAngles(ply:EyeAngles())
			bomb.tf2=true
			bomb:Spawn()
			bomb:SetPhysicsAttacker(ply)
			bomb:SetOwner(ply)
		end
	},
	reload=function(ply,ent)
		local tracein={}
		tracein.maxs=Vector(25,25,140)
		tracein.mins=Vector(-25,-25,0)
		tracein.start=ply:EyePos()
		tracein.endpos=ply:EyePos()+ply:EyeAngles():Forward()*9999
		tracein.filter = {ply,ent,ent:GetPuppet()}

		local traceout= util.TraceHull(tracein)
		ply:SetPos(traceout.HitPos)
		ent:PillSound("teleport")
		ent:PillAnim("teleport",true)
	end,
	flashlight=function(ply,ent)
		ent:PillSound("hide")
		local h = ply:Health()
		local s = ent:GetPuppet():GetSkin()
		local p = pk_pills.apply(ply,"tf_wizard_hidden")
		p.wizard_health=h
		p.wizard_skin=s
		//models/props_lakeside_event/bomb_temp.mdl
	end,
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_wizard_hidden",{
	type="phys",
	camera={
		dist=200
	},
	options=function() return {
		{model="models/props_2fort/chimney003.mdl"},
		{model="models/props_2fort/trainwheel002.mdl"},
		{model="models/props_2fort/metalbucket001.mdl"},
		{model="models/props_2fort/fire_extinguisher.mdl"},
		{model="models/props_2fort/tire001.mdl"},
		{model="models/props_badlands/barrel01.mdl"},
		{model="models/props_farm/oilcan01.mdl"},
		{model="models/props_farm/wooden_barrel.mdl"},
		{model="models/props_gameplay/ball001.mdl"},
		{model="models/props_gameplay/orange_cone001.mdl"},
		{model="models/props_halloween/pumpkin_01.mdl"},
		{model="models/props_halloween/jackolantern_02.mdl"},
		{model="models/props_hydro/dumptruck.mdl"},
		{model="models/props_manor/chair_01.mdl"},
		{model="models/props_soho/trashbag001.mdl"},
		{model="models/props_well/computer_cart01.mdl"},
		{model="models/props_vehicles/mining_car_metal.mdl"}
	} end,
	attack={
		mode="trigger",
		func=function(ply,ent)
			local p = pk_pills.apply(ply,"tf_wizard")
			p:PillSound("hide")
			ply:SetHealth(ent.wizard_health)
			p:GetPuppet():SetSkin(ent.wizard_skin)
		end
	},
	health=100
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_spooky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_hhh",{
	printName="HHH",
	type="ply",
	model="models/bots/headless_hatman.mdl",
	side="wild",
	//modelScale=1.75,
	attachments={"models/weapons/c_models/c_bigaxe/c_bigaxe.mdl"},
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	duckBy=30,
	anims={
		default={
			idle="stand_item1",
			walk="run_item1",
			crouch="crouch_item1",
			crouch_walk="crouch_walk_item1",
			glide="airwalk_item1",
			g_melee="attackstand_item1"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boss/knight_laugh0#.mp3",4),
		//vo/halloween_boss/knight_laugh01.mp3
		melee=pk_pills.helpers.makeList("vo/halloween_boss/knight_attack0#.mp3",4),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_boss/knight_death02.mp3"
	},
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=200
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_skeleton_king",{
	parent="tf_hhh",
	printName="Skeleton King",
	model="models/bots/skeleton_sniper_boss/skeleton_sniper_boss.mdl",
	modelScale=1.75,
	attachments={"models/player/items/demo/crown.mdl"},
	default_rp_cost=8000,
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	anims={
		default={
			g_melee="melee_swing"
		}
	},
	skin=2,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_giant_0#.wav",3),
		melee="weapons/knife_swing.wav",
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		die="misc/halloween/skeleton_break.wav"
	},
	attack={
		dmg=50
	},
	noragdoll=true,
	health=1000
})

pk_pills.register("tf_skeleton",{
	parent="tf_skeleton_king",
	printName="Skeleton",
	model="models/bots/skeleton_sniper/skeleton_sniper.mdl",
	modelScale=false,
	attachments=false,
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,60),
		dist=100
	},
	hull=Vector(30,30,80),
	duckBy=20,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_medium_0#.wav",7)
	},
	attack={
		range=30,
		dmg=25
	},
	moveSpeed={
		walk=150,
		run=300
	},
	jumpPower=200,
	health=150
})

pk_pills.register("tf_skeleton_tiny",{
	parent="tf_skeleton",
	printName="Tiny Skeleton",
	modelScale=.5,
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,30),
		dist=75
	},
	hull=Vector(30,30,50),
	duckBy=10,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_small_0#.wav",9)
	},
	attack={
		dmg=10
	},
	health=75
})

pk_pills.register("tf_ghost",{
	printName="Ghost",
	type="ply",
	side="wild",
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,60),
		dist=200
	},
	hull=Vector(30,30,80),
	options=function() return {
		{model="models/props_halloween/ghost.mdl"},
		{model="models/props_halloween/ghost_no_hat.mdl"}
	} end,
	anims={
		default={
			idle="idle"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boo#.mp3",7)
	},
	muteSteps=true,
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	moveSpeed={
		walk=200,
		run=400
	},
	noFallDamage=true,
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*400+Vector(0,0,200))
		end
	end
	//health=3000
})

pk_pills.register("tf_eye",{
	printName="MONOCULUS",
	side="wild",
	type="phys",
	model="models/props_halloween/halloween_demoeye.mdl",
	sphericalPhysics=50,
	default_rp_cost=20000,
	driveType="fly",
	driveOptions={
		speed=10
	},
	camera={
		dist=300
	},
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	skin=0,
	aim={
		xPose="left_right",
		yPose="up_down"
	},
	attack={
		mode="auto",
		delay=.5,
		func=function(ply,ent)
			ent:PillSound("shoot",true)
			ent:PillAnim("firing1",true)
			ent:SetCycle(.5)

			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/props_halloween/eyeball_projectile.mdl")
			rocket:SetPos(ent:GetPos())
			rocket:SetAngles(ply:EyeAngles())
			rocket.speed=330
			rocket.dmgmod=3
			//rocket.shooter=ent
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			if ent:GetSkin()==2 then
				rocket:SetParticle("critical_rocket_red")
			elseif ent:GetSkin()==3 then
				rocket:SetParticle("critical_rocket_blue")
			else
				rocket:SetParticle("eyeboss_projectile")
			end
			rocket:Spawn()
			rocket:SetOwner(ply)
		end
	},
	attack2={
		mode= "trigger",
		func=function(ply,ent)
			ent:PillSound("laugh")
			ent:PillAnim("laugh",true)
		end
	},
	seqInit="general_noise",
	health=10000,
	sounds={
		die="vo/halloween_eyeball/eyeball_boss_pain01.mp3",
		shoot = "weapons/rocket_shoot_crit.wav",
		laugh= pk_pills.helpers.makeList("vo/halloween_eyeball/eyeball_laugh0#.mp3",3)
	}
})

pk_pills.register("tf_wizard",{
	printName="Merasmus",
	type="ply",
	model="models/bots/merasmus/merasmus.mdl",
	side="wild",
	//modelScale=1.75,
	default_rp_cost=25000,
	camera={
		offset=Vector(0,0,120),
		dist=200
	},
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	hull=Vector(50,50,140),
	aim={},
	anims={
		default={
			idle="stand_melee",
			walk="run_melee",
			glide="airwalk_melee",
			g_melee="melee_swing",

			g_throw="item1_fire",

			teleport="teleport_in"
		}
	},
	sounds={
		throw="misc/halloween/merasmus_spell.wav",
		melee=pk_pills.helpers.makeList("vo/halloween_merasmus/sf12_attacks0#.mp3",3,9),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_merasmus/sf12_defeated12.mp3",
		teleport="misc/halloween/merasmus_appear.wav",
		hide="misc/halloween/merasmus_hiding_explode.wav"
	},
	muteSteps=true,
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=50
	},
	attack2={
		mode="auto",
		delay=1,
		func=function(ply,ent)
			ent:PillSound("throw")
			ent:PillGesture("throw")

			local bomb = ents.Create("pill_proj_bomb")
			bomb:SetModel("models/props_lakeside_event/bomb_temp.mdl")
			bomb:SetPos(ply:EyePos()+ply:EyeAngles():Forward()*100)
			bomb:SetAngles(ply:EyeAngles())
			bomb.tf2=true
			bomb:Spawn()
			bomb:SetPhysicsAttacker(ply)
			bomb:SetOwner(ply)
		end
	},
	reload=function(ply,ent)
		local tracein={}
		tracein.maxs=Vector(25,25,140)
		tracein.mins=Vector(-25,-25,0)
		tracein.start=ply:EyePos()
		tracein.endpos=ply:EyePos()+ply:EyeAngles():Forward()*9999
		tracein.filter = {ply,ent,ent:GetPuppet()}

		local traceout= util.TraceHull(tracein)
		ply:SetPos(traceout.HitPos)
		ent:PillSound("teleport")
		ent:PillAnim("teleport",true)
	end,
	flashlight=function(ply,ent)
		ent:PillSound("hide")
		local h = ply:Health()
		local s = ent:GetPuppet():GetSkin()
		local p = pk_pills.apply(ply,"tf_wizard_hidden")
		p.wizard_health=h
		p.wizard_skin=s
		//models/props_lakeside_event/bomb_temp.mdl
	end,
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_wizard_hidden",{
	type="phys",
	camera={
		dist=200
	},
	options=function() return {
		{model="models/props_2fort/chimney003.mdl"},
		{model="models/props_2fort/trainwheel002.mdl"},
		{model="models/props_2fort/metalbucket001.mdl"},
		{model="models/props_2fort/fire_extinguisher.mdl"},
		{model="models/props_2fort/tire001.mdl"},
		{model="models/props_badlands/barrel01.mdl"},
		{model="models/props_farm/oilcan01.mdl"},
		{model="models/props_farm/wooden_barrel.mdl"},
		{model="models/props_gameplay/ball001.mdl"},
		{model="models/props_gameplay/orange_cone001.mdl"},
		{model="models/props_halloween/pumpkin_01.mdl"},
		{model="models/props_halloween/jackolantern_02.mdl"},
		{model="models/props_hydro/dumptruck.mdl"},
		{model="models/props_manor/chair_01.mdl"},
		{model="models/props_soho/trashbag001.mdl"},
		{model="models/props_well/computer_cart01.mdl"},
		{model="models/props_vehicles/mining_car_metal.mdl"}
	} end,
	attack={
		mode="trigger",
		func=function(ply,ent)
			local p = pk_pills.apply(ply,"tf_wizard")
			p:PillSound("hide")
			ply:SetHealth(ent.wizard_health)
			p:GetPuppet():SetSkin(ent.wizard_skin)
		end
	},
	health=100
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_spooky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_hhh",{
	printName="HHH",
	type="ply",
	model="models/bots/headless_hatman.mdl",
	side="wild",
	//modelScale=1.75,
	attachments={"models/weapons/c_models/c_bigaxe/c_bigaxe.mdl"},
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	duckBy=30,
	anims={
		default={
			idle="stand_item1",
			walk="run_item1",
			crouch="crouch_item1",
			crouch_walk="crouch_walk_item1",
			glide="airwalk_item1",
			g_melee="attackstand_item1"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boss/knight_laugh0#.mp3",4),
		//vo/halloween_boss/knight_laugh01.mp3
		melee=pk_pills.helpers.makeList("vo/halloween_boss/knight_attack0#.mp3",4),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_boss/knight_death02.mp3"
	},
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=200
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_skeleton_king",{
	parent="tf_hhh",
	printName="Skeleton King",
	model="models/bots/skeleton_sniper_boss/skeleton_sniper_boss.mdl",
	modelScale=1.75,
	attachments={"models/player/items/demo/crown.mdl"},
	default_rp_cost=8000,
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	anims={
		default={
			g_melee="melee_swing"
		}
	},
	skin=2,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_giant_0#.wav",3),
		melee="weapons/knife_swing.wav",
		melee_hit=pk_pills.helpers.makeList("npc/zombie/claw_strike#.wav",3),
		die="misc/halloween/skeleton_break.wav"
	},
	attack={
		dmg=50
	},
	noragdoll=true,
	health=1000
})

pk_pills.register("tf_skeleton",{
	parent="tf_skeleton_king",
	printName="Skeleton",
	model="models/bots/skeleton_sniper/skeleton_sniper.mdl",
	modelScale=false,
	attachments=false,
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,60),
		dist=100
	},
	hull=Vector(30,30,80),
	duckBy=20,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_medium_0#.wav",7)
	},
	attack={
		range=30,
		dmg=25
	},
	moveSpeed={
		walk=150,
		run=300
	},
	jumpPower=200,
	health=150
})

pk_pills.register("tf_skeleton_tiny",{
	parent="tf_skeleton",
	printName="Tiny Skeleton",
	modelScale=.5,
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,30),
		dist=75
	},
	hull=Vector(30,30,50),
	duckBy=10,
	sounds={
		fun=pk_pills.helpers.makeList("misc/halloween/skeletons/skelly_small_0#.wav",9)
	},
	attack={
		dmg=10
	},
	health=75
})

pk_pills.register("tf_ghost",{
	printName="Ghost",
	type="ply",
	side="wild",
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,60),
		dist=200
	},
	hull=Vector(30,30,80),
	options=function() return {
		{model="models/props_halloween/ghost.mdl"},
		{model="models/props_halloween/ghost_no_hat.mdl"}
	} end,
	anims={
		default={
			idle="idle"
		}
	},
	sounds={
		fun=pk_pills.helpers.makeList("vo/halloween_boo#.mp3",7)
	},
	muteSteps=true,
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	moveSpeed={
		walk=200,
		run=400
	},
	noFallDamage=true,
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*400+Vector(0,0,200))
		end
	end
	//health=3000
})

pk_pills.register("tf_eye",{
	printName="MONOCULUS",
	side="wild",
	type="phys",
	model="models/props_halloween/halloween_demoeye.mdl",
	sphericalPhysics=50,
	default_rp_cost=20000,
	driveType="fly",
	driveOptions={
		speed=10
	},
	camera={
		dist=300
	},
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=2},
		{skin=3},
	} end,
	skin=0,
	aim={
		xPose="left_right",
		yPose="up_down"
	},
	attack={
		mode="auto",
		delay=.5,
		func=function(ply,ent)
			ent:PillSound("shoot",true)
			ent:PillAnim("firing1",true)
			ent:SetCycle(.5)

			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/props_halloween/eyeball_projectile.mdl")
			rocket:SetPos(ent:GetPos())
			rocket:SetAngles(ply:EyeAngles())
			rocket.speed=330
			rocket.dmgmod=3
			//rocket.shooter=ent
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			if ent:GetSkin()==2 then
				rocket:SetParticle("critical_rocket_red")
			elseif ent:GetSkin()==3 then
				rocket:SetParticle("critical_rocket_blue")
			else
				rocket:SetParticle("eyeboss_projectile")
			end
			rocket:Spawn()
			rocket:SetOwner(ply)
		end
	},
	attack2={
		mode= "trigger",
		func=function(ply,ent)
			ent:PillSound("laugh")
			ent:PillAnim("laugh",true)
		end
	},
	seqInit="general_noise",
	health=10000,
	sounds={
		die="vo/halloween_eyeball/eyeball_boss_pain01.mp3",
		shoot = "weapons/rocket_shoot_crit.wav",
		laugh= pk_pills.helpers.makeList("vo/halloween_eyeball/eyeball_laugh0#.mp3",3)
	}
})

pk_pills.register("tf_wizard",{
	printName="Merasmus",
	type="ply",
	model="models/bots/merasmus/merasmus.mdl",
	side="wild",
	//modelScale=1.75,
	default_rp_cost=25000,
	camera={
		offset=Vector(0,0,120),
		dist=200
	},
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	hull=Vector(50,50,140),
	aim={},
	anims={
		default={
			idle="stand_melee",
			walk="run_melee",
			glide="airwalk_melee",
			g_melee="melee_swing",

			g_throw="item1_fire",

			teleport="teleport_in"
		}
	},
	sounds={
		throw="misc/halloween/merasmus_spell.wav",
		melee=pk_pills.helpers.makeList("vo/halloween_merasmus/sf12_attacks0#.mp3",3,9),
		melee_hit=pk_pills.helpers.makeList("weapons/demo_charge_hit_flesh#.wav",3),
		die="vo/halloween_merasmus/sf12_defeated12.mp3",
		teleport="misc/halloween/merasmus_appear.wav",
		hide="misc/halloween/merasmus_hiding_explode.wav"
	},
	muteSteps=true,
	attack={
		mode="auto",
		func = pk_pills.common.melee,
		delay=.2,
		interval=1,
		range=120,
		dmg=50
	},
	attack2={
		mode="auto",
		delay=1,
		func=function(ply,ent)
			ent:PillSound("throw")
			ent:PillGesture("throw")

			local bomb = ents.Create("pill_proj_bomb")
			bomb:SetModel("models/props_lakeside_event/bomb_temp.mdl")
			bomb:SetPos(ply:EyePos()+ply:EyeAngles():Forward()*100)
			bomb:SetAngles(ply:EyeAngles())
			bomb.tf2=true
			bomb:Spawn()
			bomb:SetPhysicsAttacker(ply)
			bomb:SetOwner(ply)
		end
	},
	reload=function(ply,ent)
		local tracein={}
		tracein.maxs=Vector(25,25,140)
		tracein.mins=Vector(-25,-25,0)
		tracein.start=ply:EyePos()
		tracein.endpos=ply:EyePos()+ply:EyeAngles():Forward()*9999
		tracein.filter = {ply,ent,ent:GetPuppet()}

		local traceout= util.TraceHull(tracein)
		ply:SetPos(traceout.HitPos)
		ent:PillSound("teleport")
		ent:PillAnim("teleport",true)
	end,
	flashlight=function(ply,ent)
		ent:PillSound("hide")
		local h = ply:Health()
		local s = ent:GetPuppet():GetSkin()
		local p = pk_pills.apply(ply,"tf_wizard_hidden")
		p.wizard_health=h
		p.wizard_skin=s
		//models/props_lakeside_event/bomb_temp.mdl
	end,
	movePoseMode="xy",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=3000
})

pk_pills.register("tf_wizard_hidden",{
	type="phys",
	camera={
		dist=200
	},
	options=function() return {
		{model="models/props_2fort/chimney003.mdl"},
		{model="models/props_2fort/trainwheel002.mdl"},
		{model="models/props_2fort/metalbucket001.mdl"},
		{model="models/props_2fort/fire_extinguisher.mdl"},
		{model="models/props_2fort/tire001.mdl"},
		{model="models/props_badlands/barrel01.mdl"},
		{model="models/props_farm/oilcan01.mdl"},
		{model="models/props_farm/wooden_barrel.mdl"},
		{model="models/props_gameplay/ball001.mdl"},
		{model="models/props_gameplay/orange_cone001.mdl"},
		{model="models/props_halloween/pumpkin_01.mdl"},
		{model="models/props_halloween/jackolantern_02.mdl"},
		{model="models/props_hydro/dumptruck.mdl"},
		{model="models/props_manor/chair_01.mdl"},
		{model="models/props_soho/trashbag001.mdl"},
		{model="models/props_well/computer_cart01.mdl"},
		{model="models/props_vehicles/mining_car_metal.mdl"}
	} end,
	attack={
		mode="trigger",
		func=function(ply,ent)
			local p = pk_pills.apply(ply,"tf_wizard")
			p:PillSound("hide")
			ply:SetHealth(ent.wizard_health)
			p:GetPuppet():SetSkin(ent.wizard_skin)
		end
	},
	health=100
})

