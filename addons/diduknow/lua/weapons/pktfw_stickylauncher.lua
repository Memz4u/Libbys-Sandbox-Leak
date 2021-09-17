-- "addons\\diduknow\\lua\\weapons\\pktfw_stickylauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sticky Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_stickybomb_launcher.mdl"

SWEP.Primary.ClipSize	= 8
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Grenade"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

SWEP.sound_fire = "weapons/stickybomblauncher_shoot.wav"
SWEP.sound_reload = "weapons/stickybomblauncher_worldreload.wav"

SWEP.time_fire = .6
SWEP.time_reload = .7

function SWEP:Initialize()
	self:SetHoldType("pistol")
	//if SERVER then
		self.charge=0
		self.sound_charge = CreateSound(self,"weapons/stickybomblauncher_charge_up.wav")
	//end
end

function SWEP:OnRemove()
	//if CLIENT then return end
	self.sound_charge:Stop()
end

function SWEP:Think()
	//if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then
			self.sound_charge:Play()
			self.charge=self.charge+FrameTime()
			if self.charge>=4 then
				self:FireBomb()
				self.charge=0
				self.sound_charge:Stop()
			end
		else
			if self.charge>0 then
				if self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then self:FireBomb() end
				self.charge=0
			end
			self.sound_charge:Stop()
		end


		self:NextThink(CurTime())
		return true
	//end
end

function SWEP:Holster()
	//if SERVER then
		self.charge=0
		self.sound_charge:Stop()
	//end
	return true
end

function SWEP:FireBomb()
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_stickybomb.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=.7
		nade.sticky=true
		nade.tf2=true
		nade.speed=920+self.charge*372.5
		nade:SetParticle("stickybombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:PrimaryAttack()
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_stickylauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sticky Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_stickybomb_launcher.mdl"

SWEP.Primary.ClipSize	= 8
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Grenade"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

SWEP.sound_fire = "weapons/stickybomblauncher_shoot.wav"
SWEP.sound_reload = "weapons/stickybomblauncher_worldreload.wav"

SWEP.time_fire = .6
SWEP.time_reload = .7

function SWEP:Initialize()
	self:SetHoldType("pistol")
	//if SERVER then
		self.charge=0
		self.sound_charge = CreateSound(self,"weapons/stickybomblauncher_charge_up.wav")
	//end
end

function SWEP:OnRemove()
	//if CLIENT then return end
	self.sound_charge:Stop()
end

function SWEP:Think()
	//if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then
			self.sound_charge:Play()
			self.charge=self.charge+FrameTime()
			if self.charge>=4 then
				self:FireBomb()
				self.charge=0
				self.sound_charge:Stop()
			end
		else
			if self.charge>0 then
				if self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then self:FireBomb() end
				self.charge=0
			end
			self.sound_charge:Stop()
		end


		self:NextThink(CurTime())
		return true
	//end
end

function SWEP:Holster()
	//if SERVER then
		self.charge=0
		self.sound_charge:Stop()
	//end
	return true
end

function SWEP:FireBomb()
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_stickybomb.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=.7
		nade.sticky=true
		nade.tf2=true
		nade.speed=920+self.charge*372.5
		nade:SetParticle("stickybombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:PrimaryAttack()
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_stickylauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sticky Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_stickybomb_launcher.mdl"

SWEP.Primary.ClipSize	= 8
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Grenade"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

SWEP.sound_fire = "weapons/stickybomblauncher_shoot.wav"
SWEP.sound_reload = "weapons/stickybomblauncher_worldreload.wav"

SWEP.time_fire = .6
SWEP.time_reload = .7

function SWEP:Initialize()
	self:SetHoldType("pistol")
	//if SERVER then
		self.charge=0
		self.sound_charge = CreateSound(self,"weapons/stickybomblauncher_charge_up.wav")
	//end
end

function SWEP:OnRemove()
	//if CLIENT then return end
	self.sound_charge:Stop()
end

function SWEP:Think()
	//if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then
			self.sound_charge:Play()
			self.charge=self.charge+FrameTime()
			if self.charge>=4 then
				self:FireBomb()
				self.charge=0
				self.sound_charge:Stop()
			end
		else
			if self.charge>0 then
				if self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then self:FireBomb() end
				self.charge=0
			end
			self.sound_charge:Stop()
		end


		self:NextThink(CurTime())
		return true
	//end
end

function SWEP:Holster()
	//if SERVER then
		self.charge=0
		self.sound_charge:Stop()
	//end
	return true
end

function SWEP:FireBomb()
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_stickybomb.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=.7
		nade.sticky=true
		nade.tf2=true
		nade.speed=920+self.charge*372.5
		nade:SetParticle("stickybombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:PrimaryAttack()
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_stickylauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sticky Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_stickybomb_launcher.mdl"

SWEP.Primary.ClipSize	= 8
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Grenade"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

SWEP.sound_fire = "weapons/stickybomblauncher_shoot.wav"
SWEP.sound_reload = "weapons/stickybomblauncher_worldreload.wav"

SWEP.time_fire = .6
SWEP.time_reload = .7

function SWEP:Initialize()
	self:SetHoldType("pistol")
	//if SERVER then
		self.charge=0
		self.sound_charge = CreateSound(self,"weapons/stickybomblauncher_charge_up.wav")
	//end
end

function SWEP:OnRemove()
	//if CLIENT then return end
	self.sound_charge:Stop()
end

function SWEP:Think()
	//if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then
			self.sound_charge:Play()
			self.charge=self.charge+FrameTime()
			if self.charge>=4 then
				self:FireBomb()
				self.charge=0
				self.sound_charge:Stop()
			end
		else
			if self.charge>0 then
				if self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then self:FireBomb() end
				self.charge=0
			end
			self.sound_charge:Stop()
		end


		self:NextThink(CurTime())
		return true
	//end
end

function SWEP:Holster()
	//if SERVER then
		self.charge=0
		self.sound_charge:Stop()
	//end
	return true
end

function SWEP:FireBomb()
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_stickybomb.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=.7
		nade.sticky=true
		nade.tf2=true
		nade.speed=920+self.charge*372.5
		nade:SetParticle("stickybombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:PrimaryAttack()
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

-- "addons\\diduknow\\lua\\weapons\\pktfw_stickylauncher.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Sticky Launcher"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_stickybomb_launcher.mdl"

SWEP.Primary.ClipSize	= 8
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "Grenade"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

SWEP.sound_fire = "weapons/stickybomblauncher_shoot.wav"
SWEP.sound_reload = "weapons/stickybomblauncher_worldreload.wav"

SWEP.time_fire = .6
SWEP.time_reload = .7

function SWEP:Initialize()
	self:SetHoldType("pistol")
	//if SERVER then
		self.charge=0
		self.sound_charge = CreateSound(self,"weapons/stickybomblauncher_charge_up.wav")
	//end
end

function SWEP:OnRemove()
	//if CLIENT then return end
	self.sound_charge:Stop()
end

function SWEP:Think()
	//if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) and self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then
			self.sound_charge:Play()
			self.charge=self.charge+FrameTime()
			if self.charge>=4 then
				self:FireBomb()
				self.charge=0
				self.sound_charge:Stop()
			end
		else
			if self.charge>0 then
				if self:CanPrimaryAttack() and CurTime()>=self:GetNextPrimaryFire() then self:FireBomb() end
				self.charge=0
			end
			self.sound_charge:Stop()
		end


		self:NextThink(CurTime())
		return true
	//end
end

function SWEP:Holster()
	//if SERVER then
		self.charge=0
		self.sound_charge:Stop()
	//end
	return true
end

function SWEP:FireBomb()
	if SERVER then
		local nade = ents.Create("pill_proj_bomb")
		nade:SetModel("models/weapons/w_models/w_stickybomb.mdl")
		nade:SetPos(self.Owner:GetShootPos())
		nade:SetAngles(self.Owner:EyeAngles())
		nade.fuse=.7
		nade.sticky=true
		nade.tf2=true
		nade.speed=920+self.charge*372.5
		nade:SetParticle("stickybombtrail_red")
		nade:Spawn()
		nade:SetOwner(self.Owner)
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self:EmitSound(self.sound_fire)
	
	self:TakePrimaryAmmo(1)

	self:SetNextPrimaryFire(CurTime() + self.time_fire)
end

function SWEP:PrimaryAttack()
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

