-- "lua\\weapons\\weapon_v2lenn_physics_gun_breendesk.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "Physics Gun 2.0 (breendesk)"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "This weapon is used for propkill practices for bots. thank you"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 0

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

SWEP.ViewModel			= "models/weapons/c_superphyscannon.mdl"
SWEP.WorldModel			= "models/weapons/w_physics.mdl"
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 1.25 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_combine/breendesk.mdl",200000000,"big")
end




function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 
bullet.Damage = self.Secondary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.75 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props/cs_militia/refrigerator01.mdl",150000000,"big")
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

                  timer.Simple( 0.05, function() 
	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 

             
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 105 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 4.25, function() ent:Remove() end )



                  timer.Simple( 0.25, function()
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
end)
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 


-- "lua\\weapons\\weapon_v2lenn_physics_gun_breendesk.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "Physics Gun 2.0 (breendesk)"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "This weapon is used for propkill practices for bots. thank you"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 0

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

SWEP.ViewModel			= "models/weapons/c_superphyscannon.mdl"
SWEP.WorldModel			= "models/weapons/w_physics.mdl"
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 1.25 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_combine/breendesk.mdl",200000000,"big")
end




function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 
bullet.Damage = self.Secondary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.75 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props/cs_militia/refrigerator01.mdl",150000000,"big")
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

                  timer.Simple( 0.05, function() 
	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 

             
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 105 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 4.25, function() ent:Remove() end )



                  timer.Simple( 0.25, function()
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
end)
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 


-- "lua\\weapons\\weapon_v2lenn_physics_gun_breendesk.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "Physics Gun 2.0 (breendesk)"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "This weapon is used for propkill practices for bots. thank you"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 0

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

SWEP.ViewModel			= "models/weapons/c_superphyscannon.mdl"
SWEP.WorldModel			= "models/weapons/w_physics.mdl"
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 1.25 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_combine/breendesk.mdl",200000000,"big")
end




function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 
bullet.Damage = self.Secondary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.75 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props/cs_militia/refrigerator01.mdl",150000000,"big")
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

                  timer.Simple( 0.05, function() 
	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 

             
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 105 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 4.25, function() ent:Remove() end )



                  timer.Simple( 0.25, function()
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
end)
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 


-- "lua\\weapons\\weapon_v2lenn_physics_gun_breendesk.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "Physics Gun 2.0 (breendesk)"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "This weapon is used for propkill practices for bots. thank you"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 0

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

SWEP.ViewModel			= "models/weapons/c_superphyscannon.mdl"
SWEP.WorldModel			= "models/weapons/w_physics.mdl"
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 1.25 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_combine/breendesk.mdl",200000000,"big")
end




function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 
bullet.Damage = self.Secondary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.75 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props/cs_militia/refrigerator01.mdl",150000000,"big")
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

                  timer.Simple( 0.05, function() 
	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 

             
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 105 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 4.25, function() ent:Remove() end )



                  timer.Simple( 0.25, function()
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
end)
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 


-- "lua\\weapons\\weapon_v2lenn_physics_gun_breendesk.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "Physics Gun 2.0 (breendesk)"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "This weapon is used for propkill practices for bots. thank you"
SWEP.Category = "Lenn's Weapons (RARE)"




SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Damage = 0

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

SWEP.ViewModel			= "models/weapons/c_superphyscannon.mdl"
SWEP.WorldModel			= "models/weapons/w_physics.mdl"
SWEP.ViewModelFOV = 54


local ShootSound1 = Sound( "" )
local ShootSound2 = Sound( "" )
local ShootSound3 = Sound( "" )
local ReloadMusic = Sound( "music/hl1_song25_remix3.mp3" )


function SWEP:PrimaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Primary.Ammo 
bullet.Damage = self.Primary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	self.Weapon:SetNextPrimaryFire( CurTime() + 1.25 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_combine/breendesk.mdl",200000000,"big")
end




function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 
bullet.Damage = self.Secondary.Damage 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.75 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,1 do
		self:ThrowMelon("models/props/cs_militia/refrigerator01.mdl",150000000,"big")
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

                  timer.Simple( 0.05, function() 
	if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 

             
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 105 ) )
	ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
        
         timer.Simple( 4.25, function() ent:Remove() end )



                  timer.Simple( 0.25, function()
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
end)
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 


