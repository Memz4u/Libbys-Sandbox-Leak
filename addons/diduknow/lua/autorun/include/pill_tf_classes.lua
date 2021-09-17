-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_classes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_scout",{
	parent="tf_scout_cutout",
	printName="Scout",
	model="models/player/scout.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_ITEM1",
			jump="Jump_Start_loser",
			glide="Jump_Float_loser",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="Jump_Start_melee",
			glide="Jump_Float_melee",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bat","pktfw_pistol","pktfw_scattergun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	rpg - rocket launcher
*/

pk_pills.register("tf_soldier",{
	parent="tf_soldier_cutout",
	printName="Soldier",
	model="models/player/soldier.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Attack_Stand_MELEE"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		rpg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_shovel","pktfw_shotgun","pktfw_rocketlauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	crossbow- flamethrower
*/

pk_pills.register("tf_pyro",{
	parent="tf_pyro_cutout",
	printName="Pyro",
	model="models/player/pyro.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="AttackStand_Melee"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fireaxe","pktfw_shotgun","pktfw_flamethrower"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - stickies
	ar2 - grenade launcher
*/

pk_pills.register("tf_demo",{
	parent="tf_demo_cutout",
	printName="Demoman",
	model="models/player/demo.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="a_PRIMARY_reload"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="SECONDARY_reload_loop"
		},
		/*
		ar2={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_SECONDARY"
		}*/
	},
	loadout={"pill_wep_holstered","pktfw_bottle","pktfw_stickylauncher","pktfw_grenadelauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	fist - melee
	shotgun - shotguns
	slam - minigun
	physgun - minigun/deployed
*/

pk_pills.register("tf_heavy",{
	parent="tf_heavy_cutout",
	printName="Heavy",
	model="models/player/heavy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		fist={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jumpstart_MELEE",
			glide="jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="attackStand_MELEE_R"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="jumpstart_SECONDARY",
			glide="jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		slam={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jumpstart_PRIMARY",
			glide="jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		},
		physgun={
			idle="stand_deployed_PRIMARY",
			walk="PRIMARY_deployed_movement",
			crouch="crouch_deployed_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="PRIMARY_deployed_movement",
			glide="PRIMARY_deployed_movement",
			swim="PRIMARY_swim_deployed_movement"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fists","pktfw_shotgun","pktfw_minigun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_engi",{
	parent="tf_engi_cutout",
	printName="Engineer",
	model="models/player/engineer.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_wrench","pktfw_pistol","pktfw_shotgun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	ar2 - mediguns
	smg - syringe guns
*/

pk_pills.register("tf_medic",{
	parent="tf_medic_cutout",
	printName="Medic",
	model="models/player/medic.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_LOSER",
			glide="jump_float_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_MELEE",
			glide="jump_float_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_start_SECONDARY",
			glide="Jump_float_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
			//g_reload="ReloadStand_SECONDARY"
		},
		smg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jump_start_PRIMARY",
			glide="jump_float_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bonesaw","pktfw_medigun","pktfw_syringegun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	smg - smgs
	crossbow - rifles
	ar2 - rifles/zoomed
*/

pk_pills.register("tf_sniper",{
	parent="tf_sniper_cutout",
	printName="Sniper",
	model="models/player/sniper.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		smg={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_kukri","pktfw_smg","pktfw_sniper"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	knife - knives
	pistol - revolvers
*/

pk_pills.register("tf_spy",{
	parent="tf_spy_cutout",
	printName="Spy",
	model="models/player/spy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:ToggleCloak()
		end
	},
	cloak={
		max=10,
		rechargeRate=.3
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		knife={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		/*shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}*/
	},
	sounds={
		cloak="player/spy_cloak.wav",
		uncloak="player/spy_uncloak.wav"
	},
	loadout={"pill_wep_holstered","pktfw_knife","pktfw_revolver"},
	movePoseMode="xy",
	noragdoll=false
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_classes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_scout",{
	parent="tf_scout_cutout",
	printName="Scout",
	model="models/player/scout.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_ITEM1",
			jump="Jump_Start_loser",
			glide="Jump_Float_loser",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="Jump_Start_melee",
			glide="Jump_Float_melee",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bat","pktfw_pistol","pktfw_scattergun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	rpg - rocket launcher
*/

pk_pills.register("tf_soldier",{
	parent="tf_soldier_cutout",
	printName="Soldier",
	model="models/player/soldier.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Attack_Stand_MELEE"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		rpg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_shovel","pktfw_shotgun","pktfw_rocketlauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	crossbow- flamethrower
*/

pk_pills.register("tf_pyro",{
	parent="tf_pyro_cutout",
	printName="Pyro",
	model="models/player/pyro.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="AttackStand_Melee"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fireaxe","pktfw_shotgun","pktfw_flamethrower"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - stickies
	ar2 - grenade launcher
*/

pk_pills.register("tf_demo",{
	parent="tf_demo_cutout",
	printName="Demoman",
	model="models/player/demo.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="a_PRIMARY_reload"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="SECONDARY_reload_loop"
		},
		/*
		ar2={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_SECONDARY"
		}*/
	},
	loadout={"pill_wep_holstered","pktfw_bottle","pktfw_stickylauncher","pktfw_grenadelauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	fist - melee
	shotgun - shotguns
	slam - minigun
	physgun - minigun/deployed
*/

pk_pills.register("tf_heavy",{
	parent="tf_heavy_cutout",
	printName="Heavy",
	model="models/player/heavy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		fist={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jumpstart_MELEE",
			glide="jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="attackStand_MELEE_R"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="jumpstart_SECONDARY",
			glide="jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		slam={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jumpstart_PRIMARY",
			glide="jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		},
		physgun={
			idle="stand_deployed_PRIMARY",
			walk="PRIMARY_deployed_movement",
			crouch="crouch_deployed_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="PRIMARY_deployed_movement",
			glide="PRIMARY_deployed_movement",
			swim="PRIMARY_swim_deployed_movement"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fists","pktfw_shotgun","pktfw_minigun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_engi",{
	parent="tf_engi_cutout",
	printName="Engineer",
	model="models/player/engineer.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_wrench","pktfw_pistol","pktfw_shotgun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	ar2 - mediguns
	smg - syringe guns
*/

pk_pills.register("tf_medic",{
	parent="tf_medic_cutout",
	printName="Medic",
	model="models/player/medic.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_LOSER",
			glide="jump_float_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_MELEE",
			glide="jump_float_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_start_SECONDARY",
			glide="Jump_float_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
			//g_reload="ReloadStand_SECONDARY"
		},
		smg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jump_start_PRIMARY",
			glide="jump_float_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bonesaw","pktfw_medigun","pktfw_syringegun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	smg - smgs
	crossbow - rifles
	ar2 - rifles/zoomed
*/

pk_pills.register("tf_sniper",{
	parent="tf_sniper_cutout",
	printName="Sniper",
	model="models/player/sniper.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		smg={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_kukri","pktfw_smg","pktfw_sniper"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	knife - knives
	pistol - revolvers
*/

pk_pills.register("tf_spy",{
	parent="tf_spy_cutout",
	printName="Spy",
	model="models/player/spy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:ToggleCloak()
		end
	},
	cloak={
		max=10,
		rechargeRate=.3
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		knife={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		/*shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}*/
	},
	sounds={
		cloak="player/spy_cloak.wav",
		uncloak="player/spy_uncloak.wav"
	},
	loadout={"pill_wep_holstered","pktfw_knife","pktfw_revolver"},
	movePoseMode="xy",
	noragdoll=false
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_classes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_scout",{
	parent="tf_scout_cutout",
	printName="Scout",
	model="models/player/scout.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_ITEM1",
			jump="Jump_Start_loser",
			glide="Jump_Float_loser",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="Jump_Start_melee",
			glide="Jump_Float_melee",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bat","pktfw_pistol","pktfw_scattergun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	rpg - rocket launcher
*/

pk_pills.register("tf_soldier",{
	parent="tf_soldier_cutout",
	printName="Soldier",
	model="models/player/soldier.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Attack_Stand_MELEE"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		rpg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_shovel","pktfw_shotgun","pktfw_rocketlauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	crossbow- flamethrower
*/

pk_pills.register("tf_pyro",{
	parent="tf_pyro_cutout",
	printName="Pyro",
	model="models/player/pyro.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="AttackStand_Melee"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fireaxe","pktfw_shotgun","pktfw_flamethrower"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - stickies
	ar2 - grenade launcher
*/

pk_pills.register("tf_demo",{
	parent="tf_demo_cutout",
	printName="Demoman",
	model="models/player/demo.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="a_PRIMARY_reload"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="SECONDARY_reload_loop"
		},
		/*
		ar2={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_SECONDARY"
		}*/
	},
	loadout={"pill_wep_holstered","pktfw_bottle","pktfw_stickylauncher","pktfw_grenadelauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	fist - melee
	shotgun - shotguns
	slam - minigun
	physgun - minigun/deployed
*/

pk_pills.register("tf_heavy",{
	parent="tf_heavy_cutout",
	printName="Heavy",
	model="models/player/heavy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		fist={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jumpstart_MELEE",
			glide="jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="attackStand_MELEE_R"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="jumpstart_SECONDARY",
			glide="jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		slam={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jumpstart_PRIMARY",
			glide="jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		},
		physgun={
			idle="stand_deployed_PRIMARY",
			walk="PRIMARY_deployed_movement",
			crouch="crouch_deployed_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="PRIMARY_deployed_movement",
			glide="PRIMARY_deployed_movement",
			swim="PRIMARY_swim_deployed_movement"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fists","pktfw_shotgun","pktfw_minigun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_engi",{
	parent="tf_engi_cutout",
	printName="Engineer",
	model="models/player/engineer.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_wrench","pktfw_pistol","pktfw_shotgun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	ar2 - mediguns
	smg - syringe guns
*/

pk_pills.register("tf_medic",{
	parent="tf_medic_cutout",
	printName="Medic",
	model="models/player/medic.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_LOSER",
			glide="jump_float_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_MELEE",
			glide="jump_float_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_start_SECONDARY",
			glide="Jump_float_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
			//g_reload="ReloadStand_SECONDARY"
		},
		smg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jump_start_PRIMARY",
			glide="jump_float_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bonesaw","pktfw_medigun","pktfw_syringegun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	smg - smgs
	crossbow - rifles
	ar2 - rifles/zoomed
*/

pk_pills.register("tf_sniper",{
	parent="tf_sniper_cutout",
	printName="Sniper",
	model="models/player/sniper.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		smg={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_kukri","pktfw_smg","pktfw_sniper"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	knife - knives
	pistol - revolvers
*/

pk_pills.register("tf_spy",{
	parent="tf_spy_cutout",
	printName="Spy",
	model="models/player/spy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:ToggleCloak()
		end
	},
	cloak={
		max=10,
		rechargeRate=.3
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		knife={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		/*shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}*/
	},
	sounds={
		cloak="player/spy_cloak.wav",
		uncloak="player/spy_uncloak.wav"
	},
	loadout={"pill_wep_holstered","pktfw_knife","pktfw_revolver"},
	movePoseMode="xy",
	noragdoll=false
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_classes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_scout",{
	parent="tf_scout_cutout",
	printName="Scout",
	model="models/player/scout.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_ITEM1",
			jump="Jump_Start_loser",
			glide="Jump_Float_loser",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="Jump_Start_melee",
			glide="Jump_Float_melee",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bat","pktfw_pistol","pktfw_scattergun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	rpg - rocket launcher
*/

pk_pills.register("tf_soldier",{
	parent="tf_soldier_cutout",
	printName="Soldier",
	model="models/player/soldier.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Attack_Stand_MELEE"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		rpg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_shovel","pktfw_shotgun","pktfw_rocketlauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	crossbow- flamethrower
*/

pk_pills.register("tf_pyro",{
	parent="tf_pyro_cutout",
	printName="Pyro",
	model="models/player/pyro.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="AttackStand_Melee"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fireaxe","pktfw_shotgun","pktfw_flamethrower"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - stickies
	ar2 - grenade launcher
*/

pk_pills.register("tf_demo",{
	parent="tf_demo_cutout",
	printName="Demoman",
	model="models/player/demo.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="a_PRIMARY_reload"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="SECONDARY_reload_loop"
		},
		/*
		ar2={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_SECONDARY"
		}*/
	},
	loadout={"pill_wep_holstered","pktfw_bottle","pktfw_stickylauncher","pktfw_grenadelauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	fist - melee
	shotgun - shotguns
	slam - minigun
	physgun - minigun/deployed
*/

pk_pills.register("tf_heavy",{
	parent="tf_heavy_cutout",
	printName="Heavy",
	model="models/player/heavy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		fist={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jumpstart_MELEE",
			glide="jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="attackStand_MELEE_R"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="jumpstart_SECONDARY",
			glide="jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		slam={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jumpstart_PRIMARY",
			glide="jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		},
		physgun={
			idle="stand_deployed_PRIMARY",
			walk="PRIMARY_deployed_movement",
			crouch="crouch_deployed_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="PRIMARY_deployed_movement",
			glide="PRIMARY_deployed_movement",
			swim="PRIMARY_swim_deployed_movement"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fists","pktfw_shotgun","pktfw_minigun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_engi",{
	parent="tf_engi_cutout",
	printName="Engineer",
	model="models/player/engineer.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_wrench","pktfw_pistol","pktfw_shotgun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	ar2 - mediguns
	smg - syringe guns
*/

pk_pills.register("tf_medic",{
	parent="tf_medic_cutout",
	printName="Medic",
	model="models/player/medic.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_LOSER",
			glide="jump_float_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_MELEE",
			glide="jump_float_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_start_SECONDARY",
			glide="Jump_float_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
			//g_reload="ReloadStand_SECONDARY"
		},
		smg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jump_start_PRIMARY",
			glide="jump_float_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bonesaw","pktfw_medigun","pktfw_syringegun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	smg - smgs
	crossbow - rifles
	ar2 - rifles/zoomed
*/

pk_pills.register("tf_sniper",{
	parent="tf_sniper_cutout",
	printName="Sniper",
	model="models/player/sniper.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		smg={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_kukri","pktfw_smg","pktfw_sniper"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	knife - knives
	pistol - revolvers
*/

pk_pills.register("tf_spy",{
	parent="tf_spy_cutout",
	printName="Spy",
	model="models/player/spy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:ToggleCloak()
		end
	},
	cloak={
		max=10,
		rechargeRate=.3
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		knife={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		/*shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}*/
	},
	sounds={
		cloak="player/spy_cloak.wav",
		uncloak="player/spy_uncloak.wav"
	},
	loadout={"pill_wep_holstered","pktfw_knife","pktfw_revolver"},
	movePoseMode="xy",
	noragdoll=false
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_classes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_scout",{
	parent="tf_scout_cutout",
	printName="Scout",
	model="models/player/scout.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_ITEM1",
			jump="Jump_Start_loser",
			glide="Jump_Float_loser",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="Jump_Start_melee",
			glide="Jump_Float_melee",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bat","pktfw_pistol","pktfw_scattergun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	rpg - rocket launcher
*/

pk_pills.register("tf_soldier",{
	parent="tf_soldier_cutout",
	printName="Soldier",
	model="models/player/soldier.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Attack_Stand_MELEE"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_Start_secondary",
			glide="Jump_Float_secondary",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		rpg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_shovel","pktfw_shotgun","pktfw_rocketlauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	shotgun - shotguns
	crossbow- flamethrower
*/

pk_pills.register("tf_pyro",{
	parent="tf_pyro_cutout",
	printName="Pyro",
	model="models/player/pyro.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="AttackStand_Melee"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fireaxe","pktfw_shotgun","pktfw_flamethrower"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - stickies
	ar2 - grenade launcher
*/

pk_pills.register("tf_demo",{
	parent="tf_demo_cutout",
	printName="Demoman",
	model="models/player/demo.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="a_PRIMARY_reload"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="SECONDARY_reload_loop"
		},
		/*
		ar2={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_SECONDARY"
		}*/
	},
	loadout={"pill_wep_holstered","pktfw_bottle","pktfw_stickylauncher","pktfw_grenadelauncher"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	fist - melee
	shotgun - shotguns
	slam - minigun
	physgun - minigun/deployed
*/

pk_pills.register("tf_heavy",{
	parent="tf_heavy_cutout",
	printName="Heavy",
	model="models/player/heavy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		fist={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jumpstart_MELEE",
			glide="jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="attackStand_MELEE_R"
		},
		shotgun={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="jumpstart_SECONDARY",
			glide="jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		slam={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jumpstart_PRIMARY",
			glide="jumpfloat_PRIMARY",
			swim="swim_PRIMARY"
		},
		physgun={
			idle="stand_deployed_PRIMARY",
			walk="PRIMARY_deployed_movement",
			crouch="crouch_deployed_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="PRIMARY_deployed_movement",
			glide="PRIMARY_deployed_movement",
			swim="PRIMARY_swim_deployed_movement"
		}
	},
	loadout={"pill_wep_holstered","pktfw_fists","pktfw_shotgun","pktfw_minigun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	pistol - pistols
	shotgun - shotguns
*/

pk_pills.register("tf_engi",{
	parent="tf_engi_cutout",
	printName="Engineer",
	model="models/player/engineer.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="Melee_Swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_wrench","pktfw_pistol","pktfw_shotgun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	ar2 - mediguns
	smg - syringe guns
*/

pk_pills.register("tf_medic",{
	parent="tf_medic_cutout",
	printName="Medic",
	model="models/player/medic.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_LOSER",
			glide="jump_float_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="jump_start_MELEE",
			glide="jump_float_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		ar2={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="Jump_start_SECONDARY",
			glide="Jump_float_SECONDARY",
			swim="swim_SECONDARY",
			g_attack="AttackStand_SECONDARY"
			//g_reload="ReloadStand_SECONDARY"
		},
		smg={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="jump_start_PRIMARY",
			glide="jump_float_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			g_reload="ReloadStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_bonesaw","pktfw_medigun","pktfw_syringegun"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	melee - melee
	smg - smgs
	crossbow - rifles
	ar2 - rifles/zoomed
*/

pk_pills.register("tf_sniper",{
	parent="tf_sniper_cutout",
	printName="Sniper",
	model="models/player/sniper.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		melee={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		smg={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY"
		},
		crossbow={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="a_jumpstart_PRIMARY",
			glide="a_jumpfloat_PRIMARY",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY"
		}
	},
	loadout={"pill_wep_holstered","pktfw_kukri","pktfw_smg","pktfw_sniper"},
	movePoseMode="xy",
	noragdoll=false
})

/*
	default - humiliation
	knife - knives
	pistol - revolvers
*/

pk_pills.register("tf_spy",{
	parent="tf_spy_cutout",
	printName="Spy",
	model="models/player/spy.mdl",
	skin=0,
	default_rp_cost=10000,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	duckBy=40,
	aim={
		xPose="body_yaw",
		yPose="body_pitch",
		xInvert=true,
		yInvert=true
	},
	attack2={
		mode="trigger",
		func=function(ply,ent)
			ent:ToggleCloak()
		end
	},
	cloak={
		max=10,
		rechargeRate=.3
	},
	anims={
		default={
			idle="stand_LOSER",
			walk="run_LOSER",
			crouch="crouch_LOSER",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_LOSER",
			glide="a_jumpfloat_LOSER",
			swim="swim_LOSER"
		},
		knife={
			idle="stand_MELEE",
			walk="run_MELEE",
			crouch="crouch_MELEE",
			crouch_walk="crouch_walk_MELEE",
			jump="a_jumpstart_MELEE",
			glide="a_jumpfloat_MELEE",
			swim="swim_MELEE",
			g_attack="MELEE_swing"
		},
		pistol={
			idle="stand_SECONDARY",
			walk="run_SECONDARY",
			crouch="crouch_SECONDARY",
			crouch_walk="crouch_walk_SECONDARY",
			jump="a_jumpstart_SECONDARY",
			glide="a_jumpfloat_SECONDARY",
			swim="swim_SECONDARY",
			g_reload="ReloadStand_SECONDARY",
			g_attack="AttackStand_SECONDARY"
		},
		/*shotgun={
			idle="stand_PRIMARY",
			walk="run_PRIMARY",
			crouch="crouch_PRIMARY",
			crouch_walk="crouch_walk_PRIMARY",
			jump="Jump_Start_primary",
			glide="Jump_Float_primary",
			swim="swim_PRIMARY",
			g_attack="AttackStand_PRIMARY",
			//g_reload="ReloadStand_PRIMARY"
		}*/
	},
	sounds={
		cloak="player/spy_cloak.wav",
		uncloak="player/spy_uncloak.wav"
	},
	loadout={"pill_wep_holstered","pktfw_knife","pktfw_revolver"},
	movePoseMode="xy",
	noragdoll=false
})

