-- "addons\\diduknow\\lua\\weapons\\pktfw_rocketlauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Rocket Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_rocketlauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/rocket_shoot.wav"
SWEP.sound_reload = "weapons/rocket_reload.wav"

SWEP.time_fire = .8
SWEP.time_reload = .8

function SWEP:Initialize()
	self:SetHoldType("rpg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if SERVER then
		local rocket = ents.Create("pill_proj_rocket")
		rocket:SetModel("models/weapons/w_models/w_rocket.mdl")
		rocket:SetPos(self.Owner:GetShootPos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket.speed=1100
		rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
		rocket:SetParticle("rockettrail")
		rocket:Spawn()
		rocket:SetOwner(self.Owner)
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_rocketlauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Rocket Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_rocketlauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/rocket_shoot.wav"
SWEP.sound_reload = "weapons/rocket_reload.wav"

SWEP.time_fire = .8
SWEP.time_reload = .8

function SWEP:Initialize()
	self:SetHoldType("rpg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if SERVER then
		local rocket = ents.Create("pill_proj_rocket")
		rocket:SetModel("models/weapons/w_models/w_rocket.mdl")
		rocket:SetPos(self.Owner:GetShootPos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket.speed=1100
		rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
		rocket:SetParticle("rockettrail")
		rocket:Spawn()
		rocket:SetOwner(self.Owner)
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_rocketlauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Rocket Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_rocketlauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/rocket_shoot.wav"
SWEP.sound_reload = "weapons/rocket_reload.wav"

SWEP.time_fire = .8
SWEP.time_reload = .8

function SWEP:Initialize()
	self:SetHoldType("rpg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if SERVER then
		local rocket = ents.Create("pill_proj_rocket")
		rocket:SetModel("models/weapons/w_models/w_rocket.mdl")
		rocket:SetPos(self.Owner:GetShootPos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket.speed=1100
		rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
		rocket:SetParticle("rockettrail")
		rocket:Spawn()
		rocket:SetOwner(self.Owner)
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_rocketlauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Rocket Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_rocketlauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/rocket_shoot.wav"
SWEP.sound_reload = "weapons/rocket_reload.wav"

SWEP.time_fire = .8
SWEP.time_reload = .8

function SWEP:Initialize()
	self:SetHoldType("rpg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if SERVER then
		local rocket = ents.Create("pill_proj_rocket")
		rocket:SetModel("models/weapons/w_models/w_rocket.mdl")
		rocket:SetPos(self.Owner:GetShootPos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket.speed=1100
		rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
		rocket:SetParticle("rockettrail")
		rocket:Spawn()
		rocket:SetOwner(self.Owner)
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_rocketlauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Rocket Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_rocketlauncher.mdl"

SWEP.Primary.ClipSize	= 4
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "RPG_Round"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/rocket_shoot.wav"
SWEP.sound_reload = "weapons/rocket_reload.wav"

SWEP.time_fire = .8
SWEP.time_reload = .8

function SWEP:Initialize()
	self:SetHoldType("rpg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if SERVER then
		local rocket = ents.Create("pill_proj_rocket")
		rocket:SetModel("models/weapons/w_models/w_rocket.mdl")
		rocket:SetPos(self.Owner:GetShootPos())
		rocket:SetAngles(self.Owner:EyeAngles())
		rocket.speed=1100
		rocket.altExplode={particle="ExplosionCore_MidAir",sound="weapons/explode1.wav"}
		rocket:SetParticle("rockettrail")
		rocket:Spawn()
		rocket:SetOwner(self.Owner)
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

