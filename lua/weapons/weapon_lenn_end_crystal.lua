-- "lua\\weapons\\weapon_lenn_end_crystal.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "end_crystal cpvp (2b2t)"			
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

SWEP.Purpose                = "Blow people up close range, If you played on 2b2t in minecraft YOU know what this is."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Blow up someone close range. Reload by pressing R"
SWEP.ViewModel			= "models/weapons/c_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"
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
SWEP.Primary.Sound = "nil" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.Damage = 99999999999 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 256 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 2 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 10 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
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
SWEP.Secondary.Delay = 0.5 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 
SWEP.HealAmount = 10

function SWEP:Initialize() 
self:SetHoldType( "fist" );
self.Owner:EmitSound("ambient/weather/thunder1.wav")
timer.Simple(0.75, function() self.Owner:ChatPrint("instructions: Primary attack: Fire bombs, Secondary attack: Heal yourself every 0.5 seconds, +10 hp, (HOLD) Reload: Protect yourself") end)
return true
end


function SWEP:Deploy() 
     self.Owner:SetHealth("500")
     self.Owner:SetArmor("255")
return true
end


function SWEP:Holster() 
     self.Owner:SetHealth("100")
return true -- So we can switch weapons. duh.
end

function SWEP:PrimaryAttack() 

	if ( !self:CanPrimaryAttack() ) then return end 

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *400 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if ( trace.Hit ) then

                  self.Owner:SendLua("sound.PlayURL('https://files.catbox.moe/x7ublp.mp3','mono noblock', function( s ) s:Play() end)")

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","100") 
			ent:Fire("Explode", 0, 0 ) 

	 
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		self:TakePrimaryAmmo(self.Primary.TakeAmmo) 



	end
end 
end




function SWEP:Reload() 
	self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"small")
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)


	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("Models/effects/comball_tape")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	timer.Simple(0, function() ent:Remove() end) 
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
                  phys:EnableMotion(false)
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



function SWEP:SecondaryAttack()

                  local need = self.HealAmount
	self.Owner:SetHealth( math.min( self.Owner:GetMaxHealth(), self.Owner:Health() + need ) )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 

end

-- "lua\\weapons\\weapon_lenn_end_crystal.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "end_crystal cpvp (2b2t)"			
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

SWEP.Purpose                = "Blow people up close range, If you played on 2b2t in minecraft YOU know what this is."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Blow up someone close range. Reload by pressing R"
SWEP.ViewModel			= "models/weapons/c_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"
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
SWEP.Primary.Sound = "nil" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.Damage = 99999999999 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 256 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 2 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 10 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
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
SWEP.Secondary.Delay = 0.5 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 
SWEP.HealAmount = 10

function SWEP:Initialize() 
self:SetHoldType( "fist" );
self.Owner:EmitSound("ambient/weather/thunder1.wav")
timer.Simple(0.75, function() self.Owner:ChatPrint("instructions: Primary attack: Fire bombs, Secondary attack: Heal yourself every 0.5 seconds, +10 hp, (HOLD) Reload: Protect yourself") end)
return true
end


function SWEP:Deploy() 
     self.Owner:SetHealth("500")
     self.Owner:SetArmor("255")
return true
end


function SWEP:Holster() 
     self.Owner:SetHealth("100")
return true -- So we can switch weapons. duh.
end

function SWEP:PrimaryAttack() 

	if ( !self:CanPrimaryAttack() ) then return end 

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *400 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if ( trace.Hit ) then

                  self.Owner:SendLua("sound.PlayURL('https://files.catbox.moe/x7ublp.mp3','mono noblock', function( s ) s:Play() end)")

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","100") 
			ent:Fire("Explode", 0, 0 ) 

	 
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		self:TakePrimaryAmmo(self.Primary.TakeAmmo) 



	end
end 
end




function SWEP:Reload() 
	self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"small")
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)


	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("Models/effects/comball_tape")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	timer.Simple(0, function() ent:Remove() end) 
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
                  phys:EnableMotion(false)
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



function SWEP:SecondaryAttack()

                  local need = self.HealAmount
	self.Owner:SetHealth( math.min( self.Owner:GetMaxHealth(), self.Owner:Health() + need ) )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 

end

-- "lua\\weapons\\weapon_lenn_end_crystal.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "end_crystal cpvp (2b2t)"			
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

SWEP.Purpose                = "Blow people up close range, If you played on 2b2t in minecraft YOU know what this is."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Blow up someone close range. Reload by pressing R"
SWEP.ViewModel			= "models/weapons/c_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"
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
SWEP.Primary.Sound = "nil" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.Damage = 99999999999 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 256 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 2 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 10 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
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
SWEP.Secondary.Delay = 0.5 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 
SWEP.HealAmount = 10

function SWEP:Initialize() 
self:SetHoldType( "fist" );
self.Owner:EmitSound("ambient/weather/thunder1.wav")
timer.Simple(0.75, function() self.Owner:ChatPrint("instructions: Primary attack: Fire bombs, Secondary attack: Heal yourself every 0.5 seconds, +10 hp, (HOLD) Reload: Protect yourself") end)
return true
end


function SWEP:Deploy() 
     self.Owner:SetHealth("500")
     self.Owner:SetArmor("255")
return true
end


function SWEP:Holster() 
     self.Owner:SetHealth("100")
return true -- So we can switch weapons. duh.
end

function SWEP:PrimaryAttack() 

	if ( !self:CanPrimaryAttack() ) then return end 

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *400 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if ( trace.Hit ) then

                  self.Owner:SendLua("sound.PlayURL('https://files.catbox.moe/x7ublp.mp3','mono noblock', function( s ) s:Play() end)")

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","100") 
			ent:Fire("Explode", 0, 0 ) 

	 
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		self:TakePrimaryAmmo(self.Primary.TakeAmmo) 



	end
end 
end




function SWEP:Reload() 
	self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"small")
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)


	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("Models/effects/comball_tape")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	timer.Simple(0, function() ent:Remove() end) 
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
                  phys:EnableMotion(false)
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



function SWEP:SecondaryAttack()

                  local need = self.HealAmount
	self.Owner:SetHealth( math.min( self.Owner:GetMaxHealth(), self.Owner:Health() + need ) )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 

end

-- "lua\\weapons\\weapon_lenn_end_crystal.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "end_crystal cpvp (2b2t)"			
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

SWEP.Purpose                = "Blow people up close range, If you played on 2b2t in minecraft YOU know what this is."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Blow up someone close range. Reload by pressing R"
SWEP.ViewModel			= "models/weapons/c_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"
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
SWEP.Primary.Sound = "nil" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.Damage = 99999999999 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 256 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 2 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 10 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
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
SWEP.Secondary.Delay = 0.5 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 
SWEP.HealAmount = 10

function SWEP:Initialize() 
self:SetHoldType( "fist" );
self.Owner:EmitSound("ambient/weather/thunder1.wav")
timer.Simple(0.75, function() self.Owner:ChatPrint("instructions: Primary attack: Fire bombs, Secondary attack: Heal yourself every 0.5 seconds, +10 hp, (HOLD) Reload: Protect yourself") end)
return true
end


function SWEP:Deploy() 
     self.Owner:SetHealth("500")
     self.Owner:SetArmor("255")
return true
end


function SWEP:Holster() 
     self.Owner:SetHealth("100")
return true -- So we can switch weapons. duh.
end

function SWEP:PrimaryAttack() 

	if ( !self:CanPrimaryAttack() ) then return end 

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *400 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if ( trace.Hit ) then

                  self.Owner:SendLua("sound.PlayURL('https://files.catbox.moe/x7ublp.mp3','mono noblock', function( s ) s:Play() end)")

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","100") 
			ent:Fire("Explode", 0, 0 ) 

	 
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		self:TakePrimaryAmmo(self.Primary.TakeAmmo) 



	end
end 
end




function SWEP:Reload() 
	self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"small")
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)


	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("Models/effects/comball_tape")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	timer.Simple(0, function() ent:Remove() end) 
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
                  phys:EnableMotion(false)
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



function SWEP:SecondaryAttack()

                  local need = self.HealAmount
	self.Owner:SetHealth( math.min( self.Owner:GetMaxHealth(), self.Owner:Health() + need ) )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 

end

-- "lua\\weapons\\weapon_lenn_end_crystal.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "end_crystal cpvp (2b2t)"			
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

SWEP.Purpose                = "Blow people up close range, If you played on 2b2t in minecraft YOU know what this is."
SWEP.Instructions            = "Shoot your weapon by pressing left click. Blow up someone close range. Reload by pressing R"
SWEP.ViewModel			= "models/weapons/c_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"
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
SWEP.Primary.Sound = "nil" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 32000 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.Damage = 99999999999 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 1 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 9999 // The clipsize
SWEP.Primary.Ammo = "smg1" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 256 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 2 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 10 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 0 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.25 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
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
SWEP.Secondary.Delay = 0.5 // How long time before you can fire again 
SWEP.Secondary.Force = 1000000 // The force of the shot 
 
SWEP.HealAmount = 10

function SWEP:Initialize() 
self:SetHoldType( "fist" );
self.Owner:EmitSound("ambient/weather/thunder1.wav")
timer.Simple(0.75, function() self.Owner:ChatPrint("instructions: Primary attack: Fire bombs, Secondary attack: Heal yourself every 0.5 seconds, +10 hp, (HOLD) Reload: Protect yourself") end)
return true
end


function SWEP:Deploy() 
     self.Owner:SetHealth("500")
     self.Owner:SetArmor("255")
return true
end


function SWEP:Holster() 
     self.Owner:SetHealth("100")
return true -- So we can switch weapons. duh.
end

function SWEP:PrimaryAttack() 

	if ( !self:CanPrimaryAttack() ) then return end 

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *400 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if ( trace.Hit ) then

                  self.Owner:SendLua("sound.PlayURL('https://files.catbox.moe/x7ublp.mp3','mono noblock', function( s ) s:Play() end)")

	local rnda = -self.Primary.Recoil 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	local eyetrace = self.Owner:GetEyeTrace() 
	self:EmitSound ( self.Primary.Sound ) 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","100") 
			ent:Fire("Explode", 0, 0 ) 

	 
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
		self:TakePrimaryAmmo(self.Primary.TakeAmmo) 



	end
end 
end




function SWEP:Reload() 
	self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"small")
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)


	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("Models/effects/comball_tape")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	timer.Simple(0, function() ent:Remove() end) 
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
                  phys:EnableMotion(false)
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



function SWEP:SecondaryAttack()

                  local need = self.HealAmount
	self.Owner:SetHealth( math.min( self.Owner:GetMaxHealth(), self.Owner:Health() + need ) )
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay ) 

end

