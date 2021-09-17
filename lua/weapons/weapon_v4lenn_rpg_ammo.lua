-- "lua\\weapons\\weapon_v4lenn_rpg_ammo.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end


if ( CLIENT ) then

	SWEP.PrintName			= "RPG / Rocket Ammo"			
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

SWEP.Purpose                = "This kind of swep will shoot ammo,"
SWEP.Instructions            = "Press right click to shoot ammo."


SWEP.ViewModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.WorldModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "SMG" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (Ammo)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 50


//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "weapons/shotgun/shotgun_cock.wav"
SWEP.Primary.Damage = 0 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 10 // The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.10 // How long time before you can fire again 
SWEP.Primary.Force = 25 // The force of the shot 

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
 
function SWEP:PrimaryAttack()

if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
        
 
	


	if ( CLIENT ) then return end
	
	local ent = ents.Create( "item_rpg_round" )

	
	if ( !IsValid( ent ) ) then return end
	
 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )	
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

	self:TakePrimaryAmmo(0)
	if self:Clip1() == 0 then
		self:Remove()
	end

end






-- "lua\\weapons\\weapon_v4lenn_rpg_ammo.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end


if ( CLIENT ) then

	SWEP.PrintName			= "RPG / Rocket Ammo"			
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

SWEP.Purpose                = "This kind of swep will shoot ammo,"
SWEP.Instructions            = "Press right click to shoot ammo."


SWEP.ViewModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.WorldModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "SMG" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (Ammo)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 50


//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "weapons/shotgun/shotgun_cock.wav"
SWEP.Primary.Damage = 0 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 10 // The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.10 // How long time before you can fire again 
SWEP.Primary.Force = 25 // The force of the shot 

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
 
function SWEP:PrimaryAttack()

if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
        
 
	


	if ( CLIENT ) then return end
	
	local ent = ents.Create( "item_rpg_round" )

	
	if ( !IsValid( ent ) ) then return end
	
 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )	
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

	self:TakePrimaryAmmo(0)
	if self:Clip1() == 0 then
		self:Remove()
	end

end






-- "lua\\weapons\\weapon_v4lenn_rpg_ammo.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end


if ( CLIENT ) then

	SWEP.PrintName			= "RPG / Rocket Ammo"			
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

SWEP.Purpose                = "This kind of swep will shoot ammo,"
SWEP.Instructions            = "Press right click to shoot ammo."


SWEP.ViewModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.WorldModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "SMG" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (Ammo)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 50


//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "weapons/shotgun/shotgun_cock.wav"
SWEP.Primary.Damage = 0 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 10 // The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.10 // How long time before you can fire again 
SWEP.Primary.Force = 25 // The force of the shot 

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
 
function SWEP:PrimaryAttack()

if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
        
 
	


	if ( CLIENT ) then return end
	
	local ent = ents.Create( "item_rpg_round" )

	
	if ( !IsValid( ent ) ) then return end
	
 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )	
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

	self:TakePrimaryAmmo(0)
	if self:Clip1() == 0 then
		self:Remove()
	end

end






-- "lua\\weapons\\weapon_v4lenn_rpg_ammo.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end


if ( CLIENT ) then

	SWEP.PrintName			= "RPG / Rocket Ammo"			
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

SWEP.Purpose                = "This kind of swep will shoot ammo,"
SWEP.Instructions            = "Press right click to shoot ammo."


SWEP.ViewModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.WorldModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "SMG" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (Ammo)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 50


//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "weapons/shotgun/shotgun_cock.wav"
SWEP.Primary.Damage = 0 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 10 // The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.10 // How long time before you can fire again 
SWEP.Primary.Force = 25 // The force of the shot 

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
 
function SWEP:PrimaryAttack()

if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
        
 
	


	if ( CLIENT ) then return end
	
	local ent = ents.Create( "item_rpg_round" )

	
	if ( !IsValid( ent ) ) then return end
	
 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )	
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

	self:TakePrimaryAmmo(0)
	if self:Clip1() == 0 then
		self:Remove()
	end

end






-- "lua\\weapons\\weapon_v4lenn_rpg_ammo.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end


if ( CLIENT ) then

	SWEP.PrintName			= "RPG / Rocket Ammo"			
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

SWEP.Purpose                = "This kind of swep will shoot ammo,"
SWEP.Instructions            = "Press right click to shoot ammo."


SWEP.ViewModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.WorldModel			= "models/Items/ammoCrate_Rockets.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "SMG" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (Ammo)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFOV = 50


//General settings\\
 
//PrimaryFire settings\\
SWEP.Primary.Sound = "weapons/shotgun/shotgun_cock.wav"
SWEP.Primary.Damage = 0 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 10 // The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 0.01 // How much we should punch the view 
SWEP.Primary.Delay = 0.10 // How long time before you can fire again 
SWEP.Primary.Force = 25 // The force of the shot 

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
 
function SWEP:PrimaryAttack()

if ( !self:CanPrimaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		bullet.AmmoType = self.Primary.Ammo 
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -2, 0, 0 ) )
        
 
	


	if ( CLIENT ) then return end
	
	local ent = ents.Create( "item_rpg_round" )

	
	if ( !IsValid( ent ) ) then return end
	
 
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )	
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end
	
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 1000
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

	self:TakePrimaryAmmo(0)
	if self:Clip1() == 0 then
		self:Remove()
	end

end






