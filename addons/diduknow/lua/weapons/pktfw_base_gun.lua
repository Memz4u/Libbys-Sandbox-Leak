-- "addons\\diduknow\\lua\\weapons\\pktfw_base_gun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"

SWEP.Primary.Automatic		= true
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Category = "Pill Pack Weapons - TF2"

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count or 1, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_gun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"

SWEP.Primary.Automatic		= true
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Category = "Pill Pack Weapons - TF2"

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count or 1, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_gun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"

SWEP.Primary.Automatic		= true
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Category = "Pill Pack Weapons - TF2"

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count or 1, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_gun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"

SWEP.Primary.Automatic		= true
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Category = "Pill Pack Weapons - TF2"

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count or 1, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_base_gun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"

SWEP.Primary.Automatic		= true
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Category = "Pill Pack Weapons - TF2"

function SWEP:Initialize()
	self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end

	self:ShootBullet(self.bullet_dmg, self.bullet_count or 1, self.bullet_spread)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end

	local pill_ent = pk_pills.getMappedEnt(self.Owner)
	if IsValid(pill_ent) and pill_ent.iscloaked then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound(self.sound_reload)
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

