-- "lua\\weapons\\weapon_v6lenn_laser_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser Shotgun"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "What? A shotgun that shoots lasers, wow. how strong is it? Very strong, shall i say? not good for taking your enemys down, but it REALLY HURTS."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/stunstick/stunstick_fleshhit1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 2.5  // How much damage the weapon does at its max (NEW VERSION) We need more damage!!!!!!!!!
SWEP.Primary.TakeAmmo = 5 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 15 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/stunstick/stunstick_fleshhit2.wav"
SWEP.Secondary.Damage = 5 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 10  // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 45 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 200  // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.50 // How much we should punch the view 
SWEP.Secondary.Delay = 3 // How long time before you can fire again 
SWEP.Secondary.Force = 1 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

//SWEP:SecondaryFire\\
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Secondary.Spread * 0.1 , self.Secondary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*100)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


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




// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 260

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

-- "lua\\weapons\\weapon_v6lenn_laser_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser Shotgun"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "What? A shotgun that shoots lasers, wow. how strong is it? Very strong, shall i say? not good for taking your enemys down, but it REALLY HURTS."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/stunstick/stunstick_fleshhit1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 2.5  // How much damage the weapon does at its max (NEW VERSION) We need more damage!!!!!!!!!
SWEP.Primary.TakeAmmo = 5 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 15 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/stunstick/stunstick_fleshhit2.wav"
SWEP.Secondary.Damage = 5 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 10  // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 45 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 200  // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.50 // How much we should punch the view 
SWEP.Secondary.Delay = 3 // How long time before you can fire again 
SWEP.Secondary.Force = 1 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

//SWEP:SecondaryFire\\
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Secondary.Spread * 0.1 , self.Secondary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*100)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


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




// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 260

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

-- "lua\\weapons\\weapon_v6lenn_laser_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser Shotgun"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "What? A shotgun that shoots lasers, wow. how strong is it? Very strong, shall i say? not good for taking your enemys down, but it REALLY HURTS."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/stunstick/stunstick_fleshhit1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 2.5  // How much damage the weapon does at its max (NEW VERSION) We need more damage!!!!!!!!!
SWEP.Primary.TakeAmmo = 5 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 15 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/stunstick/stunstick_fleshhit2.wav"
SWEP.Secondary.Damage = 5 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 10  // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 45 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 200  // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.50 // How much we should punch the view 
SWEP.Secondary.Delay = 3 // How long time before you can fire again 
SWEP.Secondary.Force = 1 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

//SWEP:SecondaryFire\\
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Secondary.Spread * 0.1 , self.Secondary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*100)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


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




// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 260

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

-- "lua\\weapons\\weapon_v6lenn_laser_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser Shotgun"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "What? A shotgun that shoots lasers, wow. how strong is it? Very strong, shall i say? not good for taking your enemys down, but it REALLY HURTS."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/stunstick/stunstick_fleshhit1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 2.5  // How much damage the weapon does at its max (NEW VERSION) We need more damage!!!!!!!!!
SWEP.Primary.TakeAmmo = 5 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 15 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/stunstick/stunstick_fleshhit2.wav"
SWEP.Secondary.Damage = 5 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 10  // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 45 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 200  // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.50 // How much we should punch the view 
SWEP.Secondary.Delay = 3 // How long time before you can fire again 
SWEP.Secondary.Force = 1 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

//SWEP:SecondaryFire\\
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Secondary.Spread * 0.1 , self.Secondary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*100)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


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




// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 260

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

-- "lua\\weapons\\weapon_v6lenn_laser_shotgun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser Shotgun"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "What? A shotgun that shoots lasers, wow. how strong is it? Very strong, shall i say? not good for taking your enemys down, but it REALLY HURTS."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/stunstick/stunstick_fleshhit1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 2.5  // How much damage the weapon does at its max (NEW VERSION) We need more damage!!!!!!!!!
SWEP.Primary.TakeAmmo = 5 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 15 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/stunstick/stunstick_fleshhit2.wav"
SWEP.Secondary.Damage = 5 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 10  // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 45 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 200  // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.50 // How much we should punch the view 
SWEP.Secondary.Delay = 3 // How long time before you can fire again 
SWEP.Secondary.Force = 1 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

//SWEP:SecondaryFire\\
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Secondary.Spread * 0.1 , self.Secondary.Spread * 0.1, 0) 
		bullet.Tracer = 1
                bullet.TracerName = "ToolTracer"
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 				
	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*100)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
     self:SetColor(Color(29, 0, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


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




// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 260

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

