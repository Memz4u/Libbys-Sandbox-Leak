-- "addons\\diduknow\\lua\\weapons\\pktfw_flamethrower.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_flamethrower/c_flamethrower.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Flame Thrower"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"Emitter")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
	
	self.sound_flame = CreateSound(self,"weapons/flame_thrower_loop.wav")
	
	if SERVER then
		local emitter = ents.Create("pill_target")
		self:SetEmitter(emitter)
		emitter:Spawn()
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self.sound_flame:Play()

	
	if self.Owner:WaterLevel()>=2 then
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="bubbles" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("flamethrower_underwater",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="bubbles"
		end
	else
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="flame" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("_flamethrower_real",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="flame"
		end

		if SERVER then
			local target = self.Owner:TraceHullAttack(
				self.Owner:GetPos()+Vector(0,0,60),
				self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*200,
				Vector(-30,-30,-30), Vector(30,30,30),
				5,DMG_BURN,0,true
			)
			if IsValid(target) then target:Ignite(10) end
		end
	end
	
	if SERVER then
		if self.takeammo then
			self:TakePrimaryAmmo(1)
		end
		self.takeammo= !self.takeammo
	end

	self:SetNextPrimaryFire(CurTime() + .04)
end

function SWEP:Think()
	if self:GetNextPrimaryFire()+.05<CurTime() then
		self.sound_flame:Stop()
		if CLIENT and self.particles then
			self:GetEmitter():StopParticles()
			self.particles=nil
		end
	end
	if IsValid(self:GetEmitter()) then
		self:GetEmitter():SetNetworkOrigin(self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*50)
		self:GetEmitter():SetAngles(self.Owner:EyeAngles())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_flamethrower.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_flamethrower/c_flamethrower.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Flame Thrower"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"Emitter")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
	
	self.sound_flame = CreateSound(self,"weapons/flame_thrower_loop.wav")
	
	if SERVER then
		local emitter = ents.Create("pill_target")
		self:SetEmitter(emitter)
		emitter:Spawn()
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self.sound_flame:Play()

	
	if self.Owner:WaterLevel()>=2 then
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="bubbles" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("flamethrower_underwater",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="bubbles"
		end
	else
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="flame" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("_flamethrower_real",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="flame"
		end

		if SERVER then
			local target = self.Owner:TraceHullAttack(
				self.Owner:GetPos()+Vector(0,0,60),
				self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*200,
				Vector(-30,-30,-30), Vector(30,30,30),
				5,DMG_BURN,0,true
			)
			if IsValid(target) then target:Ignite(10) end
		end
	end
	
	if SERVER then
		if self.takeammo then
			self:TakePrimaryAmmo(1)
		end
		self.takeammo= !self.takeammo
	end

	self:SetNextPrimaryFire(CurTime() + .04)
end

function SWEP:Think()
	if self:GetNextPrimaryFire()+.05<CurTime() then
		self.sound_flame:Stop()
		if CLIENT and self.particles then
			self:GetEmitter():StopParticles()
			self.particles=nil
		end
	end
	if IsValid(self:GetEmitter()) then
		self:GetEmitter():SetNetworkOrigin(self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*50)
		self:GetEmitter():SetAngles(self.Owner:EyeAngles())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_flamethrower.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_flamethrower/c_flamethrower.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Flame Thrower"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"Emitter")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
	
	self.sound_flame = CreateSound(self,"weapons/flame_thrower_loop.wav")
	
	if SERVER then
		local emitter = ents.Create("pill_target")
		self:SetEmitter(emitter)
		emitter:Spawn()
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self.sound_flame:Play()

	
	if self.Owner:WaterLevel()>=2 then
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="bubbles" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("flamethrower_underwater",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="bubbles"
		end
	else
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="flame" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("_flamethrower_real",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="flame"
		end

		if SERVER then
			local target = self.Owner:TraceHullAttack(
				self.Owner:GetPos()+Vector(0,0,60),
				self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*200,
				Vector(-30,-30,-30), Vector(30,30,30),
				5,DMG_BURN,0,true
			)
			if IsValid(target) then target:Ignite(10) end
		end
	end
	
	if SERVER then
		if self.takeammo then
			self:TakePrimaryAmmo(1)
		end
		self.takeammo= !self.takeammo
	end

	self:SetNextPrimaryFire(CurTime() + .04)
end

function SWEP:Think()
	if self:GetNextPrimaryFire()+.05<CurTime() then
		self.sound_flame:Stop()
		if CLIENT and self.particles then
			self:GetEmitter():StopParticles()
			self.particles=nil
		end
	end
	if IsValid(self:GetEmitter()) then
		self:GetEmitter():SetNetworkOrigin(self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*50)
		self:GetEmitter():SetAngles(self.Owner:EyeAngles())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_flamethrower.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_flamethrower/c_flamethrower.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Flame Thrower"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"Emitter")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
	
	self.sound_flame = CreateSound(self,"weapons/flame_thrower_loop.wav")
	
	if SERVER then
		local emitter = ents.Create("pill_target")
		self:SetEmitter(emitter)
		emitter:Spawn()
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self.sound_flame:Play()

	
	if self.Owner:WaterLevel()>=2 then
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="bubbles" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("flamethrower_underwater",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="bubbles"
		end
	else
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="flame" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("_flamethrower_real",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="flame"
		end

		if SERVER then
			local target = self.Owner:TraceHullAttack(
				self.Owner:GetPos()+Vector(0,0,60),
				self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*200,
				Vector(-30,-30,-30), Vector(30,30,30),
				5,DMG_BURN,0,true
			)
			if IsValid(target) then target:Ignite(10) end
		end
	end
	
	if SERVER then
		if self.takeammo then
			self:TakePrimaryAmmo(1)
		end
		self.takeammo= !self.takeammo
	end

	self:SetNextPrimaryFire(CurTime() + .04)
end

function SWEP:Think()
	if self:GetNextPrimaryFire()+.05<CurTime() then
		self.sound_flame:Stop()
		if CLIENT and self.particles then
			self:GetEmitter():StopParticles()
			self.particles=nil
		end
	end
	if IsValid(self:GetEmitter()) then
		self:GetEmitter():SetNetworkOrigin(self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*50)
		self:GetEmitter():SetAngles(self.Owner:EyeAngles())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_flamethrower.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/c_models/c_flamethrower/c_flamethrower.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Flame Thrower"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"Emitter")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
	
	self.sound_flame = CreateSound(self,"weapons/flame_thrower_loop.wav")
	
	if SERVER then
		local emitter = ents.Create("pill_target")
		self:SetEmitter(emitter)
		emitter:Spawn()
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self.sound_flame:Play()

	
	if self.Owner:WaterLevel()>=2 then
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="bubbles" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("flamethrower_underwater",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="bubbles"
		end
	else
		if CLIENT and IsValid(self:GetEmitter()) and self.particles!="flame" then
			self:GetEmitter():StopParticles()
			ParticleEffectAttach("_flamethrower_real",PATTACH_ABSORIGIN_FOLLOW,self:GetEmitter(),0)
			self.particles="flame"
		end

		if SERVER then
			local target = self.Owner:TraceHullAttack(
				self.Owner:GetPos()+Vector(0,0,60),
				self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*200,
				Vector(-30,-30,-30), Vector(30,30,30),
				5,DMG_BURN,0,true
			)
			if IsValid(target) then target:Ignite(10) end
		end
	end
	
	if SERVER then
		if self.takeammo then
			self:TakePrimaryAmmo(1)
		end
		self.takeammo= !self.takeammo
	end

	self:SetNextPrimaryFire(CurTime() + .04)
end

function SWEP:Think()
	if self:GetNextPrimaryFire()+.05<CurTime() then
		self.sound_flame:Stop()
		if CLIENT and self.particles then
			self:GetEmitter():StopParticles()
			self.particles=nil
		end
	end
	if IsValid(self:GetEmitter()) then
		self:GetEmitter():SetNetworkOrigin(self.Owner:GetPos()+Vector(0,0,60)+self.Owner:EyeAngles():Forward()*50)
		self:GetEmitter():SetAngles(self.Owner:EyeAngles())
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

