-- "lua\\weapons\\weapon_v6lenn_test_weapon_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "ar2"

if ( CLIENT ) then


SWEP.WeaponSelectIconLetter = "B"
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox = true
SWEP.BounceWeaponIcon = false
SWEP.SwayScale = 1.0
SWEP.BobScale = 1.0
SWEP.WepSelectIcon = surface.GetTextureID( "weapons/swep" )
SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

end

SWEP.Category = "Lenn's Weapons"

SWEP.PrintName = "Test Weapon 2"
SWEP.Author = "Lenn"
SWEP.Purpose = "Typhical lenn weapon that should be here for god sakes."
SWEP.Slot = 3
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.IconLetter = "1"
SWEP.IconLetterFont = "HL2SelectIcons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ShakeWeaponSelectIcon = false

SWEP.DrawCrosshair = true
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.InfiniteAmmo = false
SWEP.UseScope = false
SWEP.WeaponDeploySpeed = .1

SWEP.Primary.Sound = Sound("weapons/irifle/fire1.wav")
SWEP.Primary.ClipSize = 60
SWEP.Primary.DefaultClip = 180
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Cone = 5
SWEP.Primary.Damage = 30
SWEP.Primary.Recoil = 5
SWEP.Primary.NumShots = 2
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.06
SWEP.Primary.Tracer = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize()
self:SetHoldType( "ar2" )
end

function SWEP:PrimaryAttack()

	  if self:CanPrimaryAttack() then
		self.Weapon:EmitSound("Weapon_AR2.Single")
		self:TakePrimaryAmmo( 1 )
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:MuzzleFlash( )
	  		local bullet = {} 
		bullet.Num = self.Primary.NumberofShots //The number of shots fired
		bullet.Src = self.Owner:GetShootPos()//Gets where the bullet comes from 
		
		bullet.Dir = self.Owner:GetAimVector() //Gets where you're aiming
                //The above, sets how far the bullets spread from each other. 
		bullet.Tracer = 1 
		bullet.TracerName = "AR2Tracer"
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo 
		bullet.Spread = Vector(0.05,0.05,0.05)
		
		self.Owner:ViewPunch(Angle(math.Rand(-0.10,-1),-1, -1)	)	
		timer.Simple(self.Primary.Delay/2, function()
		if (!IsValid(self)) or (!IsValid(self.Owner)) then return end
		self.Owner:ViewPunch(Angle( 5, 0.85, 0.02 )	)
		end)	
		
		self.Owner:FireBullets( bullet )	
		
	   end

end

function SWEP:SecondaryAttack()
	return false ----- if you do not want a secondary attack

end

-- "lua\\weapons\\weapon_v6lenn_test_weapon_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "ar2"

if ( CLIENT ) then


SWEP.WeaponSelectIconLetter = "B"
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox = true
SWEP.BounceWeaponIcon = false
SWEP.SwayScale = 1.0
SWEP.BobScale = 1.0
SWEP.WepSelectIcon = surface.GetTextureID( "weapons/swep" )
SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

end

SWEP.Category = "Lenn's Weapons"

SWEP.PrintName = "Test Weapon 2"
SWEP.Author = "Lenn"
SWEP.Purpose = "Typhical lenn weapon that should be here for god sakes."
SWEP.Slot = 3
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.IconLetter = "1"
SWEP.IconLetterFont = "HL2SelectIcons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ShakeWeaponSelectIcon = false

SWEP.DrawCrosshair = true
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.InfiniteAmmo = false
SWEP.UseScope = false
SWEP.WeaponDeploySpeed = .1

SWEP.Primary.Sound = Sound("weapons/irifle/fire1.wav")
SWEP.Primary.ClipSize = 60
SWEP.Primary.DefaultClip = 180
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Cone = 5
SWEP.Primary.Damage = 30
SWEP.Primary.Recoil = 5
SWEP.Primary.NumShots = 2
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.06
SWEP.Primary.Tracer = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize()
self:SetHoldType( "ar2" )
end

function SWEP:PrimaryAttack()

	  if self:CanPrimaryAttack() then
		self.Weapon:EmitSound("Weapon_AR2.Single")
		self:TakePrimaryAmmo( 1 )
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:MuzzleFlash( )
	  		local bullet = {} 
		bullet.Num = self.Primary.NumberofShots //The number of shots fired
		bullet.Src = self.Owner:GetShootPos()//Gets where the bullet comes from 
		
		bullet.Dir = self.Owner:GetAimVector() //Gets where you're aiming
                //The above, sets how far the bullets spread from each other. 
		bullet.Tracer = 1 
		bullet.TracerName = "AR2Tracer"
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo 
		bullet.Spread = Vector(0.05,0.05,0.05)
		
		self.Owner:ViewPunch(Angle(math.Rand(-0.10,-1),-1, -1)	)	
		timer.Simple(self.Primary.Delay/2, function()
		if (!IsValid(self)) or (!IsValid(self.Owner)) then return end
		self.Owner:ViewPunch(Angle( 5, 0.85, 0.02 )	)
		end)	
		
		self.Owner:FireBullets( bullet )	
		
	   end

end

function SWEP:SecondaryAttack()
	return false ----- if you do not want a secondary attack

end

-- "lua\\weapons\\weapon_v6lenn_test_weapon_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "ar2"

if ( CLIENT ) then


SWEP.WeaponSelectIconLetter = "B"
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox = true
SWEP.BounceWeaponIcon = false
SWEP.SwayScale = 1.0
SWEP.BobScale = 1.0
SWEP.WepSelectIcon = surface.GetTextureID( "weapons/swep" )
SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

end

SWEP.Category = "Lenn's Weapons"

SWEP.PrintName = "Test Weapon 2"
SWEP.Author = "Lenn"
SWEP.Purpose = "Typhical lenn weapon that should be here for god sakes."
SWEP.Slot = 3
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.IconLetter = "1"
SWEP.IconLetterFont = "HL2SelectIcons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ShakeWeaponSelectIcon = false

SWEP.DrawCrosshair = true
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.InfiniteAmmo = false
SWEP.UseScope = false
SWEP.WeaponDeploySpeed = .1

SWEP.Primary.Sound = Sound("weapons/irifle/fire1.wav")
SWEP.Primary.ClipSize = 60
SWEP.Primary.DefaultClip = 180
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Cone = 5
SWEP.Primary.Damage = 30
SWEP.Primary.Recoil = 5
SWEP.Primary.NumShots = 2
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.06
SWEP.Primary.Tracer = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize()
self:SetHoldType( "ar2" )
end

function SWEP:PrimaryAttack()

	  if self:CanPrimaryAttack() then
		self.Weapon:EmitSound("Weapon_AR2.Single")
		self:TakePrimaryAmmo( 1 )
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:MuzzleFlash( )
	  		local bullet = {} 
		bullet.Num = self.Primary.NumberofShots //The number of shots fired
		bullet.Src = self.Owner:GetShootPos()//Gets where the bullet comes from 
		
		bullet.Dir = self.Owner:GetAimVector() //Gets where you're aiming
                //The above, sets how far the bullets spread from each other. 
		bullet.Tracer = 1 
		bullet.TracerName = "AR2Tracer"
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo 
		bullet.Spread = Vector(0.05,0.05,0.05)
		
		self.Owner:ViewPunch(Angle(math.Rand(-0.10,-1),-1, -1)	)	
		timer.Simple(self.Primary.Delay/2, function()
		if (!IsValid(self)) or (!IsValid(self.Owner)) then return end
		self.Owner:ViewPunch(Angle( 5, 0.85, 0.02 )	)
		end)	
		
		self.Owner:FireBullets( bullet )	
		
	   end

end

function SWEP:SecondaryAttack()
	return false ----- if you do not want a secondary attack

end

-- "lua\\weapons\\weapon_v6lenn_test_weapon_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "ar2"

if ( CLIENT ) then


SWEP.WeaponSelectIconLetter = "B"
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox = true
SWEP.BounceWeaponIcon = false
SWEP.SwayScale = 1.0
SWEP.BobScale = 1.0
SWEP.WepSelectIcon = surface.GetTextureID( "weapons/swep" )
SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

end

SWEP.Category = "Lenn's Weapons"

SWEP.PrintName = "Test Weapon 2"
SWEP.Author = "Lenn"
SWEP.Purpose = "Typhical lenn weapon that should be here for god sakes."
SWEP.Slot = 3
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.IconLetter = "1"
SWEP.IconLetterFont = "HL2SelectIcons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ShakeWeaponSelectIcon = false

SWEP.DrawCrosshair = true
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.InfiniteAmmo = false
SWEP.UseScope = false
SWEP.WeaponDeploySpeed = .1

SWEP.Primary.Sound = Sound("weapons/irifle/fire1.wav")
SWEP.Primary.ClipSize = 60
SWEP.Primary.DefaultClip = 180
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Cone = 5
SWEP.Primary.Damage = 30
SWEP.Primary.Recoil = 5
SWEP.Primary.NumShots = 2
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.06
SWEP.Primary.Tracer = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize()
self:SetHoldType( "ar2" )
end

function SWEP:PrimaryAttack()

	  if self:CanPrimaryAttack() then
		self.Weapon:EmitSound("Weapon_AR2.Single")
		self:TakePrimaryAmmo( 1 )
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:MuzzleFlash( )
	  		local bullet = {} 
		bullet.Num = self.Primary.NumberofShots //The number of shots fired
		bullet.Src = self.Owner:GetShootPos()//Gets where the bullet comes from 
		
		bullet.Dir = self.Owner:GetAimVector() //Gets where you're aiming
                //The above, sets how far the bullets spread from each other. 
		bullet.Tracer = 1 
		bullet.TracerName = "AR2Tracer"
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo 
		bullet.Spread = Vector(0.05,0.05,0.05)
		
		self.Owner:ViewPunch(Angle(math.Rand(-0.10,-1),-1, -1)	)	
		timer.Simple(self.Primary.Delay/2, function()
		if (!IsValid(self)) or (!IsValid(self.Owner)) then return end
		self.Owner:ViewPunch(Angle( 5, 0.85, 0.02 )	)
		end)	
		
		self.Owner:FireBullets( bullet )	
		
	   end

end

function SWEP:SecondaryAttack()
	return false ----- if you do not want a secondary attack

end

-- "lua\\weapons\\weapon_v6lenn_test_weapon_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "ar2"

if ( CLIENT ) then


SWEP.WeaponSelectIconLetter = "B"
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox = true
SWEP.BounceWeaponIcon = false
SWEP.SwayScale = 1.0
SWEP.BobScale = 1.0
SWEP.WepSelectIcon = surface.GetTextureID( "weapons/swep" )
SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

end

SWEP.Category = "Lenn's Weapons"

SWEP.PrintName = "Test Weapon 2"
SWEP.Author = "Lenn"
SWEP.Purpose = "Typhical lenn weapon that should be here for god sakes."
SWEP.Slot = 3
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.IconLetter = "1"
SWEP.IconLetterFont = "HL2SelectIcons"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ShakeWeaponSelectIcon = false

SWEP.DrawCrosshair = true
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.InfiniteAmmo = false
SWEP.UseScope = false
SWEP.WeaponDeploySpeed = .1

SWEP.Primary.Sound = Sound("weapons/irifle/fire1.wav")
SWEP.Primary.ClipSize = 60
SWEP.Primary.DefaultClip = 180
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Cone = 5
SWEP.Primary.Damage = 30
SWEP.Primary.Recoil = 5
SWEP.Primary.NumShots = 2
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.06
SWEP.Primary.Tracer = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize()
self:SetHoldType( "ar2" )
end

function SWEP:PrimaryAttack()

	  if self:CanPrimaryAttack() then
		self.Weapon:EmitSound("Weapon_AR2.Single")
		self:TakePrimaryAmmo( 1 )
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:MuzzleFlash( )
	  		local bullet = {} 
		bullet.Num = self.Primary.NumberofShots //The number of shots fired
		bullet.Src = self.Owner:GetShootPos()//Gets where the bullet comes from 
		
		bullet.Dir = self.Owner:GetAimVector() //Gets where you're aiming
                //The above, sets how far the bullets spread from each other. 
		bullet.Tracer = 1 
		bullet.TracerName = "AR2Tracer"
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo 
		bullet.Spread = Vector(0.05,0.05,0.05)
		
		self.Owner:ViewPunch(Angle(math.Rand(-0.10,-1),-1, -1)	)	
		timer.Simple(self.Primary.Delay/2, function()
		if (!IsValid(self)) or (!IsValid(self.Owner)) then return end
		self.Owner:ViewPunch(Angle( 5, 0.85, 0.02 )	)
		end)	
		
		self.Owner:FireBullets( bullet )	
		
	   end

end

function SWEP:SecondaryAttack()
	return false ----- if you do not want a secondary attack

end

