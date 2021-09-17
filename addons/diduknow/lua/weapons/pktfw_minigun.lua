-- "addons\\diduknow\\lua\\weapons\\pktfw_minigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_minigun.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Minigun"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:Initialize()
	self:SetHoldType("slam")

	self.sound_shoot = CreateSound(self,"weapons/minigun_shoot.wav")
	self.sound_spin = CreateSound(self,"weapons/minigun_spin.wav")
	self.sound_windup = CreateSound(self,"weapons/minigun_wind_up.wav")
	self.sound_winddown = CreateSound(self,"weapons/minigun_wind_down.wav")

	//if SERVER then
		self.lastattack = 0
		//self.windupstart = -1
	//end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	self.primaryAttackCalled=true

	if CurTime()<self.lastattack+.1 or !self.windupstart or self.windupstart+.87>CurTime() then return end

	self:ShootBullet(9, 1, 0.04)
	
	self:TakePrimaryAmmo(1)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self.lastattack=CurTime()

	//self:SetNextPrimaryFire(CurTime() + .1)
end

function SWEP:SecondaryAttack()
	self.secondaryAttackCalled=true
end

//if SERVER then
	function SWEP:Think()
			/*if self.lastShot+.11>=CurTime() then
				if !self.sound_shoot:IsPlaying() then
					self.sound_shoot:Play()
				end
			else
				if self.sound_shoot:IsPlaying() then
					self.sound_shoot:Stop()
				end
			end*/
		/*if self.primaryAttackCalled then
			self.primaryAttackCalled=false

			if !self.sound_shoot:IsPlaying() then
				self.sound_shoot:Play()
			end
		else
			if self.sound_shoot:IsPlaying() then
				self.sound_shoot:Stop()
			end
		end*/

		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_windup:Play()
				self:SetHoldType("physgun")
				//self:EmitSound("weapons/minigun_wind_up.wav")
			end
		else
			if self.windupstart then
				self.windupstart=nil
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_winddown:Play()
				self:SetHoldType("slam")
				//self:EmitSound("weapons/minigun_wind_down.wav")
			end
		end

		if self.windupstart and self.windupstart+.87<=CurTime() then
			if self.primaryAttackCalled then
				self.sound_shoot:Play()
				self.sound_spin:Stop()
			else
				self.sound_shoot:Stop()
				self.sound_spin:Play()
			end

			/*if self:GetHoldType() != "physgun" then
				self:SetWeaponHoldType("physgun")
			end*/
		else
			self.sound_shoot:Stop()
			self.sound_spin:Stop()

			/*if self:GetHoldType() != "slam" then
				self:SetWeaponHoldType("slam")
			end*/
		end

		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end

/*else
	function SWEP:Think()
		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
			end
		else
			if self.windupstart then
				self.windupstart=nil
			end
		end
		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end
end*/

//function SWEP:Remove()

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound("weapons/pistol_worldreload.wav")
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + 1.3
		self:SetNextPrimaryFire(CurTime() + 1.3)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

function SWEP:momo_SpeedMod()
	if self.windupstart then return .478 end
end

function SWEP:OnRemove()
	self.sound_shoot:Stop()
	self.sound_spin:Stop()
	self.sound_windup:Stop()
	self.sound_winddown:Stop()
end

function SWEP:Holster()
	return !self.windupstart
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_minigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_minigun.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Minigun"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:Initialize()
	self:SetHoldType("slam")

	self.sound_shoot = CreateSound(self,"weapons/minigun_shoot.wav")
	self.sound_spin = CreateSound(self,"weapons/minigun_spin.wav")
	self.sound_windup = CreateSound(self,"weapons/minigun_wind_up.wav")
	self.sound_winddown = CreateSound(self,"weapons/minigun_wind_down.wav")

	//if SERVER then
		self.lastattack = 0
		//self.windupstart = -1
	//end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	self.primaryAttackCalled=true

	if CurTime()<self.lastattack+.1 or !self.windupstart or self.windupstart+.87>CurTime() then return end

	self:ShootBullet(9, 1, 0.04)
	
	self:TakePrimaryAmmo(1)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self.lastattack=CurTime()

	//self:SetNextPrimaryFire(CurTime() + .1)
end

function SWEP:SecondaryAttack()
	self.secondaryAttackCalled=true
end

//if SERVER then
	function SWEP:Think()
			/*if self.lastShot+.11>=CurTime() then
				if !self.sound_shoot:IsPlaying() then
					self.sound_shoot:Play()
				end
			else
				if self.sound_shoot:IsPlaying() then
					self.sound_shoot:Stop()
				end
			end*/
		/*if self.primaryAttackCalled then
			self.primaryAttackCalled=false

			if !self.sound_shoot:IsPlaying() then
				self.sound_shoot:Play()
			end
		else
			if self.sound_shoot:IsPlaying() then
				self.sound_shoot:Stop()
			end
		end*/

		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_windup:Play()
				self:SetHoldType("physgun")
				//self:EmitSound("weapons/minigun_wind_up.wav")
			end
		else
			if self.windupstart then
				self.windupstart=nil
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_winddown:Play()
				self:SetHoldType("slam")
				//self:EmitSound("weapons/minigun_wind_down.wav")
			end
		end

		if self.windupstart and self.windupstart+.87<=CurTime() then
			if self.primaryAttackCalled then
				self.sound_shoot:Play()
				self.sound_spin:Stop()
			else
				self.sound_shoot:Stop()
				self.sound_spin:Play()
			end

			/*if self:GetHoldType() != "physgun" then
				self:SetWeaponHoldType("physgun")
			end*/
		else
			self.sound_shoot:Stop()
			self.sound_spin:Stop()

			/*if self:GetHoldType() != "slam" then
				self:SetWeaponHoldType("slam")
			end*/
		end

		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end

/*else
	function SWEP:Think()
		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
			end
		else
			if self.windupstart then
				self.windupstart=nil
			end
		end
		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end
end*/

//function SWEP:Remove()

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound("weapons/pistol_worldreload.wav")
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + 1.3
		self:SetNextPrimaryFire(CurTime() + 1.3)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

function SWEP:momo_SpeedMod()
	if self.windupstart then return .478 end
end

function SWEP:OnRemove()
	self.sound_shoot:Stop()
	self.sound_spin:Stop()
	self.sound_windup:Stop()
	self.sound_winddown:Stop()
end

function SWEP:Holster()
	return !self.windupstart
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_minigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_minigun.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Minigun"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:Initialize()
	self:SetHoldType("slam")

	self.sound_shoot = CreateSound(self,"weapons/minigun_shoot.wav")
	self.sound_spin = CreateSound(self,"weapons/minigun_spin.wav")
	self.sound_windup = CreateSound(self,"weapons/minigun_wind_up.wav")
	self.sound_winddown = CreateSound(self,"weapons/minigun_wind_down.wav")

	//if SERVER then
		self.lastattack = 0
		//self.windupstart = -1
	//end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	self.primaryAttackCalled=true

	if CurTime()<self.lastattack+.1 or !self.windupstart or self.windupstart+.87>CurTime() then return end

	self:ShootBullet(9, 1, 0.04)
	
	self:TakePrimaryAmmo(1)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self.lastattack=CurTime()

	//self:SetNextPrimaryFire(CurTime() + .1)
end

function SWEP:SecondaryAttack()
	self.secondaryAttackCalled=true
end

//if SERVER then
	function SWEP:Think()
			/*if self.lastShot+.11>=CurTime() then
				if !self.sound_shoot:IsPlaying() then
					self.sound_shoot:Play()
				end
			else
				if self.sound_shoot:IsPlaying() then
					self.sound_shoot:Stop()
				end
			end*/
		/*if self.primaryAttackCalled then
			self.primaryAttackCalled=false

			if !self.sound_shoot:IsPlaying() then
				self.sound_shoot:Play()
			end
		else
			if self.sound_shoot:IsPlaying() then
				self.sound_shoot:Stop()
			end
		end*/

		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_windup:Play()
				self:SetHoldType("physgun")
				//self:EmitSound("weapons/minigun_wind_up.wav")
			end
		else
			if self.windupstart then
				self.windupstart=nil
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_winddown:Play()
				self:SetHoldType("slam")
				//self:EmitSound("weapons/minigun_wind_down.wav")
			end
		end

		if self.windupstart and self.windupstart+.87<=CurTime() then
			if self.primaryAttackCalled then
				self.sound_shoot:Play()
				self.sound_spin:Stop()
			else
				self.sound_shoot:Stop()
				self.sound_spin:Play()
			end

			/*if self:GetHoldType() != "physgun" then
				self:SetWeaponHoldType("physgun")
			end*/
		else
			self.sound_shoot:Stop()
			self.sound_spin:Stop()

			/*if self:GetHoldType() != "slam" then
				self:SetWeaponHoldType("slam")
			end*/
		end

		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end

/*else
	function SWEP:Think()
		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
			end
		else
			if self.windupstart then
				self.windupstart=nil
			end
		end
		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end
end*/

//function SWEP:Remove()

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound("weapons/pistol_worldreload.wav")
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + 1.3
		self:SetNextPrimaryFire(CurTime() + 1.3)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

function SWEP:momo_SpeedMod()
	if self.windupstart then return .478 end
end

function SWEP:OnRemove()
	self.sound_shoot:Stop()
	self.sound_spin:Stop()
	self.sound_windup:Stop()
	self.sound_winddown:Stop()
end

function SWEP:Holster()
	return !self.windupstart
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_minigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_minigun.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Minigun"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:Initialize()
	self:SetHoldType("slam")

	self.sound_shoot = CreateSound(self,"weapons/minigun_shoot.wav")
	self.sound_spin = CreateSound(self,"weapons/minigun_spin.wav")
	self.sound_windup = CreateSound(self,"weapons/minigun_wind_up.wav")
	self.sound_winddown = CreateSound(self,"weapons/minigun_wind_down.wav")

	//if SERVER then
		self.lastattack = 0
		//self.windupstart = -1
	//end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	self.primaryAttackCalled=true

	if CurTime()<self.lastattack+.1 or !self.windupstart or self.windupstart+.87>CurTime() then return end

	self:ShootBullet(9, 1, 0.04)
	
	self:TakePrimaryAmmo(1)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self.lastattack=CurTime()

	//self:SetNextPrimaryFire(CurTime() + .1)
end

function SWEP:SecondaryAttack()
	self.secondaryAttackCalled=true
end

//if SERVER then
	function SWEP:Think()
			/*if self.lastShot+.11>=CurTime() then
				if !self.sound_shoot:IsPlaying() then
					self.sound_shoot:Play()
				end
			else
				if self.sound_shoot:IsPlaying() then
					self.sound_shoot:Stop()
				end
			end*/
		/*if self.primaryAttackCalled then
			self.primaryAttackCalled=false

			if !self.sound_shoot:IsPlaying() then
				self.sound_shoot:Play()
			end
		else
			if self.sound_shoot:IsPlaying() then
				self.sound_shoot:Stop()
			end
		end*/

		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_windup:Play()
				self:SetHoldType("physgun")
				//self:EmitSound("weapons/minigun_wind_up.wav")
			end
		else
			if self.windupstart then
				self.windupstart=nil
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_winddown:Play()
				self:SetHoldType("slam")
				//self:EmitSound("weapons/minigun_wind_down.wav")
			end
		end

		if self.windupstart and self.windupstart+.87<=CurTime() then
			if self.primaryAttackCalled then
				self.sound_shoot:Play()
				self.sound_spin:Stop()
			else
				self.sound_shoot:Stop()
				self.sound_spin:Play()
			end

			/*if self:GetHoldType() != "physgun" then
				self:SetWeaponHoldType("physgun")
			end*/
		else
			self.sound_shoot:Stop()
			self.sound_spin:Stop()

			/*if self:GetHoldType() != "slam" then
				self:SetWeaponHoldType("slam")
			end*/
		end

		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end

/*else
	function SWEP:Think()
		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
			end
		else
			if self.windupstart then
				self.windupstart=nil
			end
		end
		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end
end*/

//function SWEP:Remove()

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound("weapons/pistol_worldreload.wav")
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + 1.3
		self:SetNextPrimaryFire(CurTime() + 1.3)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

function SWEP:momo_SpeedMod()
	if self.windupstart then return .478 end
end

function SWEP:OnRemove()
	self.sound_shoot:Stop()
	self.sound_spin:Stop()
	self.sound_windup:Stop()
	self.sound_winddown:Stop()
end

function SWEP:Holster()
	return !self.windupstart
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_minigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_minigun.mdl"

SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Minigun"
SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Slot=2

function SWEP:Initialize()
	self:SetHoldType("slam")

	self.sound_shoot = CreateSound(self,"weapons/minigun_shoot.wav")
	self.sound_spin = CreateSound(self,"weapons/minigun_spin.wav")
	self.sound_windup = CreateSound(self,"weapons/minigun_wind_up.wav")
	self.sound_winddown = CreateSound(self,"weapons/minigun_wind_down.wav")

	//if SERVER then
		self.lastattack = 0
		//self.windupstart = -1
	//end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end

	self.primaryAttackCalled=true

	if CurTime()<self.lastattack+.1 or !self.windupstart or self.windupstart+.87>CurTime() then return end

	self:ShootBullet(9, 1, 0.04)
	
	self:TakePrimaryAmmo(1)

	self.Owner:SetAnimation(PLAYER_ATTACK1)

	self.lastattack=CurTime()

	//self:SetNextPrimaryFire(CurTime() + .1)
end

function SWEP:SecondaryAttack()
	self.secondaryAttackCalled=true
end

//if SERVER then
	function SWEP:Think()
			/*if self.lastShot+.11>=CurTime() then
				if !self.sound_shoot:IsPlaying() then
					self.sound_shoot:Play()
				end
			else
				if self.sound_shoot:IsPlaying() then
					self.sound_shoot:Stop()
				end
			end*/
		/*if self.primaryAttackCalled then
			self.primaryAttackCalled=false

			if !self.sound_shoot:IsPlaying() then
				self.sound_shoot:Play()
			end
		else
			if self.sound_shoot:IsPlaying() then
				self.sound_shoot:Stop()
			end
		end*/

		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_windup:Play()
				self:SetHoldType("physgun")
				//self:EmitSound("weapons/minigun_wind_up.wav")
			end
		else
			if self.windupstart then
				self.windupstart=nil
				self.sound_windup:Stop()
				self.sound_winddown:Stop()
				self.sound_winddown:Play()
				self:SetHoldType("slam")
				//self:EmitSound("weapons/minigun_wind_down.wav")
			end
		end

		if self.windupstart and self.windupstart+.87<=CurTime() then
			if self.primaryAttackCalled then
				self.sound_shoot:Play()
				self.sound_spin:Stop()
			else
				self.sound_shoot:Stop()
				self.sound_spin:Play()
			end

			/*if self:GetHoldType() != "physgun" then
				self:SetWeaponHoldType("physgun")
			end*/
		else
			self.sound_shoot:Stop()
			self.sound_spin:Stop()

			/*if self:GetHoldType() != "slam" then
				self:SetWeaponHoldType("slam")
			end*/
		end

		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end

/*else
	function SWEP:Think()
		if self.primaryAttackCalled or self.secondaryAttackCalled then
			if !self.windupstart then
				self.windupstart=CurTime()
			end
		else
			if self.windupstart then
				self.windupstart=nil
			end
		end
		self.primaryAttackCalled = false
		self.secondaryAttackCalled = false
	end
end*/

//function SWEP:Remove()

function SWEP:Reload()
	/*if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if (self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:EmitSound("weapons/pistol_worldreload.wav")
		self:DefaultReload(ACT_INVALID)
		self.ReloadingTime = CurTime() + 1.3
		self:SetNextPrimaryFire(CurTime() + 1.3)
	end*/
end

function SWEP:CanPrimaryAttack()
	if self:Clip1() <= 0 then
		return false
	end

	return true
end

function SWEP:momo_SpeedMod()
	if self.windupstart then return .478 end
end

function SWEP:OnRemove()
	self.sound_shoot:Stop()
	self.sound_spin:Stop()
	self.sound_windup:Stop()
	self.sound_winddown:Stop()
end

function SWEP:Holster()
	return !self.windupstart
end

