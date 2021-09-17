-- "addons\\diduknow\\lua\\weapons\\pktfw_base_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_scattergun.mdl"

SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Buckshot"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Initialize()
	self:SetHoldType("shotgun")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:SetClip1(self:Clip1()+1)
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo)-1,self.Primary.Ammo)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_scattergun.mdl"

SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Buckshot"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Initialize()
	self:SetHoldType("shotgun")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:SetClip1(self:Clip1()+1)
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo)-1,self.Primary.Ammo)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_scattergun.mdl"

SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Buckshot"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Initialize()
	self:SetHoldType("shotgun")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:SetClip1(self:Clip1()+1)
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo)-1,self.Primary.Ammo)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_scattergun.mdl"

SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Buckshot"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Initialize()
	self:SetHoldType("shotgun")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:SetClip1(self:Clip1()+1)
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo)-1,self.Primary.Ammo)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_scattergun.mdl"

SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Buckshot"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Initialize()
	self:SetHoldType("shotgun")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:SetClip1(self:Clip1()+1)
		self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo)-1,self.Primary.Ammo)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

