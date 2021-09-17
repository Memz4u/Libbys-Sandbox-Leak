-- "addons\\diduknow\\lua\\weapons\\pktfw_sniper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_sniperrifle.mdl"

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "357"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sniper Rifle"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

SWEP.sound_fire = "weapons/sniper_shoot.wav"
SWEP.sound_reload = "weapons/sniper_worldreload.wav"

SWEP.time_fire = 1.5
SWEP.time_charge = 3.3

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Scoped")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local bullet = {}
	bullet.Src=self.Owner:GetShootPos()
	bullet.Dir=self.Owner:GetAimVector()
	bullet.Damage=50
	if self:GetScoped() then
		bullet.Damage=bullet.Damage+(math.Min(CurTime()-self.scopeStart,self.time_charge)/self.time_charge)*100
	end
	bullet.Callback = function(ply,tr,dmginfo)
		if tr.HitGroup==HITGROUP_HEAD and self:GetScoped() then
			dmginfo:ScaleDamage(3)
			self.Owner:EmitSound("player/crit_hit.wav")
		end
	end
	self.Owner:FireBullets(bullet)
	
	self:EmitSound(self.sound_fire)

	timer.Simple(self.time_fire/2,function() if !IsValid(self) then return end self:EmitSound(self.sound_reload) end)
	if SERVER then
		timer.Simple(self.time_fire/4,function() if !IsValid(self) then return end self:SetScoped(false) end)
	end
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
	//if !IsFirstTimePredicted() then return end
	self:SetScoped(!self:GetScoped())

	if self:GetScoped() then
		self.scopeStart=CurTime()

		/*local effectdata = EffectData()  BLEH!
		effectdata:SetEntity(self)
		util.Effect("sniper_dot",effectdata,true,true)*/
	end
end

function SWEP:Reload()

end

function SWEP:TranslateFOV( fov )
	if self:GetScoped() then
		return 15
	end
	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:GetScoped() then
		return .1
	end
	return 1
end

function SWEP:Holster()
	self:SetScoped(false)
	return true
end

function SWEP:momo_speedMod()
	//if self.windupstart then return .478 end
	//plz do
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_sniper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_sniperrifle.mdl"

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "357"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sniper Rifle"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

SWEP.sound_fire = "weapons/sniper_shoot.wav"
SWEP.sound_reload = "weapons/sniper_worldreload.wav"

SWEP.time_fire = 1.5
SWEP.time_charge = 3.3

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Scoped")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local bullet = {}
	bullet.Src=self.Owner:GetShootPos()
	bullet.Dir=self.Owner:GetAimVector()
	bullet.Damage=50
	if self:GetScoped() then
		bullet.Damage=bullet.Damage+(math.Min(CurTime()-self.scopeStart,self.time_charge)/self.time_charge)*100
	end
	bullet.Callback = function(ply,tr,dmginfo)
		if tr.HitGroup==HITGROUP_HEAD and self:GetScoped() then
			dmginfo:ScaleDamage(3)
			self.Owner:EmitSound("player/crit_hit.wav")
		end
	end
	self.Owner:FireBullets(bullet)
	
	self:EmitSound(self.sound_fire)

	timer.Simple(self.time_fire/2,function() if !IsValid(self) then return end self:EmitSound(self.sound_reload) end)
	if SERVER then
		timer.Simple(self.time_fire/4,function() if !IsValid(self) then return end self:SetScoped(false) end)
	end
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
	//if !IsFirstTimePredicted() then return end
	self:SetScoped(!self:GetScoped())

	if self:GetScoped() then
		self.scopeStart=CurTime()

		/*local effectdata = EffectData()  BLEH!
		effectdata:SetEntity(self)
		util.Effect("sniper_dot",effectdata,true,true)*/
	end
end

function SWEP:Reload()

end

function SWEP:TranslateFOV( fov )
	if self:GetScoped() then
		return 15
	end
	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:GetScoped() then
		return .1
	end
	return 1
end

function SWEP:Holster()
	self:SetScoped(false)
	return true
end

function SWEP:momo_speedMod()
	//if self.windupstart then return .478 end
	//plz do
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_sniper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_sniperrifle.mdl"

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "357"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sniper Rifle"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

SWEP.sound_fire = "weapons/sniper_shoot.wav"
SWEP.sound_reload = "weapons/sniper_worldreload.wav"

SWEP.time_fire = 1.5
SWEP.time_charge = 3.3

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Scoped")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local bullet = {}
	bullet.Src=self.Owner:GetShootPos()
	bullet.Dir=self.Owner:GetAimVector()
	bullet.Damage=50
	if self:GetScoped() then
		bullet.Damage=bullet.Damage+(math.Min(CurTime()-self.scopeStart,self.time_charge)/self.time_charge)*100
	end
	bullet.Callback = function(ply,tr,dmginfo)
		if tr.HitGroup==HITGROUP_HEAD and self:GetScoped() then
			dmginfo:ScaleDamage(3)
			self.Owner:EmitSound("player/crit_hit.wav")
		end
	end
	self.Owner:FireBullets(bullet)
	
	self:EmitSound(self.sound_fire)

	timer.Simple(self.time_fire/2,function() if !IsValid(self) then return end self:EmitSound(self.sound_reload) end)
	if SERVER then
		timer.Simple(self.time_fire/4,function() if !IsValid(self) then return end self:SetScoped(false) end)
	end
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
	//if !IsFirstTimePredicted() then return end
	self:SetScoped(!self:GetScoped())

	if self:GetScoped() then
		self.scopeStart=CurTime()

		/*local effectdata = EffectData()  BLEH!
		effectdata:SetEntity(self)
		util.Effect("sniper_dot",effectdata,true,true)*/
	end
end

function SWEP:Reload()

end

function SWEP:TranslateFOV( fov )
	if self:GetScoped() then
		return 15
	end
	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:GetScoped() then
		return .1
	end
	return 1
end

function SWEP:Holster()
	self:SetScoped(false)
	return true
end

function SWEP:momo_speedMod()
	//if self.windupstart then return .478 end
	//plz do
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_sniper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_sniperrifle.mdl"

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "357"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sniper Rifle"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

SWEP.sound_fire = "weapons/sniper_shoot.wav"
SWEP.sound_reload = "weapons/sniper_worldreload.wav"

SWEP.time_fire = 1.5
SWEP.time_charge = 3.3

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Scoped")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local bullet = {}
	bullet.Src=self.Owner:GetShootPos()
	bullet.Dir=self.Owner:GetAimVector()
	bullet.Damage=50
	if self:GetScoped() then
		bullet.Damage=bullet.Damage+(math.Min(CurTime()-self.scopeStart,self.time_charge)/self.time_charge)*100
	end
	bullet.Callback = function(ply,tr,dmginfo)
		if tr.HitGroup==HITGROUP_HEAD and self:GetScoped() then
			dmginfo:ScaleDamage(3)
			self.Owner:EmitSound("player/crit_hit.wav")
		end
	end
	self.Owner:FireBullets(bullet)
	
	self:EmitSound(self.sound_fire)

	timer.Simple(self.time_fire/2,function() if !IsValid(self) then return end self:EmitSound(self.sound_reload) end)
	if SERVER then
		timer.Simple(self.time_fire/4,function() if !IsValid(self) then return end self:SetScoped(false) end)
	end
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
	//if !IsFirstTimePredicted() then return end
	self:SetScoped(!self:GetScoped())

	if self:GetScoped() then
		self.scopeStart=CurTime()

		/*local effectdata = EffectData()  BLEH!
		effectdata:SetEntity(self)
		util.Effect("sniper_dot",effectdata,true,true)*/
	end
end

function SWEP:Reload()

end

function SWEP:TranslateFOV( fov )
	if self:GetScoped() then
		return 15
	end
	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:GetScoped() then
		return .1
	end
	return 1
end

function SWEP:Holster()
	self:SetScoped(false)
	return true
end

function SWEP:momo_speedMod()
	//if self.windupstart then return .478 end
	//plz do
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_sniper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_sniperrifle.mdl"

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "357"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sniper Rifle"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

SWEP.sound_fire = "weapons/sniper_shoot.wav"
SWEP.sound_reload = "weapons/sniper_worldreload.wav"

SWEP.time_fire = 1.5
SWEP.time_charge = 3.3

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Scoped")
end

function SWEP:Initialize()
	self:SetHoldType("crossbow")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local bullet = {}
	bullet.Src=self.Owner:GetShootPos()
	bullet.Dir=self.Owner:GetAimVector()
	bullet.Damage=50
	if self:GetScoped() then
		bullet.Damage=bullet.Damage+(math.Min(CurTime()-self.scopeStart,self.time_charge)/self.time_charge)*100
	end
	bullet.Callback = function(ply,tr,dmginfo)
		if tr.HitGroup==HITGROUP_HEAD and self:GetScoped() then
			dmginfo:ScaleDamage(3)
			self.Owner:EmitSound("player/crit_hit.wav")
		end
	end
	self.Owner:FireBullets(bullet)
	
	self:EmitSound(self.sound_fire)

	timer.Simple(self.time_fire/2,function() if !IsValid(self) then return end self:EmitSound(self.sound_reload) end)
	if SERVER then
		timer.Simple(self.time_fire/4,function() if !IsValid(self) then return end self:SetScoped(false) end)
	end
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
	//if !IsFirstTimePredicted() then return end
	self:SetScoped(!self:GetScoped())

	if self:GetScoped() then
		self.scopeStart=CurTime()

		/*local effectdata = EffectData()  BLEH!
		effectdata:SetEntity(self)
		util.Effect("sniper_dot",effectdata,true,true)*/
	end
end

function SWEP:Reload()

end

function SWEP:TranslateFOV( fov )
	if self:GetScoped() then
		return 15
	end
	return fov
end

function SWEP:AdjustMouseSensitivity()
	if self:GetScoped() then
		return .1
	end
	return 1
end

function SWEP:Holster()
	self:SetScoped(false)
	return true
end

function SWEP:momo_speedMod()
	//if self.windupstart then return .478 end
	//plz do
end

