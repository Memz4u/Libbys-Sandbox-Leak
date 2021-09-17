-- "lua\\weapons\\weapon_v7lenn_lolololol.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Deaf Picture"			
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

SWEP.Purpose                = "Take a picture of somebody and they'll die because of you."
SWEP.Instructions            = "Look at that guy, click the right mouse, and they DIE"

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = Model( "models/MaxOfS2D/camera.mdl" )
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (RARE)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "NPC_CScanner.TakePhoto" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 50 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.15 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 1 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.5 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 1000000000 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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

function SWEP:DoShootEffect()

	self:EmitSound( self.ShootSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( SERVER && !game.SinglePlayer() ) then

		--
		-- Note that the flash effect is only
		-- shown to other players!
		--

		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos + vForward * 256
		trace.filter = self.Owner

		local tr = util.TraceLine( trace )

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "camera_flash", effectdata, true )

	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 90, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 70, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	elseif(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	elseif(ScopeLevel == 3) then
 
		if(SERVER) then
			self.Owner:SetFOV( 30, 0 )
		end	
 
		ScopeLevel = 4
		//This is zoom level 4.
 
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

	self:SetHoldType( "camera" )

end

-- "lua\\weapons\\weapon_v7lenn_lolololol.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Deaf Picture"			
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

SWEP.Purpose                = "Take a picture of somebody and they'll die because of you."
SWEP.Instructions            = "Look at that guy, click the right mouse, and they DIE"

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = Model( "models/MaxOfS2D/camera.mdl" )
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (RARE)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "NPC_CScanner.TakePhoto" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 50 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.15 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 1 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.5 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 1000000000 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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

function SWEP:DoShootEffect()

	self:EmitSound( self.ShootSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( SERVER && !game.SinglePlayer() ) then

		--
		-- Note that the flash effect is only
		-- shown to other players!
		--

		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos + vForward * 256
		trace.filter = self.Owner

		local tr = util.TraceLine( trace )

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "camera_flash", effectdata, true )

	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 90, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 70, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	elseif(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	elseif(ScopeLevel == 3) then
 
		if(SERVER) then
			self.Owner:SetFOV( 30, 0 )
		end	
 
		ScopeLevel = 4
		//This is zoom level 4.
 
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

	self:SetHoldType( "camera" )

end

-- "lua\\weapons\\weapon_v7lenn_lolololol.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Deaf Picture"			
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

SWEP.Purpose                = "Take a picture of somebody and they'll die because of you."
SWEP.Instructions            = "Look at that guy, click the right mouse, and they DIE"

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = Model( "models/MaxOfS2D/camera.mdl" )
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (RARE)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "NPC_CScanner.TakePhoto" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 50 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.15 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 1 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.5 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 1000000000 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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

function SWEP:DoShootEffect()

	self:EmitSound( self.ShootSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( SERVER && !game.SinglePlayer() ) then

		--
		-- Note that the flash effect is only
		-- shown to other players!
		--

		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos + vForward * 256
		trace.filter = self.Owner

		local tr = util.TraceLine( trace )

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "camera_flash", effectdata, true )

	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 90, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 70, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	elseif(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	elseif(ScopeLevel == 3) then
 
		if(SERVER) then
			self.Owner:SetFOV( 30, 0 )
		end	
 
		ScopeLevel = 4
		//This is zoom level 4.
 
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

	self:SetHoldType( "camera" )

end

-- "lua\\weapons\\weapon_v7lenn_lolololol.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Deaf Picture"			
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

SWEP.Purpose                = "Take a picture of somebody and they'll die because of you."
SWEP.Instructions            = "Look at that guy, click the right mouse, and they DIE"

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = Model( "models/MaxOfS2D/camera.mdl" )
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (RARE)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "NPC_CScanner.TakePhoto" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 50 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.15 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 1 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.5 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 1000000000 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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

function SWEP:DoShootEffect()

	self:EmitSound( self.ShootSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( SERVER && !game.SinglePlayer() ) then

		--
		-- Note that the flash effect is only
		-- shown to other players!
		--

		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos + vForward * 256
		trace.filter = self.Owner

		local tr = util.TraceLine( trace )

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "camera_flash", effectdata, true )

	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 90, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 70, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	elseif(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	elseif(ScopeLevel == 3) then
 
		if(SERVER) then
			self.Owner:SetFOV( 30, 0 )
		end	
 
		ScopeLevel = 4
		//This is zoom level 4.
 
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

	self:SetHoldType( "camera" )

end

-- "lua\\weapons\\weapon_v7lenn_lolololol.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Deaf Picture"			
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

SWEP.Purpose                = "Take a picture of somebody and they'll die because of you."
SWEP.Instructions            = "Look at that guy, click the right mouse, and they DIE"

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = Model( "models/MaxOfS2D/camera.mdl" )
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
SWEP.FiresUnderwater = true // If true then the weapons shoots in water. If false then the weapon does not shoot in water.
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (RARE)" // Category name, used to get it from the weapon list.
 
SWEP.DrawAmmo = true // Show's ammo in your hud, True = shows ammo in hud. False = No ammo showed
 
SWEP.ReloadSound = "sound/weapons/alyxgun/alyx_gun_reload.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "NPC_CScanner.TakePhoto" // Weapon sound effect. i choosed the awp one but it requires CSS
SWEP.Primary.Damage = 50 // How much damage the weapon does at its max / NERFED /
SWEP.Primary.TakeAmmo = 0 // How much ammo it takes for one shot.
SWEP.Primary.ClipSize = 10 // The clipsize
SWEP.Primary.Ammo = "ar2" // ammmo type pistol/ smg1 or ar2
SWEP.Primary.DefaultClip = 1337 // How much ammo the weapon gives in total. / NERFED /
SWEP.Primary.Spread = 0.15 // The bullet spread. 0.01 = nospread, anything over 1 would be very terrible spread / NERFED /
SWEP.Primary.NumberofShots = 0 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Makes it able to be shoot automatically / forever just by holding the attack button
SWEP.Primary.Recoil = 1 // How much we should punch the view. higher recoil makes it terribly bad when you wanna shoot it / INCREASED /
SWEP.Primary.Delay = 0.5 // Delay. or how much milliseconds it takes to shoot another bullet after the other bullet was shot. / INCREASED /
SWEP.Primary.Force = 1000000000 // The force of the shot, How strong it can blast objects, high force would be incredibly tough / NERFED /

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

function SWEP:DoShootEffect()

	self:EmitSound( self.ShootSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( SERVER && !game.SinglePlayer() ) then

		--
		-- Note that the flash effect is only
		-- shown to other players!
		--

		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos + vForward * 256
		trace.filter = self.Owner

		local tr = util.TraceLine( trace )

		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos )
		util.Effect( "camera_flash", effectdata, true )

	end

end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 90, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 70, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	elseif(ScopeLevel == 2) then
 
		if(SERVER) then
			self.Owner:SetFOV( 50, 0 )
		end	
 
		ScopeLevel = 3
		//This is zoom level 3.
 
	elseif(ScopeLevel == 3) then
 
		if(SERVER) then
			self.Owner:SetFOV( 30, 0 )
		end	
 
		ScopeLevel = 4
		//This is zoom level 4.
 
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

	self:SetHoldType( "camera" )

end

