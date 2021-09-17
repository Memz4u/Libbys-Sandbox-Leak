-- "addons\\diduknow\\lua\\weapons\\pktfw_syringegun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Syringe Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_syringegun.mdl"

SWEP.Primary.ClipSize	= 40
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/syringegun_shoot.wav"
SWEP.sound_reload = "weapons/syringegun_worldreload.wav"

SWEP.time_fire=.1
SWEP.time_reload=1.6

function SWEP:Initialize()
	self:SetHoldType("smg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local spread = 2

	if SERVER then
		local needle = ents.Create("pill_proj_arrow")
		needle:SetModel("models/weapons/w_models/w_syringe_proj.mdl")
		needle:SetPos(self.Owner:GetShootPos())
		needle:SetAngles(self.Owner:EyeAngles()+Angle(math.Rand(-spread,spread),math.Rand(-spread,spread),0))
		needle.damage=10
		needle.speed=1000
		needle.particle="nailtrails_medic_red"
		needle:Spawn()
		needle:SetOwner(self.Owner)
	end

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
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_syringegun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Syringe Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_syringegun.mdl"

SWEP.Primary.ClipSize	= 40
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/syringegun_shoot.wav"
SWEP.sound_reload = "weapons/syringegun_worldreload.wav"

SWEP.time_fire=.1
SWEP.time_reload=1.6

function SWEP:Initialize()
	self:SetHoldType("smg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local spread = 2

	if SERVER then
		local needle = ents.Create("pill_proj_arrow")
		needle:SetModel("models/weapons/w_models/w_syringe_proj.mdl")
		needle:SetPos(self.Owner:GetShootPos())
		needle:SetAngles(self.Owner:EyeAngles()+Angle(math.Rand(-spread,spread),math.Rand(-spread,spread),0))
		needle.damage=10
		needle.speed=1000
		needle.particle="nailtrails_medic_red"
		needle:Spawn()
		needle:SetOwner(self.Owner)
	end

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
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_syringegun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Syringe Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_syringegun.mdl"

SWEP.Primary.ClipSize	= 40
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/syringegun_shoot.wav"
SWEP.sound_reload = "weapons/syringegun_worldreload.wav"

SWEP.time_fire=.1
SWEP.time_reload=1.6

function SWEP:Initialize()
	self:SetHoldType("smg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local spread = 2

	if SERVER then
		local needle = ents.Create("pill_proj_arrow")
		needle:SetModel("models/weapons/w_models/w_syringe_proj.mdl")
		needle:SetPos(self.Owner:GetShootPos())
		needle:SetAngles(self.Owner:EyeAngles()+Angle(math.Rand(-spread,spread),math.Rand(-spread,spread),0))
		needle.damage=10
		needle.speed=1000
		needle.particle="nailtrails_medic_red"
		needle:Spawn()
		needle:SetOwner(self.Owner)
	end

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
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_syringegun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Syringe Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_syringegun.mdl"

SWEP.Primary.ClipSize	= 40
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/syringegun_shoot.wav"
SWEP.sound_reload = "weapons/syringegun_worldreload.wav"

SWEP.time_fire=.1
SWEP.time_reload=1.6

function SWEP:Initialize()
	self:SetHoldType("smg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local spread = 2

	if SERVER then
		local needle = ents.Create("pill_proj_arrow")
		needle:SetModel("models/weapons/w_models/w_syringe_proj.mdl")
		needle:SetPos(self.Owner:GetShootPos())
		needle:SetAngles(self.Owner:EyeAngles()+Angle(math.Rand(-spread,spread),math.Rand(-spread,spread),0))
		needle.damage=10
		needle.speed=1000
		needle.particle="nailtrails_medic_red"
		needle:Spawn()
		needle:SetOwner(self.Owner)
	end

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
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_syringegun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Syringe Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_syringegun.mdl"

SWEP.Primary.ClipSize	= 40
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=2

SWEP.sound_fire = "weapons/syringegun_shoot.wav"
SWEP.sound_reload = "weapons/syringegun_worldreload.wav"

SWEP.time_fire=.1
SWEP.time_reload=1.6

function SWEP:Initialize()
	self:SetHoldType("smg")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	local spread = 2

	if SERVER then
		local needle = ents.Create("pill_proj_arrow")
		needle:SetModel("models/weapons/w_models/w_syringe_proj.mdl")
		needle:SetPos(self.Owner:GetShootPos())
		needle:SetAngles(self.Owner:EyeAngles()+Angle(math.Rand(-spread,spread),math.Rand(-spread,spread),0))
		needle.damage=10
		needle.speed=1000
		needle.particle="nailtrails_medic_red"
		needle:Spawn()
		needle:SetOwner(self.Owner)
	end

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
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + self.time_reload
		self:SetNextPrimaryFire(CurTime() + self.time_reload)
	end
end

