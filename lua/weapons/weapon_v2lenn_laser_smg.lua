-- "lua\\weapons\\weapon_v2lenn_laser_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser SMG"			
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

SWEP.Purpose                = "A weapon created by one of the smartest scientists in about 60 mins, it really is epic too see some smart scientists build a laser smg in such a hour, not even anyone else can build a laser smg in a hour, when we tested it, it shoots primary lasers in 0.08 seconds and the second laser weapon click takes about 6 seconds of delay too reload"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, Press right click to shoot a lot of lasers"

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


//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 15 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 120 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1// How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.03 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.05 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1



//SecondaryFire settings\\
SWEP.Secondary.Sound = "npc/vort/attack_shoot.wav"
SWEP.Secondary.Damage = 100 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 20 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 120 // The clipsize 
SWEP.Secondary.Ammo = "AR2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 300 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.03 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.05 // How much we should punch the view 
SWEP.Secondary.Delay = 6 // How long time before you can fire again 
SWEP.Secondary.Force = 500 // The force of the shot 
SWEP.Primary.Tracer			= 1

 
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
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "rpg" );
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
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 330

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

-- "lua\\weapons\\weapon_v2lenn_laser_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser SMG"			
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

SWEP.Purpose                = "A weapon created by one of the smartest scientists in about 60 mins, it really is epic too see some smart scientists build a laser smg in such a hour, not even anyone else can build a laser smg in a hour, when we tested it, it shoots primary lasers in 0.08 seconds and the second laser weapon click takes about 6 seconds of delay too reload"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, Press right click to shoot a lot of lasers"

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


//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 15 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 120 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1// How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.03 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.05 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1



//SecondaryFire settings\\
SWEP.Secondary.Sound = "npc/vort/attack_shoot.wav"
SWEP.Secondary.Damage = 100 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 20 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 120 // The clipsize 
SWEP.Secondary.Ammo = "AR2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 300 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.03 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.05 // How much we should punch the view 
SWEP.Secondary.Delay = 6 // How long time before you can fire again 
SWEP.Secondary.Force = 500 // The force of the shot 
SWEP.Primary.Tracer			= 1

 
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
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "rpg" );
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
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 330

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

-- "lua\\weapons\\weapon_v2lenn_laser_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser SMG"			
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

SWEP.Purpose                = "A weapon created by one of the smartest scientists in about 60 mins, it really is epic too see some smart scientists build a laser smg in such a hour, not even anyone else can build a laser smg in a hour, when we tested it, it shoots primary lasers in 0.08 seconds and the second laser weapon click takes about 6 seconds of delay too reload"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, Press right click to shoot a lot of lasers"

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


//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 15 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 120 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1// How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.03 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.05 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1



//SecondaryFire settings\\
SWEP.Secondary.Sound = "npc/vort/attack_shoot.wav"
SWEP.Secondary.Damage = 100 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 20 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 120 // The clipsize 
SWEP.Secondary.Ammo = "AR2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 300 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.03 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.05 // How much we should punch the view 
SWEP.Secondary.Delay = 6 // How long time before you can fire again 
SWEP.Secondary.Force = 500 // The force of the shot 
SWEP.Primary.Tracer			= 1

 
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
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "rpg" );
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
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 330

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

-- "lua\\weapons\\weapon_v2lenn_laser_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser SMG"			
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

SWEP.Purpose                = "A weapon created by one of the smartest scientists in about 60 mins, it really is epic too see some smart scientists build a laser smg in such a hour, not even anyone else can build a laser smg in a hour, when we tested it, it shoots primary lasers in 0.08 seconds and the second laser weapon click takes about 6 seconds of delay too reload"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, Press right click to shoot a lot of lasers"

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


//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 15 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 120 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1// How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.03 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.05 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1



//SecondaryFire settings\\
SWEP.Secondary.Sound = "npc/vort/attack_shoot.wav"
SWEP.Secondary.Damage = 100 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 20 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 120 // The clipsize 
SWEP.Secondary.Ammo = "AR2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 300 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.03 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.05 // How much we should punch the view 
SWEP.Secondary.Delay = 6 // How long time before you can fire again 
SWEP.Secondary.Force = 500 // The force of the shot 
SWEP.Primary.Tracer			= 1

 
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
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "rpg" );
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
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 330

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

-- "lua\\weapons\\weapon_v2lenn_laser_smg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "rpg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "The Laser SMG"			
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

SWEP.Purpose                = "A weapon created by one of the smartest scientists in about 60 mins, it really is epic too see some smart scientists build a laser smg in such a hour, not even anyone else can build a laser smg in a hour, when we tested it, it shoots primary lasers in 0.08 seconds and the second laser weapon click takes about 6 seconds of delay too reload"
SWEP.Instructions            = "Shoot your weapon by pressing left click. Reload by pressing R, Press right click to shoot a lot of lasers"

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


//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "beams/beamstart5.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 15 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 120 // The clipsize
SWEP.Primary.Ammo = "AR2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 300 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.05 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 1// How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0.03 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.05 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 50 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /
SWEP.Primary.Cone = 5
SWEP.Primary.Tracer			= 1



//SecondaryFire settings\\
SWEP.Secondary.Sound = "npc/vort/attack_shoot.wav"
SWEP.Secondary.Damage = 100 // How much damage the swep is doing 
SWEP.Secondary.TakeAmmo = 20 // How much ammo does it take for each shot ? 
SWEP.Secondary.ClipSize = 120 // The clipsize 
SWEP.Secondary.Ammo = "AR2" // ammmo type pistol/ smg1 
SWEP.Secondary.DefaultClip = 300 // How much ammo does the swep come with `? 
SWEP.Secondary.Spread = 0.03 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it 0.1 
SWEP.Secondary.NumberofShots = 20 // How many bullets you are firing each shot. 
SWEP.Secondary.Automatic = true // Is the swep automatic ? 
SWEP.Secondary.Recoil = 0.05 // How much we should punch the view 
SWEP.Secondary.Delay = 6 // How long time before you can fire again 
SWEP.Secondary.Force = 500 // The force of the shot 
SWEP.Primary.Tracer			= 1

 
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
 
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	
end 



-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "rpg" );
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
SWEP.WalkSpeed = 180
SWEP.RunSpeed = 330

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

