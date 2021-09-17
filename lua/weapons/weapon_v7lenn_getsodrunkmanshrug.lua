-- "lua\\weapons\\weapon_v7lenn_getsodrunkmanshrug.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Your medication pills"
SWEP.Author			= "Credits to shrug: A friend of lenn, suggested to create this weapon"
SWEP.Instructions 	= "Press right click to get drunk, seriously yes if you want to be drunk you do this"
SWEP.Purpose = "What's wrong with you? The purpose of this swep is to make you felt like you had been disclipined, that also mean's you got drunk! If the cops see you drunk, please suggest running away. But after all, this is the type of pills that give you nightmares."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/companion_doll.mdl"
SWEP.WorldModel                 = "models/maxofs2d/companion_doll.mdl"


local owner = self

local ShootSound1 = Sound( "music/hl2_ambient_1.wav" )
local ShootSound2 = Sound( "music/hl2_song8.mp3" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song6.mp3" )

function SWEP:PrimaryAttack()
if (IsValid(self.Owner)) then
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You're just drunk. Literal drunk. Please die in a minecart or change weapons to stop from being DRUNK.")
	self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay effects/dodge_overlay")
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.02")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 0.5")
       timer.Simple( 1, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("-right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 3, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 4, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 6, function()self.Owner:ConCommand("-right") end)
 



        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end
end

function SWEP:Reload()
	self:PlayerAct("dance")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.05")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 20")

	for FireTimes=1,3 do
		self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"big")
                self.Owner:ChatPrint("You're just broke now.............")
                self.Owner:ConCommand("pp_mat_overlay models/shadertest/shader4")
                self.Owner:SetWalkSpeed( "100" )
                self.Owner:SetRunSpeed( "155" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay effects/water_warp01")
                self.Owner:ConCommand("pp_texturize pp/texturize/rainbow.png")
                self.Owner:ChatPrint("You're just screwed now. You're just god damn screwed.")
                        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 100")
	end
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)

	if melontype == "big" then
		self:EmitSound( ShootSound1 )
	elseif melontype == "small" then
		self:EmitSound( ShootSound2 )
	else
		self:EmitSound( ShootSound3 )
	end

	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "The doll died, :(" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- UPDATE 8/9/2020 -- thank for fix blackraven.....................
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end




-- "lua\\weapons\\weapon_v7lenn_getsodrunkmanshrug.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Your medication pills"
SWEP.Author			= "Credits to shrug: A friend of lenn, suggested to create this weapon"
SWEP.Instructions 	= "Press right click to get drunk, seriously yes if you want to be drunk you do this"
SWEP.Purpose = "What's wrong with you? The purpose of this swep is to make you felt like you had been disclipined, that also mean's you got drunk! If the cops see you drunk, please suggest running away. But after all, this is the type of pills that give you nightmares."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/companion_doll.mdl"
SWEP.WorldModel                 = "models/maxofs2d/companion_doll.mdl"


local owner = self

local ShootSound1 = Sound( "music/hl2_ambient_1.wav" )
local ShootSound2 = Sound( "music/hl2_song8.mp3" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song6.mp3" )

function SWEP:PrimaryAttack()
if (IsValid(self.Owner)) then
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You're just drunk. Literal drunk. Please die in a minecart or change weapons to stop from being DRUNK.")
	self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay effects/dodge_overlay")
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.02")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 0.5")
       timer.Simple( 1, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("-right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 3, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 4, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 6, function()self.Owner:ConCommand("-right") end)
 



        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end
end

function SWEP:Reload()
	self:PlayerAct("dance")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.05")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 20")

	for FireTimes=1,3 do
		self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"big")
                self.Owner:ChatPrint("You're just broke now.............")
                self.Owner:ConCommand("pp_mat_overlay models/shadertest/shader4")
                self.Owner:SetWalkSpeed( "100" )
                self.Owner:SetRunSpeed( "155" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay effects/water_warp01")
                self.Owner:ConCommand("pp_texturize pp/texturize/rainbow.png")
                self.Owner:ChatPrint("You're just screwed now. You're just god damn screwed.")
                        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 100")
	end
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)

	if melontype == "big" then
		self:EmitSound( ShootSound1 )
	elseif melontype == "small" then
		self:EmitSound( ShootSound2 )
	else
		self:EmitSound( ShootSound3 )
	end

	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "The doll died, :(" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- UPDATE 8/9/2020 -- thank for fix blackraven.....................
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end




-- "lua\\weapons\\weapon_v7lenn_getsodrunkmanshrug.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Your medication pills"
SWEP.Author			= "Credits to shrug: A friend of lenn, suggested to create this weapon"
SWEP.Instructions 	= "Press right click to get drunk, seriously yes if you want to be drunk you do this"
SWEP.Purpose = "What's wrong with you? The purpose of this swep is to make you felt like you had been disclipined, that also mean's you got drunk! If the cops see you drunk, please suggest running away. But after all, this is the type of pills that give you nightmares."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/companion_doll.mdl"
SWEP.WorldModel                 = "models/maxofs2d/companion_doll.mdl"


local owner = self

local ShootSound1 = Sound( "music/hl2_ambient_1.wav" )
local ShootSound2 = Sound( "music/hl2_song8.mp3" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song6.mp3" )

function SWEP:PrimaryAttack()
if (IsValid(self.Owner)) then
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You're just drunk. Literal drunk. Please die in a minecart or change weapons to stop from being DRUNK.")
	self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay effects/dodge_overlay")
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.02")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 0.5")
       timer.Simple( 1, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("-right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 3, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 4, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 6, function()self.Owner:ConCommand("-right") end)
 



        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end
end

function SWEP:Reload()
	self:PlayerAct("dance")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.05")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 20")

	for FireTimes=1,3 do
		self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"big")
                self.Owner:ChatPrint("You're just broke now.............")
                self.Owner:ConCommand("pp_mat_overlay models/shadertest/shader4")
                self.Owner:SetWalkSpeed( "100" )
                self.Owner:SetRunSpeed( "155" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay effects/water_warp01")
                self.Owner:ConCommand("pp_texturize pp/texturize/rainbow.png")
                self.Owner:ChatPrint("You're just screwed now. You're just god damn screwed.")
                        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 100")
	end
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)

	if melontype == "big" then
		self:EmitSound( ShootSound1 )
	elseif melontype == "small" then
		self:EmitSound( ShootSound2 )
	else
		self:EmitSound( ShootSound3 )
	end

	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "The doll died, :(" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- UPDATE 8/9/2020 -- thank for fix blackraven.....................
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end




-- "lua\\weapons\\weapon_v7lenn_getsodrunkmanshrug.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Your medication pills"
SWEP.Author			= "Credits to shrug: A friend of lenn, suggested to create this weapon"
SWEP.Instructions 	= "Press right click to get drunk, seriously yes if you want to be drunk you do this"
SWEP.Purpose = "What's wrong with you? The purpose of this swep is to make you felt like you had been disclipined, that also mean's you got drunk! If the cops see you drunk, please suggest running away. But after all, this is the type of pills that give you nightmares."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/companion_doll.mdl"
SWEP.WorldModel                 = "models/maxofs2d/companion_doll.mdl"


local owner = self

local ShootSound1 = Sound( "music/hl2_ambient_1.wav" )
local ShootSound2 = Sound( "music/hl2_song8.mp3" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song6.mp3" )

function SWEP:PrimaryAttack()
if (IsValid(self.Owner)) then
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You're just drunk. Literal drunk. Please die in a minecart or change weapons to stop from being DRUNK.")
	self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay effects/dodge_overlay")
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.02")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 0.5")
       timer.Simple( 1, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("-right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 3, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 4, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 6, function()self.Owner:ConCommand("-right") end)
 



        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end
end

function SWEP:Reload()
	self:PlayerAct("dance")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.05")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 20")

	for FireTimes=1,3 do
		self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"big")
                self.Owner:ChatPrint("You're just broke now.............")
                self.Owner:ConCommand("pp_mat_overlay models/shadertest/shader4")
                self.Owner:SetWalkSpeed( "100" )
                self.Owner:SetRunSpeed( "155" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay effects/water_warp01")
                self.Owner:ConCommand("pp_texturize pp/texturize/rainbow.png")
                self.Owner:ChatPrint("You're just screwed now. You're just god damn screwed.")
                        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 100")
	end
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)

	if melontype == "big" then
		self:EmitSound( ShootSound1 )
	elseif melontype == "small" then
		self:EmitSound( ShootSound2 )
	else
		self:EmitSound( ShootSound3 )
	end

	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "The doll died, :(" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- UPDATE 8/9/2020 -- thank for fix blackraven.....................
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end




-- "lua\\weapons\\weapon_v7lenn_getsodrunkmanshrug.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Your medication pills"
SWEP.Author			= "Credits to shrug: A friend of lenn, suggested to create this weapon"
SWEP.Instructions 	= "Press right click to get drunk, seriously yes if you want to be drunk you do this"
SWEP.Purpose = "What's wrong with you? The purpose of this swep is to make you felt like you had been disclipined, that also mean's you got drunk! If the cops see you drunk, please suggest running away. But after all, this is the type of pills that give you nightmares."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/companion_doll.mdl"
SWEP.WorldModel                 = "models/maxofs2d/companion_doll.mdl"


local owner = self

local ShootSound1 = Sound( "music/hl2_ambient_1.wav" )
local ShootSound2 = Sound( "music/hl2_song8.mp3" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song6.mp3" )

function SWEP:PrimaryAttack()
if (IsValid(self.Owner)) then
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You're just drunk. Literal drunk. Please die in a minecart or change weapons to stop from being DRUNK.")
	self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay effects/dodge_overlay")
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.02")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 0.5")
       timer.Simple( 1, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("-right") end)
       timer.Simple( 2, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 3, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 4, function()self.Owner:ConCommand("+left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("-left") end)
       timer.Simple( 5, function()self.Owner:ConCommand("+right") end)
       timer.Simple( 6, function()self.Owner:ConCommand("-right") end)
 



        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end
end

function SWEP:Reload()
	self:PlayerAct("dance")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:ConCommand("pp_motionblur 1")
        self.Owner:ConCommand("pp_motionblur_delay 0.05")
        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 20")

	for FireTimes=1,3 do
		self:ThrowMelon("models/props_junk/garbage_glassbottle001a.mdl",5000,"big")
                self.Owner:ChatPrint("You're just broke now.............")
                self.Owner:ConCommand("pp_mat_overlay models/shadertest/shader4")
                self.Owner:SetWalkSpeed( "100" )
                self.Owner:SetRunSpeed( "155" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay effects/water_warp01")
                self.Owner:ConCommand("pp_texturize pp/texturize/rainbow.png")
                self.Owner:ChatPrint("You're just screwed now. You're just god damn screwed.")
                        self.Owner:ConCommand("pp_sobel 1")
        self.Owner:ConCommand("pp_sharpen 1")
        self.Owner:ConCommand("pp_sharpen_contrast 100")
	end
end

function SWEP:ThrowMelon(model_file,set_velocity,melontype)

	if melontype == "big" then
		self:EmitSound( ShootSound1 )
	elseif melontype == "small" then
		self:EmitSound( ShootSound2 )
	else
		self:EmitSound( ShootSound3 )
	end

	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "The doll died, :(" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- UPDATE 8/9/2020 -- thank for fix blackraven.....................
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

-- we need too change the walkspeed and runspeed when it's deployed. let us change it!
function SWEP:Deploy()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( self.WalkSpeed )
self.Owner:SetRunSpeed( self.RunSpeed )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when it's gone!
function SWEP:OnRemove()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end

-- we can't let the walkspeed and runspeed stay there when you change to a different weapon! (holster = putting gun away, but not removed)
function SWEP:Holster()
if (IsValid(self.Owner)) then
self.Owner:SetWalkSpeed( "200" )
self.Owner:SetRunSpeed( "400" )
self.Owner:ConCommand("pp_mat_overlay  No.")
RunConsoleCommand("pp_texturize","")
self.Owner:ConCommand("pp_motionblur  0")
        self.Owner:ConCommand("pp_sobel  0")
        self.Owner:ConCommand("pp_sharpen  0")
        self.Owner:ConCommand("pp_sharpen_contrast  0.5")
        self.Owner:ConCommand("-right")
        self.Owner:ConCommand("-left")
end

return true
end




