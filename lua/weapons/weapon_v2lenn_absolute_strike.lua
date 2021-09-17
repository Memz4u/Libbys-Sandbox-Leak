-- "lua\\weapons\\weapon_v2lenn_absolute_strike.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Striker"			
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

SWEP.Purpose                = "This weapon's good if you want too take down a boss, though it also has a precised scope. but it has limited ammo, if you fire the gun more than 2 times it won't work anymore,"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Signal your squad to get away from the boom by pressing r, press right click to scope very good"

SWEP.ViewModel			= "models/weapons/v_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
SWEP.DrawCrosshair = true	
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFov = 30
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 200 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 100 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 1000 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 50 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 500 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1

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



function SWEP:Reload()
	self:PlayerAct("halt")
end 



function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		RunConsoleCommand("act",act)
	end
end





 
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
 
        self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )


	self:ShootEffects() 
        
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then 	
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 6.2 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 5000 )
		
end	
	ent:SetOwner( self.Owner )
end


 				
	

function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 35, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
        
        else if(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 5, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
        end
 
end

function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "smg" );
        
        end
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again

-- heavy freaking weapon, tbh
-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 120
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v2lenn_absolute_strike.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Striker"			
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

SWEP.Purpose                = "This weapon's good if you want too take down a boss, though it also has a precised scope. but it has limited ammo, if you fire the gun more than 2 times it won't work anymore,"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Signal your squad to get away from the boom by pressing r, press right click to scope very good"

SWEP.ViewModel			= "models/weapons/v_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
SWEP.DrawCrosshair = true	
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFov = 30
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 200 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 100 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 1000 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 50 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 500 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1

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



function SWEP:Reload()
	self:PlayerAct("halt")
end 



function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		RunConsoleCommand("act",act)
	end
end





 
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
 
        self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )


	self:ShootEffects() 
        
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then 	
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 6.2 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 5000 )
		
end	
	ent:SetOwner( self.Owner )
end


 				
	

function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 35, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
        
        else if(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 5, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
        end
 
end

function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "smg" );
        
        end
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again

-- heavy freaking weapon, tbh
-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 120
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v2lenn_absolute_strike.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Striker"			
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

SWEP.Purpose                = "This weapon's good if you want too take down a boss, though it also has a precised scope. but it has limited ammo, if you fire the gun more than 2 times it won't work anymore,"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Signal your squad to get away from the boom by pressing r, press right click to scope very good"

SWEP.ViewModel			= "models/weapons/v_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
SWEP.DrawCrosshair = true	
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFov = 30
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 200 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 100 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 1000 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 50 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 500 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1

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



function SWEP:Reload()
	self:PlayerAct("halt")
end 



function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		RunConsoleCommand("act",act)
	end
end





 
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
 
        self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )


	self:ShootEffects() 
        
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then 	
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 6.2 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 5000 )
		
end	
	ent:SetOwner( self.Owner )
end


 				
	

function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 35, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
        
        else if(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 5, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
        end
 
end

function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "smg" );
        
        end
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again

-- heavy freaking weapon, tbh
-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 120
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v2lenn_absolute_strike.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Striker"			
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

SWEP.Purpose                = "This weapon's good if you want too take down a boss, though it also has a precised scope. but it has limited ammo, if you fire the gun more than 2 times it won't work anymore,"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Signal your squad to get away from the boom by pressing r, press right click to scope very good"

SWEP.ViewModel			= "models/weapons/v_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
SWEP.DrawCrosshair = true	
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFov = 30
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 200 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 100 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 1000 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 50 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 500 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1

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



function SWEP:Reload()
	self:PlayerAct("halt")
end 



function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		RunConsoleCommand("act",act)
	end
end





 
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
 
        self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )


	self:ShootEffects() 
        
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then 	
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 6.2 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 5000 )
		
end	
	ent:SetOwner( self.Owner )
end


 				
	

function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 35, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
        
        else if(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 5, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
        end
 
end

function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "smg" );
        
        end
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again

-- heavy freaking weapon, tbh
-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 120
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v2lenn_absolute_strike.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Striker"			
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

SWEP.Purpose                = "This weapon's good if you want too take down a boss, though it also has a precised scope. but it has limited ammo, if you fire the gun more than 2 times it won't work anymore,"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Signal your squad to get away from the boom by pressing r, press right click to scope very good"

SWEP.ViewModel			= "models/weapons/v_smg1.mdl"
SWEP.WorldModel			= "models/weapons/w_smg1.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 35 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
SWEP.DrawCrosshair = true	
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.ViewModelFov = 30
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 200 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 100 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 1000 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 200 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 50 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.25 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 500 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1

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



function SWEP:Reload()
	self:PlayerAct("halt")
end 



function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		RunConsoleCommand("act",act)
	end
end





 
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
 
        self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Primary.Sound))

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -0.75, 0, 0 ) )


	self:ShootEffects() 
        
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "grenade_ar2" )
	if ( IsValid( ent ) ) then 	
	
ent:SetPos( self.Owner:GetShootPos() + Forward * 6.2 + Right * 12.4 + Up * -7.4)
ent:SetAngles( self.Owner:EyeAngles() )
ent:Spawn()
ent:SetVelocity( Forward * 5000 )
		
end	
	ent:SetOwner( self.Owner )
end


 				
	

function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 35, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
        
        else if(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 5, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
        end
 
end

function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "smg" );
        
        end
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again

-- heavy freaking weapon, tbh
-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 120
SWEP.RunSpeed = 150

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

