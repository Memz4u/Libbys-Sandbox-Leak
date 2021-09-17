-- "lua\\weapons\\weapon_v4lenn_m60.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Particular M60"			
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

SWEP.Purpose                = "Just like a machine gun, incept it shoots slower and has a smaller ammo! it uses the ar2 ammo. There also is a secondary button to launch a shotgun blast."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 500 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

SWEP.ViewModelFOV = 45

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_Shotgun.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 25 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 80 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread (NEW VERSION) I decided to bring down the spread of the m249 by half, original: 1,
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.15 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 75 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "Weapon_Shotgun.Double"
SWEP.Secondary.Damage = 10 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 5 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 30 // The clipsize 
SWEP.Secondary.Ammo = "ar2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 60 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 2.5 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 8 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 1  // How much we should punch the view 
SWEP.Secondary.Delay = 1  // How long time before you can fire again 
SWEP.Secondary.Force = 30 // The force of the shot 



 
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
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
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
        self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 


//SWEP:SecondaryFire\\
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
		bullet.Tracer = 1
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -1.5, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
end 

function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 20
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 40
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 10
			else
			self.Primary.Cone = 8.5
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



function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 310

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

-- "lua\\weapons\\weapon_v4lenn_m60.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Particular M60"			
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

SWEP.Purpose                = "Just like a machine gun, incept it shoots slower and has a smaller ammo! it uses the ar2 ammo. There also is a secondary button to launch a shotgun blast."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 500 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

SWEP.ViewModelFOV = 45

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_Shotgun.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 25 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 80 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread (NEW VERSION) I decided to bring down the spread of the m249 by half, original: 1,
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.15 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 75 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "Weapon_Shotgun.Double"
SWEP.Secondary.Damage = 10 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 5 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 30 // The clipsize 
SWEP.Secondary.Ammo = "ar2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 60 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 2.5 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 8 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 1  // How much we should punch the view 
SWEP.Secondary.Delay = 1  // How long time before you can fire again 
SWEP.Secondary.Force = 30 // The force of the shot 



 
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
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
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
        self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 


//SWEP:SecondaryFire\\
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
		bullet.Tracer = 1
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -1.5, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
end 

function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 20
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 40
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 10
			else
			self.Primary.Cone = 8.5
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



function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 310

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

-- "lua\\weapons\\weapon_v4lenn_m60.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Particular M60"			
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

SWEP.Purpose                = "Just like a machine gun, incept it shoots slower and has a smaller ammo! it uses the ar2 ammo. There also is a secondary button to launch a shotgun blast."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 500 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

SWEP.ViewModelFOV = 45

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_Shotgun.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 25 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 80 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread (NEW VERSION) I decided to bring down the spread of the m249 by half, original: 1,
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.15 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 75 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "Weapon_Shotgun.Double"
SWEP.Secondary.Damage = 10 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 5 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 30 // The clipsize 
SWEP.Secondary.Ammo = "ar2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 60 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 2.5 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 8 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 1  // How much we should punch the view 
SWEP.Secondary.Delay = 1  // How long time before you can fire again 
SWEP.Secondary.Force = 30 // The force of the shot 



 
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
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
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
        self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 


//SWEP:SecondaryFire\\
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
		bullet.Tracer = 1
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -1.5, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
end 

function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 20
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 40
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 10
			else
			self.Primary.Cone = 8.5
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



function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 310

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

-- "lua\\weapons\\weapon_v4lenn_m60.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Particular M60"			
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

SWEP.Purpose                = "Just like a machine gun, incept it shoots slower and has a smaller ammo! it uses the ar2 ammo. There also is a secondary button to launch a shotgun blast."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 500 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

SWEP.ViewModelFOV = 45

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_Shotgun.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 25 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 80 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread (NEW VERSION) I decided to bring down the spread of the m249 by half, original: 1,
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.15 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 75 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "Weapon_Shotgun.Double"
SWEP.Secondary.Damage = 10 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 5 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 30 // The clipsize 
SWEP.Secondary.Ammo = "ar2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 60 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 2.5 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 8 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 1  // How much we should punch the view 
SWEP.Secondary.Delay = 1  // How long time before you can fire again 
SWEP.Secondary.Force = 30 // The force of the shot 



 
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
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
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
        self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 


//SWEP:SecondaryFire\\
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
		bullet.Tracer = 1
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -1.5, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
end 

function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 20
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 40
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 10
			else
			self.Primary.Cone = 8.5
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



function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 310

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

-- "lua\\weapons\\weapon_v4lenn_m60.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Particular M60"			
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

SWEP.Purpose                = "Just like a machine gun, incept it shoots slower and has a smaller ammo! it uses the ar2 ammo. There also is a secondary button to launch a shotgun blast."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "rpg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 500 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.Primary.Tracer			= 1

SWEP.ViewModelFOV = 45

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_Shotgun.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 25 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 80 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread (NEW VERSION) I decided to bring down the spread of the m249 by half, original: 1,
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.15 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.10 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 75 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 1 

//SecondaryFire settings\\
SWEP.Secondary.Sound = "Weapon_Shotgun.Double"
SWEP.Secondary.Damage = 10 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 5 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 30 // The clipsize 
SWEP.Secondary.Ammo = "ar2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 60 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 2.5 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 8 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 1  // How much we should punch the view 
SWEP.Secondary.Delay = 1  // How long time before you can fire again 
SWEP.Secondary.Force = 30 // The force of the shot 



 
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
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
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
        self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 


//SWEP:SecondaryFire\\
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0)
		bullet.Tracer = 1
		bullet.Force = self.Secondary.Force 
		bullet.Damage = self.Secondary.Damage 
		bullet.AmmoType = self.Secondary.Ammo 
 
	local rnda = self.Secondary.Recoil * -1 
	local rndb = self.Secondary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Secondary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo) 
        self.Owner:ViewPunch( Angle( -1.5, 0, 0 ) )
    
        
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 
end 

function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 20
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 8
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 12
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 6
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 40
			else
			if self.Owner:KeyDown ( IN_RELOAD) then
			self.Primary.Cone = 10
			else
			self.Primary.Cone = 8.5
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



function SWEP:Initialize()
     self:SetHoldType( "rpg" );
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
SWEP.RunSpeed = 310

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

