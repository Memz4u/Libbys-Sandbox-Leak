-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_original.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


SWEP.PrintName		= "BOTS TIDEGATES ONLY"
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
self:ShootEffects()

 

 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()

local ent = self.Owner
local eyeang = ent:EyeAngles()


               
                  if self.Owner:OnGround() then
	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.75,1.25) )	
                  self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")    
end    

                  if not self.Owner:OnGround() then
                  self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.95,1.25) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")              

       
self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) 
                                             

end
                  


   

                  if self.Owner:OnGround() then 
                  timer.Simple( 0.25, function()
                 
                  self.Owner:SetEyeAngles( Angle( self.Owner:EyeAngles().p, self.Owner:EyeAngles().y - math.Rand( 0, 180 ) , self.Owner:EyeAngles().r ) )
                  
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",-10,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(2000,3500) ) end )

end)



timer.Simple( 0.25, function()

         timer.Simple( 0.01, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.02, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.03, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.04, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.05, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.06, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.07, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.08, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.09, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.10, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.11, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.12, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.13, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.14, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.15, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.16, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.17, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.18, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.19, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.20, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.21, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.22, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.23, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.24, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.26, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.27, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.28, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.29, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.30, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.35, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  0
                  ent:SetEyeAngles(eyeang) end)



end)







                    

                
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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end



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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

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


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)

function SWEP:Initialize()
     self:SetHoldType( "physgun" )
end


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end













-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_original.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


SWEP.PrintName		= "BOTS TIDEGATES ONLY"
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
self:ShootEffects()

 

 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()

local ent = self.Owner
local eyeang = ent:EyeAngles()


               
                  if self.Owner:OnGround() then
	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.75,1.25) )	
                  self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")    
end    

                  if not self.Owner:OnGround() then
                  self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.95,1.25) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")              

       
self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) 
                                             

end
                  


   

                  if self.Owner:OnGround() then 
                  timer.Simple( 0.25, function()
                 
                  self.Owner:SetEyeAngles( Angle( self.Owner:EyeAngles().p, self.Owner:EyeAngles().y - math.Rand( 0, 180 ) , self.Owner:EyeAngles().r ) )
                  
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",-10,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(2000,3500) ) end )

end)



timer.Simple( 0.25, function()

         timer.Simple( 0.01, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.02, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.03, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.04, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.05, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.06, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.07, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.08, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.09, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.10, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.11, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.12, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.13, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.14, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.15, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.16, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.17, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.18, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.19, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.20, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.21, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.22, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.23, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.24, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.26, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.27, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.28, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.29, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.30, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.35, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  0
                  ent:SetEyeAngles(eyeang) end)



end)







                    

                
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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end



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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

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


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)

function SWEP:Initialize()
     self:SetHoldType( "physgun" )
end


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end













-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_original.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


SWEP.PrintName		= "BOTS TIDEGATES ONLY"
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
self:ShootEffects()

 

 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()

local ent = self.Owner
local eyeang = ent:EyeAngles()


               
                  if self.Owner:OnGround() then
	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.75,1.25) )	
                  self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")    
end    

                  if not self.Owner:OnGround() then
                  self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.95,1.25) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")              

       
self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) 
                                             

end
                  


   

                  if self.Owner:OnGround() then 
                  timer.Simple( 0.25, function()
                 
                  self.Owner:SetEyeAngles( Angle( self.Owner:EyeAngles().p, self.Owner:EyeAngles().y - math.Rand( 0, 180 ) , self.Owner:EyeAngles().r ) )
                  
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",-10,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(2000,3500) ) end )

end)



timer.Simple( 0.25, function()

         timer.Simple( 0.01, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.02, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.03, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.04, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.05, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.06, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.07, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.08, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.09, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.10, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.11, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.12, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.13, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.14, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.15, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.16, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.17, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.18, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.19, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.20, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.21, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.22, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.23, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.24, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.26, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.27, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.28, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.29, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.30, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.35, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  0
                  ent:SetEyeAngles(eyeang) end)



end)







                    

                
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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end



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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

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


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)

function SWEP:Initialize()
     self:SetHoldType( "physgun" )
end


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end













-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_original.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


SWEP.PrintName		= "BOTS TIDEGATES ONLY"
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
self:ShootEffects()

 

 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()

local ent = self.Owner
local eyeang = ent:EyeAngles()


               
                  if self.Owner:OnGround() then
	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.75,1.25) )	
                  self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")    
end    

                  if not self.Owner:OnGround() then
                  self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.95,1.25) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")              

       
self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) 
                                             

end
                  


   

                  if self.Owner:OnGround() then 
                  timer.Simple( 0.25, function()
                 
                  self.Owner:SetEyeAngles( Angle( self.Owner:EyeAngles().p, self.Owner:EyeAngles().y - math.Rand( 0, 180 ) , self.Owner:EyeAngles().r ) )
                  
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",-10,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(2000,3500) ) end )

end)



timer.Simple( 0.25, function()

         timer.Simple( 0.01, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.02, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.03, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.04, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.05, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.06, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.07, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.08, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.09, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.10, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.11, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.12, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.13, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.14, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.15, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.16, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.17, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.18, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.19, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.20, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.21, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.22, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.23, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.24, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.26, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.27, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.28, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.29, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.30, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.35, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  0
                  ent:SetEyeAngles(eyeang) end)



end)







                    

                
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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end



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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

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


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)

function SWEP:Initialize()
     self:SetHoldType( "physgun" )
end


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end













-- "lua\\weapons\\weapon_v2lenn_physics_gun_the_real_original.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


SWEP.PrintName		= "BOTS TIDEGATES ONLY"
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
self:ShootEffects()

 

 
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

local aimvector = self.Owner:GetAimVector()

local ent = self.Owner
local eyeang = ent:EyeAngles()


               
                  if self.Owner:OnGround() then
	self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.75,1.25) )	
                  self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")    
end    

                  if not self.Owner:OnGround() then
                  self.Weapon:SetNextPrimaryFire( CurTime() + math.random(0.95,1.25) )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 ) 
	self:ThrowMelon("models/props/de_tides/gate_large.mdl",200000000,"big")              

       
self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) 
                                             

end
                  


   

                  if self.Owner:OnGround() then 
                  timer.Simple( 0.25, function()
                 
                  self.Owner:SetEyeAngles( Angle( self.Owner:EyeAngles().p, self.Owner:EyeAngles().y - math.Rand( 0, 180 ) , self.Owner:EyeAngles().r ) )
                  
                  self:ThrowMelon("models/props_phx/wheels/moped_tire.mdl",-10,"fly")              
                  self.Owner:SetVelocity(self.Owner:GetUp() * math.random(1000,2000) )
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetRight() * math.random(-2500,2500) ) end )
                  timer.Simple( 0.5, function() if not IsValid(self) or not self.Owner:Alive() then return end self.Owner:SetVelocity(self.Owner:GetForward() * math.random(2000,3500) ) end )

end)



timer.Simple( 0.25, function()

         timer.Simple( 0.01, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.02, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.03, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.04, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.05, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.06, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.07, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.08, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.09, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.10, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.11, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.12, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.13, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.14, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.15, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.16, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.17, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.18, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.19, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.20, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.21, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.22, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.23, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.24, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.25, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.26, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.27, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.28, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.29, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.30, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  89
                  ent:SetEyeAngles(eyeang) end)
                  timer.Simple( 0.35, function() if not IsValid(self) or not self.Owner:Alive() then return end eyeang.pitch =  0
                  ent:SetEyeAngles(eyeang) end)



end)







                    

                
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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end



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
 
                  if self.Owner:OnGround() then
	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(50,150) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

                  if not self.Owner:OnGround() then
                  ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * math.random(250,500) ) )
                  ent:SetAngles( self.Owner:EyeAngles() )
	ent:Spawn()
                  ent:SetOwner( self.Owner ) -- Gonna set it to the guy who shot the weapon, That way people in build mode can't kill people in pvp with these projectile weapons.
end

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


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)


-- 11/25/19 (V6 UPDATE) Readded the color code and edited it for some weapons because i thought it broked the holdtype, (as it was deleted back then in the version 4.4)

function SWEP:Initialize()
     self:SetHoldType( "physgun" )
end


-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize()
     self:SetHoldType( "physgun" )
     self:SetColor(Color(255, 0, 0, 100)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
end













