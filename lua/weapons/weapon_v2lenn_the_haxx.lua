-- "lua\\weapons\\weapon_v2lenn_the_haxx.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "HAX! THE HAAAAAAAAAAAAAAAX"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Left mouse to ban someone, Right click to ban someone 6 times, Reload to warn them."
SWEP.Purpose = "The hacks!!! Hacks!!! I will hack ban you"
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

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= ""

local ShootSound1 = Sound( "vo/npc/male01/thehacks01.wav" )
local ShootSound2 = Sound( "vo/npc/male01/hacks01.wav" )
local ShootSound3 = Sound( "vo/npc/male01/hacks02.wav" )
local hax = Sound( "vo/npc/male01/herecomehacks01.wav" )

function SWEP:PrimaryAttack()
        self.Owner:ChatPrint("HACKS!")
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_lab/monitor01a.mdl",200000,"small")
       
end

function SWEP:Reload()
	self:PlayerAct("disagree")
        self.Owner:ChatPrint("THE HACKS ARE COMING")

end 

function SWEP:SecondaryAttack()
self.Owner:ChatPrint("THE HACKS")
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,6 do
		self:ThrowMelon("models/props_lab/monitor01a.mdl",500000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( hax )
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
 
	undo.Create( "NO YOU CAN'T UNDO THE HAX!!!!" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_the_haxx.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "HAX! THE HAAAAAAAAAAAAAAAX"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Left mouse to ban someone, Right click to ban someone 6 times, Reload to warn them."
SWEP.Purpose = "The hacks!!! Hacks!!! I will hack ban you"
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

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= ""

local ShootSound1 = Sound( "vo/npc/male01/thehacks01.wav" )
local ShootSound2 = Sound( "vo/npc/male01/hacks01.wav" )
local ShootSound3 = Sound( "vo/npc/male01/hacks02.wav" )
local hax = Sound( "vo/npc/male01/herecomehacks01.wav" )

function SWEP:PrimaryAttack()
        self.Owner:ChatPrint("HACKS!")
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_lab/monitor01a.mdl",200000,"small")
       
end

function SWEP:Reload()
	self:PlayerAct("disagree")
        self.Owner:ChatPrint("THE HACKS ARE COMING")

end 

function SWEP:SecondaryAttack()
self.Owner:ChatPrint("THE HACKS")
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,6 do
		self:ThrowMelon("models/props_lab/monitor01a.mdl",500000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( hax )
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
 
	undo.Create( "NO YOU CAN'T UNDO THE HAX!!!!" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_the_haxx.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "HAX! THE HAAAAAAAAAAAAAAAX"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Left mouse to ban someone, Right click to ban someone 6 times, Reload to warn them."
SWEP.Purpose = "The hacks!!! Hacks!!! I will hack ban you"
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

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= ""

local ShootSound1 = Sound( "vo/npc/male01/thehacks01.wav" )
local ShootSound2 = Sound( "vo/npc/male01/hacks01.wav" )
local ShootSound3 = Sound( "vo/npc/male01/hacks02.wav" )
local hax = Sound( "vo/npc/male01/herecomehacks01.wav" )

function SWEP:PrimaryAttack()
        self.Owner:ChatPrint("HACKS!")
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_lab/monitor01a.mdl",200000,"small")
       
end

function SWEP:Reload()
	self:PlayerAct("disagree")
        self.Owner:ChatPrint("THE HACKS ARE COMING")

end 

function SWEP:SecondaryAttack()
self.Owner:ChatPrint("THE HACKS")
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,6 do
		self:ThrowMelon("models/props_lab/monitor01a.mdl",500000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( hax )
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
 
	undo.Create( "NO YOU CAN'T UNDO THE HAX!!!!" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_the_haxx.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "HAX! THE HAAAAAAAAAAAAAAAX"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Left mouse to ban someone, Right click to ban someone 6 times, Reload to warn them."
SWEP.Purpose = "The hacks!!! Hacks!!! I will hack ban you"
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

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= ""

local ShootSound1 = Sound( "vo/npc/male01/thehacks01.wav" )
local ShootSound2 = Sound( "vo/npc/male01/hacks01.wav" )
local ShootSound3 = Sound( "vo/npc/male01/hacks02.wav" )
local hax = Sound( "vo/npc/male01/herecomehacks01.wav" )

function SWEP:PrimaryAttack()
        self.Owner:ChatPrint("HACKS!")
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_lab/monitor01a.mdl",200000,"small")
       
end

function SWEP:Reload()
	self:PlayerAct("disagree")
        self.Owner:ChatPrint("THE HACKS ARE COMING")

end 

function SWEP:SecondaryAttack()
self.Owner:ChatPrint("THE HACKS")
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,6 do
		self:ThrowMelon("models/props_lab/monitor01a.mdl",500000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( hax )
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
 
	undo.Create( "NO YOU CAN'T UNDO THE HAX!!!!" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



-- "lua\\weapons\\weapon_v2lenn_the_haxx.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "HAX! THE HAAAAAAAAAAAAAAAX"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Left mouse to ban someone, Right click to ban someone 6 times, Reload to warn them."
SWEP.Purpose = "The hacks!!! Hacks!!! I will hack ban you"
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

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= ""

local ShootSound1 = Sound( "vo/npc/male01/thehacks01.wav" )
local ShootSound2 = Sound( "vo/npc/male01/hacks01.wav" )
local ShootSound3 = Sound( "vo/npc/male01/hacks02.wav" )
local hax = Sound( "vo/npc/male01/herecomehacks01.wav" )

function SWEP:PrimaryAttack()
        self.Owner:ChatPrint("HACKS!")
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ThrowMelon("models/props_lab/monitor01a.mdl",200000,"small")
       
end

function SWEP:Reload()
	self:PlayerAct("disagree")
        self.Owner:ChatPrint("THE HACKS ARE COMING")

end 

function SWEP:SecondaryAttack()
self.Owner:ChatPrint("THE HACKS")
self.Weapon:SetNextSecondaryFire( CurTime() + 5 )	
local FireTimes = 1
self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	for FireTimes=1,6 do
		self:ThrowMelon("models/props_lab/monitor01a.mdl",500000,"big")
	end
end

function SWEP:PlayerAct(act)
	if CLIENT or game.SinglePlayer() then
		self:EmitSound( hax )
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
 
	undo.Create( "NO YOU CAN'T UNDO THE HAX!!!!" )
		undo.AddEntity( ent )
		undo.SetPlayer( self.Owner )
	undo.Finish()
end



