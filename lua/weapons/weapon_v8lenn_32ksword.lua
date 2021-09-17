-- "lua\\weapons\\weapon_v8lenn_32ksword.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "32k Sword"			
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

SWEP.Purpose                = "Its just like the 32k weapons on a minecraft anarchy server. Hit someone. and they die instantly, they deal exactly 32k damage."
SWEP.Instructions            = "Hit somebody with it. you die"

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
SWEP.MissSound = Sound( "ambient/energy/newspark03.wav" )
SWEP.WallSound = Sound( "ambient/energy/newspark02.wav" )

//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "ambient/energy/ion_cannon_shot3.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.00 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.6 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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
 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 1
                                                      bullet.TracerName = "ToolTracer"
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.Primary.Sound )
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end




-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "melee" ); -- gaming
     self:SetColor(Color(0, 0, 161, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

-- "lua\\weapons\\weapon_v8lenn_32ksword.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "32k Sword"			
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

SWEP.Purpose                = "Its just like the 32k weapons on a minecraft anarchy server. Hit someone. and they die instantly, they deal exactly 32k damage."
SWEP.Instructions            = "Hit somebody with it. you die"

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
SWEP.MissSound = Sound( "ambient/energy/newspark03.wav" )
SWEP.WallSound = Sound( "ambient/energy/newspark02.wav" )

//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "ambient/energy/ion_cannon_shot3.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.00 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.6 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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
 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 1
                                                      bullet.TracerName = "ToolTracer"
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.Primary.Sound )
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end




-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "melee" ); -- gaming
     self:SetColor(Color(0, 0, 161, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

-- "lua\\weapons\\weapon_v8lenn_32ksword.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "32k Sword"			
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

SWEP.Purpose                = "Its just like the 32k weapons on a minecraft anarchy server. Hit someone. and they die instantly, they deal exactly 32k damage."
SWEP.Instructions            = "Hit somebody with it. you die"

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
SWEP.MissSound = Sound( "ambient/energy/newspark03.wav" )
SWEP.WallSound = Sound( "ambient/energy/newspark02.wav" )

//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "ambient/energy/ion_cannon_shot3.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.00 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.6 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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
 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 1
                                                      bullet.TracerName = "ToolTracer"
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.Primary.Sound )
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end




-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "melee" ); -- gaming
     self:SetColor(Color(0, 0, 161, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

-- "lua\\weapons\\weapon_v8lenn_32ksword.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "32k Sword"			
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

SWEP.Purpose                = "Its just like the 32k weapons on a minecraft anarchy server. Hit someone. and they die instantly, they deal exactly 32k damage."
SWEP.Instructions            = "Hit somebody with it. you die"

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
SWEP.MissSound = Sound( "ambient/energy/newspark03.wav" )
SWEP.WallSound = Sound( "ambient/energy/newspark02.wav" )

//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "ambient/energy/ion_cannon_shot3.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.00 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.6 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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
 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 1
                                                      bullet.TracerName = "ToolTracer"
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.Primary.Sound )
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end




-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "melee" ); -- gaming
     self:SetColor(Color(0, 0, 161, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

-- "lua\\weapons\\weapon_v8lenn_32ksword.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "32k Sword"			
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

SWEP.Purpose                = "Its just like the 32k weapons on a minecraft anarchy server. Hit someone. and they die instantly, they deal exactly 32k damage."
SWEP.Instructions            = "Hit somebody with it. you die"

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
SWEP.MissSound = Sound( "ambient/energy/newspark03.wav" )
SWEP.WallSound = Sound( "ambient/energy/newspark02.wav" )

//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "ambient/energy/ion_cannon_shot3.wav" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.00 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.6 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 999 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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
 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 1
                                                      bullet.TracerName = "ToolTracer"
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.Primary.Sound )
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end




-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "melee" ); -- gaming
     self:SetColor(Color(0, 0, 161, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED FOREVER WHEN WE DIE. IF SOMEONE USES THAT SAME WORLDMODEL, ITS GONNA BE COLORED AS WELL IF WE DON'T HAVE THIS CODE
function SWEP:OnRemove()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end


-- We can't have the weapon COLORED when we aren't using it. if a weapon uses that same worldmodel, its gonna be colored as well if we dont have this code
function SWEP:Holster()
     self:SetColor(Color(0, 0, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- How we change the color of the viewmodel.
function SWEP:PreDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

function SWEP:PostDrawViewModel(vm, wep, ply)
	render.SetColorModulation(0, 0, 1) -- RGB, lets say 0, 0, 1 = blue. 0, 1, 0 = green, and 1, 0, 0, = red. its like rgb but say that 1 = 100, therefore you do not just set 0 to 100 on this one, you actually set it to 1, or 0, its your final options.
end

