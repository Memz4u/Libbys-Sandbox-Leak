-- "lua\\weapons\\weapon_v2lenn_critical_pulse_rifle.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical Pulse-Rifle"	
SWEP.Author	= "credits too Nope i think nope. edited by lenn"
SWEP.Instructions = "Left click to instant-kill someone, right click to fire a bunch of fucking ar2 orbs."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "ar2"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_IRifle.mdl"
SWEP.WorldModel	= "models/weapons/w_IRifle.mdl"
local ShootSound = Sound("Weapon_AR2.Single")
local ShootSound2 = Sound("Weapon_AR2.Reload")


function SWEP:PrimaryAttack()
 if (self:Clip1() > self.MinAmmo) then
self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )	
self:ShootBullet()
end
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self.Owner:SetAnimation(PLAYER_ATTACK1)
self.Owner:EmitSound(Sound("weapons/physcannon/energy_bounce1.wav"))     
local cballspawner = ents.Create( "point_combine_ball_launcher" )
cballspawner:SetAngles( self.Owner:GetAngles())
cballspawner:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector()*10)
cballspawner:SetKeyValue( "minspeed",1200 )
cballspawner:SetKeyValue( "maxspeed", 1200 )
cballspawner:SetKeyValue( "ballradius", "15" )
cballspawner:SetKeyValue( "ballcount", "1" )
cballspawner:SetKeyValue( "maxballbounces", "1" )
cballspawner:SetKeyValue( "launchconenoise", 5 )
cballspawner:Fire( "LaunchBall" )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
        bullet.TracerName = "Ar2Tracer"
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "IRifle"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_pulse_rifle.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical Pulse-Rifle"	
SWEP.Author	= "credits too Nope i think nope. edited by lenn"
SWEP.Instructions = "Left click to instant-kill someone, right click to fire a bunch of fucking ar2 orbs."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "ar2"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_IRifle.mdl"
SWEP.WorldModel	= "models/weapons/w_IRifle.mdl"
local ShootSound = Sound("Weapon_AR2.Single")
local ShootSound2 = Sound("Weapon_AR2.Reload")


function SWEP:PrimaryAttack()
 if (self:Clip1() > self.MinAmmo) then
self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )	
self:ShootBullet()
end
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self.Owner:SetAnimation(PLAYER_ATTACK1)
self.Owner:EmitSound(Sound("weapons/physcannon/energy_bounce1.wav"))     
local cballspawner = ents.Create( "point_combine_ball_launcher" )
cballspawner:SetAngles( self.Owner:GetAngles())
cballspawner:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector()*10)
cballspawner:SetKeyValue( "minspeed",1200 )
cballspawner:SetKeyValue( "maxspeed", 1200 )
cballspawner:SetKeyValue( "ballradius", "15" )
cballspawner:SetKeyValue( "ballcount", "1" )
cballspawner:SetKeyValue( "maxballbounces", "1" )
cballspawner:SetKeyValue( "launchconenoise", 5 )
cballspawner:Fire( "LaunchBall" )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
        bullet.TracerName = "Ar2Tracer"
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "IRifle"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_pulse_rifle.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical Pulse-Rifle"	
SWEP.Author	= "credits too Nope i think nope. edited by lenn"
SWEP.Instructions = "Left click to instant-kill someone, right click to fire a bunch of fucking ar2 orbs."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "ar2"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_IRifle.mdl"
SWEP.WorldModel	= "models/weapons/w_IRifle.mdl"
local ShootSound = Sound("Weapon_AR2.Single")
local ShootSound2 = Sound("Weapon_AR2.Reload")


function SWEP:PrimaryAttack()
 if (self:Clip1() > self.MinAmmo) then
self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )	
self:ShootBullet()
end
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self.Owner:SetAnimation(PLAYER_ATTACK1)
self.Owner:EmitSound(Sound("weapons/physcannon/energy_bounce1.wav"))     
local cballspawner = ents.Create( "point_combine_ball_launcher" )
cballspawner:SetAngles( self.Owner:GetAngles())
cballspawner:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector()*10)
cballspawner:SetKeyValue( "minspeed",1200 )
cballspawner:SetKeyValue( "maxspeed", 1200 )
cballspawner:SetKeyValue( "ballradius", "15" )
cballspawner:SetKeyValue( "ballcount", "1" )
cballspawner:SetKeyValue( "maxballbounces", "1" )
cballspawner:SetKeyValue( "launchconenoise", 5 )
cballspawner:Fire( "LaunchBall" )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
        bullet.TracerName = "Ar2Tracer"
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "IRifle"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_pulse_rifle.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical Pulse-Rifle"	
SWEP.Author	= "credits too Nope i think nope. edited by lenn"
SWEP.Instructions = "Left click to instant-kill someone, right click to fire a bunch of fucking ar2 orbs."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "ar2"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_IRifle.mdl"
SWEP.WorldModel	= "models/weapons/w_IRifle.mdl"
local ShootSound = Sound("Weapon_AR2.Single")
local ShootSound2 = Sound("Weapon_AR2.Reload")


function SWEP:PrimaryAttack()
 if (self:Clip1() > self.MinAmmo) then
self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )	
self:ShootBullet()
end
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self.Owner:SetAnimation(PLAYER_ATTACK1)
self.Owner:EmitSound(Sound("weapons/physcannon/energy_bounce1.wav"))     
local cballspawner = ents.Create( "point_combine_ball_launcher" )
cballspawner:SetAngles( self.Owner:GetAngles())
cballspawner:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector()*10)
cballspawner:SetKeyValue( "minspeed",1200 )
cballspawner:SetKeyValue( "maxspeed", 1200 )
cballspawner:SetKeyValue( "ballradius", "15" )
cballspawner:SetKeyValue( "ballcount", "1" )
cballspawner:SetKeyValue( "maxballbounces", "1" )
cballspawner:SetKeyValue( "launchconenoise", 5 )
cballspawner:Fire( "LaunchBall" )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
        bullet.TracerName = "Ar2Tracer"
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "IRifle"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_pulse_rifle.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical Pulse-Rifle"	
SWEP.Author	= "credits too Nope i think nope. edited by lenn"
SWEP.Instructions = "Left click to instant-kill someone, right click to fire a bunch of fucking ar2 orbs."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "ar2"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_IRifle.mdl"
SWEP.WorldModel	= "models/weapons/w_IRifle.mdl"
local ShootSound = Sound("Weapon_AR2.Single")
local ShootSound2 = Sound("Weapon_AR2.Reload")


function SWEP:PrimaryAttack()
 if (self:Clip1() > self.MinAmmo) then
self.Weapon:SetClip1( self.Weapon:Clip1() - 1 )
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )	
self:ShootBullet()
end
end

function SWEP:SecondaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self.Owner:SetAnimation(PLAYER_ATTACK1)
self.Owner:EmitSound(Sound("weapons/physcannon/energy_bounce1.wav"))     
local cballspawner = ents.Create( "point_combine_ball_launcher" )
cballspawner:SetAngles( self.Owner:GetAngles())
cballspawner:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector()*10)
cballspawner:SetKeyValue( "minspeed",1200 )
cballspawner:SetKeyValue( "maxspeed", 1200 )
cballspawner:SetKeyValue( "ballradius", "15" )
cballspawner:SetKeyValue( "ballcount", "1" )
cballspawner:SetKeyValue( "maxballbounces", "1" )
cballspawner:SetKeyValue( "launchconenoise", 5 )
cballspawner:Fire( "LaunchBall" )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
        bullet.TracerName = "Ar2Tracer"
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "IRifle"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

