-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_sentry.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

local function sentry_transform(ent,type)
	local ply = ent:GetPillUser()

	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	local _skin = ent:GetSkin()
	local attached = IsValid(ent.attachWeld)

	local newpill = pk_pills.apply(ply,type)
	newpill:SetPos(pos)
	newpill:SetAngles(ang)
	newpill:SetSkin(_skin)

	if attached and (IsValid(ent.attachEnt) or ent.attachEnt==game.GetWorld()) then
		newpill.attachEnt = ent.attachEnt
		newpill.attachWeld = constraint.Weld(newpill,ent.attachEnt,0,0,0,true)
	end
end

pk_pills.register("tf_sentry",{
	printName="Sentry",
	type="phys",
	model="models/weapons/w_models/w_toolbox.mdl",
	default_rp_cost=8000,
	camera={
		dist=100,
		offset=Vector(0,0,20)
	},
	skin=0,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	health=50,
	reload=function(ply,ent)
		if ent:GetModel()!= "models/buildables/sentry1_heavy.mdl" then
			ent:SetModel("models/buildables/sentry1_heavy.mdl")
			ent:PillAnim("build",true)
			if ent.formTable.minisentry then
				ent:SetSkin(ent:GetSkin()+2)
				ent:SetBodygroup(3,1)
				ent:SetModelScale(.75,.5)
				ent:SetPlaybackRate(2)
			end
			timer.Simple(ent.formTable.minisentry and 2.5 or 5,function()
				if IsValid(ent) then
					sentry_transform(ent,ent.formTable.minisentry and "tf_minisentry_1" or "tf_sentry_1")
				end
			end)
			local tr = util.QuickTrace(ent:GetPos(),ent:GetAngles():Up()*-10,ent)
			if IsValid(tr.Entity) or tr.HitWorld then
				ent.attachEnt = tr.Entity
				ent.attachWeld = constraint.Weld(ent,tr.Entity,0,0,0,true)
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav"
	}
})

pk_pills.register("tf_minisentry",{
	printName="Mini-Sentry",
	parent="tf_sentry",
	default_rp_cost=6000,
	minisentry=true
})

pk_pills.register("tf_sentry_1",{
	type="phys",
	model="models/buildables/sentry1.mdl",
	sentry_lvl=1,
	boxPhysics={Vector(-24,-24,0),Vector(24,24,50)},
	camera={
		dist=100,
		offset=Vector(0,0,40)
	},
	aim={
		xPose="aim_yaw",
		yPose="aim_pitch",
		attachment="muzzle",
		xInvert=true,
		yInvert=true
	},
	health=150,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.25,
		damage=16,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	reload=function(ply,ent)
		if ply:KeyDown(IN_DUCK) then
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl>1 then
				sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl-1))
			elseif ent.formTable.sentry_lvl then
				pk_pills.apply(ply,"tf_sentry"):SetSkin(ent:GetSkin())
			else
				pk_pills.apply(ply,"tf_minisentry"):SetSkin(ent:GetSkin()-2)
			end
			ent:PillSound("downgrade")
		else
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl<3 then
				if ent:GetModel()!= "models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl" then
					ent:SetModel("models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl")
					ent:PillAnim("build",true)
					timer.Simple(1,function()
						if IsValid(ent) then
							sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl+1))
						end
					end)
				end
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav",
		shoot="weapons/sentry_shoot.wav",
		downgrade=pk_pills.helpers.makeList("weapons/sentry_upgrading#.wav",8)
	}
})

pk_pills.register("tf_minisentry_1",{
	parent="tf_sentry_1",
	sentry_lvl=false,
	boxPhysics={Vector(-18,-18,0),Vector(18,18,37.5)},
	camera={
		dist=80,
		offset=Vector(0,0,40)
	},
	health=100,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.166,
		damage=8,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	sounds={
		shoot_pitch=125,
	},
	bodyGroups={2},
	modelScale=.75
})

pk_pills.register("tf_sentry_2",{
	parent="tf_sentry_1",
	model="models/buildables/sentry2.mdl",
	sentry_lvl=2,
	camera={
		dist=100,
		offset=Vector(0,0,50)
	},
	health=180,
	aim={
		attachment="muzzle_l",
		fixTracers=true
	},
	attack={
		mode= "auto",
		func=function(ply,ent,tbl)
			if (!ent.leftFired) then
				ent:PillSound("shoot2")
				ent.formTable.aim.overrideStart=nil
				ent.leftFired=true
			else
				local a = ent:GetAttachment(ent:LookupAttachment("muzzle_r"))
				ent.formTable.aim.overrideStart= ent:WorldToLocal(a.Pos)
				ent.leftFired=false
			end
			pk_pills.common.shoot(ply,ent,tbl)
		end,
		delay=.125,
		damage=16,
		spread=.01,
		tracer="Tracer"
	},
	boneMorphs = {
		["S2chaingunR_02"]=function(ply,ent)
			local a= ent.curRotRightBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotRightBarrel=a
			return {rot=Angle(0,a,0)}
		end,
		["S2chaingunL_02"]=function(ply,ent)
			local a= ent.curRotLeftBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotLeftBarrel=a
			return {rot=Angle(0,a,0)}
		end
	},
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot2.wav"
	}
})

pk_pills.register("tf_sentry_3",{
	parent="tf_sentry_2",
	model="models/buildables/sentry3.mdl",
	sentry_lvl=3,
	camera={
		dist=125,
		offset=Vector(0,0,80)
	},
	attack2={
		mode= "auto",
		func=function(ply,ent)
			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/buildables/sentry3_rockets.mdl")
			local a = ent:GetAttachment(ent:LookupAttachment("rocket"))
			rocket:SetPos(a.Pos)
			rocket:SetAngles(a.Ang)
			rocket.noPhys=true
			rocket.shooter=ent
			rocket.speed=1100
			rocket.spin=true
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			rocket:Spawn()
			rocket:SetOwner(ply)

			ent:PillSound("shootRocket")
		end,
		delay=3
	},
	health=216,
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot3.wav",
		shootRocket="weapons/sentry_rocket.wav"
	}
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_sentry.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

local function sentry_transform(ent,type)
	local ply = ent:GetPillUser()

	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	local _skin = ent:GetSkin()
	local attached = IsValid(ent.attachWeld)

	local newpill = pk_pills.apply(ply,type)
	newpill:SetPos(pos)
	newpill:SetAngles(ang)
	newpill:SetSkin(_skin)

	if attached and (IsValid(ent.attachEnt) or ent.attachEnt==game.GetWorld()) then
		newpill.attachEnt = ent.attachEnt
		newpill.attachWeld = constraint.Weld(newpill,ent.attachEnt,0,0,0,true)
	end
end

pk_pills.register("tf_sentry",{
	printName="Sentry",
	type="phys",
	model="models/weapons/w_models/w_toolbox.mdl",
	default_rp_cost=8000,
	camera={
		dist=100,
		offset=Vector(0,0,20)
	},
	skin=0,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	health=50,
	reload=function(ply,ent)
		if ent:GetModel()!= "models/buildables/sentry1_heavy.mdl" then
			ent:SetModel("models/buildables/sentry1_heavy.mdl")
			ent:PillAnim("build",true)
			if ent.formTable.minisentry then
				ent:SetSkin(ent:GetSkin()+2)
				ent:SetBodygroup(3,1)
				ent:SetModelScale(.75,.5)
				ent:SetPlaybackRate(2)
			end
			timer.Simple(ent.formTable.minisentry and 2.5 or 5,function()
				if IsValid(ent) then
					sentry_transform(ent,ent.formTable.minisentry and "tf_minisentry_1" or "tf_sentry_1")
				end
			end)
			local tr = util.QuickTrace(ent:GetPos(),ent:GetAngles():Up()*-10,ent)
			if IsValid(tr.Entity) or tr.HitWorld then
				ent.attachEnt = tr.Entity
				ent.attachWeld = constraint.Weld(ent,tr.Entity,0,0,0,true)
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav"
	}
})

pk_pills.register("tf_minisentry",{
	printName="Mini-Sentry",
	parent="tf_sentry",
	default_rp_cost=6000,
	minisentry=true
})

pk_pills.register("tf_sentry_1",{
	type="phys",
	model="models/buildables/sentry1.mdl",
	sentry_lvl=1,
	boxPhysics={Vector(-24,-24,0),Vector(24,24,50)},
	camera={
		dist=100,
		offset=Vector(0,0,40)
	},
	aim={
		xPose="aim_yaw",
		yPose="aim_pitch",
		attachment="muzzle",
		xInvert=true,
		yInvert=true
	},
	health=150,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.25,
		damage=16,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	reload=function(ply,ent)
		if ply:KeyDown(IN_DUCK) then
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl>1 then
				sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl-1))
			elseif ent.formTable.sentry_lvl then
				pk_pills.apply(ply,"tf_sentry"):SetSkin(ent:GetSkin())
			else
				pk_pills.apply(ply,"tf_minisentry"):SetSkin(ent:GetSkin()-2)
			end
			ent:PillSound("downgrade")
		else
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl<3 then
				if ent:GetModel()!= "models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl" then
					ent:SetModel("models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl")
					ent:PillAnim("build",true)
					timer.Simple(1,function()
						if IsValid(ent) then
							sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl+1))
						end
					end)
				end
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav",
		shoot="weapons/sentry_shoot.wav",
		downgrade=pk_pills.helpers.makeList("weapons/sentry_upgrading#.wav",8)
	}
})

pk_pills.register("tf_minisentry_1",{
	parent="tf_sentry_1",
	sentry_lvl=false,
	boxPhysics={Vector(-18,-18,0),Vector(18,18,37.5)},
	camera={
		dist=80,
		offset=Vector(0,0,40)
	},
	health=100,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.166,
		damage=8,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	sounds={
		shoot_pitch=125,
	},
	bodyGroups={2},
	modelScale=.75
})

pk_pills.register("tf_sentry_2",{
	parent="tf_sentry_1",
	model="models/buildables/sentry2.mdl",
	sentry_lvl=2,
	camera={
		dist=100,
		offset=Vector(0,0,50)
	},
	health=180,
	aim={
		attachment="muzzle_l",
		fixTracers=true
	},
	attack={
		mode= "auto",
		func=function(ply,ent,tbl)
			if (!ent.leftFired) then
				ent:PillSound("shoot2")
				ent.formTable.aim.overrideStart=nil
				ent.leftFired=true
			else
				local a = ent:GetAttachment(ent:LookupAttachment("muzzle_r"))
				ent.formTable.aim.overrideStart= ent:WorldToLocal(a.Pos)
				ent.leftFired=false
			end
			pk_pills.common.shoot(ply,ent,tbl)
		end,
		delay=.125,
		damage=16,
		spread=.01,
		tracer="Tracer"
	},
	boneMorphs = {
		["S2chaingunR_02"]=function(ply,ent)
			local a= ent.curRotRightBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotRightBarrel=a
			return {rot=Angle(0,a,0)}
		end,
		["S2chaingunL_02"]=function(ply,ent)
			local a= ent.curRotLeftBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotLeftBarrel=a
			return {rot=Angle(0,a,0)}
		end
	},
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot2.wav"
	}
})

pk_pills.register("tf_sentry_3",{
	parent="tf_sentry_2",
	model="models/buildables/sentry3.mdl",
	sentry_lvl=3,
	camera={
		dist=125,
		offset=Vector(0,0,80)
	},
	attack2={
		mode= "auto",
		func=function(ply,ent)
			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/buildables/sentry3_rockets.mdl")
			local a = ent:GetAttachment(ent:LookupAttachment("rocket"))
			rocket:SetPos(a.Pos)
			rocket:SetAngles(a.Ang)
			rocket.noPhys=true
			rocket.shooter=ent
			rocket.speed=1100
			rocket.spin=true
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			rocket:Spawn()
			rocket:SetOwner(ply)

			ent:PillSound("shootRocket")
		end,
		delay=3
	},
	health=216,
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot3.wav",
		shootRocket="weapons/sentry_rocket.wav"
	}
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_sentry.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

local function sentry_transform(ent,type)
	local ply = ent:GetPillUser()

	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	local _skin = ent:GetSkin()
	local attached = IsValid(ent.attachWeld)

	local newpill = pk_pills.apply(ply,type)
	newpill:SetPos(pos)
	newpill:SetAngles(ang)
	newpill:SetSkin(_skin)

	if attached and (IsValid(ent.attachEnt) or ent.attachEnt==game.GetWorld()) then
		newpill.attachEnt = ent.attachEnt
		newpill.attachWeld = constraint.Weld(newpill,ent.attachEnt,0,0,0,true)
	end
end

pk_pills.register("tf_sentry",{
	printName="Sentry",
	type="phys",
	model="models/weapons/w_models/w_toolbox.mdl",
	default_rp_cost=8000,
	camera={
		dist=100,
		offset=Vector(0,0,20)
	},
	skin=0,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	health=50,
	reload=function(ply,ent)
		if ent:GetModel()!= "models/buildables/sentry1_heavy.mdl" then
			ent:SetModel("models/buildables/sentry1_heavy.mdl")
			ent:PillAnim("build",true)
			if ent.formTable.minisentry then
				ent:SetSkin(ent:GetSkin()+2)
				ent:SetBodygroup(3,1)
				ent:SetModelScale(.75,.5)
				ent:SetPlaybackRate(2)
			end
			timer.Simple(ent.formTable.minisentry and 2.5 or 5,function()
				if IsValid(ent) then
					sentry_transform(ent,ent.formTable.minisentry and "tf_minisentry_1" or "tf_sentry_1")
				end
			end)
			local tr = util.QuickTrace(ent:GetPos(),ent:GetAngles():Up()*-10,ent)
			if IsValid(tr.Entity) or tr.HitWorld then
				ent.attachEnt = tr.Entity
				ent.attachWeld = constraint.Weld(ent,tr.Entity,0,0,0,true)
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav"
	}
})

pk_pills.register("tf_minisentry",{
	printName="Mini-Sentry",
	parent="tf_sentry",
	default_rp_cost=6000,
	minisentry=true
})

pk_pills.register("tf_sentry_1",{
	type="phys",
	model="models/buildables/sentry1.mdl",
	sentry_lvl=1,
	boxPhysics={Vector(-24,-24,0),Vector(24,24,50)},
	camera={
		dist=100,
		offset=Vector(0,0,40)
	},
	aim={
		xPose="aim_yaw",
		yPose="aim_pitch",
		attachment="muzzle",
		xInvert=true,
		yInvert=true
	},
	health=150,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.25,
		damage=16,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	reload=function(ply,ent)
		if ply:KeyDown(IN_DUCK) then
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl>1 then
				sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl-1))
			elseif ent.formTable.sentry_lvl then
				pk_pills.apply(ply,"tf_sentry"):SetSkin(ent:GetSkin())
			else
				pk_pills.apply(ply,"tf_minisentry"):SetSkin(ent:GetSkin()-2)
			end
			ent:PillSound("downgrade")
		else
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl<3 then
				if ent:GetModel()!= "models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl" then
					ent:SetModel("models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl")
					ent:PillAnim("build",true)
					timer.Simple(1,function()
						if IsValid(ent) then
							sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl+1))
						end
					end)
				end
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav",
		shoot="weapons/sentry_shoot.wav",
		downgrade=pk_pills.helpers.makeList("weapons/sentry_upgrading#.wav",8)
	}
})

pk_pills.register("tf_minisentry_1",{
	parent="tf_sentry_1",
	sentry_lvl=false,
	boxPhysics={Vector(-18,-18,0),Vector(18,18,37.5)},
	camera={
		dist=80,
		offset=Vector(0,0,40)
	},
	health=100,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.166,
		damage=8,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	sounds={
		shoot_pitch=125,
	},
	bodyGroups={2},
	modelScale=.75
})

pk_pills.register("tf_sentry_2",{
	parent="tf_sentry_1",
	model="models/buildables/sentry2.mdl",
	sentry_lvl=2,
	camera={
		dist=100,
		offset=Vector(0,0,50)
	},
	health=180,
	aim={
		attachment="muzzle_l",
		fixTracers=true
	},
	attack={
		mode= "auto",
		func=function(ply,ent,tbl)
			if (!ent.leftFired) then
				ent:PillSound("shoot2")
				ent.formTable.aim.overrideStart=nil
				ent.leftFired=true
			else
				local a = ent:GetAttachment(ent:LookupAttachment("muzzle_r"))
				ent.formTable.aim.overrideStart= ent:WorldToLocal(a.Pos)
				ent.leftFired=false
			end
			pk_pills.common.shoot(ply,ent,tbl)
		end,
		delay=.125,
		damage=16,
		spread=.01,
		tracer="Tracer"
	},
	boneMorphs = {
		["S2chaingunR_02"]=function(ply,ent)
			local a= ent.curRotRightBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotRightBarrel=a
			return {rot=Angle(0,a,0)}
		end,
		["S2chaingunL_02"]=function(ply,ent)
			local a= ent.curRotLeftBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotLeftBarrel=a
			return {rot=Angle(0,a,0)}
		end
	},
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot2.wav"
	}
})

pk_pills.register("tf_sentry_3",{
	parent="tf_sentry_2",
	model="models/buildables/sentry3.mdl",
	sentry_lvl=3,
	camera={
		dist=125,
		offset=Vector(0,0,80)
	},
	attack2={
		mode= "auto",
		func=function(ply,ent)
			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/buildables/sentry3_rockets.mdl")
			local a = ent:GetAttachment(ent:LookupAttachment("rocket"))
			rocket:SetPos(a.Pos)
			rocket:SetAngles(a.Ang)
			rocket.noPhys=true
			rocket.shooter=ent
			rocket.speed=1100
			rocket.spin=true
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			rocket:Spawn()
			rocket:SetOwner(ply)

			ent:PillSound("shootRocket")
		end,
		delay=3
	},
	health=216,
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot3.wav",
		shootRocket="weapons/sentry_rocket.wav"
	}
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_sentry.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

local function sentry_transform(ent,type)
	local ply = ent:GetPillUser()

	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	local _skin = ent:GetSkin()
	local attached = IsValid(ent.attachWeld)

	local newpill = pk_pills.apply(ply,type)
	newpill:SetPos(pos)
	newpill:SetAngles(ang)
	newpill:SetSkin(_skin)

	if attached and (IsValid(ent.attachEnt) or ent.attachEnt==game.GetWorld()) then
		newpill.attachEnt = ent.attachEnt
		newpill.attachWeld = constraint.Weld(newpill,ent.attachEnt,0,0,0,true)
	end
end

pk_pills.register("tf_sentry",{
	printName="Sentry",
	type="phys",
	model="models/weapons/w_models/w_toolbox.mdl",
	default_rp_cost=8000,
	camera={
		dist=100,
		offset=Vector(0,0,20)
	},
	skin=0,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	health=50,
	reload=function(ply,ent)
		if ent:GetModel()!= "models/buildables/sentry1_heavy.mdl" then
			ent:SetModel("models/buildables/sentry1_heavy.mdl")
			ent:PillAnim("build",true)
			if ent.formTable.minisentry then
				ent:SetSkin(ent:GetSkin()+2)
				ent:SetBodygroup(3,1)
				ent:SetModelScale(.75,.5)
				ent:SetPlaybackRate(2)
			end
			timer.Simple(ent.formTable.minisentry and 2.5 or 5,function()
				if IsValid(ent) then
					sentry_transform(ent,ent.formTable.minisentry and "tf_minisentry_1" or "tf_sentry_1")
				end
			end)
			local tr = util.QuickTrace(ent:GetPos(),ent:GetAngles():Up()*-10,ent)
			if IsValid(tr.Entity) or tr.HitWorld then
				ent.attachEnt = tr.Entity
				ent.attachWeld = constraint.Weld(ent,tr.Entity,0,0,0,true)
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav"
	}
})

pk_pills.register("tf_minisentry",{
	printName="Mini-Sentry",
	parent="tf_sentry",
	default_rp_cost=6000,
	minisentry=true
})

pk_pills.register("tf_sentry_1",{
	type="phys",
	model="models/buildables/sentry1.mdl",
	sentry_lvl=1,
	boxPhysics={Vector(-24,-24,0),Vector(24,24,50)},
	camera={
		dist=100,
		offset=Vector(0,0,40)
	},
	aim={
		xPose="aim_yaw",
		yPose="aim_pitch",
		attachment="muzzle",
		xInvert=true,
		yInvert=true
	},
	health=150,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.25,
		damage=16,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	reload=function(ply,ent)
		if ply:KeyDown(IN_DUCK) then
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl>1 then
				sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl-1))
			elseif ent.formTable.sentry_lvl then
				pk_pills.apply(ply,"tf_sentry"):SetSkin(ent:GetSkin())
			else
				pk_pills.apply(ply,"tf_minisentry"):SetSkin(ent:GetSkin()-2)
			end
			ent:PillSound("downgrade")
		else
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl<3 then
				if ent:GetModel()!= "models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl" then
					ent:SetModel("models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl")
					ent:PillAnim("build",true)
					timer.Simple(1,function()
						if IsValid(ent) then
							sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl+1))
						end
					end)
				end
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav",
		shoot="weapons/sentry_shoot.wav",
		downgrade=pk_pills.helpers.makeList("weapons/sentry_upgrading#.wav",8)
	}
})

pk_pills.register("tf_minisentry_1",{
	parent="tf_sentry_1",
	sentry_lvl=false,
	boxPhysics={Vector(-18,-18,0),Vector(18,18,37.5)},
	camera={
		dist=80,
		offset=Vector(0,0,40)
	},
	health=100,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.166,
		damage=8,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	sounds={
		shoot_pitch=125,
	},
	bodyGroups={2},
	modelScale=.75
})

pk_pills.register("tf_sentry_2",{
	parent="tf_sentry_1",
	model="models/buildables/sentry2.mdl",
	sentry_lvl=2,
	camera={
		dist=100,
		offset=Vector(0,0,50)
	},
	health=180,
	aim={
		attachment="muzzle_l",
		fixTracers=true
	},
	attack={
		mode= "auto",
		func=function(ply,ent,tbl)
			if (!ent.leftFired) then
				ent:PillSound("shoot2")
				ent.formTable.aim.overrideStart=nil
				ent.leftFired=true
			else
				local a = ent:GetAttachment(ent:LookupAttachment("muzzle_r"))
				ent.formTable.aim.overrideStart= ent:WorldToLocal(a.Pos)
				ent.leftFired=false
			end
			pk_pills.common.shoot(ply,ent,tbl)
		end,
		delay=.125,
		damage=16,
		spread=.01,
		tracer="Tracer"
	},
	boneMorphs = {
		["S2chaingunR_02"]=function(ply,ent)
			local a= ent.curRotRightBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotRightBarrel=a
			return {rot=Angle(0,a,0)}
		end,
		["S2chaingunL_02"]=function(ply,ent)
			local a= ent.curRotLeftBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotLeftBarrel=a
			return {rot=Angle(0,a,0)}
		end
	},
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot2.wav"
	}
})

pk_pills.register("tf_sentry_3",{
	parent="tf_sentry_2",
	model="models/buildables/sentry3.mdl",
	sentry_lvl=3,
	camera={
		dist=125,
		offset=Vector(0,0,80)
	},
	attack2={
		mode= "auto",
		func=function(ply,ent)
			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/buildables/sentry3_rockets.mdl")
			local a = ent:GetAttachment(ent:LookupAttachment("rocket"))
			rocket:SetPos(a.Pos)
			rocket:SetAngles(a.Ang)
			rocket.noPhys=true
			rocket.shooter=ent
			rocket.speed=1100
			rocket.spin=true
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			rocket:Spawn()
			rocket:SetOwner(ply)

			ent:PillSound("shootRocket")
		end,
		delay=3
	},
	health=216,
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot3.wav",
		shootRocket="weapons/sentry_rocket.wav"
	}
})

-- "addons\\diduknow\\lua\\autorun\\include\\pill_tf_sentry.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

local function sentry_transform(ent,type)
	local ply = ent:GetPillUser()

	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	local _skin = ent:GetSkin()
	local attached = IsValid(ent.attachWeld)

	local newpill = pk_pills.apply(ply,type)
	newpill:SetPos(pos)
	newpill:SetAngles(ang)
	newpill:SetSkin(_skin)

	if attached and (IsValid(ent.attachEnt) or ent.attachEnt==game.GetWorld()) then
		newpill.attachEnt = ent.attachEnt
		newpill.attachWeld = constraint.Weld(newpill,ent.attachEnt,0,0,0,true)
	end
end

pk_pills.register("tf_sentry",{
	printName="Sentry",
	type="phys",
	model="models/weapons/w_models/w_toolbox.mdl",
	default_rp_cost=8000,
	camera={
		dist=100,
		offset=Vector(0,0,20)
	},
	skin=0,
	options=function() return {
		{skin=0},
		{skin=1}
	} end,
	health=50,
	reload=function(ply,ent)
		if ent:GetModel()!= "models/buildables/sentry1_heavy.mdl" then
			ent:SetModel("models/buildables/sentry1_heavy.mdl")
			ent:PillAnim("build",true)
			if ent.formTable.minisentry then
				ent:SetSkin(ent:GetSkin()+2)
				ent:SetBodygroup(3,1)
				ent:SetModelScale(.75,.5)
				ent:SetPlaybackRate(2)
			end
			timer.Simple(ent.formTable.minisentry and 2.5 or 5,function()
				if IsValid(ent) then
					sentry_transform(ent,ent.formTable.minisentry and "tf_minisentry_1" or "tf_sentry_1")
				end
			end)
			local tr = util.QuickTrace(ent:GetPos(),ent:GetAngles():Up()*-10,ent)
			if IsValid(tr.Entity) or tr.HitWorld then
				ent.attachEnt = tr.Entity
				ent.attachWeld = constraint.Weld(ent,tr.Entity,0,0,0,true)
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav"
	}
})

pk_pills.register("tf_minisentry",{
	printName="Mini-Sentry",
	parent="tf_sentry",
	default_rp_cost=6000,
	minisentry=true
})

pk_pills.register("tf_sentry_1",{
	type="phys",
	model="models/buildables/sentry1.mdl",
	sentry_lvl=1,
	boxPhysics={Vector(-24,-24,0),Vector(24,24,50)},
	camera={
		dist=100,
		offset=Vector(0,0,40)
	},
	aim={
		xPose="aim_yaw",
		yPose="aim_pitch",
		attachment="muzzle",
		xInvert=true,
		yInvert=true
	},
	health=150,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.25,
		damage=16,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	reload=function(ply,ent)
		if ply:KeyDown(IN_DUCK) then
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl>1 then
				sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl-1))
			elseif ent.formTable.sentry_lvl then
				pk_pills.apply(ply,"tf_sentry"):SetSkin(ent:GetSkin())
			else
				pk_pills.apply(ply,"tf_minisentry"):SetSkin(ent:GetSkin()-2)
			end
			ent:PillSound("downgrade")
		else
			if ent.formTable.sentry_lvl and ent.formTable.sentry_lvl<3 then
				if ent:GetModel()!= "models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl" then
					ent:SetModel("models/buildables/sentry"..(ent.formTable.sentry_lvl+1).."_heavy.mdl")
					ent:PillAnim("build",true)
					timer.Simple(1,function()
						if IsValid(ent) then
							sentry_transform(ent,"tf_sentry_"..(ent.formTable.sentry_lvl+1))
						end
					end)
				end
			end
		end
	end,
	damageFromWater=-1,
	sounds={
		die="weapons/sentry_explode.wav",
		shoot="weapons/sentry_shoot.wav",
		downgrade=pk_pills.helpers.makeList("weapons/sentry_upgrading#.wav",8)
	}
})

pk_pills.register("tf_minisentry_1",{
	parent="tf_sentry_1",
	sentry_lvl=false,
	boxPhysics={Vector(-18,-18,0),Vector(18,18,37.5)},
	camera={
		dist=80,
		offset=Vector(0,0,40)
	},
	health=100,
	attack={
		mode= "auto",
		func=pk_pills.common.shoot,
		delay=.166,
		damage=8,
		spread=.01,
		tracer="Tracer",
		fixTracers=true
	},
	sounds={
		shoot_pitch=125,
	},
	bodyGroups={2},
	modelScale=.75
})

pk_pills.register("tf_sentry_2",{
	parent="tf_sentry_1",
	model="models/buildables/sentry2.mdl",
	sentry_lvl=2,
	camera={
		dist=100,
		offset=Vector(0,0,50)
	},
	health=180,
	aim={
		attachment="muzzle_l",
		fixTracers=true
	},
	attack={
		mode= "auto",
		func=function(ply,ent,tbl)
			if (!ent.leftFired) then
				ent:PillSound("shoot2")
				ent.formTable.aim.overrideStart=nil
				ent.leftFired=true
			else
				local a = ent:GetAttachment(ent:LookupAttachment("muzzle_r"))
				ent.formTable.aim.overrideStart= ent:WorldToLocal(a.Pos)
				ent.leftFired=false
			end
			pk_pills.common.shoot(ply,ent,tbl)
		end,
		delay=.125,
		damage=16,
		spread=.01,
		tracer="Tracer"
	},
	boneMorphs = {
		["S2chaingunR_02"]=function(ply,ent)
			local a= ent.curRotRightBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotRightBarrel=a
			return {rot=Angle(0,a,0)}
		end,
		["S2chaingunL_02"]=function(ply,ent)
			local a= ent.curRotLeftBarrel or 0
			if ply:KeyDown(IN_ATTACK) then
				a=a+10
			end
			ent.curRotLeftBarrel=a
			return {rot=Angle(0,a,0)}
		end
	},
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot2.wav"
	}
})

pk_pills.register("tf_sentry_3",{
	parent="tf_sentry_2",
	model="models/buildables/sentry3.mdl",
	sentry_lvl=3,
	camera={
		dist=125,
		offset=Vector(0,0,80)
	},
	attack2={
		mode= "auto",
		func=function(ply,ent)
			local rocket = ents.Create("pill_proj_rocket")
			rocket:SetModel("models/buildables/sentry3_rockets.mdl")
			local a = ent:GetAttachment(ent:LookupAttachment("rocket"))
			rocket:SetPos(a.Pos)
			rocket:SetAngles(a.Ang)
			rocket.noPhys=true
			rocket.shooter=ent
			rocket.speed=1100
			rocket.spin=true
			rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
			rocket:Spawn()
			rocket:SetOwner(ply)

			ent:PillSound("shootRocket")
		end,
		delay=3
	},
	health=216,
	sounds={
		shoot=false,
		shoot2="weapons/sentry_shoot3.wav",
		shootRocket="weapons/sentry_rocket.wav"
	}
})

