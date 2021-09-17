-- "lua\\weapons\\weapon_v2lenn_critical_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical SMG"	
SWEP.Author	= "Credits too (Nope i think nope), edited by: lenn"
SWEP.Instructions = "Left click to instant-kill someone, Right click to fire a shit-ton of grenades."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = 500
SWEP.Secondary.DefaultClip = 500
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Rain=0
SWEP.MinAmmo2= 0
SWEP.MaxAmmo2= 300
SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_smg1.mdl"
SWEP.WorldModel	= "models/weapons/w_smg1.mdl"
local ShootSound = Sound("Weapon_SMG1.Burst")
local ShootSound2 = Sound("Weapon_SMG1.Reload")
local ShootSound3 = Sound("Weapon_SMG1.Special2")


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
self:EmitSound( ShootSound3 )   
local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	
	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 50 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 2500 )
		
end	
	ent:SetOwner( self.Owner )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "smg1"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical SMG"	
SWEP.Author	= "Credits too (Nope i think nope), edited by: lenn"
SWEP.Instructions = "Left click to instant-kill someone, Right click to fire a shit-ton of grenades."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = 500
SWEP.Secondary.DefaultClip = 500
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Rain=0
SWEP.MinAmmo2= 0
SWEP.MaxAmmo2= 300
SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_smg1.mdl"
SWEP.WorldModel	= "models/weapons/w_smg1.mdl"
local ShootSound = Sound("Weapon_SMG1.Burst")
local ShootSound2 = Sound("Weapon_SMG1.Reload")
local ShootSound3 = Sound("Weapon_SMG1.Special2")


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
self:EmitSound( ShootSound3 )   
local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	
	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 50 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 2500 )
		
end	
	ent:SetOwner( self.Owner )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "smg1"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical SMG"	
SWEP.Author	= "Credits too (Nope i think nope), edited by: lenn"
SWEP.Instructions = "Left click to instant-kill someone, Right click to fire a shit-ton of grenades."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = 500
SWEP.Secondary.DefaultClip = 500
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Rain=0
SWEP.MinAmmo2= 0
SWEP.MaxAmmo2= 300
SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_smg1.mdl"
SWEP.WorldModel	= "models/weapons/w_smg1.mdl"
local ShootSound = Sound("Weapon_SMG1.Burst")
local ShootSound2 = Sound("Weapon_SMG1.Reload")
local ShootSound3 = Sound("Weapon_SMG1.Special2")


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
self:EmitSound( ShootSound3 )   
local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	
	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 50 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 2500 )
		
end	
	ent:SetOwner( self.Owner )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "smg1"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical SMG"	
SWEP.Author	= "Credits too (Nope i think nope), edited by: lenn"
SWEP.Instructions = "Left click to instant-kill someone, Right click to fire a shit-ton of grenades."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = 500
SWEP.Secondary.DefaultClip = 500
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Rain=0
SWEP.MinAmmo2= 0
SWEP.MaxAmmo2= 300
SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_smg1.mdl"
SWEP.WorldModel	= "models/weapons/w_smg1.mdl"
local ShootSound = Sound("Weapon_SMG1.Burst")
local ShootSound2 = Sound("Weapon_SMG1.Reload")
local ShootSound3 = Sound("Weapon_SMG1.Special2")


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
self:EmitSound( ShootSound3 )   
local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	
	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 50 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 2500 )
		
end	
	ent:SetOwner( self.Owner )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "smg1"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

-- "lua\\weapons\\weapon_v2lenn_critical_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName	= "A Literal Critical SMG"	
SWEP.Author	= "Credits too (Nope i think nope), edited by: lenn"
SWEP.Instructions = "Left click to instant-kill someone, Right click to fire a shit-ton of grenades."
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.Purpose = "There was a reason why we made this weapon restricted.. its crtical, and its features are deadly enough to take down giant creatures like elephants."


SWEP.Spawnable = true
SWEP.AdminOnly = true 

SWEP.Primary.ClipSize= 500
SWEP.Primary.DefaultClip= 500
SWEP.Primary.Automatic	= true 
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = 500
SWEP.Secondary.DefaultClip = 500
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Rain=0
SWEP.MinAmmo2= 0
SWEP.MaxAmmo2= 300
SWEP.MinAmmo= 0
SWEP.MaxAmmo= 500
SWEP.Slot = 2 
SWEP.SlotPos = 2 
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true
SWEP.ViewModel	= "models/weapons/v_smg1.mdl"
SWEP.WorldModel	= "models/weapons/w_smg1.mdl"
local ShootSound = Sound("Weapon_SMG1.Burst")
local ShootSound2 = Sound("Weapon_SMG1.Reload")
local ShootSound3 = Sound("Weapon_SMG1.Special2")


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
self:EmitSound( ShootSound3 )   
local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	
	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 50 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 2500 )
		
end	
	ent:SetOwner( self.Owner )
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )	
local bullet = {}
        self:EmitSound( ShootSound )
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos()
	bullet.Dir 	= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 5 )
	bullet.Tracer	= 5
	bullet.Force	= 1000 
	bullet.Damage	= 100
	bullet.AmmoType = "smg1"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:Reload()
self:EmitSound( ShootSound2 )
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

