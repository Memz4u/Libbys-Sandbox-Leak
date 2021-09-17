-- "lua\\weapons\\weapon_lenn_m9k_emergencyweapon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 
-- THEY THINK THOSE HACKERS CAN TAKE ME DOWN?
-- NICE TRY
-- THEY'LL NEVER TAKE ME DOWN LOLOLOLOLOL


if ( CLIENT ) then

	SWEP.PrintName			= "Emergency weapon for hackers"			
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

SWEP.Purpose                = "ez, get aimbot, get priority, and kill those motherfucking cuck bagging aimbotters, these cucks will lose to me, i will be hvh god!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_dot_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_ak47_m9k.mdl"
SWEP.ViewModelFlip 		= true

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
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
SWEP.Primary.Sound = "47ak.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 10000000000000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 99999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0. // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.15 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "47ak.Single"
SWEP.Secondary.Damage = 10000000000000 // How much damage the weapon does at its max
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 99999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.1  // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 25 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
                  killicon.Add( "weapon_lenn_m9k_emergencyweapon", "vgui/hud/m9k_ak47", Color( 255, 255, 255, 255 ) )
 	

    end
	self:SetHoldType(self.HoldType);	
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
                                    bullet.Spread = Vector( self.Primary.Spread * 0.15 , self.Primary.Spread * 0.15, 0) 
		bullet.Tracer = 5
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
end 

//SWEP:SecondaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
                                    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 5
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
    
        
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end 









-- "lua\\weapons\\weapon_lenn_m9k_emergencyweapon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 
-- THEY THINK THOSE HACKERS CAN TAKE ME DOWN?
-- NICE TRY
-- THEY'LL NEVER TAKE ME DOWN LOLOLOLOLOL


if ( CLIENT ) then

	SWEP.PrintName			= "Emergency weapon for hackers"			
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

SWEP.Purpose                = "ez, get aimbot, get priority, and kill those motherfucking cuck bagging aimbotters, these cucks will lose to me, i will be hvh god!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_dot_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_ak47_m9k.mdl"
SWEP.ViewModelFlip 		= true

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
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
SWEP.Primary.Sound = "47ak.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 10000000000000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 99999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0. // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.15 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "47ak.Single"
SWEP.Secondary.Damage = 10000000000000 // How much damage the weapon does at its max
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 99999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.1  // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 25 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
                  killicon.Add( "weapon_lenn_m9k_emergencyweapon", "vgui/hud/m9k_ak47", Color( 255, 255, 255, 255 ) )
 	

    end
	self:SetHoldType(self.HoldType);	
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
                                    bullet.Spread = Vector( self.Primary.Spread * 0.15 , self.Primary.Spread * 0.15, 0) 
		bullet.Tracer = 5
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
end 

//SWEP:SecondaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
                                    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 5
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
    
        
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end 









-- "lua\\weapons\\weapon_lenn_m9k_emergencyweapon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 
-- THEY THINK THOSE HACKERS CAN TAKE ME DOWN?
-- NICE TRY
-- THEY'LL NEVER TAKE ME DOWN LOLOLOLOLOL


if ( CLIENT ) then

	SWEP.PrintName			= "Emergency weapon for hackers"			
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

SWEP.Purpose                = "ez, get aimbot, get priority, and kill those motherfucking cuck bagging aimbotters, these cucks will lose to me, i will be hvh god!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_dot_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_ak47_m9k.mdl"
SWEP.ViewModelFlip 		= true

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
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
SWEP.Primary.Sound = "47ak.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 10000000000000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 99999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0. // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.15 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "47ak.Single"
SWEP.Secondary.Damage = 10000000000000 // How much damage the weapon does at its max
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 99999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.1  // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 25 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
                  killicon.Add( "weapon_lenn_m9k_emergencyweapon", "vgui/hud/m9k_ak47", Color( 255, 255, 255, 255 ) )
 	

    end
	self:SetHoldType(self.HoldType);	
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
                                    bullet.Spread = Vector( self.Primary.Spread * 0.15 , self.Primary.Spread * 0.15, 0) 
		bullet.Tracer = 5
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
end 

//SWEP:SecondaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
                                    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 5
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
    
        
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end 









-- "lua\\weapons\\weapon_lenn_m9k_emergencyweapon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 
-- THEY THINK THOSE HACKERS CAN TAKE ME DOWN?
-- NICE TRY
-- THEY'LL NEVER TAKE ME DOWN LOLOLOLOLOL


if ( CLIENT ) then

	SWEP.PrintName			= "Emergency weapon for hackers"			
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

SWEP.Purpose                = "ez, get aimbot, get priority, and kill those motherfucking cuck bagging aimbotters, these cucks will lose to me, i will be hvh god!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_dot_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_ak47_m9k.mdl"
SWEP.ViewModelFlip 		= true

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
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
SWEP.Primary.Sound = "47ak.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 10000000000000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 99999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0. // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.15 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "47ak.Single"
SWEP.Secondary.Damage = 10000000000000 // How much damage the weapon does at its max
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 99999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.1  // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 25 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
                  killicon.Add( "weapon_lenn_m9k_emergencyweapon", "vgui/hud/m9k_ak47", Color( 255, 255, 255, 255 ) )
 	

    end
	self:SetHoldType(self.HoldType);	
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
                                    bullet.Spread = Vector( self.Primary.Spread * 0.15 , self.Primary.Spread * 0.15, 0) 
		bullet.Tracer = 5
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
end 

//SWEP:SecondaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
                                    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 5
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
    
        
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end 









-- "lua\\weapons\\weapon_lenn_m9k_emergencyweapon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 
-- THEY THINK THOSE HACKERS CAN TAKE ME DOWN?
-- NICE TRY
-- THEY'LL NEVER TAKE ME DOWN LOLOLOLOLOL


if ( CLIENT ) then

	SWEP.PrintName			= "Emergency weapon for hackers"			
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

SWEP.Purpose                = "ez, get aimbot, get priority, and kill those motherfucking cuck bagging aimbotters, these cucks will lose to me, i will be hvh god!"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R,"

SWEP.ViewModel			= "models/weapons/v_dot_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_ak47_m9k.mdl"
SWEP.ViewModelFlip 		= true

SWEP.Weight			= 35
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
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
SWEP.Primary.Sound = "47ak.Single" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 10000000000000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 99999 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.1 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0. // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.15 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 25 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

//SecondaryFire settings\\
SWEP.Secondary.Sound = "47ak.Single"
SWEP.Secondary.Damage = 10000000000000 // How much damage the weapon does at its max
SWEP.Secondary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 9999 // The clipsize 
SWEP.Secondary.Ammo = "smg1" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 99999 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.1  // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 6 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0 // How much we should punch the view 
SWEP.Secondary.Delay = 0.05 // How long time before you can fire again 
SWEP.Secondary.Force = 25 // The force of the shot 



 
//SWEP:Initialize\\ 
function SWEP:Initialize() 

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
                  killicon.Add( "weapon_lenn_m9k_emergencyweapon", "vgui/hud/m9k_ak47", Color( 255, 255, 255, 255 ) )
 	

    end
	self:SetHoldType(self.HoldType);	
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
                                    bullet.Spread = Vector( self.Primary.Spread * 0.15 , self.Primary.Spread * 0.15, 0) 
		bullet.Tracer = 5
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
end 

//SWEP:SecondaryFire\\ 
// We added some other functions or parts too make viewpunch recoil for the new versions.
function SWEP:SecondaryAttack() 
	if ( !self:CanSecondaryAttack() ) then return end 
 
	local bullet = {} 
		bullet.Num = self.Secondary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
                                    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 5
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
    
        
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end 









