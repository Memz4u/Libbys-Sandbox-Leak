-- "lua\\weapons\\weapon_v6lenn_spammer_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Spammer 2.0"			
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

SWEP.Purpose                = "Just improved version of spammer. shoots rockets faster, increased ammo"
SWEP.Instructions            = "Press right click to shoot the rocket launcher and blow something up."

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "Weapon_RPG.Single"
SWEP.Primary.Damage = 100 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 2  // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 20// The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.25  // How long time before you can fire again 
SWEP.Primary.Force = 1000 // The force of the shot 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "false"
SWEP.Secondary.Damage = 0 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 0 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 0 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = false // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.0 // How long time before you can fire again 
SWEP.Secondary.Force = 0 // The force of the shot 
SWEP.Secondary.Cone = 1 




 
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
		bullet.Tracer = 0 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 

 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
        if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*1000)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 
			

function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 220

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


-- "lua\\weapons\\weapon_v6lenn_spammer_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Spammer 2.0"			
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

SWEP.Purpose                = "Just improved version of spammer. shoots rockets faster, increased ammo"
SWEP.Instructions            = "Press right click to shoot the rocket launcher and blow something up."

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "Weapon_RPG.Single"
SWEP.Primary.Damage = 100 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 2  // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 20// The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.25  // How long time before you can fire again 
SWEP.Primary.Force = 1000 // The force of the shot 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "false"
SWEP.Secondary.Damage = 0 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 0 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 0 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = false // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.0 // How long time before you can fire again 
SWEP.Secondary.Force = 0 // The force of the shot 
SWEP.Secondary.Cone = 1 




 
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
		bullet.Tracer = 0 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 

 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
        if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*1000)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 
			

function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 220

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


-- "lua\\weapons\\weapon_v6lenn_spammer_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Spammer 2.0"			
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

SWEP.Purpose                = "Just improved version of spammer. shoots rockets faster, increased ammo"
SWEP.Instructions            = "Press right click to shoot the rocket launcher and blow something up."

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "Weapon_RPG.Single"
SWEP.Primary.Damage = 100 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 2  // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 20// The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.25  // How long time before you can fire again 
SWEP.Primary.Force = 1000 // The force of the shot 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "false"
SWEP.Secondary.Damage = 0 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 0 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 0 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = false // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.0 // How long time before you can fire again 
SWEP.Secondary.Force = 0 // The force of the shot 
SWEP.Secondary.Cone = 1 




 
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
		bullet.Tracer = 0 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 

 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
        if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*1000)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 
			

function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 220

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


-- "lua\\weapons\\weapon_v6lenn_spammer_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Spammer 2.0"			
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

SWEP.Purpose                = "Just improved version of spammer. shoots rockets faster, increased ammo"
SWEP.Instructions            = "Press right click to shoot the rocket launcher and blow something up."

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "Weapon_RPG.Single"
SWEP.Primary.Damage = 100 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 2  // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 20// The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.25  // How long time before you can fire again 
SWEP.Primary.Force = 1000 // The force of the shot 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "false"
SWEP.Secondary.Damage = 0 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 0 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 0 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = false // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.0 // How long time before you can fire again 
SWEP.Secondary.Force = 0 // The force of the shot 
SWEP.Secondary.Cone = 1 




 
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
		bullet.Tracer = 0 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 

 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
        if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*1000)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 
			

function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 220

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


-- "lua\\weapons\\weapon_v6lenn_spammer_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Spammer 2.0"			
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

SWEP.Purpose                = "Just improved version of spammer. shoots rockets faster, increased ammo"
SWEP.Instructions            = "Press right click to shoot the rocket launcher and blow something up."

SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "Weapon_RPG.Single"
SWEP.Primary.Damage = 100 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 2  // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 20// The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.25  // How long time before you can fire again 
SWEP.Primary.Force = 1000 // The force of the shot 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "false"
SWEP.Secondary.Damage = 0 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 0 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 0 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = false // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.0 // How long time before you can fire again 
SWEP.Secondary.Force = 0 // The force of the shot 
SWEP.Secondary.Cone = 1 




 
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
		bullet.Tracer = 0 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 

 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
        if SERVER then
	local rocket = ents.Create("rpg_missile")
			rocket:SetPos( self.Owner:GetShootPos()+self.Owner:GetAimVector()*50 )
			rocket:SetAngles( self.Owner:GetAngles() )
                                                rocket:SetVelocity(self.Owner:GetAimVector()*1000)
			rocket:SetOwner( self.Owner )
			rocket:Spawn()
			rocket:SetSaveValue( "m_flDamage", 200 )
                        self:EmitSound(Sound(self.Primary.Sound)) 
                        self.Owner:FireBullets( bullet ) 
                        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		        self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
end 
			

function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 150
SWEP.RunSpeed = 220

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


