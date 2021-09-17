-- "lua\\weapons\\weapon_v8lenn_placeblocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Block Placer"
SWEP.Author			= "aaaaaaaaaaaah not lenn"
SWEP.Instructions 	= "Left click to place blocks. Right click to place bigger blocks"
SWEP.Purpose = "It's exactly what the title of the weapon is. Place blocks"
SWEP.Category = "Lenn's Weapons (MINECRAFT)"

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

SWEP.ViewModel			= "models/hunter/blocks/cube05x05x05.mdl"
SWEP.WorldModel			= "models/hunter/blocks/cube05x05x05.mdl"

local ShootSound1 = Sound( "ambient/energy/newspark01.wav" )
local ShootSound2 = Sound( "ambient/energy/newspark06.wav" )
local ShootSound3 = Sound( "ambient/energy/newspark06.wav" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:Initialize() 
     self:SetHoldType( "fist" ); 
end



function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/hunter/blocks/cube075x075x075.mdl",100,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"big")
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
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 64 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end




-- "lua\\weapons\\weapon_v8lenn_placeblocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Block Placer"
SWEP.Author			= "aaaaaaaaaaaah not lenn"
SWEP.Instructions 	= "Left click to place blocks. Right click to place bigger blocks"
SWEP.Purpose = "It's exactly what the title of the weapon is. Place blocks"
SWEP.Category = "Lenn's Weapons (MINECRAFT)"

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

SWEP.ViewModel			= "models/hunter/blocks/cube05x05x05.mdl"
SWEP.WorldModel			= "models/hunter/blocks/cube05x05x05.mdl"

local ShootSound1 = Sound( "ambient/energy/newspark01.wav" )
local ShootSound2 = Sound( "ambient/energy/newspark06.wav" )
local ShootSound3 = Sound( "ambient/energy/newspark06.wav" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:Initialize() 
     self:SetHoldType( "fist" ); 
end



function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/hunter/blocks/cube075x075x075.mdl",100,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"big")
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
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 64 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end




-- "lua\\weapons\\weapon_v8lenn_placeblocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Block Placer"
SWEP.Author			= "aaaaaaaaaaaah not lenn"
SWEP.Instructions 	= "Left click to place blocks. Right click to place bigger blocks"
SWEP.Purpose = "It's exactly what the title of the weapon is. Place blocks"
SWEP.Category = "Lenn's Weapons (MINECRAFT)"

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

SWEP.ViewModel			= "models/hunter/blocks/cube05x05x05.mdl"
SWEP.WorldModel			= "models/hunter/blocks/cube05x05x05.mdl"

local ShootSound1 = Sound( "ambient/energy/newspark01.wav" )
local ShootSound2 = Sound( "ambient/energy/newspark06.wav" )
local ShootSound3 = Sound( "ambient/energy/newspark06.wav" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:Initialize() 
     self:SetHoldType( "fist" ); 
end



function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/hunter/blocks/cube075x075x075.mdl",100,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"big")
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
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 64 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end




-- "lua\\weapons\\weapon_v8lenn_placeblocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Block Placer"
SWEP.Author			= "aaaaaaaaaaaah not lenn"
SWEP.Instructions 	= "Left click to place blocks. Right click to place bigger blocks"
SWEP.Purpose = "It's exactly what the title of the weapon is. Place blocks"
SWEP.Category = "Lenn's Weapons (MINECRAFT)"

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

SWEP.ViewModel			= "models/hunter/blocks/cube05x05x05.mdl"
SWEP.WorldModel			= "models/hunter/blocks/cube05x05x05.mdl"

local ShootSound1 = Sound( "ambient/energy/newspark01.wav" )
local ShootSound2 = Sound( "ambient/energy/newspark06.wav" )
local ShootSound3 = Sound( "ambient/energy/newspark06.wav" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:Initialize() 
     self:SetHoldType( "fist" ); 
end



function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/hunter/blocks/cube075x075x075.mdl",100,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"big")
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
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 64 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end




-- "lua\\weapons\\weapon_v8lenn_placeblocks.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Block Placer"
SWEP.Author			= "aaaaaaaaaaaah not lenn"
SWEP.Instructions 	= "Left click to place blocks. Right click to place bigger blocks"
SWEP.Purpose = "It's exactly what the title of the weapon is. Place blocks"
SWEP.Category = "Lenn's Weapons (MINECRAFT)"

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

SWEP.ViewModel			= "models/hunter/blocks/cube05x05x05.mdl"
SWEP.WorldModel			= "models/hunter/blocks/cube05x05x05.mdl"

local ShootSound1 = Sound( "ambient/energy/newspark01.wav" )
local ShootSound2 = Sound( "ambient/energy/newspark06.wav" )
local ShootSound3 = Sound( "ambient/energy/newspark06.wav" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )

function SWEP:Initialize() 
     self:SetHoldType( "fist" ); 
end



function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/hunter/blocks/cube075x075x075.mdl",100,"small")
end

function SWEP:Reload()
	self:PlayerAct("dance")
end 

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/hunter/blocks/cube2x2x2.mdl",100,"big")
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
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 64 ) )
                  ent:SetColor( Color( 127, 95, 0, 255 ) ) 
                  ent:SetMaterial("models/props_foliage/tree_deciduous_01a_trunk")
	ent:Spawn()

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "Block" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end




