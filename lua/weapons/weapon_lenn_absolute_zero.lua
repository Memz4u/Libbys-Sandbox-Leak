-- "lua\\weapons\\weapon_lenn_absolute_zero.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Zero"			
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

SWEP.Purpose                = "What hell of a name would a author put? And what does this weapon do? Top secret weapon. i'm not telling you. But one thing i know about this gun is that it killed more than 200 ragdolls in less than 40 seconds. Nobody will ever handle this modern looking badass. (NERFED VERSION): Attempted too try not too make it too insane"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, (NERFED)"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
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
SWEP.Primary.Sound = "Weapon_Shotgun.Double" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 3 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 3 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 220 // The clipsize
SWEP.Primary.Ammo = "buckshot" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1000 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 12 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.10  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25  // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1






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



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
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
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
     
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are now more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
                        
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
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

function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 245

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

-- "lua\\weapons\\weapon_lenn_absolute_zero.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Zero"			
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

SWEP.Purpose                = "What hell of a name would a author put? And what does this weapon do? Top secret weapon. i'm not telling you. But one thing i know about this gun is that it killed more than 200 ragdolls in less than 40 seconds. Nobody will ever handle this modern looking badass. (NERFED VERSION): Attempted too try not too make it too insane"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, (NERFED)"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
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
SWEP.Primary.Sound = "Weapon_Shotgun.Double" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 3 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 3 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 220 // The clipsize
SWEP.Primary.Ammo = "buckshot" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1000 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 12 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.10  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25  // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1






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



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
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
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
     
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are now more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
                        
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
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

function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 245

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

-- "lua\\weapons\\weapon_lenn_absolute_zero.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Zero"			
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

SWEP.Purpose                = "What hell of a name would a author put? And what does this weapon do? Top secret weapon. i'm not telling you. But one thing i know about this gun is that it killed more than 200 ragdolls in less than 40 seconds. Nobody will ever handle this modern looking badass. (NERFED VERSION): Attempted too try not too make it too insane"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, (NERFED)"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
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
SWEP.Primary.Sound = "Weapon_Shotgun.Double" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 3 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 3 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 220 // The clipsize
SWEP.Primary.Ammo = "buckshot" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1000 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 12 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.10  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25  // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1






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



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
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
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
     
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are now more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
                        
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
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

function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 245

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

-- "lua\\weapons\\weapon_lenn_absolute_zero.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Zero"			
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

SWEP.Purpose                = "What hell of a name would a author put? And what does this weapon do? Top secret weapon. i'm not telling you. But one thing i know about this gun is that it killed more than 200 ragdolls in less than 40 seconds. Nobody will ever handle this modern looking badass. (NERFED VERSION): Attempted too try not too make it too insane"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, (NERFED)"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
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
SWEP.Primary.Sound = "Weapon_Shotgun.Double" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 3 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 3 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 220 // The clipsize
SWEP.Primary.Ammo = "buckshot" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1000 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 12 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.10  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25  // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1






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



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
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
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
     
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are now more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
                        
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
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

function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 245

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

-- "lua\\weapons\\weapon_lenn_absolute_zero.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "shotgun"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Absolute Zero"			
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

SWEP.Purpose                = "What hell of a name would a author put? And what does this weapon do? Top secret weapon. i'm not telling you. But one thing i know about this gun is that it killed more than 200 ragdolls in less than 40 seconds. Nobody will ever handle this modern looking badass. (NERFED VERSION): Attempted too try not too make it too insane"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, (NERFED)"

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
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
SWEP.Primary.Sound = "Weapon_Shotgun.Double" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 3 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 3 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 220 // The clipsize
SWEP.Primary.Ammo = "buckshot" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1000 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.70 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 12 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.10  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25  // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1






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



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
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
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -4, 0, 0 ) )
     
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
        // (NEW VERSION) Sniper scopes are now more precised.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
                        
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
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

function SWEP:Initialize()
     self:SetHoldType( "shotgun" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 245

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

