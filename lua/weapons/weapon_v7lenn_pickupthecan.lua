-- "lua\\weapons\\weapon_v7lenn_pickupthecan.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- yes professor i obey you i will fix this grammar mistake >>> 3/22/2020


SWEP.PrintName		= "Pick up that can"
SWEP.Author			= "Created by lenn"
SWEP.Instructions 	= "What? It was obvious.."
SWEP.Purpose = "Use this ordinary swep to embrass your friends and disclipine them."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"




SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel			= "models/props_junk/PopCan01a.mdl"
SWEP.WorldModel			= "models/props_junk/PopCan01a.mdl"

local ShootSound1 = Sound( "npc/metropolice/vo/putitinthetrash1.wav" )
local ShootSound2 = Sound( "npc/metropolice/vo/pickupthecan1.wav" )
local ShootSound3 = Sound( "vo/ravenholm/monk_rant02.wav" )

local ReloadMusic = Sound( "npc/metropolice/vo/allrightyoucango.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/PopCan01a.mdl",50,"small")
                  self.Owner:ConCommand("say  Pick up that can.")
end



function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props_trainstation/trashcan_indoor001b.mdl",00,"big")
                                    self.Owner:ConCommand("say  Now put it, in the trashcan.")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
                                    self.Owner:ConCommand("say  Alright, You can go.")
		RunConsoleCommand("act",act)
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

        -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)


 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Did you pick up the can?" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 220
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

-- "lua\\weapons\\weapon_v7lenn_pickupthecan.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- yes professor i obey you i will fix this grammar mistake >>> 3/22/2020


SWEP.PrintName		= "Pick up that can"
SWEP.Author			= "Created by lenn"
SWEP.Instructions 	= "What? It was obvious.."
SWEP.Purpose = "Use this ordinary swep to embrass your friends and disclipine them."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"




SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel			= "models/props_junk/PopCan01a.mdl"
SWEP.WorldModel			= "models/props_junk/PopCan01a.mdl"

local ShootSound1 = Sound( "npc/metropolice/vo/putitinthetrash1.wav" )
local ShootSound2 = Sound( "npc/metropolice/vo/pickupthecan1.wav" )
local ShootSound3 = Sound( "vo/ravenholm/monk_rant02.wav" )

local ReloadMusic = Sound( "npc/metropolice/vo/allrightyoucango.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/PopCan01a.mdl",50,"small")
                  self.Owner:ConCommand("say  Pick up that can.")
end



function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props_trainstation/trashcan_indoor001b.mdl",00,"big")
                                    self.Owner:ConCommand("say  Now put it, in the trashcan.")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
                                    self.Owner:ConCommand("say  Alright, You can go.")
		RunConsoleCommand("act",act)
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

        -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)


 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Did you pick up the can?" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 220
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

-- "lua\\weapons\\weapon_v7lenn_pickupthecan.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- yes professor i obey you i will fix this grammar mistake >>> 3/22/2020


SWEP.PrintName		= "Pick up that can"
SWEP.Author			= "Created by lenn"
SWEP.Instructions 	= "What? It was obvious.."
SWEP.Purpose = "Use this ordinary swep to embrass your friends and disclipine them."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"




SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel			= "models/props_junk/PopCan01a.mdl"
SWEP.WorldModel			= "models/props_junk/PopCan01a.mdl"

local ShootSound1 = Sound( "npc/metropolice/vo/putitinthetrash1.wav" )
local ShootSound2 = Sound( "npc/metropolice/vo/pickupthecan1.wav" )
local ShootSound3 = Sound( "vo/ravenholm/monk_rant02.wav" )

local ReloadMusic = Sound( "npc/metropolice/vo/allrightyoucango.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/PopCan01a.mdl",50,"small")
                  self.Owner:ConCommand("say  Pick up that can.")
end



function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props_trainstation/trashcan_indoor001b.mdl",00,"big")
                                    self.Owner:ConCommand("say  Now put it, in the trashcan.")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
                                    self.Owner:ConCommand("say  Alright, You can go.")
		RunConsoleCommand("act",act)
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

        -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)


 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Did you pick up the can?" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 220
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

-- "lua\\weapons\\weapon_v7lenn_pickupthecan.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- yes professor i obey you i will fix this grammar mistake >>> 3/22/2020


SWEP.PrintName		= "Pick up that can"
SWEP.Author			= "Created by lenn"
SWEP.Instructions 	= "What? It was obvious.."
SWEP.Purpose = "Use this ordinary swep to embrass your friends and disclipine them."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"




SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel			= "models/props_junk/PopCan01a.mdl"
SWEP.WorldModel			= "models/props_junk/PopCan01a.mdl"

local ShootSound1 = Sound( "npc/metropolice/vo/putitinthetrash1.wav" )
local ShootSound2 = Sound( "npc/metropolice/vo/pickupthecan1.wav" )
local ShootSound3 = Sound( "vo/ravenholm/monk_rant02.wav" )

local ReloadMusic = Sound( "npc/metropolice/vo/allrightyoucango.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/PopCan01a.mdl",50,"small")
                  self.Owner:ConCommand("say  Pick up that can.")
end



function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props_trainstation/trashcan_indoor001b.mdl",00,"big")
                                    self.Owner:ConCommand("say  Now put it, in the trashcan.")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
                                    self.Owner:ConCommand("say  Alright, You can go.")
		RunConsoleCommand("act",act)
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

        -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)


 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Did you pick up the can?" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 220
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

-- "lua\\weapons\\weapon_v7lenn_pickupthecan.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- yes professor i obey you i will fix this grammar mistake >>> 3/22/2020


SWEP.PrintName		= "Pick up that can"
SWEP.Author			= "Created by lenn"
SWEP.Instructions 	= "What? It was obvious.."
SWEP.Purpose = "Use this ordinary swep to embrass your friends and disclipine them."
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"




SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel			= "models/props_junk/PopCan01a.mdl"
SWEP.WorldModel			= "models/props_junk/PopCan01a.mdl"

local ShootSound1 = Sound( "npc/metropolice/vo/putitinthetrash1.wav" )
local ShootSound2 = Sound( "npc/metropolice/vo/pickupthecan1.wav" )
local ShootSound3 = Sound( "vo/ravenholm/monk_rant02.wav" )

local ReloadMusic = Sound( "npc/metropolice/vo/allrightyoucango.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/PopCan01a.mdl",50,"small")
                  self.Owner:ConCommand("say  Pick up that can.")
end



function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props_trainstation/trashcan_indoor001b.mdl",00,"big")
                                    self.Owner:ConCommand("say  Now put it, in the trashcan.")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
                                    self.Owner:ConCommand("say  Alright, You can go.")
		RunConsoleCommand("act",act)
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

        -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)


 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Did you pick up the can?" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 220
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

