-- "lua\\weapons\\weapon_v7lenn_disgayswep.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






SWEP.PrintName		= "pee"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "What the fuck? Why should i give you instructions"
SWEP.Purpose = "i mean............ this is hella disgusting"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Spread = 0.3

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Damage = 0


SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "ambient/fire/mtov_flame2.wav" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *140 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )


if ( trace.Hit ) then
if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")
else

local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 

	

self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")


end
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

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
ent:SetPos( self.Owner:GetShootPos() + Forward * 30 + Right * 0 + Up * -20)
ent:SetAngles( self.Owner:EyeAngles() )
ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
ent:Spawn()
             


	

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 0.75, function() ent:Remove() end )



                  timer.Simple( 0.1, function()
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end)
end


function SWEP:Initialize() 
self:SetHoldType( "normal" )
end 


-- "lua\\weapons\\weapon_v7lenn_disgayswep.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






SWEP.PrintName		= "pee"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "What the fuck? Why should i give you instructions"
SWEP.Purpose = "i mean............ this is hella disgusting"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Spread = 0.3

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Damage = 0


SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "ambient/fire/mtov_flame2.wav" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *140 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )


if ( trace.Hit ) then
if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")
else

local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 

	

self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")


end
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

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
ent:SetPos( self.Owner:GetShootPos() + Forward * 30 + Right * 0 + Up * -20)
ent:SetAngles( self.Owner:EyeAngles() )
ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
ent:Spawn()
             


	

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 0.75, function() ent:Remove() end )



                  timer.Simple( 0.1, function()
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end)
end


function SWEP:Initialize() 
self:SetHoldType( "normal" )
end 


-- "lua\\weapons\\weapon_v7lenn_disgayswep.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






SWEP.PrintName		= "pee"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "What the fuck? Why should i give you instructions"
SWEP.Purpose = "i mean............ this is hella disgusting"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Spread = 0.3

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Damage = 0


SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "ambient/fire/mtov_flame2.wav" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *140 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )


if ( trace.Hit ) then
if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")
else

local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 

	

self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")


end
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

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
ent:SetPos( self.Owner:GetShootPos() + Forward * 30 + Right * 0 + Up * -20)
ent:SetAngles( self.Owner:EyeAngles() )
ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
ent:Spawn()
             


	

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 0.75, function() ent:Remove() end )



                  timer.Simple( 0.1, function()
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end)
end


function SWEP:Initialize() 
self:SetHoldType( "normal" )
end 


-- "lua\\weapons\\weapon_v7lenn_disgayswep.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






SWEP.PrintName		= "pee"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "What the fuck? Why should i give you instructions"
SWEP.Purpose = "i mean............ this is hella disgusting"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Spread = 0.3

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Damage = 0


SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "ambient/fire/mtov_flame2.wav" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *140 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )


if ( trace.Hit ) then
if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")
else

local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 

	

self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")


end
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

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
ent:SetPos( self.Owner:GetShootPos() + Forward * 30 + Right * 0 + Up * -20)
ent:SetAngles( self.Owner:EyeAngles() )
ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
ent:Spawn()
             


	

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 0.75, function() ent:Remove() end )



                  timer.Simple( 0.1, function()
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end)
end


function SWEP:Initialize() 
self:SetHoldType( "normal" )
end 


-- "lua\\weapons\\weapon_v7lenn_disgayswep.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






SWEP.PrintName		= "pee"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "What the fuck? Why should i give you instructions"
SWEP.Purpose = "i mean............ this is hella disgusting"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Spread = 0.3

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Damage = 0


SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "ambient/fire/mtov_flame2.wav" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *140 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )


if ( trace.Hit ) then
if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")
else

local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1 
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 

	

self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.05 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/squad/sf_bars/sf_bar25x25x1.mdl",15000,"big")


end
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

local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
ent:SetPos( self.Owner:GetShootPos() + Forward * 30 + Right * 0 + Up * -20)
ent:SetAngles( self.Owner:EyeAngles() )
ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
ent:Spawn()
             


	

 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 0.75, function() ent:Remove() end )



                  timer.Simple( 0.1, function()
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )
 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end)
end


function SWEP:Initialize() 
self:SetHoldType( "normal" )
end 


