-- "lua\\weapons\\weapon_lenn_laser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.PrintName		= "The Laser AR2"
SWEP.Slot		                   = 3
SWEP.SlotPos		= 5		
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair		= true		
SWEP.ViewModel		= "models/weapons/v_irifle.mdl"	
SWEP.WorldModel		= "models/weapons/w_irifle.mdl"	
SWEP.ReloadSound		= "Weapon_AR2.Reload"	
SWEP.HoldType		= "ar2"			
-- Other settings
SWEP.Weight		= 4			
SWEP.AutoSwitchTo		= false			
SWEP.Spawnable		= true		
 
-- Weapon info
SWEP.Author		= "Created by Lenn"			
SWEP.Purpose		= "Automatic very rapid fast firing AR2. Like a laser. Does less damage but becareful. when you shoot it automatically. its a pain in the ass! |UPDATE 5/10/2019| Increased primary delay. Sound changed. |UPDATE 5/11/2019| Damage increased. Ammo increased."	
SWEP.Instructions	= "Shoot your weapon by pressing left click. Reload by pressing R, Make a extreme shot by pressing right click."		

-- Primary fire settings
SWEP.Primary.Sound			= "Weapon_PhysCannon.Launch"	
SWEP.Primary.Damage		= 8
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Recoil			= 0			
SWEP.Primary.Cone			= 0		
SWEP.Primary.Delay			= 0.03
SWEP.Primary.ClipSize		= 400	
SWEP.Primary.DefaultClip	                  = 1000	
SWEP.Primary.Tracer			= 2			
SWEP.Primary.Force			= 50	
SWEP.Primary.Automatic		= 4	
SWEP.Primary.Ammo		= "AR2"	
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Category 			= "Lenn's Weapons"


-- Secondary fire settings
SWEP.Secondary.Sound		= "Weapon_PhysCannon.Launch"
SWEP.Secondary.Damage		= 100			
SWEP.Secondary.NumShots		= 20		
SWEP.Secondary.Recoil		= 2.5			
SWEP.Secondary.Cone		= 1			
SWEP.Secondary.Delay		= 5			
SWEP.Secondary.ClipSize		= 50		
SWEP.Secondary.DefaultClip	                  = 100			
SWEP.Secondary.Tracer		= 1			
SWEP.Secondary.Force		= 100			
SWEP.Secondary.Automatic	           	= 4
SWEP.Secondary.Ammo		= "ar2"	
SWEP.Secondary.Spread = 0
SWEP.Secondary.TakeAmmo = 20

//SWEP:Initialize\\ 
function SWEP:Initialize() 
 self:SetHoldType( "rpg" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

//SWEP:PrimaryFire\\ 

function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer
                                    bullet.TracerName = "ToolTracer"				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()		
	if ( !self:CanSecondaryAttack() ) then return end	
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Secondary.NumShots			
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Secondary.Cone / 90, self.Secondary.Cone / 90, 0 )	
		bullet.Tracer = self.Secondary.Tracer	
                                    bullet.TracerName = "ToolTracer"		
		bullet.Force = self.Secondary.Force				
		bullet.Damage = self.Secondary.Damage			
		bullet.AmmoType = self.Secondary.Ammo			
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))	
	self.Owner:ViewPunch(Angle( -self.Secondary.Recoil, 0, 0 ))
	if (self.Secondary.TakeAmmoPerBullet) then			
		self:TakeSecondaryAmmo(self.Secondary.NumShots)
	else
		self:TakeSecondaryAmmo(1)
	end
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )	
end

function SWEP:Think()				
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 300

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


-- "lua\\weapons\\weapon_lenn_laser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.PrintName		= "The Laser AR2"
SWEP.Slot		                   = 3
SWEP.SlotPos		= 5		
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair		= true		
SWEP.ViewModel		= "models/weapons/v_irifle.mdl"	
SWEP.WorldModel		= "models/weapons/w_irifle.mdl"	
SWEP.ReloadSound		= "Weapon_AR2.Reload"	
SWEP.HoldType		= "ar2"			
-- Other settings
SWEP.Weight		= 4			
SWEP.AutoSwitchTo		= false			
SWEP.Spawnable		= true		
 
-- Weapon info
SWEP.Author		= "Created by Lenn"			
SWEP.Purpose		= "Automatic very rapid fast firing AR2. Like a laser. Does less damage but becareful. when you shoot it automatically. its a pain in the ass! |UPDATE 5/10/2019| Increased primary delay. Sound changed. |UPDATE 5/11/2019| Damage increased. Ammo increased."	
SWEP.Instructions	= "Shoot your weapon by pressing left click. Reload by pressing R, Make a extreme shot by pressing right click."		

-- Primary fire settings
SWEP.Primary.Sound			= "Weapon_PhysCannon.Launch"	
SWEP.Primary.Damage		= 8
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Recoil			= 0			
SWEP.Primary.Cone			= 0		
SWEP.Primary.Delay			= 0.03
SWEP.Primary.ClipSize		= 400	
SWEP.Primary.DefaultClip	                  = 1000	
SWEP.Primary.Tracer			= 2			
SWEP.Primary.Force			= 50	
SWEP.Primary.Automatic		= 4	
SWEP.Primary.Ammo		= "AR2"	
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Category 			= "Lenn's Weapons"


-- Secondary fire settings
SWEP.Secondary.Sound		= "Weapon_PhysCannon.Launch"
SWEP.Secondary.Damage		= 100			
SWEP.Secondary.NumShots		= 20		
SWEP.Secondary.Recoil		= 2.5			
SWEP.Secondary.Cone		= 1			
SWEP.Secondary.Delay		= 5			
SWEP.Secondary.ClipSize		= 50		
SWEP.Secondary.DefaultClip	                  = 100			
SWEP.Secondary.Tracer		= 1			
SWEP.Secondary.Force		= 100			
SWEP.Secondary.Automatic	           	= 4
SWEP.Secondary.Ammo		= "ar2"	
SWEP.Secondary.Spread = 0
SWEP.Secondary.TakeAmmo = 20

//SWEP:Initialize\\ 
function SWEP:Initialize() 
 self:SetHoldType( "rpg" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

//SWEP:PrimaryFire\\ 

function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer
                                    bullet.TracerName = "ToolTracer"				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()		
	if ( !self:CanSecondaryAttack() ) then return end	
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Secondary.NumShots			
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Secondary.Cone / 90, self.Secondary.Cone / 90, 0 )	
		bullet.Tracer = self.Secondary.Tracer	
                                    bullet.TracerName = "ToolTracer"		
		bullet.Force = self.Secondary.Force				
		bullet.Damage = self.Secondary.Damage			
		bullet.AmmoType = self.Secondary.Ammo			
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))	
	self.Owner:ViewPunch(Angle( -self.Secondary.Recoil, 0, 0 ))
	if (self.Secondary.TakeAmmoPerBullet) then			
		self:TakeSecondaryAmmo(self.Secondary.NumShots)
	else
		self:TakeSecondaryAmmo(1)
	end
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )	
end

function SWEP:Think()				
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 300

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


-- "lua\\weapons\\weapon_lenn_laser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.PrintName		= "The Laser AR2"
SWEP.Slot		                   = 3
SWEP.SlotPos		= 5		
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair		= true		
SWEP.ViewModel		= "models/weapons/v_irifle.mdl"	
SWEP.WorldModel		= "models/weapons/w_irifle.mdl"	
SWEP.ReloadSound		= "Weapon_AR2.Reload"	
SWEP.HoldType		= "ar2"			
-- Other settings
SWEP.Weight		= 4			
SWEP.AutoSwitchTo		= false			
SWEP.Spawnable		= true		
 
-- Weapon info
SWEP.Author		= "Created by Lenn"			
SWEP.Purpose		= "Automatic very rapid fast firing AR2. Like a laser. Does less damage but becareful. when you shoot it automatically. its a pain in the ass! |UPDATE 5/10/2019| Increased primary delay. Sound changed. |UPDATE 5/11/2019| Damage increased. Ammo increased."	
SWEP.Instructions	= "Shoot your weapon by pressing left click. Reload by pressing R, Make a extreme shot by pressing right click."		

-- Primary fire settings
SWEP.Primary.Sound			= "Weapon_PhysCannon.Launch"	
SWEP.Primary.Damage		= 8
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Recoil			= 0			
SWEP.Primary.Cone			= 0		
SWEP.Primary.Delay			= 0.03
SWEP.Primary.ClipSize		= 400	
SWEP.Primary.DefaultClip	                  = 1000	
SWEP.Primary.Tracer			= 2			
SWEP.Primary.Force			= 50	
SWEP.Primary.Automatic		= 4	
SWEP.Primary.Ammo		= "AR2"	
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Category 			= "Lenn's Weapons"


-- Secondary fire settings
SWEP.Secondary.Sound		= "Weapon_PhysCannon.Launch"
SWEP.Secondary.Damage		= 100			
SWEP.Secondary.NumShots		= 20		
SWEP.Secondary.Recoil		= 2.5			
SWEP.Secondary.Cone		= 1			
SWEP.Secondary.Delay		= 5			
SWEP.Secondary.ClipSize		= 50		
SWEP.Secondary.DefaultClip	                  = 100			
SWEP.Secondary.Tracer		= 1			
SWEP.Secondary.Force		= 100			
SWEP.Secondary.Automatic	           	= 4
SWEP.Secondary.Ammo		= "ar2"	
SWEP.Secondary.Spread = 0
SWEP.Secondary.TakeAmmo = 20

//SWEP:Initialize\\ 
function SWEP:Initialize() 
 self:SetHoldType( "rpg" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

//SWEP:PrimaryFire\\ 

function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer
                                    bullet.TracerName = "ToolTracer"				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()		
	if ( !self:CanSecondaryAttack() ) then return end	
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Secondary.NumShots			
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Secondary.Cone / 90, self.Secondary.Cone / 90, 0 )	
		bullet.Tracer = self.Secondary.Tracer	
                                    bullet.TracerName = "ToolTracer"		
		bullet.Force = self.Secondary.Force				
		bullet.Damage = self.Secondary.Damage			
		bullet.AmmoType = self.Secondary.Ammo			
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))	
	self.Owner:ViewPunch(Angle( -self.Secondary.Recoil, 0, 0 ))
	if (self.Secondary.TakeAmmoPerBullet) then			
		self:TakeSecondaryAmmo(self.Secondary.NumShots)
	else
		self:TakeSecondaryAmmo(1)
	end
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )	
end

function SWEP:Think()				
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 300

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


-- "lua\\weapons\\weapon_lenn_laser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.PrintName		= "The Laser AR2"
SWEP.Slot		                   = 3
SWEP.SlotPos		= 5		
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair		= true		
SWEP.ViewModel		= "models/weapons/v_irifle.mdl"	
SWEP.WorldModel		= "models/weapons/w_irifle.mdl"	
SWEP.ReloadSound		= "Weapon_AR2.Reload"	
SWEP.HoldType		= "ar2"			
-- Other settings
SWEP.Weight		= 4			
SWEP.AutoSwitchTo		= false			
SWEP.Spawnable		= true		
 
-- Weapon info
SWEP.Author		= "Created by Lenn"			
SWEP.Purpose		= "Automatic very rapid fast firing AR2. Like a laser. Does less damage but becareful. when you shoot it automatically. its a pain in the ass! |UPDATE 5/10/2019| Increased primary delay. Sound changed. |UPDATE 5/11/2019| Damage increased. Ammo increased."	
SWEP.Instructions	= "Shoot your weapon by pressing left click. Reload by pressing R, Make a extreme shot by pressing right click."		

-- Primary fire settings
SWEP.Primary.Sound			= "Weapon_PhysCannon.Launch"	
SWEP.Primary.Damage		= 8
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Recoil			= 0			
SWEP.Primary.Cone			= 0		
SWEP.Primary.Delay			= 0.03
SWEP.Primary.ClipSize		= 400	
SWEP.Primary.DefaultClip	                  = 1000	
SWEP.Primary.Tracer			= 2			
SWEP.Primary.Force			= 50	
SWEP.Primary.Automatic		= 4	
SWEP.Primary.Ammo		= "AR2"	
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Category 			= "Lenn's Weapons"


-- Secondary fire settings
SWEP.Secondary.Sound		= "Weapon_PhysCannon.Launch"
SWEP.Secondary.Damage		= 100			
SWEP.Secondary.NumShots		= 20		
SWEP.Secondary.Recoil		= 2.5			
SWEP.Secondary.Cone		= 1			
SWEP.Secondary.Delay		= 5			
SWEP.Secondary.ClipSize		= 50		
SWEP.Secondary.DefaultClip	                  = 100			
SWEP.Secondary.Tracer		= 1			
SWEP.Secondary.Force		= 100			
SWEP.Secondary.Automatic	           	= 4
SWEP.Secondary.Ammo		= "ar2"	
SWEP.Secondary.Spread = 0
SWEP.Secondary.TakeAmmo = 20

//SWEP:Initialize\\ 
function SWEP:Initialize() 
 self:SetHoldType( "rpg" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

//SWEP:PrimaryFire\\ 

function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer
                                    bullet.TracerName = "ToolTracer"				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()		
	if ( !self:CanSecondaryAttack() ) then return end	
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Secondary.NumShots			
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Secondary.Cone / 90, self.Secondary.Cone / 90, 0 )	
		bullet.Tracer = self.Secondary.Tracer	
                                    bullet.TracerName = "ToolTracer"		
		bullet.Force = self.Secondary.Force				
		bullet.Damage = self.Secondary.Damage			
		bullet.AmmoType = self.Secondary.Ammo			
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))	
	self.Owner:ViewPunch(Angle( -self.Secondary.Recoil, 0, 0 ))
	if (self.Secondary.TakeAmmoPerBullet) then			
		self:TakeSecondaryAmmo(self.Secondary.NumShots)
	else
		self:TakeSecondaryAmmo(1)
	end
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )	
end

function SWEP:Think()				
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 300

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


-- "lua\\weapons\\weapon_lenn_laser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.PrintName		= "The Laser AR2"
SWEP.Slot		                   = 3
SWEP.SlotPos		= 5		
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair		= true		
SWEP.ViewModel		= "models/weapons/v_irifle.mdl"	
SWEP.WorldModel		= "models/weapons/w_irifle.mdl"	
SWEP.ReloadSound		= "Weapon_AR2.Reload"	
SWEP.HoldType		= "ar2"			
-- Other settings
SWEP.Weight		= 4			
SWEP.AutoSwitchTo		= false			
SWEP.Spawnable		= true		
 
-- Weapon info
SWEP.Author		= "Created by Lenn"			
SWEP.Purpose		= "Automatic very rapid fast firing AR2. Like a laser. Does less damage but becareful. when you shoot it automatically. its a pain in the ass! |UPDATE 5/10/2019| Increased primary delay. Sound changed. |UPDATE 5/11/2019| Damage increased. Ammo increased."	
SWEP.Instructions	= "Shoot your weapon by pressing left click. Reload by pressing R, Make a extreme shot by pressing right click."		

-- Primary fire settings
SWEP.Primary.Sound			= "Weapon_PhysCannon.Launch"	
SWEP.Primary.Damage		= 8
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Recoil			= 0			
SWEP.Primary.Cone			= 0		
SWEP.Primary.Delay			= 0.03
SWEP.Primary.ClipSize		= 400	
SWEP.Primary.DefaultClip	                  = 1000	
SWEP.Primary.Tracer			= 2			
SWEP.Primary.Force			= 50	
SWEP.Primary.Automatic		= 4	
SWEP.Primary.Ammo		= "AR2"	
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Category 			= "Lenn's Weapons"


-- Secondary fire settings
SWEP.Secondary.Sound		= "Weapon_PhysCannon.Launch"
SWEP.Secondary.Damage		= 100			
SWEP.Secondary.NumShots		= 20		
SWEP.Secondary.Recoil		= 2.5			
SWEP.Secondary.Cone		= 1			
SWEP.Secondary.Delay		= 5			
SWEP.Secondary.ClipSize		= 50		
SWEP.Secondary.DefaultClip	                  = 100			
SWEP.Secondary.Tracer		= 1			
SWEP.Secondary.Force		= 100			
SWEP.Secondary.Automatic	           	= 4
SWEP.Secondary.Ammo		= "ar2"	
SWEP.Secondary.Spread = 0
SWEP.Secondary.TakeAmmo = 20

//SWEP:Initialize\\ 
function SWEP:Initialize() 
 self:SetHoldType( "rpg" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

//SWEP:PrimaryFire\\ 

function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer
                                    bullet.TracerName = "ToolTracer"				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()		
	if ( !self:CanSecondaryAttack() ) then return end	
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Secondary.NumShots			
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Secondary.Cone / 90, self.Secondary.Cone / 90, 0 )	
		bullet.Tracer = self.Secondary.Tracer	
                                    bullet.TracerName = "ToolTracer"		
		bullet.Force = self.Secondary.Force				
		bullet.Damage = self.Secondary.Damage			
		bullet.AmmoType = self.Secondary.Ammo			
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))	
	self.Owner:ViewPunch(Angle( -self.Secondary.Recoil, 0, 0 ))
	if (self.Secondary.TakeAmmoPerBullet) then			
		self:TakeSecondaryAmmo(self.Secondary.NumShots)
	else
		self:TakeSecondaryAmmo(1)
	end
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )	
end

function SWEP:Think()				
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 300

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


