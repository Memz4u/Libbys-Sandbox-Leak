-- "lua\\weapons\\weapon_lenn_nospread.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "nospread hack"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = true

SWEP.Purpose                = "This is a big stepup to the older Admin Weapon. This one is a freaking epic weapon. There is no recoil. And a shit ton of spread to kill everybody. You can even explode people with this!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, If you want to make explosions, press right click"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl" -- Insert a viewmodel, Or a c model if i say.... (something that isn't a worldmodel)
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl" -- Insert a worldmodel, like a ak47 from css that was dropped.
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_AK47.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 100 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 100 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 9999999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 99999999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/automag/deagle-1.wav"
SWEP.Secondary.Damage = 9999999 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999999 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 9999999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 



 
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
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 
//SWEP:PrimaryFire\\
 


-- "lua\\weapons\\weapon_lenn_nospread.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "nospread hack"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = true

SWEP.Purpose                = "This is a big stepup to the older Admin Weapon. This one is a freaking epic weapon. There is no recoil. And a shit ton of spread to kill everybody. You can even explode people with this!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, If you want to make explosions, press right click"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl" -- Insert a viewmodel, Or a c model if i say.... (something that isn't a worldmodel)
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl" -- Insert a worldmodel, like a ak47 from css that was dropped.
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_AK47.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 100 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 100 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 9999999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 99999999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/automag/deagle-1.wav"
SWEP.Secondary.Damage = 9999999 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999999 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 9999999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 



 
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
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 
//SWEP:PrimaryFire\\
 


-- "lua\\weapons\\weapon_lenn_nospread.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "nospread hack"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = true

SWEP.Purpose                = "This is a big stepup to the older Admin Weapon. This one is a freaking epic weapon. There is no recoil. And a shit ton of spread to kill everybody. You can even explode people with this!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, If you want to make explosions, press right click"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl" -- Insert a viewmodel, Or a c model if i say.... (something that isn't a worldmodel)
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl" -- Insert a worldmodel, like a ak47 from css that was dropped.
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_AK47.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 100 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 100 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 9999999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 99999999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/automag/deagle-1.wav"
SWEP.Secondary.Damage = 9999999 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999999 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 9999999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 



 
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
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 
//SWEP:PrimaryFire\\
 


-- "lua\\weapons\\weapon_lenn_nospread.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "nospread hack"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = true

SWEP.Purpose                = "This is a big stepup to the older Admin Weapon. This one is a freaking epic weapon. There is no recoil. And a shit ton of spread to kill everybody. You can even explode people with this!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, If you want to make explosions, press right click"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl" -- Insert a viewmodel, Or a c model if i say.... (something that isn't a worldmodel)
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl" -- Insert a worldmodel, like a ak47 from css that was dropped.
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_AK47.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 100 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 100 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 9999999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 99999999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/automag/deagle-1.wav"
SWEP.Secondary.Damage = 9999999 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999999 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 9999999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 



 
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
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 
//SWEP:PrimaryFire\\
 


-- "lua\\weapons\\weapon_lenn_nospread.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "nospread hack"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end

SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = true

SWEP.Purpose                = "This is a big stepup to the older Admin Weapon. This one is a freaking epic weapon. There is no recoil. And a shit ton of spread to kill everybody. You can even explode people with this!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, If you want to make explosions, press right click"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl" -- Insert a viewmodel, Or a c model if i say.... (something that isn't a worldmodel)
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl" -- Insert a worldmodel, like a ak47 from css that was dropped.
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 70
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "Smg" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "Weapon_AK47.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 100 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 100 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 9999999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.1 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 99999999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "weapons/automag/deagle-1.wav"
SWEP.Secondary.Damage = 9999999 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999999 // The clipsize 
SWEP.Secondary.Ammo = "Pistol" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 9999999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 1 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 



 
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
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self:ShootEffects() 
 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 
//SWEP:PrimaryFire\\
 


