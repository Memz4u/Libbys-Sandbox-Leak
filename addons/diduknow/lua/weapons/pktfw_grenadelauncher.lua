-- "addons\\diduknow\\lua\\weapons\\pktfw_grenadelauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Grenade Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_grenadelauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/grenade_launcher_shoot.wav"
SWEP.sound_reload = "weapons/grenade_launcher_drum_load.wav"

SWEP.time_fire = .6
SWEP.time_reload = .6

function SWEP:Initialize()
	self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_grenade_grenadelauncher.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=2.3
		nade.tf2=true
		nade.speed=1220
		nade:SetParticle("pipebombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	

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
		self.Owner:DoReloadEvent()
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_grenadelauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Grenade Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_grenadelauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/grenade_launcher_shoot.wav"
SWEP.sound_reload = "weapons/grenade_launcher_drum_load.wav"

SWEP.time_fire = .6
SWEP.time_reload = .6

function SWEP:Initialize()
	self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_grenade_grenadelauncher.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=2.3
		nade.tf2=true
		nade.speed=1220
		nade:SetParticle("pipebombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	

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
		self.Owner:DoReloadEvent()
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_grenadelauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Grenade Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_grenadelauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/grenade_launcher_shoot.wav"
SWEP.sound_reload = "weapons/grenade_launcher_drum_load.wav"

SWEP.time_fire = .6
SWEP.time_reload = .6

function SWEP:Initialize()
	self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_grenade_grenadelauncher.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=2.3
		nade.tf2=true
		nade.speed=1220
		nade:SetParticle("pipebombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	

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
		self.Owner:DoReloadEvent()
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_grenadelauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Grenade Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_grenadelauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/grenade_launcher_shoot.wav"
SWEP.sound_reload = "weapons/grenade_launcher_drum_load.wav"

SWEP.time_fire = .6
SWEP.time_reload = .6

function SWEP:Initialize()
	self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_grenade_grenadelauncher.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=2.3
		nade.tf2=true
		nade.speed=1220
		nade:SetParticle("pipebombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	

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
		self.Owner:DoReloadEvent()
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_grenadelauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Grenade Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_grenadelauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/grenade_launcher_shoot.wav"
SWEP.sound_reload = "weapons/grenade_launcher_drum_load.wav"

SWEP.time_fire = .6
SWEP.time_reload = .6

function SWEP:Initialize()
	self:SetHoldType("ar2")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_grenade_grenadelauncher.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=2.3
		nade.tf2=true
		nade.speed=1220
		nade:SetParticle("pipebombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	

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
		self.Owner:DoReloadEvent()
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

