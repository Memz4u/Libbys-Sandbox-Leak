-- "lua\\weapons\\weapon_v2lenn_silencer_m4a1.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Silencer m4a1"			
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

SWEP.Purpose                = "A god damn swat weapon holded right at your hands, you claimed it, but now you're the swat now. this weapon also has a silencer, so u'll wont make any loud sounds on this weapon."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1_silencer.mdl"
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
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.SilencedSound = Sound("Weapon_M4A1.2") // Do not edit. This is secondary sound but it's for the silencer
SWEP.Primary.Damage = 10 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.10 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.04  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.07 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 20 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
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

SWEP.CanBeSilenced		= true
SWEP.SelectiveFire		= true


 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\

-- 3/21/2020: We added real recoil, whenever you shoot a bullet it will make your angles go up by a imeter (or even inches if you hold the attack button)

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:GetOwner():MuzzleFlash()
   self:GetOwner():SetAnimation( PLAYER_ATTACK1 )


   numbul = numbul or 5
   cone   = cone   or 5

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self:GetOwner():GetShootPos()
   bullet.Dir    = self:GetOwner():GetAimVector()
   bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
   bullet.Tracer = 1
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = self.Primary.Damage 
   bullet.AmmoType = self.Primary.Ammo 

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:GetOwner():FireBullets( bullet )
   self:EmitSound(Sound(self.Primary.Sound)) 
   self.Owner:ViewPunch( Angle( -0.07, 0, 0 ) )
    
   self:ShootEffects() 
                  

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or (not self:GetOwner():Alive()) or self:GetOwner():IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 100) or recoil


     -- actual seteyeangles recoil is here
      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
	
   end
end


function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.75
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 0.6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 6
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 1.25
			else
			self.Primary.Cone = 1.5
							end
							
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	self.Primary.Cone = 2.4
	return true
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 10 * self.Primary.Cone
	
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 0.9 * scale
	local length = gap + 0.4 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

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
     self:SetHoldType( "smg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 360

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

-- "lua\\weapons\\weapon_v2lenn_silencer_m4a1.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Silencer m4a1"			
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

SWEP.Purpose                = "A god damn swat weapon holded right at your hands, you claimed it, but now you're the swat now. this weapon also has a silencer, so u'll wont make any loud sounds on this weapon."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1_silencer.mdl"
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
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.SilencedSound = Sound("Weapon_M4A1.2") // Do not edit. This is secondary sound but it's for the silencer
SWEP.Primary.Damage = 10 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.10 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.04  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.07 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 20 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
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

SWEP.CanBeSilenced		= true
SWEP.SelectiveFire		= true


 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\

-- 3/21/2020: We added real recoil, whenever you shoot a bullet it will make your angles go up by a imeter (or even inches if you hold the attack button)

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:GetOwner():MuzzleFlash()
   self:GetOwner():SetAnimation( PLAYER_ATTACK1 )


   numbul = numbul or 5
   cone   = cone   or 5

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self:GetOwner():GetShootPos()
   bullet.Dir    = self:GetOwner():GetAimVector()
   bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
   bullet.Tracer = 1
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = self.Primary.Damage 
   bullet.AmmoType = self.Primary.Ammo 

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:GetOwner():FireBullets( bullet )
   self:EmitSound(Sound(self.Primary.Sound)) 
   self.Owner:ViewPunch( Angle( -0.07, 0, 0 ) )
    
   self:ShootEffects() 
                  

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or (not self:GetOwner():Alive()) or self:GetOwner():IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 100) or recoil


     -- actual seteyeangles recoil is here
      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
	
   end
end


function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.75
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 0.6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 6
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 1.25
			else
			self.Primary.Cone = 1.5
							end
							
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	self.Primary.Cone = 2.4
	return true
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 10 * self.Primary.Cone
	
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 0.9 * scale
	local length = gap + 0.4 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

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
     self:SetHoldType( "smg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 360

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

-- "lua\\weapons\\weapon_v2lenn_silencer_m4a1.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Silencer m4a1"			
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

SWEP.Purpose                = "A god damn swat weapon holded right at your hands, you claimed it, but now you're the swat now. this weapon also has a silencer, so u'll wont make any loud sounds on this weapon."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1_silencer.mdl"
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
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.SilencedSound = Sound("Weapon_M4A1.2") // Do not edit. This is secondary sound but it's for the silencer
SWEP.Primary.Damage = 10 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.10 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.04  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.07 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 20 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
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

SWEP.CanBeSilenced		= true
SWEP.SelectiveFire		= true


 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\

-- 3/21/2020: We added real recoil, whenever you shoot a bullet it will make your angles go up by a imeter (or even inches if you hold the attack button)

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:GetOwner():MuzzleFlash()
   self:GetOwner():SetAnimation( PLAYER_ATTACK1 )


   numbul = numbul or 5
   cone   = cone   or 5

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self:GetOwner():GetShootPos()
   bullet.Dir    = self:GetOwner():GetAimVector()
   bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
   bullet.Tracer = 1
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = self.Primary.Damage 
   bullet.AmmoType = self.Primary.Ammo 

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:GetOwner():FireBullets( bullet )
   self:EmitSound(Sound(self.Primary.Sound)) 
   self.Owner:ViewPunch( Angle( -0.07, 0, 0 ) )
    
   self:ShootEffects() 
                  

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or (not self:GetOwner():Alive()) or self:GetOwner():IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 100) or recoil


     -- actual seteyeangles recoil is here
      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
	
   end
end


function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.75
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 0.6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 6
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 1.25
			else
			self.Primary.Cone = 1.5
							end
							
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	self.Primary.Cone = 2.4
	return true
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 10 * self.Primary.Cone
	
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 0.9 * scale
	local length = gap + 0.4 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

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
     self:SetHoldType( "smg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 360

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

-- "lua\\weapons\\weapon_v2lenn_silencer_m4a1.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Silencer m4a1"			
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

SWEP.Purpose                = "A god damn swat weapon holded right at your hands, you claimed it, but now you're the swat now. this weapon also has a silencer, so u'll wont make any loud sounds on this weapon."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1_silencer.mdl"
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
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.SilencedSound = Sound("Weapon_M4A1.2") // Do not edit. This is secondary sound but it's for the silencer
SWEP.Primary.Damage = 10 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.10 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.04  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.07 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 20 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
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

SWEP.CanBeSilenced		= true
SWEP.SelectiveFire		= true


 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\

-- 3/21/2020: We added real recoil, whenever you shoot a bullet it will make your angles go up by a imeter (or even inches if you hold the attack button)

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:GetOwner():MuzzleFlash()
   self:GetOwner():SetAnimation( PLAYER_ATTACK1 )


   numbul = numbul or 5
   cone   = cone   or 5

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self:GetOwner():GetShootPos()
   bullet.Dir    = self:GetOwner():GetAimVector()
   bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
   bullet.Tracer = 1
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = self.Primary.Damage 
   bullet.AmmoType = self.Primary.Ammo 

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:GetOwner():FireBullets( bullet )
   self:EmitSound(Sound(self.Primary.Sound)) 
   self.Owner:ViewPunch( Angle( -0.07, 0, 0 ) )
    
   self:ShootEffects() 
                  

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or (not self:GetOwner():Alive()) or self:GetOwner():IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 100) or recoil


     -- actual seteyeangles recoil is here
      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
	
   end
end


function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.75
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 0.6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 6
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 1.25
			else
			self.Primary.Cone = 1.5
							end
							
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	self.Primary.Cone = 2.4
	return true
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 10 * self.Primary.Cone
	
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 0.9 * scale
	local length = gap + 0.4 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

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
     self:SetHoldType( "smg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 360

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

-- "lua\\weapons\\weapon_v2lenn_silencer_m4a1.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Silencer m4a1"			
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

SWEP.Purpose                = "A god damn swat weapon holded right at your hands, you claimed it, but now you're the swat now. this weapon also has a silencer, so u'll wont make any loud sounds on this weapon."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1_silencer.mdl"
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
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/m4a1/m4a1-1.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.SilencedSound = Sound("Weapon_M4A1.2") // Do not edit. This is secondary sound but it's for the silencer
SWEP.Primary.Damage = 10 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 45 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.10 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.04  // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.07 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 20 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
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

SWEP.CanBeSilenced		= true
SWEP.SelectiveFire		= true


 
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 

//SWEP:PrimaryFire\\

-- 3/21/2020: We added real recoil, whenever you shoot a bullet it will make your angles go up by a imeter (or even inches if you hold the attack button)

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self:GetOwner():MuzzleFlash()
   self:GetOwner():SetAnimation( PLAYER_ATTACK1 )


   numbul = numbul or 5
   cone   = cone   or 5

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self:GetOwner():GetShootPos()
   bullet.Dir    = self:GetOwner():GetAimVector()
   bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
   bullet.Tracer = 1
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = 10
   bullet.Damage = self.Primary.Damage 
   bullet.AmmoType = self.Primary.Ammo 

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   self:GetOwner():FireBullets( bullet )
   self:EmitSound(Sound(self.Primary.Sound)) 
   self.Owner:ViewPunch( Angle( -0.07, 0, 0 ) )
    
   self:ShootEffects() 
                  

   -- Owner can die after firebullets
   if (not IsValid(self:GetOwner())) or (not self:GetOwner():Alive()) or self:GetOwner():IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 100) or recoil


     -- actual seteyeangles recoil is here
      local eyeang = self:GetOwner():EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self:GetOwner():SetEyeAngles( eyeang )
	
   end
end


function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.75
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 0.5
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 1.5
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 0.6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 6
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 1.25
			else
			self.Primary.Cone = 1.5
							end
							
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	self.Primary.Cone = 2.4
	return true
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 10 * self.Primary.Cone
	
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 0.9 * scale
	local length = gap + 0.4 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

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
     self:SetHoldType( "smg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 200
SWEP.RunSpeed = 360

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

