-- "lua\\weapons\\weapon_v3lenn_a_epiccal_shrinker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include('shared.lua')

SWEP.PrintName = "The Shrinker"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Category = "Lenn's Weapons (RARE)"
SWEP.DrawCrosshair = true


AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua') 
SWEP.Author = "DerHobbyTroller"
SWEP.Instructions = "Shoot some Ar2 Orbs"
SWEP.Spawnable = true 
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_irifle_dx7.mdl" 
SWEP.WorldModel = "models/weapons/w_irifle.mdl" 
SWEP.HoldType = "pistol" 
SWEP.Base = "weapon_base"
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Damage	= 900
SWEP.Primary.NumShots = 1
SWEP.Secondary.Recoil = 0.05
SWEP.Secondary.Damage = 99999999
SWEP.Primary.Cone = 0.0
SWEP.Primary.Sound = Sound("weapons/ar2/ar2_altfire.wav")
SWEP.Primary.Delay = 0.50

ReloadSound = Sound("weapons/ar2/ar2_reload.wav")
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

function SWEP:Initialize()
	if ( SERVER ) then 
		self:SetWeaponHoldType("pistol")
		AddCSLuaFile("shared.lua")
	end
	util.PrecacheSound("weapons/ar2/ar2_altfire.wav")
	util.PrecacheSound("weapons/ar2/ar2_reload.wav")
end

function SWEP:Think()
end

function SWEP:Deploy()
	return true
end

function SWEP:PrimaryAttack()
	Available1 = true
	if not IsValid(self) then 
		Available1 = false
	else if not IsValid(self.Weapon) then 
		Available1 = false
	else if not IsValid(self.Owner) then
		Available1 = false
	end	end	end
	
	if not Available1 then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "5" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end

function SWEP:SecondaryAttack()
	Available = false
	if not IsValid(self) then 
		Available = false
	else if not IsValid(self.Weapon) then 
		Available = false
	else if not IsValid(self.Owner) then
		Available = false
	end	end	end
	
	if not Available then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "3" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 330

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v3lenn_a_epiccal_shrinker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include('shared.lua')

SWEP.PrintName = "The Shrinker"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Category = "Lenn's Weapons (RARE)"
SWEP.DrawCrosshair = true


AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua') 
SWEP.Author = "DerHobbyTroller"
SWEP.Instructions = "Shoot some Ar2 Orbs"
SWEP.Spawnable = true 
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_irifle_dx7.mdl" 
SWEP.WorldModel = "models/weapons/w_irifle.mdl" 
SWEP.HoldType = "pistol" 
SWEP.Base = "weapon_base"
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Damage	= 900
SWEP.Primary.NumShots = 1
SWEP.Secondary.Recoil = 0.05
SWEP.Secondary.Damage = 99999999
SWEP.Primary.Cone = 0.0
SWEP.Primary.Sound = Sound("weapons/ar2/ar2_altfire.wav")
SWEP.Primary.Delay = 0.50

ReloadSound = Sound("weapons/ar2/ar2_reload.wav")
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

function SWEP:Initialize()
	if ( SERVER ) then 
		self:SetWeaponHoldType("pistol")
		AddCSLuaFile("shared.lua")
	end
	util.PrecacheSound("weapons/ar2/ar2_altfire.wav")
	util.PrecacheSound("weapons/ar2/ar2_reload.wav")
end

function SWEP:Think()
end

function SWEP:Deploy()
	return true
end

function SWEP:PrimaryAttack()
	Available1 = true
	if not IsValid(self) then 
		Available1 = false
	else if not IsValid(self.Weapon) then 
		Available1 = false
	else if not IsValid(self.Owner) then
		Available1 = false
	end	end	end
	
	if not Available1 then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "5" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end

function SWEP:SecondaryAttack()
	Available = false
	if not IsValid(self) then 
		Available = false
	else if not IsValid(self.Weapon) then 
		Available = false
	else if not IsValid(self.Owner) then
		Available = false
	end	end	end
	
	if not Available then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "3" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 330

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v3lenn_a_epiccal_shrinker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include('shared.lua')

SWEP.PrintName = "The Shrinker"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Category = "Lenn's Weapons (RARE)"
SWEP.DrawCrosshair = true


AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua') 
SWEP.Author = "DerHobbyTroller"
SWEP.Instructions = "Shoot some Ar2 Orbs"
SWEP.Spawnable = true 
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_irifle_dx7.mdl" 
SWEP.WorldModel = "models/weapons/w_irifle.mdl" 
SWEP.HoldType = "pistol" 
SWEP.Base = "weapon_base"
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Damage	= 900
SWEP.Primary.NumShots = 1
SWEP.Secondary.Recoil = 0.05
SWEP.Secondary.Damage = 99999999
SWEP.Primary.Cone = 0.0
SWEP.Primary.Sound = Sound("weapons/ar2/ar2_altfire.wav")
SWEP.Primary.Delay = 0.50

ReloadSound = Sound("weapons/ar2/ar2_reload.wav")
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

function SWEP:Initialize()
	if ( SERVER ) then 
		self:SetWeaponHoldType("pistol")
		AddCSLuaFile("shared.lua")
	end
	util.PrecacheSound("weapons/ar2/ar2_altfire.wav")
	util.PrecacheSound("weapons/ar2/ar2_reload.wav")
end

function SWEP:Think()
end

function SWEP:Deploy()
	return true
end

function SWEP:PrimaryAttack()
	Available1 = true
	if not IsValid(self) then 
		Available1 = false
	else if not IsValid(self.Weapon) then 
		Available1 = false
	else if not IsValid(self.Owner) then
		Available1 = false
	end	end	end
	
	if not Available1 then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "5" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end

function SWEP:SecondaryAttack()
	Available = false
	if not IsValid(self) then 
		Available = false
	else if not IsValid(self.Weapon) then 
		Available = false
	else if not IsValid(self.Owner) then
		Available = false
	end	end	end
	
	if not Available then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "3" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 330

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v3lenn_a_epiccal_shrinker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include('shared.lua')

SWEP.PrintName = "The Shrinker"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Category = "Lenn's Weapons (RARE)"
SWEP.DrawCrosshair = true


AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua') 
SWEP.Author = "DerHobbyTroller"
SWEP.Instructions = "Shoot some Ar2 Orbs"
SWEP.Spawnable = true 
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_irifle_dx7.mdl" 
SWEP.WorldModel = "models/weapons/w_irifle.mdl" 
SWEP.HoldType = "pistol" 
SWEP.Base = "weapon_base"
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Damage	= 900
SWEP.Primary.NumShots = 1
SWEP.Secondary.Recoil = 0.05
SWEP.Secondary.Damage = 99999999
SWEP.Primary.Cone = 0.0
SWEP.Primary.Sound = Sound("weapons/ar2/ar2_altfire.wav")
SWEP.Primary.Delay = 0.50

ReloadSound = Sound("weapons/ar2/ar2_reload.wav")
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

function SWEP:Initialize()
	if ( SERVER ) then 
		self:SetWeaponHoldType("pistol")
		AddCSLuaFile("shared.lua")
	end
	util.PrecacheSound("weapons/ar2/ar2_altfire.wav")
	util.PrecacheSound("weapons/ar2/ar2_reload.wav")
end

function SWEP:Think()
end

function SWEP:Deploy()
	return true
end

function SWEP:PrimaryAttack()
	Available1 = true
	if not IsValid(self) then 
		Available1 = false
	else if not IsValid(self.Weapon) then 
		Available1 = false
	else if not IsValid(self.Owner) then
		Available1 = false
	end	end	end
	
	if not Available1 then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "5" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end

function SWEP:SecondaryAttack()
	Available = false
	if not IsValid(self) then 
		Available = false
	else if not IsValid(self.Weapon) then 
		Available = false
	else if not IsValid(self.Owner) then
		Available = false
	end	end	end
	
	if not Available then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "3" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 330

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v3lenn_a_epiccal_shrinker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include('shared.lua')

SWEP.PrintName = "The Shrinker"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Category = "Lenn's Weapons (RARE)"
SWEP.DrawCrosshair = true


AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua') 
SWEP.Author = "DerHobbyTroller"
SWEP.Instructions = "Shoot some Ar2 Orbs"
SWEP.Spawnable = true 
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/v_irifle_dx7.mdl" 
SWEP.WorldModel = "models/weapons/w_irifle.mdl" 
SWEP.HoldType = "pistol" 
SWEP.Base = "weapon_base"
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Damage	= 900
SWEP.Primary.NumShots = 1
SWEP.Secondary.Recoil = 0.05
SWEP.Secondary.Damage = 99999999
SWEP.Primary.Cone = 0.0
SWEP.Primary.Sound = Sound("weapons/ar2/ar2_altfire.wav")
SWEP.Primary.Delay = 0.50

ReloadSound = Sound("weapons/ar2/ar2_reload.wav")
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

function SWEP:Initialize()
	if ( SERVER ) then 
		self:SetWeaponHoldType("pistol")
		AddCSLuaFile("shared.lua")
	end
	util.PrecacheSound("weapons/ar2/ar2_altfire.wav")
	util.PrecacheSound("weapons/ar2/ar2_reload.wav")
end

function SWEP:Think()
end

function SWEP:Deploy()
	return true
end

function SWEP:PrimaryAttack()
	Available1 = true
	if not IsValid(self) then 
		Available1 = false
	else if not IsValid(self.Weapon) then 
		Available1 = false
	else if not IsValid(self.Owner) then
		Available1 = false
	end	end	end
	
	if not Available1 then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "5" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end

function SWEP:SecondaryAttack()
	Available = false
	if not IsValid(self) then 
		Available = false
	else if not IsValid(self.Weapon) then 
		Available = false
	else if not IsValid(self.Owner) then
		Available = false
	end	end	end
	
	if not Available then return end
	
	
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
		if !self.Owner:KeyDown(IN_RELOAD) then
			self.Weapon:EmitSound(self.Primary.Sound)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Owner:MuzzleFlash()
			if CLIENT then return end
			local cballspawner = ents.Create( "point_combine_ball_launcher" )
			cballspawner:SetOwner(self.Owner)
			cballspawner:SetAngles( self.Owner:GetAngles())
			cballspawner:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector()*130)
			cballspawner:SetKeyValue( "minspeed",500 )
			cballspawner:SetKeyValue( "maxspeed", 1000 )
			cballspawner:SetKeyValue( "ballradius", "15" )
			cballspawner:SetKeyValue( "ballcount", "1" )
			cballspawner:SetKeyValue( "maxballbounces", "3" )
			cballspawner:SetKeyValue( "launchconenoise", 0 )
			cballspawner:Spawn()
			cballspawner:Activate()
			cballspawner:Fire( "LaunchBall",2,0)
			cballspawner:Fire("kill","",0)
			self.Weapon:SetNextPrimaryFire(CurTime()+self.Primary.Delay) 
		end
	end
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 330

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
return true
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

