-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_robots.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_sentrybuster",{
	printName="Sentry Buster",
	type="ply",
	model="models/bots/demo/bot_sentry_buster.mdl",
	attachments={},
	modelScale=1.75,
	options=function() return {
		{icon="models/weapons/w_models/w_stickybomb.mdl"},
		{icon="models/weapons/c_models/c_battleaxe/c_battleaxe.mdl",attachments={"models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"}}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	anims={
		default={
			idle="Stand_ITEM1",
			walk="Run_ITEM1",
			boom="taunt04",
			jump="a_jumpStart_ITEM1",
			glide="a_jumpfloat_ITEM1"
		}
	},
	sounds={
		spin="mvm/sentrybuster/mvm_sentrybuster_spin.wav",
		boom="mvm/sentrybuster/mvm_sentrybuster_explode.wav",
		fun="mvm/sentrybuster/mvm_sentrybuster_intro.wav",
		loop_move="mvm/sentrybuster/mvm_sentrybuster_loop.wav",
		step= pk_pills.helpers.makeList("mvm/sentrybuster/mvm_sentrybuster_step_0#.wav",4)
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("boom",true)
			ent:PillSound("spin")
			timer.Simple(2, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					ParticleEffect("fireSmokeExplosion",ply:GetPos(), Angle(0,0,0))
					util.BlastDamage(ent,ply,ent:GetPos(),200,200)
				end
			end)
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	noragdoll=true,
	movePoseMode="xy-bot",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=2500,
	damageFromWater=-1
})

pk_pills.register("tf_tank",{
	printName="Tank",
	type="ply",
	model="models/bots/boss_bot/boss_tank.mdl",
	attachments={"models/bots/boss_bot/tank_track_l.mdl","models/bots/boss_bot/tank_track_r.mdl"},
	options=function() return {
		{},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl"},
		{skin=1},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl",skin=1},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",skin=1,attachments={}}
	} end,
	skin=0,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,150),
		dist=400
	},
	hull=Vector(200,200,150),
	anims={
		default={
			idle="movement",
			deploy="deploy"
		}
	},
	sounds={
		boom="mvm/mvm_tank_explode.wav",
		horn="mvm/mvm_tank_horn.wav",
		deploy="mvm/mvm_tank_deploy.wav",
		loop_move="mvm/mvm_tank_loop.wav"
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("deploy",true)
			ent:PillSound("deploy")
			timer.Simple(7.5, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					local anchor=ents.Create("prop_dynamic")
					anchor:SetPos(ent:GetPos())
					anchor:SetModel("models/props_junk/PopCan01a.mdl")
					anchor:Spawn()
					anchor:SetRenderMode(RENDERMODE_NONE)

					ParticleEffect("cinefx_goldrush",ply:GetPos()+Vector(0,0,200), Angle(-90,0,0),anchor)
					util.BlastDamage(ent,ply,ent:GetPos(),800,800)

					timer.Simple(10,function()
						if IsValid(anchor) then
							anchor:Remove()
						end
					end)
				end
			end)

			local bomb=ents.Create("pill_attachment")
			bomb:SetParent(ent:GetPuppet())
			bomb:SetModel("models/bots/boss_bot/bomb_mechanism.mdl")
			bomb:Spawn()
			bomb:ResetSequence(bomb:LookupSequence("deploy"))
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("horn")
		end
	},
	noragdoll=true,
	noFallDamage=true,
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		if cmd:KeyDown(IN_FORWARD) then
			local angs = mv:GetAngles()
			local vz = mv:GetVelocity().z
			angs.pitch=0
			mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
		end
	end,
	jumpPower=0,
	health=5000,
	damageFromWater=-1
})


local bot_steps = table.Add(
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_0#.wav",9),
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_1#.wav",0,8)
)

local noduck_anims = {}

local holdtypes= {
	"default","pistol","smg","grenade","ar2","shotgun","rpg","physgun","crossbow",
	"melee","slam","normal","fist","melee2","passive","knife","duel","camera",
	"magic","revolver"
}

for k,v in pairs(holdtypes) do
	noduck_anims[v]={
		crouch=false,
		crouch_walk=false,
	}
end

pk_pills.register("tf_bot_scout",{
	parent="tf_scout",
	printName="Scout Bot",
	model="models/bots/scout/bot_scout.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_soldier",{
	parent="tf_soldier",
	printName="Soldier Bot",
	model="models/bots/soldier/bot_soldier.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_pyro",{
	parent="tf_pyro",
	printName="Pyro Bot",
	model="models/bots/pyro/bot_pyro.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_demo",{
	parent="tf_demo",
	printName="Demoman Bot",
	model="models/bots/demo/bot_demo.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_heavy",{
	parent="tf_heavy",
	printName="Heavy Bot",
	model="models/bots/heavy/bot_heavy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_engi",{
	parent="tf_engi",
	printName="Engineer Bot",
	model="models/bots/engineer/bot_engineer.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_medic",{
	parent="tf_medic",
	printName="Medic Bot",
	model="models/bots/medic/bot_medic.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	noragdoll=true,
	muteSteps=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_sniper",{
	parent="tf_sniper",
	printName="Sniper Bot",
	model="models/bots/sniper/bot_sniper.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_spy",{
	parent="tf_spy",
	printName="Spy Bot",
	model="models/bots/spy/bot_spy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_worker_a",{
	printName="Worker Bot Alpha",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=3000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=300,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_b",{
	printName="Worker Bot Bravo",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker2.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(50,50,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_c",{
	printName="Worker Bot Charlie",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker3.mdl",
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=0,model="models/bots/bot_worker/bot_worker3_nohead.mdl"},
		{skin=1,model="models/bots/bot_worker/bot_worker3_nohead.mdl"}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,70),
		dist=150
	},
	hull=Vector(60,60,80),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_d",{
	printName="Worker Bot Delta",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker_a.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	bodyGroups={1,2},
	noragdoll=true,
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={
		default={
			idle="idle",
			jump="panic_start_a",
			glide="panic",
			fly="draw_bot_idle"
		}
	},
	sounds={
		loop_fly="weapons/rpg/rocket1.wav"
	},
	moveSpeed={
		walk=150,
		run=300
	},
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_DUCK)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,300))
			ent:PillAnimTick("fly")
			if !ent.bot_flying then
				ent:PillLoopSound("fly")
				ParticleEffectAttach("rockettrail", PATTACH_POINT_FOLLOW,ent,ent:LookupAttachment("top"))
				ent.bot_flying=true
			end
		elseif ent.bot_flying then
			ent:PillLoopStop("fly")
			ent:StopParticles( )
			ent.bot_flying=false
		end
	end,
	health=200,
	muteSteps=true
})

local function idiotfix(a)
	local t = table.Copy(a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	return t
end

pk_pills.register("tf_bot_scout_giant",{
	parent="tf_bot_scout",
	printName="Giant Scout Bot",
	modelScale=1.75,
	health=1600,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=500,
	moveSpeed={
		walk=400,
		run=800
	},
	sounds={
		loop_move="mvm/giant_scout/giant_scout_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_scout/giant_scout_step_0#.wav",4))
	},
	model="models/bots/scout_boss/bot_scout_boss.mdl"
})

pk_pills.register("tf_bot_soldier_giant",{
	parent="tf_bot_soldier",
	printName="Giant Soldier Bot",
	modelScale=1.75,
	health=3800,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=120
	},
	sounds={
		loop_move="mvm/giant_soldier/giant_soldier_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_soldier/giant_soldier_step0#.wav",4))
	},
	model="models/bots/soldier_boss/bot_soldier_boss.mdl"
})

pk_pills.register("tf_bot_pyro_giant",{
	parent="tf_bot_pyro",
	printName="Giant Pyro Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=75,
		run=150
	},
	sounds={
		loop_move="mvm/giant_pyro/giant_pyro_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_pyro/giant_pyro_step_0#.wav",4))
	},
	model="models/bots/pyro_boss/bot_pyro_boss.mdl"
})

pk_pills.register("tf_bot_demo_giant",{
	parent="tf_bot_demo",
	printName="Giant Demo Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=70,
		run=140
	},
	sounds={
		loop_move="mvm/giant_demoman/giant_demoman_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_demoman/giant_demoman_step_0#.wav",4))
	},
	model="models/bots/demo_boss/bot_demo_boss.mdl"
})

pk_pills.register("tf_bot_heavy_giant",{
	parent="tf_bot_heavy",
	printName="Giant Heavy Bot",
	modelScale=1.75,
	health=5000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=115
	},
	sounds={
		loop_move="mvm/giant_heavy/giant_heavy_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_heavy/giant_heavy_step0#.wav",4))
	},
	model="models/bots/heavy_boss/bot_heavy_boss.mdl"
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_robots.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_sentrybuster",{
	printName="Sentry Buster",
	type="ply",
	model="models/bots/demo/bot_sentry_buster.mdl",
	attachments={},
	modelScale=1.75,
	options=function() return {
		{icon="models/weapons/w_models/w_stickybomb.mdl"},
		{icon="models/weapons/c_models/c_battleaxe/c_battleaxe.mdl",attachments={"models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"}}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	anims={
		default={
			idle="Stand_ITEM1",
			walk="Run_ITEM1",
			boom="taunt04",
			jump="a_jumpStart_ITEM1",
			glide="a_jumpfloat_ITEM1"
		}
	},
	sounds={
		spin="mvm/sentrybuster/mvm_sentrybuster_spin.wav",
		boom="mvm/sentrybuster/mvm_sentrybuster_explode.wav",
		fun="mvm/sentrybuster/mvm_sentrybuster_intro.wav",
		loop_move="mvm/sentrybuster/mvm_sentrybuster_loop.wav",
		step= pk_pills.helpers.makeList("mvm/sentrybuster/mvm_sentrybuster_step_0#.wav",4)
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("boom",true)
			ent:PillSound("spin")
			timer.Simple(2, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					ParticleEffect("fireSmokeExplosion",ply:GetPos(), Angle(0,0,0))
					util.BlastDamage(ent,ply,ent:GetPos(),200,200)
				end
			end)
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	noragdoll=true,
	movePoseMode="xy-bot",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=2500,
	damageFromWater=-1
})

pk_pills.register("tf_tank",{
	printName="Tank",
	type="ply",
	model="models/bots/boss_bot/boss_tank.mdl",
	attachments={"models/bots/boss_bot/tank_track_l.mdl","models/bots/boss_bot/tank_track_r.mdl"},
	options=function() return {
		{},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl"},
		{skin=1},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl",skin=1},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",skin=1,attachments={}}
	} end,
	skin=0,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,150),
		dist=400
	},
	hull=Vector(200,200,150),
	anims={
		default={
			idle="movement",
			deploy="deploy"
		}
	},
	sounds={
		boom="mvm/mvm_tank_explode.wav",
		horn="mvm/mvm_tank_horn.wav",
		deploy="mvm/mvm_tank_deploy.wav",
		loop_move="mvm/mvm_tank_loop.wav"
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("deploy",true)
			ent:PillSound("deploy")
			timer.Simple(7.5, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					local anchor=ents.Create("prop_dynamic")
					anchor:SetPos(ent:GetPos())
					anchor:SetModel("models/props_junk/PopCan01a.mdl")
					anchor:Spawn()
					anchor:SetRenderMode(RENDERMODE_NONE)

					ParticleEffect("cinefx_goldrush",ply:GetPos()+Vector(0,0,200), Angle(-90,0,0),anchor)
					util.BlastDamage(ent,ply,ent:GetPos(),800,800)

					timer.Simple(10,function()
						if IsValid(anchor) then
							anchor:Remove()
						end
					end)
				end
			end)

			local bomb=ents.Create("pill_attachment")
			bomb:SetParent(ent:GetPuppet())
			bomb:SetModel("models/bots/boss_bot/bomb_mechanism.mdl")
			bomb:Spawn()
			bomb:ResetSequence(bomb:LookupSequence("deploy"))
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("horn")
		end
	},
	noragdoll=true,
	noFallDamage=true,
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		if cmd:KeyDown(IN_FORWARD) then
			local angs = mv:GetAngles()
			local vz = mv:GetVelocity().z
			angs.pitch=0
			mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
		end
	end,
	jumpPower=0,
	health=5000,
	damageFromWater=-1
})


local bot_steps = table.Add(
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_0#.wav",9),
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_1#.wav",0,8)
)

local noduck_anims = {}

local holdtypes= {
	"default","pistol","smg","grenade","ar2","shotgun","rpg","physgun","crossbow",
	"melee","slam","normal","fist","melee2","passive","knife","duel","camera",
	"magic","revolver"
}

for k,v in pairs(holdtypes) do
	noduck_anims[v]={
		crouch=false,
		crouch_walk=false,
	}
end

pk_pills.register("tf_bot_scout",{
	parent="tf_scout",
	printName="Scout Bot",
	model="models/bots/scout/bot_scout.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_soldier",{
	parent="tf_soldier",
	printName="Soldier Bot",
	model="models/bots/soldier/bot_soldier.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_pyro",{
	parent="tf_pyro",
	printName="Pyro Bot",
	model="models/bots/pyro/bot_pyro.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_demo",{
	parent="tf_demo",
	printName="Demoman Bot",
	model="models/bots/demo/bot_demo.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_heavy",{
	parent="tf_heavy",
	printName="Heavy Bot",
	model="models/bots/heavy/bot_heavy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_engi",{
	parent="tf_engi",
	printName="Engineer Bot",
	model="models/bots/engineer/bot_engineer.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_medic",{
	parent="tf_medic",
	printName="Medic Bot",
	model="models/bots/medic/bot_medic.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	noragdoll=true,
	muteSteps=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_sniper",{
	parent="tf_sniper",
	printName="Sniper Bot",
	model="models/bots/sniper/bot_sniper.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_spy",{
	parent="tf_spy",
	printName="Spy Bot",
	model="models/bots/spy/bot_spy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_worker_a",{
	printName="Worker Bot Alpha",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=3000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=300,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_b",{
	printName="Worker Bot Bravo",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker2.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(50,50,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_c",{
	printName="Worker Bot Charlie",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker3.mdl",
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=0,model="models/bots/bot_worker/bot_worker3_nohead.mdl"},
		{skin=1,model="models/bots/bot_worker/bot_worker3_nohead.mdl"}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,70),
		dist=150
	},
	hull=Vector(60,60,80),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_d",{
	printName="Worker Bot Delta",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker_a.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	bodyGroups={1,2},
	noragdoll=true,
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={
		default={
			idle="idle",
			jump="panic_start_a",
			glide="panic",
			fly="draw_bot_idle"
		}
	},
	sounds={
		loop_fly="weapons/rpg/rocket1.wav"
	},
	moveSpeed={
		walk=150,
		run=300
	},
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_DUCK)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,300))
			ent:PillAnimTick("fly")
			if !ent.bot_flying then
				ent:PillLoopSound("fly")
				ParticleEffectAttach("rockettrail", PATTACH_POINT_FOLLOW,ent,ent:LookupAttachment("top"))
				ent.bot_flying=true
			end
		elseif ent.bot_flying then
			ent:PillLoopStop("fly")
			ent:StopParticles( )
			ent.bot_flying=false
		end
	end,
	health=200,
	muteSteps=true
})

local function idiotfix(a)
	local t = table.Copy(a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	return t
end

pk_pills.register("tf_bot_scout_giant",{
	parent="tf_bot_scout",
	printName="Giant Scout Bot",
	modelScale=1.75,
	health=1600,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=500,
	moveSpeed={
		walk=400,
		run=800
	},
	sounds={
		loop_move="mvm/giant_scout/giant_scout_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_scout/giant_scout_step_0#.wav",4))
	},
	model="models/bots/scout_boss/bot_scout_boss.mdl"
})

pk_pills.register("tf_bot_soldier_giant",{
	parent="tf_bot_soldier",
	printName="Giant Soldier Bot",
	modelScale=1.75,
	health=3800,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=120
	},
	sounds={
		loop_move="mvm/giant_soldier/giant_soldier_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_soldier/giant_soldier_step0#.wav",4))
	},
	model="models/bots/soldier_boss/bot_soldier_boss.mdl"
})

pk_pills.register("tf_bot_pyro_giant",{
	parent="tf_bot_pyro",
	printName="Giant Pyro Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=75,
		run=150
	},
	sounds={
		loop_move="mvm/giant_pyro/giant_pyro_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_pyro/giant_pyro_step_0#.wav",4))
	},
	model="models/bots/pyro_boss/bot_pyro_boss.mdl"
})

pk_pills.register("tf_bot_demo_giant",{
	parent="tf_bot_demo",
	printName="Giant Demo Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=70,
		run=140
	},
	sounds={
		loop_move="mvm/giant_demoman/giant_demoman_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_demoman/giant_demoman_step_0#.wav",4))
	},
	model="models/bots/demo_boss/bot_demo_boss.mdl"
})

pk_pills.register("tf_bot_heavy_giant",{
	parent="tf_bot_heavy",
	printName="Giant Heavy Bot",
	modelScale=1.75,
	health=5000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=115
	},
	sounds={
		loop_move="mvm/giant_heavy/giant_heavy_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_heavy/giant_heavy_step0#.wav",4))
	},
	model="models/bots/heavy_boss/bot_heavy_boss.mdl"
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_robots.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_sentrybuster",{
	printName="Sentry Buster",
	type="ply",
	model="models/bots/demo/bot_sentry_buster.mdl",
	attachments={},
	modelScale=1.75,
	options=function() return {
		{icon="models/weapons/w_models/w_stickybomb.mdl"},
		{icon="models/weapons/c_models/c_battleaxe/c_battleaxe.mdl",attachments={"models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"}}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	anims={
		default={
			idle="Stand_ITEM1",
			walk="Run_ITEM1",
			boom="taunt04",
			jump="a_jumpStart_ITEM1",
			glide="a_jumpfloat_ITEM1"
		}
	},
	sounds={
		spin="mvm/sentrybuster/mvm_sentrybuster_spin.wav",
		boom="mvm/sentrybuster/mvm_sentrybuster_explode.wav",
		fun="mvm/sentrybuster/mvm_sentrybuster_intro.wav",
		loop_move="mvm/sentrybuster/mvm_sentrybuster_loop.wav",
		step= pk_pills.helpers.makeList("mvm/sentrybuster/mvm_sentrybuster_step_0#.wav",4)
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("boom",true)
			ent:PillSound("spin")
			timer.Simple(2, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					ParticleEffect("fireSmokeExplosion",ply:GetPos(), Angle(0,0,0))
					util.BlastDamage(ent,ply,ent:GetPos(),200,200)
				end
			end)
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	noragdoll=true,
	movePoseMode="xy-bot",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=2500,
	damageFromWater=-1
})

pk_pills.register("tf_tank",{
	printName="Tank",
	type="ply",
	model="models/bots/boss_bot/boss_tank.mdl",
	attachments={"models/bots/boss_bot/tank_track_l.mdl","models/bots/boss_bot/tank_track_r.mdl"},
	options=function() return {
		{},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl"},
		{skin=1},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl",skin=1},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",skin=1,attachments={}}
	} end,
	skin=0,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,150),
		dist=400
	},
	hull=Vector(200,200,150),
	anims={
		default={
			idle="movement",
			deploy="deploy"
		}
	},
	sounds={
		boom="mvm/mvm_tank_explode.wav",
		horn="mvm/mvm_tank_horn.wav",
		deploy="mvm/mvm_tank_deploy.wav",
		loop_move="mvm/mvm_tank_loop.wav"
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("deploy",true)
			ent:PillSound("deploy")
			timer.Simple(7.5, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					local anchor=ents.Create("prop_dynamic")
					anchor:SetPos(ent:GetPos())
					anchor:SetModel("models/props_junk/PopCan01a.mdl")
					anchor:Spawn()
					anchor:SetRenderMode(RENDERMODE_NONE)

					ParticleEffect("cinefx_goldrush",ply:GetPos()+Vector(0,0,200), Angle(-90,0,0),anchor)
					util.BlastDamage(ent,ply,ent:GetPos(),800,800)

					timer.Simple(10,function()
						if IsValid(anchor) then
							anchor:Remove()
						end
					end)
				end
			end)

			local bomb=ents.Create("pill_attachment")
			bomb:SetParent(ent:GetPuppet())
			bomb:SetModel("models/bots/boss_bot/bomb_mechanism.mdl")
			bomb:Spawn()
			bomb:ResetSequence(bomb:LookupSequence("deploy"))
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("horn")
		end
	},
	noragdoll=true,
	noFallDamage=true,
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		if cmd:KeyDown(IN_FORWARD) then
			local angs = mv:GetAngles()
			local vz = mv:GetVelocity().z
			angs.pitch=0
			mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
		end
	end,
	jumpPower=0,
	health=5000,
	damageFromWater=-1
})


local bot_steps = table.Add(
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_0#.wav",9),
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_1#.wav",0,8)
)

local noduck_anims = {}

local holdtypes= {
	"default","pistol","smg","grenade","ar2","shotgun","rpg","physgun","crossbow",
	"melee","slam","normal","fist","melee2","passive","knife","duel","camera",
	"magic","revolver"
}

for k,v in pairs(holdtypes) do
	noduck_anims[v]={
		crouch=false,
		crouch_walk=false,
	}
end

pk_pills.register("tf_bot_scout",{
	parent="tf_scout",
	printName="Scout Bot",
	model="models/bots/scout/bot_scout.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_soldier",{
	parent="tf_soldier",
	printName="Soldier Bot",
	model="models/bots/soldier/bot_soldier.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_pyro",{
	parent="tf_pyro",
	printName="Pyro Bot",
	model="models/bots/pyro/bot_pyro.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_demo",{
	parent="tf_demo",
	printName="Demoman Bot",
	model="models/bots/demo/bot_demo.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_heavy",{
	parent="tf_heavy",
	printName="Heavy Bot",
	model="models/bots/heavy/bot_heavy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_engi",{
	parent="tf_engi",
	printName="Engineer Bot",
	model="models/bots/engineer/bot_engineer.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_medic",{
	parent="tf_medic",
	printName="Medic Bot",
	model="models/bots/medic/bot_medic.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	noragdoll=true,
	muteSteps=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_sniper",{
	parent="tf_sniper",
	printName="Sniper Bot",
	model="models/bots/sniper/bot_sniper.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_spy",{
	parent="tf_spy",
	printName="Spy Bot",
	model="models/bots/spy/bot_spy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_worker_a",{
	printName="Worker Bot Alpha",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=3000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=300,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_b",{
	printName="Worker Bot Bravo",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker2.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(50,50,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_c",{
	printName="Worker Bot Charlie",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker3.mdl",
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=0,model="models/bots/bot_worker/bot_worker3_nohead.mdl"},
		{skin=1,model="models/bots/bot_worker/bot_worker3_nohead.mdl"}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,70),
		dist=150
	},
	hull=Vector(60,60,80),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_d",{
	printName="Worker Bot Delta",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker_a.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	bodyGroups={1,2},
	noragdoll=true,
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={
		default={
			idle="idle",
			jump="panic_start_a",
			glide="panic",
			fly="draw_bot_idle"
		}
	},
	sounds={
		loop_fly="weapons/rpg/rocket1.wav"
	},
	moveSpeed={
		walk=150,
		run=300
	},
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_DUCK)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,300))
			ent:PillAnimTick("fly")
			if !ent.bot_flying then
				ent:PillLoopSound("fly")
				ParticleEffectAttach("rockettrail", PATTACH_POINT_FOLLOW,ent,ent:LookupAttachment("top"))
				ent.bot_flying=true
			end
		elseif ent.bot_flying then
			ent:PillLoopStop("fly")
			ent:StopParticles( )
			ent.bot_flying=false
		end
	end,
	health=200,
	muteSteps=true
})

local function idiotfix(a)
	local t = table.Copy(a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	return t
end

pk_pills.register("tf_bot_scout_giant",{
	parent="tf_bot_scout",
	printName="Giant Scout Bot",
	modelScale=1.75,
	health=1600,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=500,
	moveSpeed={
		walk=400,
		run=800
	},
	sounds={
		loop_move="mvm/giant_scout/giant_scout_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_scout/giant_scout_step_0#.wav",4))
	},
	model="models/bots/scout_boss/bot_scout_boss.mdl"
})

pk_pills.register("tf_bot_soldier_giant",{
	parent="tf_bot_soldier",
	printName="Giant Soldier Bot",
	modelScale=1.75,
	health=3800,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=120
	},
	sounds={
		loop_move="mvm/giant_soldier/giant_soldier_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_soldier/giant_soldier_step0#.wav",4))
	},
	model="models/bots/soldier_boss/bot_soldier_boss.mdl"
})

pk_pills.register("tf_bot_pyro_giant",{
	parent="tf_bot_pyro",
	printName="Giant Pyro Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=75,
		run=150
	},
	sounds={
		loop_move="mvm/giant_pyro/giant_pyro_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_pyro/giant_pyro_step_0#.wav",4))
	},
	model="models/bots/pyro_boss/bot_pyro_boss.mdl"
})

pk_pills.register("tf_bot_demo_giant",{
	parent="tf_bot_demo",
	printName="Giant Demo Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=70,
		run=140
	},
	sounds={
		loop_move="mvm/giant_demoman/giant_demoman_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_demoman/giant_demoman_step_0#.wav",4))
	},
	model="models/bots/demo_boss/bot_demo_boss.mdl"
})

pk_pills.register("tf_bot_heavy_giant",{
	parent="tf_bot_heavy",
	printName="Giant Heavy Bot",
	modelScale=1.75,
	health=5000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=115
	},
	sounds={
		loop_move="mvm/giant_heavy/giant_heavy_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_heavy/giant_heavy_step0#.wav",4))
	},
	model="models/bots/heavy_boss/bot_heavy_boss.mdl"
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_robots.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_sentrybuster",{
	printName="Sentry Buster",
	type="ply",
	model="models/bots/demo/bot_sentry_buster.mdl",
	attachments={},
	modelScale=1.75,
	options=function() return {
		{icon="models/weapons/w_models/w_stickybomb.mdl"},
		{icon="models/weapons/c_models/c_battleaxe/c_battleaxe.mdl",attachments={"models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"}}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	anims={
		default={
			idle="Stand_ITEM1",
			walk="Run_ITEM1",
			boom="taunt04",
			jump="a_jumpStart_ITEM1",
			glide="a_jumpfloat_ITEM1"
		}
	},
	sounds={
		spin="mvm/sentrybuster/mvm_sentrybuster_spin.wav",
		boom="mvm/sentrybuster/mvm_sentrybuster_explode.wav",
		fun="mvm/sentrybuster/mvm_sentrybuster_intro.wav",
		loop_move="mvm/sentrybuster/mvm_sentrybuster_loop.wav",
		step= pk_pills.helpers.makeList("mvm/sentrybuster/mvm_sentrybuster_step_0#.wav",4)
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("boom",true)
			ent:PillSound("spin")
			timer.Simple(2, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					ParticleEffect("fireSmokeExplosion",ply:GetPos(), Angle(0,0,0))
					util.BlastDamage(ent,ply,ent:GetPos(),200,200)
				end
			end)
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	noragdoll=true,
	movePoseMode="xy-bot",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=2500,
	damageFromWater=-1
})

pk_pills.register("tf_tank",{
	printName="Tank",
	type="ply",
	model="models/bots/boss_bot/boss_tank.mdl",
	attachments={"models/bots/boss_bot/tank_track_l.mdl","models/bots/boss_bot/tank_track_r.mdl"},
	options=function() return {
		{},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl"},
		{skin=1},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl",skin=1},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",skin=1,attachments={}}
	} end,
	skin=0,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,150),
		dist=400
	},
	hull=Vector(200,200,150),
	anims={
		default={
			idle="movement",
			deploy="deploy"
		}
	},
	sounds={
		boom="mvm/mvm_tank_explode.wav",
		horn="mvm/mvm_tank_horn.wav",
		deploy="mvm/mvm_tank_deploy.wav",
		loop_move="mvm/mvm_tank_loop.wav"
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("deploy",true)
			ent:PillSound("deploy")
			timer.Simple(7.5, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					local anchor=ents.Create("prop_dynamic")
					anchor:SetPos(ent:GetPos())
					anchor:SetModel("models/props_junk/PopCan01a.mdl")
					anchor:Spawn()
					anchor:SetRenderMode(RENDERMODE_NONE)

					ParticleEffect("cinefx_goldrush",ply:GetPos()+Vector(0,0,200), Angle(-90,0,0),anchor)
					util.BlastDamage(ent,ply,ent:GetPos(),800,800)

					timer.Simple(10,function()
						if IsValid(anchor) then
							anchor:Remove()
						end
					end)
				end
			end)

			local bomb=ents.Create("pill_attachment")
			bomb:SetParent(ent:GetPuppet())
			bomb:SetModel("models/bots/boss_bot/bomb_mechanism.mdl")
			bomb:Spawn()
			bomb:ResetSequence(bomb:LookupSequence("deploy"))
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("horn")
		end
	},
	noragdoll=true,
	noFallDamage=true,
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		if cmd:KeyDown(IN_FORWARD) then
			local angs = mv:GetAngles()
			local vz = mv:GetVelocity().z
			angs.pitch=0
			mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
		end
	end,
	jumpPower=0,
	health=5000,
	damageFromWater=-1
})


local bot_steps = table.Add(
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_0#.wav",9),
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_1#.wav",0,8)
)

local noduck_anims = {}

local holdtypes= {
	"default","pistol","smg","grenade","ar2","shotgun","rpg","physgun","crossbow",
	"melee","slam","normal","fist","melee2","passive","knife","duel","camera",
	"magic","revolver"
}

for k,v in pairs(holdtypes) do
	noduck_anims[v]={
		crouch=false,
		crouch_walk=false,
	}
end

pk_pills.register("tf_bot_scout",{
	parent="tf_scout",
	printName="Scout Bot",
	model="models/bots/scout/bot_scout.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_soldier",{
	parent="tf_soldier",
	printName="Soldier Bot",
	model="models/bots/soldier/bot_soldier.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_pyro",{
	parent="tf_pyro",
	printName="Pyro Bot",
	model="models/bots/pyro/bot_pyro.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_demo",{
	parent="tf_demo",
	printName="Demoman Bot",
	model="models/bots/demo/bot_demo.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_heavy",{
	parent="tf_heavy",
	printName="Heavy Bot",
	model="models/bots/heavy/bot_heavy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_engi",{
	parent="tf_engi",
	printName="Engineer Bot",
	model="models/bots/engineer/bot_engineer.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_medic",{
	parent="tf_medic",
	printName="Medic Bot",
	model="models/bots/medic/bot_medic.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	noragdoll=true,
	muteSteps=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_sniper",{
	parent="tf_sniper",
	printName="Sniper Bot",
	model="models/bots/sniper/bot_sniper.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_spy",{
	parent="tf_spy",
	printName="Spy Bot",
	model="models/bots/spy/bot_spy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_worker_a",{
	printName="Worker Bot Alpha",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=3000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=300,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_b",{
	printName="Worker Bot Bravo",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker2.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(50,50,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_c",{
	printName="Worker Bot Charlie",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker3.mdl",
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=0,model="models/bots/bot_worker/bot_worker3_nohead.mdl"},
		{skin=1,model="models/bots/bot_worker/bot_worker3_nohead.mdl"}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,70),
		dist=150
	},
	hull=Vector(60,60,80),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_d",{
	printName="Worker Bot Delta",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker_a.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	bodyGroups={1,2},
	noragdoll=true,
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={
		default={
			idle="idle",
			jump="panic_start_a",
			glide="panic",
			fly="draw_bot_idle"
		}
	},
	sounds={
		loop_fly="weapons/rpg/rocket1.wav"
	},
	moveSpeed={
		walk=150,
		run=300
	},
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_DUCK)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,300))
			ent:PillAnimTick("fly")
			if !ent.bot_flying then
				ent:PillLoopSound("fly")
				ParticleEffectAttach("rockettrail", PATTACH_POINT_FOLLOW,ent,ent:LookupAttachment("top"))
				ent.bot_flying=true
			end
		elseif ent.bot_flying then
			ent:PillLoopStop("fly")
			ent:StopParticles( )
			ent.bot_flying=false
		end
	end,
	health=200,
	muteSteps=true
})

local function idiotfix(a)
	local t = table.Copy(a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	return t
end

pk_pills.register("tf_bot_scout_giant",{
	parent="tf_bot_scout",
	printName="Giant Scout Bot",
	modelScale=1.75,
	health=1600,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=500,
	moveSpeed={
		walk=400,
		run=800
	},
	sounds={
		loop_move="mvm/giant_scout/giant_scout_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_scout/giant_scout_step_0#.wav",4))
	},
	model="models/bots/scout_boss/bot_scout_boss.mdl"
})

pk_pills.register("tf_bot_soldier_giant",{
	parent="tf_bot_soldier",
	printName="Giant Soldier Bot",
	modelScale=1.75,
	health=3800,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=120
	},
	sounds={
		loop_move="mvm/giant_soldier/giant_soldier_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_soldier/giant_soldier_step0#.wav",4))
	},
	model="models/bots/soldier_boss/bot_soldier_boss.mdl"
})

pk_pills.register("tf_bot_pyro_giant",{
	parent="tf_bot_pyro",
	printName="Giant Pyro Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=75,
		run=150
	},
	sounds={
		loop_move="mvm/giant_pyro/giant_pyro_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_pyro/giant_pyro_step_0#.wav",4))
	},
	model="models/bots/pyro_boss/bot_pyro_boss.mdl"
})

pk_pills.register("tf_bot_demo_giant",{
	parent="tf_bot_demo",
	printName="Giant Demo Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=70,
		run=140
	},
	sounds={
		loop_move="mvm/giant_demoman/giant_demoman_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_demoman/giant_demoman_step_0#.wav",4))
	},
	model="models/bots/demo_boss/bot_demo_boss.mdl"
})

pk_pills.register("tf_bot_heavy_giant",{
	parent="tf_bot_heavy",
	printName="Giant Heavy Bot",
	modelScale=1.75,
	health=5000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=115
	},
	sounds={
		loop_move="mvm/giant_heavy/giant_heavy_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_heavy/giant_heavy_step0#.wav",4))
	},
	model="models/bots/heavy_boss/bot_heavy_boss.mdl"
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_robots.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

pk_pills.register("tf_sentrybuster",{
	printName="Sentry Buster",
	type="ply",
	model="models/bots/demo/bot_sentry_buster.mdl",
	attachments={},
	modelScale=1.75,
	options=function() return {
		{icon="models/weapons/w_models/w_stickybomb.mdl"},
		{icon="models/weapons/c_models/c_battleaxe/c_battleaxe.mdl",attachments={"models/workshop/player/items/demo/tw_sentrybuster/tw_sentrybuster.mdl"}}
	} end,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	anims={
		default={
			idle="Stand_ITEM1",
			walk="Run_ITEM1",
			boom="taunt04",
			jump="a_jumpStart_ITEM1",
			glide="a_jumpfloat_ITEM1"
		}
	},
	sounds={
		spin="mvm/sentrybuster/mvm_sentrybuster_spin.wav",
		boom="mvm/sentrybuster/mvm_sentrybuster_explode.wav",
		fun="mvm/sentrybuster/mvm_sentrybuster_intro.wav",
		loop_move="mvm/sentrybuster/mvm_sentrybuster_loop.wav",
		step= pk_pills.helpers.makeList("mvm/sentrybuster/mvm_sentrybuster_step_0#.wav",4)
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("boom",true)
			ent:PillSound("spin")
			timer.Simple(2, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					ParticleEffect("fireSmokeExplosion",ply:GetPos(), Angle(0,0,0))
					util.BlastDamage(ent,ply,ent:GetPos(),200,200)
				end
			end)
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("fun")
		end
	},
	noragdoll=true,
	movePoseMode="xy-bot",
	moveSpeed={
		walk=300,
		run=561
	},
	jumpPower=300,
	health=2500,
	damageFromWater=-1
})

pk_pills.register("tf_tank",{
	printName="Tank",
	type="ply",
	model="models/bots/boss_bot/boss_tank.mdl",
	attachments={"models/bots/boss_bot/tank_track_l.mdl","models/bots/boss_bot/tank_track_r.mdl"},
	options=function() return {
		{},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl"},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl"},
		{skin=1},
		{model="models/bots/boss_bot/boss_tank_damage1.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage2.mdl",skin=1},
		{model="models/bots/boss_bot/boss_tank_damage3.mdl",skin=1},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage1.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage2.mdl",skin=1,attachments={}},
		{model="models/bots/tw2/boss_bot/boss_tank_damage3.mdl",skin=1,attachments={}}
	} end,
	skin=0,
	default_rp_cost=10000,
	camera={
		offset=Vector(0,0,150),
		dist=400
	},
	hull=Vector(200,200,150),
	anims={
		default={
			idle="movement",
			deploy="deploy"
		}
	},
	sounds={
		boom="mvm/mvm_tank_explode.wav",
		horn="mvm/mvm_tank_horn.wav",
		deploy="mvm/mvm_tank_deploy.wav",
		loop_move="mvm/mvm_tank_loop.wav"
	},
	attack={
		mode="trigger",
		func=function(ply,ent)
			ent:PillAnim("deploy",true)
			ent:PillSound("deploy")
			timer.Simple(7.5, function()
				if IsValid(ent) then
					ply:Kill()
					ent:PillSound("boom")

					local anchor=ents.Create("prop_dynamic")
					anchor:SetPos(ent:GetPos())
					anchor:SetModel("models/props_junk/PopCan01a.mdl")
					anchor:Spawn()
					anchor:SetRenderMode(RENDERMODE_NONE)

					ParticleEffect("cinefx_goldrush",ply:GetPos()+Vector(0,0,200), Angle(-90,0,0),anchor)
					util.BlastDamage(ent,ply,ent:GetPos(),800,800)

					timer.Simple(10,function()
						if IsValid(anchor) then
							anchor:Remove()
						end
					end)
				end
			end)

			local bomb=ents.Create("pill_attachment")
			bomb:SetParent(ent:GetPuppet())
			bomb:SetModel("models/bots/boss_bot/bomb_mechanism.mdl")
			bomb:Spawn()
			bomb:ResetSequence(bomb:LookupSequence("deploy"))
		end
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:PillSound("horn")
		end
	},
	noragdoll=true,
	noFallDamage=true,
	moveSpeed={
		walk=1
	},
	moveMod=function(ply,ent,mv,cmd)
		if cmd:KeyDown(IN_FORWARD) then
			local angs = mv:GetAngles()
			local vz = mv:GetVelocity().z
			angs.pitch=0
			mv:SetVelocity(angs:Forward()*50+Vector(0,0,vz))
		end
	end,
	jumpPower=0,
	health=5000,
	damageFromWater=-1
})


local bot_steps = table.Add(
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_0#.wav",9),
	pk_pills.helpers.makeList("mvm/player/footsteps/robostep_1#.wav",0,8)
)

local noduck_anims = {}

local holdtypes= {
	"default","pistol","smg","grenade","ar2","shotgun","rpg","physgun","crossbow",
	"melee","slam","normal","fist","melee2","passive","knife","duel","camera",
	"magic","revolver"
}

for k,v in pairs(holdtypes) do
	noduck_anims[v]={
		crouch=false,
		crouch_walk=false,
	}
end

pk_pills.register("tf_bot_scout",{
	parent="tf_scout",
	printName="Scout Bot",
	model="models/bots/scout/bot_scout.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_soldier",{
	parent="tf_soldier",
	printName="Soldier Bot",
	model="models/bots/soldier/bot_soldier.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_pyro",{
	parent="tf_pyro",
	printName="Pyro Bot",
	model="models/bots/pyro/bot_pyro.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_demo",{
	parent="tf_demo",
	printName="Demoman Bot",
	model="models/bots/demo/bot_demo.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_heavy",{
	parent="tf_heavy",
	printName="Heavy Bot",
	model="models/bots/heavy/bot_heavy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_engi",{
	parent="tf_engi",
	printName="Engineer Bot",
	model="models/bots/engineer/bot_engineer.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_medic",{
	parent="tf_medic",
	printName="Medic Bot",
	model="models/bots/medic/bot_medic.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	noragdoll=true,
	muteSteps=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_sniper",{
	parent="tf_sniper",
	printName="Sniper Bot",
	model="models/bots/sniper/bot_sniper.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_spy",{
	parent="tf_spy",
	printName="Spy Bot",
	model="models/bots/spy/bot_spy.mdl",
	skin=1,
	duckBy=0,
	anims=noduck_anims,
	default_rp_cost=12000,
	movePoseMode="xy-bot",
	sounds={
		step=bot_steps
	},
	noragdoll=true,
	damageFromWater=-1
})

pk_pills.register("tf_bot_worker_a",{
	printName="Worker Bot Alpha",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=3000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=300,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_b",{
	printName="Worker Bot Bravo",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker2.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=4000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(50,50,60),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_c",{
	printName="Worker Bot Charlie",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker3.mdl",
	options=function() return {
		{skin=0},
		{skin=1},
		{skin=0,model="models/bots/bot_worker/bot_worker3_nohead.mdl"},
		{skin=1,model="models/bots/bot_worker/bot_worker3_nohead.mdl"}
	} end,
	skin=0,
	noragdoll=true,
	default_rp_cost=5000,
	camera={
		offset=Vector(0,0,70),
		dist=150
	},
	hull=Vector(60,60,80),
	anims={},
	moveSpeed={
		walk=150,
		run=300
	},
	health=500,
	muteSteps=true
})

pk_pills.register("tf_bot_worker_d",{
	printName="Worker Bot Delta",
	side="harmless",
	type="ply",
	model="models/bots/bot_worker/bot_worker_a.mdl",
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	skin=0,
	bodyGroups={1,2},
	noragdoll=true,
	default_rp_cost=8000,
	camera={
		offset=Vector(0,0,50),
		dist=120
	},
	hull=Vector(40,40,60),
	anims={
		default={
			idle="idle",
			jump="panic_start_a",
			glide="panic",
			fly="draw_bot_idle"
		}
	},
	sounds={
		loop_fly="weapons/rpg/rocket1.wav"
	},
	moveSpeed={
		walk=150,
		run=300
	},
	moveMod=function(ply,ent,mv,cmd)
		if (cmd:KeyDown(IN_DUCK)) then
			local angs = mv:GetAngles()
			mv:SetVelocity(angs:Forward()*600+Vector(0,0,300))
			ent:PillAnimTick("fly")
			if !ent.bot_flying then
				ent:PillLoopSound("fly")
				ParticleEffectAttach("rockettrail", PATTACH_POINT_FOLLOW,ent,ent:LookupAttachment("top"))
				ent.bot_flying=true
			end
		elseif ent.bot_flying then
			ent:PillLoopStop("fly")
			ent:StopParticles( )
			ent.bot_flying=false
		end
	end,
	health=200,
	muteSteps=true
})

local function idiotfix(a)
	local t = table.Copy(a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	table.Add(t,a)
	return t
end

pk_pills.register("tf_bot_scout_giant",{
	parent="tf_bot_scout",
	printName="Giant Scout Bot",
	modelScale=1.75,
	health=1600,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=500,
	moveSpeed={
		walk=400,
		run=800
	},
	sounds={
		loop_move="mvm/giant_scout/giant_scout_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_scout/giant_scout_step_0#.wav",4))
	},
	model="models/bots/scout_boss/bot_scout_boss.mdl"
})

pk_pills.register("tf_bot_soldier_giant",{
	parent="tf_bot_soldier",
	printName="Giant Soldier Bot",
	modelScale=1.75,
	health=3800,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=120
	},
	sounds={
		loop_move="mvm/giant_soldier/giant_soldier_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_soldier/giant_soldier_step0#.wav",4))
	},
	model="models/bots/soldier_boss/bot_soldier_boss.mdl"
})

pk_pills.register("tf_bot_pyro_giant",{
	parent="tf_bot_pyro",
	printName="Giant Pyro Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=75,
		run=150
	},
	sounds={
		loop_move="mvm/giant_pyro/giant_pyro_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_pyro/giant_pyro_step_0#.wav",4))
	},
	model="models/bots/pyro_boss/bot_pyro_boss.mdl"
})

pk_pills.register("tf_bot_demo_giant",{
	parent="tf_bot_demo",
	printName="Giant Demo Bot",
	modelScale=1.75,
	health=3000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=70,
		run=140
	},
	sounds={
		loop_move="mvm/giant_demoman/giant_demoman_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_demoman/giant_demoman_step_0#.wav",4))
	},
	model="models/bots/demo_boss/bot_demo_boss.mdl"
})

pk_pills.register("tf_bot_heavy_giant",{
	parent="tf_bot_heavy",
	printName="Giant Heavy Bot",
	modelScale=1.75,
	health=5000,
	default_rp_cost=30000,
	camera={
		offset=Vector(0,0,100),
		dist=200
	},
	hull=Vector(50,50,120),
	jumpPower=300,
	moveSpeed={
		walk=60,
		run=115
	},
	sounds={
		loop_move="mvm/giant_heavy/giant_heavy_loop.wav",
		step=idiotfix(pk_pills.helpers.makeList("mvm/giant_heavy/giant_heavy_step0#.wav",4))
	},
	model="models/bots/heavy_boss/bot_heavy_boss.mdl"
})

