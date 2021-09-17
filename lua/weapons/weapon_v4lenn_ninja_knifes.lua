-- "lua\\weapons\\weapon_v4lenn_ninja_knifes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Ninja Knifes"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Right click to throw knifes, Left click to throw more knifes."
SWEP.Purpose = "Throw knifes at people."
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

SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

local ShootSound1 = Sound( "Weapon_Crowbar.Single" )
local ShootSound2 = Sound( "Weapon_Crowbar.Single" )
local ShootSound3 = Sound( "Weapon_Crowbar.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/weapons/w_knife_t.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5.25 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/weapons/w_knife_t.mdl",100000,"big")
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
        timer.Simple(/* "Timey", 20, */1, function() ent:Remove() end )
 
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



-- "lua\\weapons\\weapon_v4lenn_ninja_knifes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Ninja Knifes"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Right click to throw knifes, Left click to throw more knifes."
SWEP.Purpose = "Throw knifes at people."
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

SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

local ShootSound1 = Sound( "Weapon_Crowbar.Single" )
local ShootSound2 = Sound( "Weapon_Crowbar.Single" )
local ShootSound3 = Sound( "Weapon_Crowbar.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/weapons/w_knife_t.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5.25 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/weapons/w_knife_t.mdl",100000,"big")
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
        timer.Simple(/* "Timey", 20, */1, function() ent:Remove() end )
 
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



-- "lua\\weapons\\weapon_v4lenn_ninja_knifes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Ninja Knifes"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Right click to throw knifes, Left click to throw more knifes."
SWEP.Purpose = "Throw knifes at people."
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

SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

local ShootSound1 = Sound( "Weapon_Crowbar.Single" )
local ShootSound2 = Sound( "Weapon_Crowbar.Single" )
local ShootSound3 = Sound( "Weapon_Crowbar.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/weapons/w_knife_t.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5.25 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/weapons/w_knife_t.mdl",100000,"big")
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
        timer.Simple(/* "Timey", 20, */1, function() ent:Remove() end )
 
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



-- "lua\\weapons\\weapon_v4lenn_ninja_knifes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Ninja Knifes"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Right click to throw knifes, Left click to throw more knifes."
SWEP.Purpose = "Throw knifes at people."
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

SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

local ShootSound1 = Sound( "Weapon_Crowbar.Single" )
local ShootSound2 = Sound( "Weapon_Crowbar.Single" )
local ShootSound3 = Sound( "Weapon_Crowbar.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/weapons/w_knife_t.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5.25 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/weapons/w_knife_t.mdl",100000,"big")
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
        timer.Simple(/* "Timey", 20, */1, function() ent:Remove() end )
 
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



-- "lua\\weapons\\weapon_v4lenn_ninja_knifes.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Ninja Knifes"
SWEP.Author			= "credits too buddy148©, edited by lenn. Secretly suggested by Aquantic, credits too Ash for the filename,"
SWEP.Instructions 	= "Right click to throw knifes, Left click to throw more knifes."
SWEP.Purpose = "Throw knifes at people."
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

SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

local ShootSound1 = Sound( "Weapon_Crowbar.Single" )
local ShootSound2 = Sound( "Weapon_Crowbar.Single" )
local ShootSound3 = Sound( "Weapon_Crowbar.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/weapons/w_knife_t.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 5.25 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,3 do
		self:ThrowMelon("models/weapons/w_knife_t.mdl",100000,"big")
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
        timer.Simple(/* "Timey", 20, */1, function() ent:Remove() end )
 
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



