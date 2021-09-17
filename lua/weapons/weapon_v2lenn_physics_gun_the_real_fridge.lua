-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_fridge.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "BOTS ONLY FRIDGE"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "A minge gun is a gun that shoots props used too prop kill, example: fridge, and a tide gates, This weapon is knowned as the: error shooter if nobody had counter-strike source. (sticky would love this)"
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"




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

local ShootSound1 = Sound( "")
local ShootSound2 = Sound( "")
local ShootSound3 = Sound( "")
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
 

self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()


	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.55,1) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
                  self.Owner:SetVelocity(aimvector *  1250 )         
	self:ThrowMelon("models/props/CS_militia/refrigerator01.mdl",200000000,"big")               
                  self.Owner:SetVelocity(aimvector *  1250 ) 
 
                  if self.Owner:OnGround() then 
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",100,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
    
                  timer.Simple( 0.1, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-1000,1000) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(-500,-1000) ) end )

                
                  end         

end

function SWEP:Reload()

local aimvector = self.Owner:GetAimVector()
	self.Owner:SetVelocity(aimvector * 1000 )
end 

function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
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

                  if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()




	elseif melontype == "small" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()

	elseif melontype == "fly" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

                   local Up = self.Owner:EyeAngles():Up()


	ent:SetModel( model_file )
 
                  ent:SetPos( self.Owner:GetShootPos() + Up * 80)
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  
                  ent:SetOwner( self.Owner )

                  timer.Simple( 1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 

-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_fridge.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "BOTS ONLY FRIDGE"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "A minge gun is a gun that shoots props used too prop kill, example: fridge, and a tide gates, This weapon is knowned as the: error shooter if nobody had counter-strike source. (sticky would love this)"
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"




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

local ShootSound1 = Sound( "")
local ShootSound2 = Sound( "")
local ShootSound3 = Sound( "")
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
 

self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()


	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.55,1) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
                  self.Owner:SetVelocity(aimvector *  1250 )         
	self:ThrowMelon("models/props/CS_militia/refrigerator01.mdl",200000000,"big")               
                  self.Owner:SetVelocity(aimvector *  1250 ) 
 
                  if self.Owner:OnGround() then 
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",100,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
    
                  timer.Simple( 0.1, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-1000,1000) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(-500,-1000) ) end )

                
                  end         

end

function SWEP:Reload()

local aimvector = self.Owner:GetAimVector()
	self.Owner:SetVelocity(aimvector * 1000 )
end 

function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
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

                  if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()




	elseif melontype == "small" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()

	elseif melontype == "fly" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

                   local Up = self.Owner:EyeAngles():Up()


	ent:SetModel( model_file )
 
                  ent:SetPos( self.Owner:GetShootPos() + Up * 80)
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  
                  ent:SetOwner( self.Owner )

                  timer.Simple( 1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 

-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_fridge.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "BOTS ONLY FRIDGE"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "A minge gun is a gun that shoots props used too prop kill, example: fridge, and a tide gates, This weapon is knowned as the: error shooter if nobody had counter-strike source. (sticky would love this)"
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"




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

local ShootSound1 = Sound( "")
local ShootSound2 = Sound( "")
local ShootSound3 = Sound( "")
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
 

self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()


	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.55,1) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
                  self.Owner:SetVelocity(aimvector *  1250 )         
	self:ThrowMelon("models/props/CS_militia/refrigerator01.mdl",200000000,"big")               
                  self.Owner:SetVelocity(aimvector *  1250 ) 
 
                  if self.Owner:OnGround() then 
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",100,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
    
                  timer.Simple( 0.1, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-1000,1000) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(-500,-1000) ) end )

                
                  end         

end

function SWEP:Reload()

local aimvector = self.Owner:GetAimVector()
	self.Owner:SetVelocity(aimvector * 1000 )
end 

function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
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

                  if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()




	elseif melontype == "small" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()

	elseif melontype == "fly" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

                   local Up = self.Owner:EyeAngles():Up()


	ent:SetModel( model_file )
 
                  ent:SetPos( self.Owner:GetShootPos() + Up * 80)
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  
                  ent:SetOwner( self.Owner )

                  timer.Simple( 1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 

-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_fridge.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "BOTS ONLY FRIDGE"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "A minge gun is a gun that shoots props used too prop kill, example: fridge, and a tide gates, This weapon is knowned as the: error shooter if nobody had counter-strike source. (sticky would love this)"
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"




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

local ShootSound1 = Sound( "")
local ShootSound2 = Sound( "")
local ShootSound3 = Sound( "")
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
 

self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()


	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.55,1) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
                  self.Owner:SetVelocity(aimvector *  1250 )         
	self:ThrowMelon("models/props/CS_militia/refrigerator01.mdl",200000000,"big")               
                  self.Owner:SetVelocity(aimvector *  1250 ) 
 
                  if self.Owner:OnGround() then 
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",100,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
    
                  timer.Simple( 0.1, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-1000,1000) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(-500,-1000) ) end )

                
                  end         

end

function SWEP:Reload()

local aimvector = self.Owner:GetAimVector()
	self.Owner:SetVelocity(aimvector * 1000 )
end 

function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
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

                  if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()




	elseif melontype == "small" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()

	elseif melontype == "fly" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

                   local Up = self.Owner:EyeAngles():Up()


	ent:SetModel( model_file )
 
                  ent:SetPos( self.Owner:GetShootPos() + Up * 80)
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  
                  ent:SetOwner( self.Owner )

                  timer.Simple( 1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 

-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_fridge.lua"
-- Retrieved by https://github.com/c4fe/glua-steal




SWEP.PrintName		= "BOTS ONLY FRIDGE"
SWEP.Author			= "credits too buddy148©, edited by lenn"
SWEP.Instructions 	= "Left mouse to fire tidegates! Hold R and jump to surf and fly! Right mouse to fire a mother-fucking-fridges!!!!!!!!!!!"
SWEP.Purpose = "A minge gun is a gun that shoots props used too prop kill, example: fridge, and a tide gates, This weapon is knowned as the: error shooter if nobody had counter-strike source. (sticky would love this)"
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"




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

local ShootSound1 = Sound( "")
local ShootSound2 = Sound( "")
local ShootSound3 = Sound( "")
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
 

self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()


	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.55,1) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
                  self.Owner:SetVelocity(aimvector *  1250 )         
	self:ThrowMelon("models/props/CS_militia/refrigerator01.mdl",200000000,"big")               
                  self.Owner:SetVelocity(aimvector *  1250 ) 
 
                  if self.Owner:OnGround() then 
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",100,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
    
                  timer.Simple( 0.1, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-1000,1000) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(-500,-1000) ) end )

                
                  end         

end

function SWEP:Reload()

local aimvector = self.Owner:GetAimVector()
	self.Owner:SetVelocity(aimvector * 1000 )
end 

function SWEP:SecondaryAttack()

 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Tracer = 1 
bullet.TracerName = "ToolTracer"
bullet.AmmoType = self.Secondary.Ammo 


self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self.Weapon:SetNextSecondaryFire( CurTime() + 1.5 )	
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

                  if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()




	elseif melontype == "small" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

	ent:SetModel( model_file )
 
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(100,300) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner )

                  timer.Simple( math.random(2.25,3), function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()

	elseif melontype == "fly" then

if ( CLIENT ) then return end

	local ent = ents.Create( "prop_physics" )

	if (  !IsValid( ent ) ) then return end

                   local Up = self.Owner:EyeAngles():Up()


	ent:SetModel( model_file )
 
                  ent:SetPos( self.Owner:GetShootPos() + Up * 80)
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  
                  ent:SetOwner( self.Owner )

                  timer.Simple( 1, function() ent:Remove() end )
 
	local phys = ent:GetPhysicsObject()
	if (  !IsValid( phys ) ) then ent:Remove() return end
 
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * set_velocity
	velocity = velocity + ( VectorRand() * 10 ) -- a random element
	phys:ApplyForceCenter( velocity )

 
	cleanup.Add( self.Owner, "props", ent )
 
	undo.Create( "RIP TEAR CRUSH" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end
end

function SWEP:Initialize() 
self:SetHoldType( "physgun" )
end 

-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end

