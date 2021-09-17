-- "lua\\weapons\\weapon_v6lenn_a_freaking_bomber_beware.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Suicide Bomber"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to blow up on someone.. R to taunt."
SWEP.Purpose = "BEING A TERRORIST IS LIKE HAVING A TANTRUM AND THEN BREAKING YOUR MOMS TV"
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

SWEP.ViewModel			= "models/weapons/v_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"

local ShootSound1 = Sound( "vo/npc/female01/no01.wav" )
local ShootSound2 = Sound( "vo/npc/female01/no02" )
local ShootSound3 = Sound( "vo/npc/female01/nice01.wav" )

local ReloadMusic = Sound( "vo/canals/gunboat_herelook.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/wood_crate002a.mdl",5000,"small")
                  self.Owner:ConCommand("say  ALLAHU AKBAR!.")

	local eyetrace = self.Owner:GetEyeTrace() 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","175") 
			ent:Fire("Explode", 0, 0 ) 
			ent:EmitSound("weapon_AWP.Single", 400, 400 ) 
	 

	end
end 


function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 15 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("",10000,"big")
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
        timer.Simple(/* "Timey", 1, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "THE BIBLE CANNOT BE DELETED" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
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

function SWEP:Initialize()
     self:SetHoldType( "knife" );
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v6lenn_a_freaking_bomber_beware.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Suicide Bomber"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to blow up on someone.. R to taunt."
SWEP.Purpose = "BEING A TERRORIST IS LIKE HAVING A TANTRUM AND THEN BREAKING YOUR MOMS TV"
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

SWEP.ViewModel			= "models/weapons/v_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"

local ShootSound1 = Sound( "vo/npc/female01/no01.wav" )
local ShootSound2 = Sound( "vo/npc/female01/no02" )
local ShootSound3 = Sound( "vo/npc/female01/nice01.wav" )

local ReloadMusic = Sound( "vo/canals/gunboat_herelook.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/wood_crate002a.mdl",5000,"small")
                  self.Owner:ConCommand("say  ALLAHU AKBAR!.")

	local eyetrace = self.Owner:GetEyeTrace() 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","175") 
			ent:Fire("Explode", 0, 0 ) 
			ent:EmitSound("weapon_AWP.Single", 400, 400 ) 
	 

	end
end 


function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 15 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("",10000,"big")
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
        timer.Simple(/* "Timey", 1, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "THE BIBLE CANNOT BE DELETED" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
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

function SWEP:Initialize()
     self:SetHoldType( "knife" );
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v6lenn_a_freaking_bomber_beware.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Suicide Bomber"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to blow up on someone.. R to taunt."
SWEP.Purpose = "BEING A TERRORIST IS LIKE HAVING A TANTRUM AND THEN BREAKING YOUR MOMS TV"
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

SWEP.ViewModel			= "models/weapons/v_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"

local ShootSound1 = Sound( "vo/npc/female01/no01.wav" )
local ShootSound2 = Sound( "vo/npc/female01/no02" )
local ShootSound3 = Sound( "vo/npc/female01/nice01.wav" )

local ReloadMusic = Sound( "vo/canals/gunboat_herelook.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/wood_crate002a.mdl",5000,"small")
                  self.Owner:ConCommand("say  ALLAHU AKBAR!.")

	local eyetrace = self.Owner:GetEyeTrace() 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","175") 
			ent:Fire("Explode", 0, 0 ) 
			ent:EmitSound("weapon_AWP.Single", 400, 400 ) 
	 

	end
end 


function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 15 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("",10000,"big")
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
        timer.Simple(/* "Timey", 1, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "THE BIBLE CANNOT BE DELETED" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
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

function SWEP:Initialize()
     self:SetHoldType( "knife" );
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v6lenn_a_freaking_bomber_beware.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Suicide Bomber"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to blow up on someone.. R to taunt."
SWEP.Purpose = "BEING A TERRORIST IS LIKE HAVING A TANTRUM AND THEN BREAKING YOUR MOMS TV"
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

SWEP.ViewModel			= "models/weapons/v_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"

local ShootSound1 = Sound( "vo/npc/female01/no01.wav" )
local ShootSound2 = Sound( "vo/npc/female01/no02" )
local ShootSound3 = Sound( "vo/npc/female01/nice01.wav" )

local ReloadMusic = Sound( "vo/canals/gunboat_herelook.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/wood_crate002a.mdl",5000,"small")
                  self.Owner:ConCommand("say  ALLAHU AKBAR!.")

	local eyetrace = self.Owner:GetEyeTrace() 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","175") 
			ent:Fire("Explode", 0, 0 ) 
			ent:EmitSound("weapon_AWP.Single", 400, 400 ) 
	 

	end
end 


function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 15 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("",10000,"big")
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
        timer.Simple(/* "Timey", 1, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "THE BIBLE CANNOT BE DELETED" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
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

function SWEP:Initialize()
     self:SetHoldType( "knife" );
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

-- "lua\\weapons\\weapon_v6lenn_a_freaking_bomber_beware.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Suicide Bomber"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Press left click to blow up on someone.. R to taunt."
SWEP.Purpose = "BEING A TERRORIST IS LIKE HAVING A TANTRUM AND THEN BREAKING YOUR MOMS TV"
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

SWEP.ViewModel			= "models/weapons/v_slam.mdl"
SWEP.WorldModel			= "models/weapons/w_slam.mdl"

local ShootSound1 = Sound( "vo/npc/female01/no01.wav" )
local ShootSound2 = Sound( "vo/npc/female01/no02" )
local ShootSound3 = Sound( "vo/npc/female01/nice01.wav" )

local ReloadMusic = Sound( "vo/canals/gunboat_herelook.wav" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_junk/wood_crate002a.mdl",5000,"small")
                  self.Owner:ConCommand("say  ALLAHU AKBAR!.")

	local eyetrace = self.Owner:GetEyeTrace() 
	self:ShootEffects() 
	if SERVER then
		local ent =  ents.Create ("env_explosion")
			ent:SetPos( eyetrace.HitPos ) 
			ent:SetOwner( self.Owner ) 
			ent:Spawn() 
			ent:SetKeyValue("iMagnitude","175") 
			ent:Fire("Explode", 0, 0 ) 
			ent:EmitSound("weapon_AWP.Single", 400, 400 ) 
	 

	end
end 


function SWEP:Reload()
	self:PlayerAct("agree")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 15 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("",10000,"big")
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
        timer.Simple(/* "Timey", 1, */1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "THE BIBLE CANNOT BE DELETED" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end


// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 175
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

function SWEP:Initialize()
     self:SetHoldType( "knife" );
end


-- without return true, the speed will still stay the same even when you holster the weapon!!!

