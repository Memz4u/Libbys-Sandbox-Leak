-- "lua\\weapons\\weapon_v4lenn_rock_thrower_throw_rocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Rock Thrower"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to throw a giant rock at your enemys, (regeneration takes about 7.0 seconds) and right click to throw bigger bits of rocks at people."
SWEP.Purpose = "Do you hate your friends that throw little tiny rocks at you? Well don't worry, afterall, you can get a REVENGE on them, just simply get the rock thrower, all the sudden you have a giant rock holding at your hand, throw at them for revenge, they'll regret whatever they had done to you, :)"
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

SWEP.ViewModel			= "models/props_wasteland/rockgranite02c.mdl"
SWEP.WorldModel			= "models/props_wasteland/rockgranite02c.mdl"

local ShootSound1 = Sound( "physics/concrete/concrete_break2.wav" )
local ShootSound2 = Sound( "physics/concrete/boulder_impact_hard1.wav" )
local ShootSound3 = Sound( "physics/concrete/boulder_impact_hard2.wav" )
local ReloadMusic = Sound( "weapons/stunstick/stunstick_impact1.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 7.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_wasteland/rockgranite02c.mdl",70000,"small")
end

function SWEP:Reload()
	self:PlayerAct("laugh")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 3.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/props_wasteland/rockgranite03a.mdl",40000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
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
        timer.Simple(/* "Timey", 10000, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Thrown_Potato" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 100
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v4lenn_rock_thrower_throw_rocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Rock Thrower"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to throw a giant rock at your enemys, (regeneration takes about 7.0 seconds) and right click to throw bigger bits of rocks at people."
SWEP.Purpose = "Do you hate your friends that throw little tiny rocks at you? Well don't worry, afterall, you can get a REVENGE on them, just simply get the rock thrower, all the sudden you have a giant rock holding at your hand, throw at them for revenge, they'll regret whatever they had done to you, :)"
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

SWEP.ViewModel			= "models/props_wasteland/rockgranite02c.mdl"
SWEP.WorldModel			= "models/props_wasteland/rockgranite02c.mdl"

local ShootSound1 = Sound( "physics/concrete/concrete_break2.wav" )
local ShootSound2 = Sound( "physics/concrete/boulder_impact_hard1.wav" )
local ShootSound3 = Sound( "physics/concrete/boulder_impact_hard2.wav" )
local ReloadMusic = Sound( "weapons/stunstick/stunstick_impact1.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 7.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_wasteland/rockgranite02c.mdl",70000,"small")
end

function SWEP:Reload()
	self:PlayerAct("laugh")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 3.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/props_wasteland/rockgranite03a.mdl",40000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
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
        timer.Simple(/* "Timey", 10000, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Thrown_Potato" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 100
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v4lenn_rock_thrower_throw_rocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Rock Thrower"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to throw a giant rock at your enemys, (regeneration takes about 7.0 seconds) and right click to throw bigger bits of rocks at people."
SWEP.Purpose = "Do you hate your friends that throw little tiny rocks at you? Well don't worry, afterall, you can get a REVENGE on them, just simply get the rock thrower, all the sudden you have a giant rock holding at your hand, throw at them for revenge, they'll regret whatever they had done to you, :)"
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

SWEP.ViewModel			= "models/props_wasteland/rockgranite02c.mdl"
SWEP.WorldModel			= "models/props_wasteland/rockgranite02c.mdl"

local ShootSound1 = Sound( "physics/concrete/concrete_break2.wav" )
local ShootSound2 = Sound( "physics/concrete/boulder_impact_hard1.wav" )
local ShootSound3 = Sound( "physics/concrete/boulder_impact_hard2.wav" )
local ReloadMusic = Sound( "weapons/stunstick/stunstick_impact1.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 7.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_wasteland/rockgranite02c.mdl",70000,"small")
end

function SWEP:Reload()
	self:PlayerAct("laugh")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 3.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/props_wasteland/rockgranite03a.mdl",40000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
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
        timer.Simple(/* "Timey", 10000, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Thrown_Potato" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 100
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v4lenn_rock_thrower_throw_rocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Rock Thrower"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to throw a giant rock at your enemys, (regeneration takes about 7.0 seconds) and right click to throw bigger bits of rocks at people."
SWEP.Purpose = "Do you hate your friends that throw little tiny rocks at you? Well don't worry, afterall, you can get a REVENGE on them, just simply get the rock thrower, all the sudden you have a giant rock holding at your hand, throw at them for revenge, they'll regret whatever they had done to you, :)"
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

SWEP.ViewModel			= "models/props_wasteland/rockgranite02c.mdl"
SWEP.WorldModel			= "models/props_wasteland/rockgranite02c.mdl"

local ShootSound1 = Sound( "physics/concrete/concrete_break2.wav" )
local ShootSound2 = Sound( "physics/concrete/boulder_impact_hard1.wav" )
local ShootSound3 = Sound( "physics/concrete/boulder_impact_hard2.wav" )
local ReloadMusic = Sound( "weapons/stunstick/stunstick_impact1.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 7.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_wasteland/rockgranite02c.mdl",70000,"small")
end

function SWEP:Reload()
	self:PlayerAct("laugh")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 3.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/props_wasteland/rockgranite03a.mdl",40000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
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
        timer.Simple(/* "Timey", 10000, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Thrown_Potato" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 100
SWEP.RunSpeed = 150

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

-- "lua\\weapons\\weapon_v4lenn_rock_thrower_throw_rocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Rock Thrower"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to throw a giant rock at your enemys, (regeneration takes about 7.0 seconds) and right click to throw bigger bits of rocks at people."
SWEP.Purpose = "Do you hate your friends that throw little tiny rocks at you? Well don't worry, afterall, you can get a REVENGE on them, just simply get the rock thrower, all the sudden you have a giant rock holding at your hand, throw at them for revenge, they'll regret whatever they had done to you, :)"
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

SWEP.ViewModel			= "models/props_wasteland/rockgranite02c.mdl"
SWEP.WorldModel			= "models/props_wasteland/rockgranite02c.mdl"

local ShootSound1 = Sound( "physics/concrete/concrete_break2.wav" )
local ShootSound2 = Sound( "physics/concrete/boulder_impact_hard1.wav" )
local ShootSound3 = Sound( "physics/concrete/boulder_impact_hard2.wav" )
local ReloadMusic = Sound( "weapons/stunstick/stunstick_impact1.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 7.0 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_wasteland/rockgranite02c.mdl",70000,"small")
end

function SWEP:Reload()
	self:PlayerAct("laugh")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 3.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/props_wasteland/rockgranite03a.mdl",40000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( ReloadMusic )
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
        timer.Simple(/* "Timey", 10000, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Thrown_Potato" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 100
SWEP.RunSpeed = 150

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

