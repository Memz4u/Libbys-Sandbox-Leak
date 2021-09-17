-- "lua\\weapons\\weapon_v2lenn_egg_scuser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "egg scuser"
SWEP.Author			= "credits too buddy148©, edited by lenn. suggested by Ash"
SWEP.Instructions 	= "Left mouse to fire potatos! R to party and dance! Right mouse to fire 6 mother-fucking-potatos!!!!!!!!!!!"
SWEP.Purpose = "A freaking gun that shoots potatos instead of watermelons, thats all!"
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

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

local ShootSound1 = Sound( "Weapon_Mortar.Impact" )
local ShootSound2 = Sound( "Weapon_FlareGun.Single" )
local ShootSound3 = Sound( "Weapon_FlareGun.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_phx/misc/egg.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,10 do
		self:ThrowMelon("models/props_phx/misc/egg.mdl",1000000,"big")
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
        
                -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)
        timer.Simple(/* "Timey", 10, */1, function() ent:Remove() end )
 
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
 
	undo.Create( "Why_You_Undo_me" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_egg_scuser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "egg scuser"
SWEP.Author			= "credits too buddy148©, edited by lenn. suggested by Ash"
SWEP.Instructions 	= "Left mouse to fire potatos! R to party and dance! Right mouse to fire 6 mother-fucking-potatos!!!!!!!!!!!"
SWEP.Purpose = "A freaking gun that shoots potatos instead of watermelons, thats all!"
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

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

local ShootSound1 = Sound( "Weapon_Mortar.Impact" )
local ShootSound2 = Sound( "Weapon_FlareGun.Single" )
local ShootSound3 = Sound( "Weapon_FlareGun.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_phx/misc/egg.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,10 do
		self:ThrowMelon("models/props_phx/misc/egg.mdl",1000000,"big")
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
        
                -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)
        timer.Simple(/* "Timey", 10, */1, function() ent:Remove() end )
 
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
 
	undo.Create( "Why_You_Undo_me" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_egg_scuser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "egg scuser"
SWEP.Author			= "credits too buddy148©, edited by lenn. suggested by Ash"
SWEP.Instructions 	= "Left mouse to fire potatos! R to party and dance! Right mouse to fire 6 mother-fucking-potatos!!!!!!!!!!!"
SWEP.Purpose = "A freaking gun that shoots potatos instead of watermelons, thats all!"
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

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

local ShootSound1 = Sound( "Weapon_Mortar.Impact" )
local ShootSound2 = Sound( "Weapon_FlareGun.Single" )
local ShootSound3 = Sound( "Weapon_FlareGun.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_phx/misc/egg.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,10 do
		self:ThrowMelon("models/props_phx/misc/egg.mdl",1000000,"big")
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
        
                -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)
        timer.Simple(/* "Timey", 10, */1, function() ent:Remove() end )
 
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
 
	undo.Create( "Why_You_Undo_me" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_egg_scuser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "egg scuser"
SWEP.Author			= "credits too buddy148©, edited by lenn. suggested by Ash"
SWEP.Instructions 	= "Left mouse to fire potatos! R to party and dance! Right mouse to fire 6 mother-fucking-potatos!!!!!!!!!!!"
SWEP.Purpose = "A freaking gun that shoots potatos instead of watermelons, thats all!"
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

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

local ShootSound1 = Sound( "Weapon_Mortar.Impact" )
local ShootSound2 = Sound( "Weapon_FlareGun.Single" )
local ShootSound3 = Sound( "Weapon_FlareGun.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_phx/misc/egg.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,10 do
		self:ThrowMelon("models/props_phx/misc/egg.mdl",1000000,"big")
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
        
                -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)
        timer.Simple(/* "Timey", 10, */1, function() ent:Remove() end )
 
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
 
	undo.Create( "Why_You_Undo_me" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_egg_scuser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "egg scuser"
SWEP.Author			= "credits too buddy148©, edited by lenn. suggested by Ash"
SWEP.Instructions 	= "Left mouse to fire potatos! R to party and dance! Right mouse to fire 6 mother-fucking-potatos!!!!!!!!!!!"
SWEP.Purpose = "A freaking gun that shoots potatos instead of watermelons, thats all!"
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

SWEP.ViewModel			= "models/weapons/v_shotgun.mdl"
SWEP.WorldModel			= "models/weapons/w_shotgun.mdl"

local ShootSound1 = Sound( "Weapon_Mortar.Impact" )
local ShootSound2 = Sound( "Weapon_FlareGun.Single" )
local ShootSound3 = Sound( "Weapon_FlareGun.Single" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_phx/misc/egg.mdl",100000000,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,10 do
		self:ThrowMelon("models/props_phx/misc/egg.mdl",1000000,"big")
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
        
                -- (NEW STUFF IMPLEMENTED FOR THE V3.5 UPDATE)
        timer.Simple(/* "Timey", 10, */1, function() ent:Remove() end )
 
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
 
	undo.Create( "Why_You_Undo_me" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



