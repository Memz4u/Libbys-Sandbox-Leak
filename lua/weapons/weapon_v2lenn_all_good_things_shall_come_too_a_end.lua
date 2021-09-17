-- "lua\\weapons\\weapon_v2lenn_all_good_things_shall_come_too_a_end.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "TAKE CARE OF BABIES"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click to let go of a baby, press right click to let go of 3 babys, press r too cry"
SWEP.Purpose = "You're holding about a zillion babys, and then all the sudden you dropped them all, what happens next? all babys drop, and then die, sucks for you. mate, LETS TRY NOT TOO KILL BABYS, if you do kill a baby, i will come to your house and PUT YOU IN JAIL"
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


local ShootSound1 = Sound( "ambient/voices/m_scream1.wav" )
local ShootSound2 = Sound( "ambient/voices/playground_memory.wav" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song23_suitsong3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You are easily crying because you have dropped a baby and killed a baby, You will not stop crying unless you drop a army of babys or use the tear wiper.")
	self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay  effects/distortion_normal001")
        self.Owner:ConCommand("say  NOOO!!! MY BABIE!")
end

function SWEP:Reload()
	self:PlayerAct("bow")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self.Owner:ConCommand("say  Aah! I dropped my babies! I need too get them!")
	for FireTimes=1,3 do
		self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"big")
                self.Owner:ChatPrint("Ah! Holy crap!")
                self.Owner:ConCommand("pp_mat_overlay rip")
                self.Owner:SetWalkSpeed( "170" )
                self.Owner:SetRunSpeed( "295" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay  effects/water_warp01")
                self.Owner:ConCommand("say  Oh god what have i done. WHAT HAVE I DONE TO BABIES!")
                self.Owner:ChatPrint(":(, Were sad, it suck's for the babys to die, drown, or fall off from you, you know, sometimes, we just have too bow down and pray too the babys, lets hope in the next life, that cibriss and lenn would help all babys be healthy again, :(")
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
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

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

-- "lua\\weapons\\weapon_v2lenn_all_good_things_shall_come_too_a_end.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "TAKE CARE OF BABIES"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click to let go of a baby, press right click to let go of 3 babys, press r too cry"
SWEP.Purpose = "You're holding about a zillion babys, and then all the sudden you dropped them all, what happens next? all babys drop, and then die, sucks for you. mate, LETS TRY NOT TOO KILL BABYS, if you do kill a baby, i will come to your house and PUT YOU IN JAIL"
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


local ShootSound1 = Sound( "ambient/voices/m_scream1.wav" )
local ShootSound2 = Sound( "ambient/voices/playground_memory.wav" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song23_suitsong3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You are easily crying because you have dropped a baby and killed a baby, You will not stop crying unless you drop a army of babys or use the tear wiper.")
	self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay  effects/distortion_normal001")
        self.Owner:ConCommand("say  NOOO!!! MY BABIE!")
end

function SWEP:Reload()
	self:PlayerAct("bow")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self.Owner:ConCommand("say  Aah! I dropped my babies! I need too get them!")
	for FireTimes=1,3 do
		self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"big")
                self.Owner:ChatPrint("Ah! Holy crap!")
                self.Owner:ConCommand("pp_mat_overlay rip")
                self.Owner:SetWalkSpeed( "170" )
                self.Owner:SetRunSpeed( "295" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay  effects/water_warp01")
                self.Owner:ConCommand("say  Oh god what have i done. WHAT HAVE I DONE TO BABIES!")
                self.Owner:ChatPrint(":(, Were sad, it suck's for the babys to die, drown, or fall off from you, you know, sometimes, we just have too bow down and pray too the babys, lets hope in the next life, that cibriss and lenn would help all babys be healthy again, :(")
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
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

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

-- "lua\\weapons\\weapon_v2lenn_all_good_things_shall_come_too_a_end.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "TAKE CARE OF BABIES"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click to let go of a baby, press right click to let go of 3 babys, press r too cry"
SWEP.Purpose = "You're holding about a zillion babys, and then all the sudden you dropped them all, what happens next? all babys drop, and then die, sucks for you. mate, LETS TRY NOT TOO KILL BABYS, if you do kill a baby, i will come to your house and PUT YOU IN JAIL"
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


local ShootSound1 = Sound( "ambient/voices/m_scream1.wav" )
local ShootSound2 = Sound( "ambient/voices/playground_memory.wav" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song23_suitsong3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You are easily crying because you have dropped a baby and killed a baby, You will not stop crying unless you drop a army of babys or use the tear wiper.")
	self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay  effects/distortion_normal001")
        self.Owner:ConCommand("say  NOOO!!! MY BABIE!")
end

function SWEP:Reload()
	self:PlayerAct("bow")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self.Owner:ConCommand("say  Aah! I dropped my babies! I need too get them!")
	for FireTimes=1,3 do
		self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"big")
                self.Owner:ChatPrint("Ah! Holy crap!")
                self.Owner:ConCommand("pp_mat_overlay rip")
                self.Owner:SetWalkSpeed( "170" )
                self.Owner:SetRunSpeed( "295" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay  effects/water_warp01")
                self.Owner:ConCommand("say  Oh god what have i done. WHAT HAVE I DONE TO BABIES!")
                self.Owner:ChatPrint(":(, Were sad, it suck's for the babys to die, drown, or fall off from you, you know, sometimes, we just have too bow down and pray too the babys, lets hope in the next life, that cibriss and lenn would help all babys be healthy again, :(")
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
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

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

-- "lua\\weapons\\weapon_v2lenn_all_good_things_shall_come_too_a_end.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "TAKE CARE OF BABIES"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click to let go of a baby, press right click to let go of 3 babys, press r too cry"
SWEP.Purpose = "You're holding about a zillion babys, and then all the sudden you dropped them all, what happens next? all babys drop, and then die, sucks for you. mate, LETS TRY NOT TOO KILL BABYS, if you do kill a baby, i will come to your house and PUT YOU IN JAIL"
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


local ShootSound1 = Sound( "ambient/voices/m_scream1.wav" )
local ShootSound2 = Sound( "ambient/voices/playground_memory.wav" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song23_suitsong3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You are easily crying because you have dropped a baby and killed a baby, You will not stop crying unless you drop a army of babys or use the tear wiper.")
	self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay  effects/distortion_normal001")
        self.Owner:ConCommand("say  NOOO!!! MY BABIE!")
end

function SWEP:Reload()
	self:PlayerAct("bow")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self.Owner:ConCommand("say  Aah! I dropped my babies! I need too get them!")
	for FireTimes=1,3 do
		self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"big")
                self.Owner:ChatPrint("Ah! Holy crap!")
                self.Owner:ConCommand("pp_mat_overlay rip")
                self.Owner:SetWalkSpeed( "170" )
                self.Owner:SetRunSpeed( "295" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay  effects/water_warp01")
                self.Owner:ConCommand("say  Oh god what have i done. WHAT HAVE I DONE TO BABIES!")
                self.Owner:ChatPrint(":(, Were sad, it suck's for the babys to die, drown, or fall off from you, you know, sometimes, we just have too bow down and pray too the babys, lets hope in the next life, that cibriss and lenn would help all babys be healthy again, :(")
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
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

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

-- "lua\\weapons\\weapon_v2lenn_all_good_things_shall_come_too_a_end.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "TAKE CARE OF BABIES"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click to let go of a baby, press right click to let go of 3 babys, press r too cry"
SWEP.Purpose = "You're holding about a zillion babys, and then all the sudden you dropped them all, what happens next? all babys drop, and then die, sucks for you. mate, LETS TRY NOT TOO KILL BABYS, if you do kill a baby, i will come to your house and PUT YOU IN JAIL"
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


local ShootSound1 = Sound( "ambient/voices/m_scream1.wav" )
local ShootSound2 = Sound( "ambient/voices/playground_memory.wav" )
local ShootSound3 = Sound( "ambient/voices/crying_loop1.wav" )
local ReloadMusic = Sound( "music/hl2_song23_suitsong3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:ChatPrint("You are easily crying because you have dropped a baby and killed a baby, You will not stop crying unless you drop a army of babys or use the tear wiper.")
	self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"small")
        self.Owner:ConCommand("pp_mat_overlay  effects/distortion_normal001")
        self.Owner:ConCommand("say  NOOO!!! MY BABIE!")
end

function SWEP:Reload()
	self:PlayerAct("bow")
        self.Owner:SetWalkSpeed( "150" )
        self.Owner:SetRunSpeed( "200" )      
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 10 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
self.Owner:ConCommand("say  Aah! I dropped my babies! I need too get them!")
	for FireTimes=1,3 do
		self:ThrowMelon("models/maxofs2d/companion_doll.mdl",5000,"big")
                self.Owner:ChatPrint("Ah! Holy crap!")
                self.Owner:ConCommand("pp_mat_overlay rip")
                self.Owner:SetWalkSpeed( "170" )
                self.Owner:SetRunSpeed( "295" )
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
		RunConsoleCommand("act",act)
                self.Owner:ConCommand("pp_mat_overlay  effects/water_warp01")
                self.Owner:ConCommand("say  Oh god what have i done. WHAT HAVE I DONE TO BABIES!")
                self.Owner:ChatPrint(":(, Were sad, it suck's for the babys to die, drown, or fall off from you, you know, sometimes, we just have too bow down and pray too the babys, lets hope in the next life, that cibriss and lenn would help all babys be healthy again, :(")
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
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 170
SWEP.RunSpeed = 280

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

