-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_cutouts.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_scout_cutout",{
	type="ply",
	printName="Scout Cutout",
	model="models/props_training/target_scout.mdl",
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={},
	hull=Vector(30,30,80),
	moveSpeed={
		walk=200,
		run=400
	},
	noragdoll=true,
	jumpPower=250,
	moveMod=function(ply,ent,mv,cmd)
		if !ply:IsOnGround() then
			if ent.hasDoubleJump and mv:KeyPressed(IN_JUMP) then
				local vel = mv:GetVelocity()

				vel.z=ply:GetJumpPower()

				mv:SetVelocity(vel)

				ent.hasDoubleJump=false

				ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP,0)
			end
		else
			ent.hasDoubleJump=true
		end
	end,
	health=125
})

pk_pills.register("tf_soldier_cutout",{
	parent="tf_scout_cutout",
	printName="Soldier Cutout",
	model="models/props_training/target_soldier.mdl",
	moveSpeed={
		walk=120,
		run=240
	},
	health=200
})

pk_pills.register("tf_pyro_cutout",{
	parent="tf_scout_cutout",
	printName="Pyro Cutout",
	model="models/props_training/target_pyro.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=175
})

pk_pills.register("tf_demo_cutout",{
	parent="tf_scout_cutout",
	printName="Demoman Cutout",
	model="models/props_training/target_demoman.mdl",
	moveSpeed={
		walk=140,
		run=280
	},
	health=175
})

pk_pills.register("tf_heavy_cutout",{
	parent="tf_scout_cutout",
	printName="Heavy Cutout",
	model="models/props_training/target_heavy.mdl",
	moveSpeed={
		walk=100,
		run=230
	},
	health=300
})

pk_pills.register("tf_engi_cutout",{
	parent="tf_scout_cutout",
	printName="Engineer Cutout",
	model="models/props_training/target_engineer.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_medic_cutout",{
	parent="tf_scout_cutout",
	printName="Medic Cutout",
	model="models/props_training/target_medic.mdl",
	moveSpeed={
		walk=160,
		run=320
	},
	health=150
})

pk_pills.register("tf_sniper_cutout",{
	parent="tf_scout_cutout",
	printName="Sniper Cutout",
	model="models/props_training/target_sniper.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_spy_cutout",{
	parent="tf_scout_cutout",
	printName="Spy Cutout",
	model="models/props_training/target_spy.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_cutouts.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_scout_cutout",{
	type="ply",
	printName="Scout Cutout",
	model="models/props_training/target_scout.mdl",
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={},
	hull=Vector(30,30,80),
	moveSpeed={
		walk=200,
		run=400
	},
	noragdoll=true,
	jumpPower=250,
	moveMod=function(ply,ent,mv,cmd)
		if !ply:IsOnGround() then
			if ent.hasDoubleJump and mv:KeyPressed(IN_JUMP) then
				local vel = mv:GetVelocity()

				vel.z=ply:GetJumpPower()

				mv:SetVelocity(vel)

				ent.hasDoubleJump=false

				ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP,0)
			end
		else
			ent.hasDoubleJump=true
		end
	end,
	health=125
})

pk_pills.register("tf_soldier_cutout",{
	parent="tf_scout_cutout",
	printName="Soldier Cutout",
	model="models/props_training/target_soldier.mdl",
	moveSpeed={
		walk=120,
		run=240
	},
	health=200
})

pk_pills.register("tf_pyro_cutout",{
	parent="tf_scout_cutout",
	printName="Pyro Cutout",
	model="models/props_training/target_pyro.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=175
})

pk_pills.register("tf_demo_cutout",{
	parent="tf_scout_cutout",
	printName="Demoman Cutout",
	model="models/props_training/target_demoman.mdl",
	moveSpeed={
		walk=140,
		run=280
	},
	health=175
})

pk_pills.register("tf_heavy_cutout",{
	parent="tf_scout_cutout",
	printName="Heavy Cutout",
	model="models/props_training/target_heavy.mdl",
	moveSpeed={
		walk=100,
		run=230
	},
	health=300
})

pk_pills.register("tf_engi_cutout",{
	parent="tf_scout_cutout",
	printName="Engineer Cutout",
	model="models/props_training/target_engineer.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_medic_cutout",{
	parent="tf_scout_cutout",
	printName="Medic Cutout",
	model="models/props_training/target_medic.mdl",
	moveSpeed={
		walk=160,
		run=320
	},
	health=150
})

pk_pills.register("tf_sniper_cutout",{
	parent="tf_scout_cutout",
	printName="Sniper Cutout",
	model="models/props_training/target_sniper.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_spy_cutout",{
	parent="tf_scout_cutout",
	printName="Spy Cutout",
	model="models/props_training/target_spy.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_cutouts.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_scout_cutout",{
	type="ply",
	printName="Scout Cutout",
	model="models/props_training/target_scout.mdl",
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={},
	hull=Vector(30,30,80),
	moveSpeed={
		walk=200,
		run=400
	},
	noragdoll=true,
	jumpPower=250,
	moveMod=function(ply,ent,mv,cmd)
		if !ply:IsOnGround() then
			if ent.hasDoubleJump and mv:KeyPressed(IN_JUMP) then
				local vel = mv:GetVelocity()

				vel.z=ply:GetJumpPower()

				mv:SetVelocity(vel)

				ent.hasDoubleJump=false

				ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP,0)
			end
		else
			ent.hasDoubleJump=true
		end
	end,
	health=125
})

pk_pills.register("tf_soldier_cutout",{
	parent="tf_scout_cutout",
	printName="Soldier Cutout",
	model="models/props_training/target_soldier.mdl",
	moveSpeed={
		walk=120,
		run=240
	},
	health=200
})

pk_pills.register("tf_pyro_cutout",{
	parent="tf_scout_cutout",
	printName="Pyro Cutout",
	model="models/props_training/target_pyro.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=175
})

pk_pills.register("tf_demo_cutout",{
	parent="tf_scout_cutout",
	printName="Demoman Cutout",
	model="models/props_training/target_demoman.mdl",
	moveSpeed={
		walk=140,
		run=280
	},
	health=175
})

pk_pills.register("tf_heavy_cutout",{
	parent="tf_scout_cutout",
	printName="Heavy Cutout",
	model="models/props_training/target_heavy.mdl",
	moveSpeed={
		walk=100,
		run=230
	},
	health=300
})

pk_pills.register("tf_engi_cutout",{
	parent="tf_scout_cutout",
	printName="Engineer Cutout",
	model="models/props_training/target_engineer.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_medic_cutout",{
	parent="tf_scout_cutout",
	printName="Medic Cutout",
	model="models/props_training/target_medic.mdl",
	moveSpeed={
		walk=160,
		run=320
	},
	health=150
})

pk_pills.register("tf_sniper_cutout",{
	parent="tf_scout_cutout",
	printName="Sniper Cutout",
	model="models/props_training/target_sniper.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_spy_cutout",{
	parent="tf_scout_cutout",
	printName="Spy Cutout",
	model="models/props_training/target_spy.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_cutouts.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_scout_cutout",{
	type="ply",
	printName="Scout Cutout",
	model="models/props_training/target_scout.mdl",
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={},
	hull=Vector(30,30,80),
	moveSpeed={
		walk=200,
		run=400
	},
	noragdoll=true,
	jumpPower=250,
	moveMod=function(ply,ent,mv,cmd)
		if !ply:IsOnGround() then
			if ent.hasDoubleJump and mv:KeyPressed(IN_JUMP) then
				local vel = mv:GetVelocity()

				vel.z=ply:GetJumpPower()

				mv:SetVelocity(vel)

				ent.hasDoubleJump=false

				ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP,0)
			end
		else
			ent.hasDoubleJump=true
		end
	end,
	health=125
})

pk_pills.register("tf_soldier_cutout",{
	parent="tf_scout_cutout",
	printName="Soldier Cutout",
	model="models/props_training/target_soldier.mdl",
	moveSpeed={
		walk=120,
		run=240
	},
	health=200
})

pk_pills.register("tf_pyro_cutout",{
	parent="tf_scout_cutout",
	printName="Pyro Cutout",
	model="models/props_training/target_pyro.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=175
})

pk_pills.register("tf_demo_cutout",{
	parent="tf_scout_cutout",
	printName="Demoman Cutout",
	model="models/props_training/target_demoman.mdl",
	moveSpeed={
		walk=140,
		run=280
	},
	health=175
})

pk_pills.register("tf_heavy_cutout",{
	parent="tf_scout_cutout",
	printName="Heavy Cutout",
	model="models/props_training/target_heavy.mdl",
	moveSpeed={
		walk=100,
		run=230
	},
	health=300
})

pk_pills.register("tf_engi_cutout",{
	parent="tf_scout_cutout",
	printName="Engineer Cutout",
	model="models/props_training/target_engineer.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_medic_cutout",{
	parent="tf_scout_cutout",
	printName="Medic Cutout",
	model="models/props_training/target_medic.mdl",
	moveSpeed={
		walk=160,
		run=320
	},
	health=150
})

pk_pills.register("tf_sniper_cutout",{
	parent="tf_scout_cutout",
	printName="Sniper Cutout",
	model="models/props_training/target_sniper.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_spy_cutout",{
	parent="tf_scout_cutout",
	printName="Spy Cutout",
	model="models/props_training/target_spy.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_cutouts.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_scout_cutout",{
	type="ply",
	printName="Scout Cutout",
	model="models/props_training/target_scout.mdl",
	default_rp_cost=6000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={},
	hull=Vector(30,30,80),
	moveSpeed={
		walk=200,
		run=400
	},
	noragdoll=true,
	jumpPower=250,
	moveMod=function(ply,ent,mv,cmd)
		if !ply:IsOnGround() then
			if ent.hasDoubleJump and mv:KeyPressed(IN_JUMP) then
				local vel = mv:GetVelocity()

				vel.z=ply:GetJumpPower()

				mv:SetVelocity(vel)

				ent.hasDoubleJump=false

				ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP,0)
			end
		else
			ent.hasDoubleJump=true
		end
	end,
	health=125
})

pk_pills.register("tf_soldier_cutout",{
	parent="tf_scout_cutout",
	printName="Soldier Cutout",
	model="models/props_training/target_soldier.mdl",
	moveSpeed={
		walk=120,
		run=240
	},
	health=200
})

pk_pills.register("tf_pyro_cutout",{
	parent="tf_scout_cutout",
	printName="Pyro Cutout",
	model="models/props_training/target_pyro.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=175
})

pk_pills.register("tf_demo_cutout",{
	parent="tf_scout_cutout",
	printName="Demoman Cutout",
	model="models/props_training/target_demoman.mdl",
	moveSpeed={
		walk=140,
		run=280
	},
	health=175
})

pk_pills.register("tf_heavy_cutout",{
	parent="tf_scout_cutout",
	printName="Heavy Cutout",
	model="models/props_training/target_heavy.mdl",
	moveSpeed={
		walk=100,
		run=230
	},
	health=300
})

pk_pills.register("tf_engi_cutout",{
	parent="tf_scout_cutout",
	printName="Engineer Cutout",
	model="models/props_training/target_engineer.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_medic_cutout",{
	parent="tf_scout_cutout",
	printName="Medic Cutout",
	model="models/props_training/target_medic.mdl",
	moveSpeed={
		walk=160,
		run=320
	},
	health=150
})

pk_pills.register("tf_sniper_cutout",{
	parent="tf_scout_cutout",
	printName="Sniper Cutout",
	model="models/props_training/target_sniper.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

pk_pills.register("tf_spy_cutout",{
	parent="tf_scout_cutout",
	printName="Spy Cutout",
	model="models/props_training/target_spy.mdl",
	moveSpeed={
		walk=150,
		run=300
	},
	health=125
})

