-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_fun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_conga",{
	type="ply",
	printName="CONGA CONGA CONGA",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=1000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={
		default={
			idle="taunt_conga"
		}
	},
	sounds={
		loop_move="music/conga_sketch_167bpm_01-04.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		local angs = mv:GetAngles()
		local vz = mv:GetVelocity().z
		angs.pitch=0
		mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
	end,
	health=500
})

pk_pills.register("tf_kazotsky",{
	type="ply",
	printName="COSSACK SANDVICH?",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,50),
		dist=100
	},
	anims={
		default={
			idle="taunt_russian"
		}
	},
	sounds={
		loop_move="music/cossack_sandvich.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=50
	},
	health=500
})

pk_pills.register("tf_broom",{
	type="ply",
	printName="ZOOMIN' BROOM",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,80),
		dist=100
	},
	anims={
		default={
			idle="taunt_zoomin_broom"
		}
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=600,
		//run=400
	},
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/workshop/player/items/all_class/zoomin_broom/zoomin_broom_demo.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,600))
		end
	end,
	muteSteps=true,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar",{
	type="ply",
	printName="Bumper Car",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,25),
		dist=100
	},
	anims={
		default={
			idle="kart_idle"
		}
	},
	hull=Vector(50,50,50),
	moveSpeed={
		walk=400
	},
	jump=function(ply,ent)
		ent:PillSound("jump")
	end,
	sounds={
		loop_move="weapons/bumper_car_go_loop.wav",
		jump="weapons/bumper_car_jump.wav"
	},
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/player/items/taunts/bumpercar/parts/bumpercar_nolights.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if !ply:IsOnGround() then return end
		local angs = mv:GetAngles()
		angs.pitch=0
		local vel = mv:GetVelocity()
		if (cmd:KeyDown(IN_FORWARD)) then
			vel=vel+angs:Forward()*100*(ent.formTable.modelScale or 1)
		end
		mv:SetVelocity(vel)
	end,
	muteSteps=true,
	jumpPower=400,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar_tiny",{
	printName="Micro Car",
	parent="tf_bumpercar",
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	modelScale=.5,
	jumpPower=300,
	health=50,
	hull=Vector(25,25,25),
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_fun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_conga",{
	type="ply",
	printName="CONGA CONGA CONGA",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=1000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={
		default={
			idle="taunt_conga"
		}
	},
	sounds={
		loop_move="music/conga_sketch_167bpm_01-04.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		local angs = mv:GetAngles()
		local vz = mv:GetVelocity().z
		angs.pitch=0
		mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
	end,
	health=500
})

pk_pills.register("tf_kazotsky",{
	type="ply",
	printName="COSSACK SANDVICH?",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,50),
		dist=100
	},
	anims={
		default={
			idle="taunt_russian"
		}
	},
	sounds={
		loop_move="music/cossack_sandvich.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=50
	},
	health=500
})

pk_pills.register("tf_broom",{
	type="ply",
	printName="ZOOMIN' BROOM",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,80),
		dist=100
	},
	anims={
		default={
			idle="taunt_zoomin_broom"
		}
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=600,
		//run=400
	},
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/workshop/player/items/all_class/zoomin_broom/zoomin_broom_demo.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,600))
		end
	end,
	muteSteps=true,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar",{
	type="ply",
	printName="Bumper Car",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,25),
		dist=100
	},
	anims={
		default={
			idle="kart_idle"
		}
	},
	hull=Vector(50,50,50),
	moveSpeed={
		walk=400
	},
	jump=function(ply,ent)
		ent:PillSound("jump")
	end,
	sounds={
		loop_move="weapons/bumper_car_go_loop.wav",
		jump="weapons/bumper_car_jump.wav"
	},
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/player/items/taunts/bumpercar/parts/bumpercar_nolights.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if !ply:IsOnGround() then return end
		local angs = mv:GetAngles()
		angs.pitch=0
		local vel = mv:GetVelocity()
		if (cmd:KeyDown(IN_FORWARD)) then
			vel=vel+angs:Forward()*100*(ent.formTable.modelScale or 1)
		end
		mv:SetVelocity(vel)
	end,
	muteSteps=true,
	jumpPower=400,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar_tiny",{
	printName="Micro Car",
	parent="tf_bumpercar",
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	modelScale=.5,
	jumpPower=300,
	health=50,
	hull=Vector(25,25,25),
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_fun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_conga",{
	type="ply",
	printName="CONGA CONGA CONGA",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=1000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={
		default={
			idle="taunt_conga"
		}
	},
	sounds={
		loop_move="music/conga_sketch_167bpm_01-04.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		local angs = mv:GetAngles()
		local vz = mv:GetVelocity().z
		angs.pitch=0
		mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
	end,
	health=500
})

pk_pills.register("tf_kazotsky",{
	type="ply",
	printName="COSSACK SANDVICH?",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,50),
		dist=100
	},
	anims={
		default={
			idle="taunt_russian"
		}
	},
	sounds={
		loop_move="music/cossack_sandvich.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=50
	},
	health=500
})

pk_pills.register("tf_broom",{
	type="ply",
	printName="ZOOMIN' BROOM",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,80),
		dist=100
	},
	anims={
		default={
			idle="taunt_zoomin_broom"
		}
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=600,
		//run=400
	},
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/workshop/player/items/all_class/zoomin_broom/zoomin_broom_demo.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,600))
		end
	end,
	muteSteps=true,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar",{
	type="ply",
	printName="Bumper Car",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,25),
		dist=100
	},
	anims={
		default={
			idle="kart_idle"
		}
	},
	hull=Vector(50,50,50),
	moveSpeed={
		walk=400
	},
	jump=function(ply,ent)
		ent:PillSound("jump")
	end,
	sounds={
		loop_move="weapons/bumper_car_go_loop.wav",
		jump="weapons/bumper_car_jump.wav"
	},
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/player/items/taunts/bumpercar/parts/bumpercar_nolights.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if !ply:IsOnGround() then return end
		local angs = mv:GetAngles()
		angs.pitch=0
		local vel = mv:GetVelocity()
		if (cmd:KeyDown(IN_FORWARD)) then
			vel=vel+angs:Forward()*100*(ent.formTable.modelScale or 1)
		end
		mv:SetVelocity(vel)
	end,
	muteSteps=true,
	jumpPower=400,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar_tiny",{
	printName="Micro Car",
	parent="tf_bumpercar",
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	modelScale=.5,
	jumpPower=300,
	health=50,
	hull=Vector(25,25,25),
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_fun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_conga",{
	type="ply",
	printName="CONGA CONGA CONGA",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=1000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={
		default={
			idle="taunt_conga"
		}
	},
	sounds={
		loop_move="music/conga_sketch_167bpm_01-04.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		local angs = mv:GetAngles()
		local vz = mv:GetVelocity().z
		angs.pitch=0
		mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
	end,
	health=500
})

pk_pills.register("tf_kazotsky",{
	type="ply",
	printName="COSSACK SANDVICH?",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,50),
		dist=100
	},
	anims={
		default={
			idle="taunt_russian"
		}
	},
	sounds={
		loop_move="music/cossack_sandvich.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=50
	},
	health=500
})

pk_pills.register("tf_broom",{
	type="ply",
	printName="ZOOMIN' BROOM",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,80),
		dist=100
	},
	anims={
		default={
			idle="taunt_zoomin_broom"
		}
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=600,
		//run=400
	},
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/workshop/player/items/all_class/zoomin_broom/zoomin_broom_demo.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,600))
		end
	end,
	muteSteps=true,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar",{
	type="ply",
	printName="Bumper Car",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,25),
		dist=100
	},
	anims={
		default={
			idle="kart_idle"
		}
	},
	hull=Vector(50,50,50),
	moveSpeed={
		walk=400
	},
	jump=function(ply,ent)
		ent:PillSound("jump")
	end,
	sounds={
		loop_move="weapons/bumper_car_go_loop.wav",
		jump="weapons/bumper_car_jump.wav"
	},
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/player/items/taunts/bumpercar/parts/bumpercar_nolights.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if !ply:IsOnGround() then return end
		local angs = mv:GetAngles()
		angs.pitch=0
		local vel = mv:GetVelocity()
		if (cmd:KeyDown(IN_FORWARD)) then
			vel=vel+angs:Forward()*100*(ent.formTable.modelScale or 1)
		end
		mv:SetVelocity(vel)
	end,
	muteSteps=true,
	jumpPower=400,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar_tiny",{
	printName="Micro Car",
	parent="tf_bumpercar",
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	modelScale=.5,
	jumpPower=300,
	health=50,
	hull=Vector(25,25,25),
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_fun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_conga",{
	type="ply",
	printName="CONGA CONGA CONGA",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=1000,
	camera={
		offset=Vector(0,0,70),
		dist=100
	},
	anims={
		default={
			idle="taunt_conga"
		}
	},
	sounds={
		loop_move="music/conga_sketch_167bpm_01-04.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		local angs = mv:GetAngles()
		local vz = mv:GetVelocity().z
		angs.pitch=0
		mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
	end,
	health=500
})

pk_pills.register("tf_kazotsky",{
	type="ply",
	printName="COSSACK SANDVICH?",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,50),
		dist=100
	},
	anims={
		default={
			idle="taunt_russian"
		}
	},
	sounds={
		loop_move="music/cossack_sandvich.wav"
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=50
	},
	health=500
})

pk_pills.register("tf_broom",{
	type="ply",
	printName="ZOOMIN' BROOM",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=2000,
	camera={
		offset=Vector(0,0,80),
		dist=100
	},
	anims={
		default={
			idle="taunt_zoomin_broom"
		}
	},
	autoRestartAnims=true,
	hull=Vector(30,30,80),
	moveSpeed={
		walk=600,
		//run=400
	},
	jumpPower=500,
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/workshop/player/items/all_class/zoomin_broom/zoomin_broom_demo.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if (cmd:KeyDown(IN_JUMP)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,600))
		end
	end,
	muteSteps=true,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar",{
	type="ply",
	printName="Bumper Car",
	options=function() return {
		{model="models/player/scout.mdl"},
		{model="models/player/soldier.mdl"},
		{model="models/player/pyro.mdl"},
		{model="models/player/demo.mdl"},
		{model="models/player/heavy.mdl"},
		{model="models/player/engineer.mdl"},
		{model="models/player/medic.mdl"},
		{model="models/player/sniper.mdl"},
		{model="models/player/spy.mdl"},
		{model="models/player/scout.mdl",skin=1},
		{model="models/player/soldier.mdl",skin=1},
		{model="models/player/pyro.mdl",skin=1},
		{model="models/player/demo.mdl",skin=1},
		{model="models/player/heavy.mdl",skin=1},
		{model="models/player/engineer.mdl",skin=1},
		{model="models/player/medic.mdl",skin=1},
		{model="models/player/sniper.mdl",skin=1},
		{model="models/player/spy.mdl",skin=1}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,25),
		dist=100
	},
	anims={
		default={
			idle="kart_idle"
		}
	},
	hull=Vector(50,50,50),
	moveSpeed={
		walk=400
	},
	jump=function(ply,ent)
		ent:PillSound("jump")
	end,
	sounds={
		loop_move="weapons/bumper_car_go_loop.wav",
		jump="weapons/bumper_car_jump.wav"
	},
	moveMod=function(ply,ent,mv,cmd)
		if !ent.driver_attachment then
			local a = ents.Create("pill_attachment")
			a:SetModel("models/player/items/taunts/bumpercar/parts/bumpercar_nolights.mdl")
			a:SetSkin(ent:GetPuppet():GetSkin())
			a:SetParent(ent:GetPuppet())
			a:Spawn()
			ent.driver_attachment=true
		end
		if !ply:IsOnGround() then return end
		local angs = mv:GetAngles()
		angs.pitch=0
		local vel = mv:GetVelocity()
		if (cmd:KeyDown(IN_FORWARD)) then
			vel=vel+angs:Forward()*100*(ent.formTable.modelScale or 1)
		end
		mv:SetVelocity(vel)
	end,
	muteSteps=true,
	jumpPower=400,
	noFallDamage=true,
	health=500
})

pk_pills.register("tf_bumpercar_tiny",{
	printName="Micro Car",
	parent="tf_bumpercar",
	boneMorphs = {
		["bip_head"]={scale=Vector(3,3,3)}
	},
	modelScale=.5,
	jumpPower=300,
	health=50,
	hull=Vector(25,25,25),
})

