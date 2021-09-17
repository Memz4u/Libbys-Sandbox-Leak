-- "lua\\weapons\\weapon_v7lenn_somecrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Unimaginable crowbar"
	SWEP.Author = "Lenn's Weapons"
	SWEP.Purpose = "kill people lol"
	SWEP.Instructions = "Ya click the left mouse, He dies by your crowbar."
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false					 

end

SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 45
SWEP.ViewModel = "models/weapons/c_crowbar.mdl" 
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true

SWEP.HoldType = "melee" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.Base = "weapon_base"

SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.WallSound = Sound( "Weapon_Crowbar.Melee_Hit" )

SWEP.Primary.Damage = 1000000000000
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.5
SWEP.Primary.DefaultClip = 1 
SWEP.Primary.Automatic = true 
SWEP.Primary.Ammo = "none" 

SWEP.Secondary.ClipSize = -1 
SWEP.Secondary.DefaultClip = -1 
SWEP.Secondary.Damage = 0 
SWEP.Secondary.Automatic = false 	 
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize() 
util.PrecacheSound(self.MissSound) 
util.PrecacheSound(self.WallSound) 
        self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *1000 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end
	
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "lua\\weapons\\weapon_v7lenn_somecrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Unimaginable crowbar"
	SWEP.Author = "Lenn's Weapons"
	SWEP.Purpose = "kill people lol"
	SWEP.Instructions = "Ya click the left mouse, He dies by your crowbar."
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false					 

end

SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 45
SWEP.ViewModel = "models/weapons/c_crowbar.mdl" 
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true

SWEP.HoldType = "melee" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.Base = "weapon_base"

SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.WallSound = Sound( "Weapon_Crowbar.Melee_Hit" )

SWEP.Primary.Damage = 1000000000000
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.5
SWEP.Primary.DefaultClip = 1 
SWEP.Primary.Automatic = true 
SWEP.Primary.Ammo = "none" 

SWEP.Secondary.ClipSize = -1 
SWEP.Secondary.DefaultClip = -1 
SWEP.Secondary.Damage = 0 
SWEP.Secondary.Automatic = false 	 
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize() 
util.PrecacheSound(self.MissSound) 
util.PrecacheSound(self.WallSound) 
        self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *1000 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end
	
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "lua\\weapons\\weapon_v7lenn_somecrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Unimaginable crowbar"
	SWEP.Author = "Lenn's Weapons"
	SWEP.Purpose = "kill people lol"
	SWEP.Instructions = "Ya click the left mouse, He dies by your crowbar."
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false					 

end

SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 45
SWEP.ViewModel = "models/weapons/c_crowbar.mdl" 
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true

SWEP.HoldType = "melee" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.Base = "weapon_base"

SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.WallSound = Sound( "Weapon_Crowbar.Melee_Hit" )

SWEP.Primary.Damage = 1000000000000
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.5
SWEP.Primary.DefaultClip = 1 
SWEP.Primary.Automatic = true 
SWEP.Primary.Ammo = "none" 

SWEP.Secondary.ClipSize = -1 
SWEP.Secondary.DefaultClip = -1 
SWEP.Secondary.Damage = 0 
SWEP.Secondary.Automatic = false 	 
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize() 
util.PrecacheSound(self.MissSound) 
util.PrecacheSound(self.WallSound) 
        self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *1000 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end
	
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "lua\\weapons\\weapon_v7lenn_somecrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Unimaginable crowbar"
	SWEP.Author = "Lenn's Weapons"
	SWEP.Purpose = "kill people lol"
	SWEP.Instructions = "Ya click the left mouse, He dies by your crowbar."
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false					 

end

SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 45
SWEP.ViewModel = "models/weapons/c_crowbar.mdl" 
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true

SWEP.HoldType = "melee" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.Base = "weapon_base"

SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.WallSound = Sound( "Weapon_Crowbar.Melee_Hit" )

SWEP.Primary.Damage = 1000000000000
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.5
SWEP.Primary.DefaultClip = 1 
SWEP.Primary.Automatic = true 
SWEP.Primary.Ammo = "none" 

SWEP.Secondary.ClipSize = -1 
SWEP.Secondary.DefaultClip = -1 
SWEP.Secondary.Damage = 0 
SWEP.Secondary.Automatic = false 	 
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize() 
util.PrecacheSound(self.MissSound) 
util.PrecacheSound(self.WallSound) 
        self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *1000 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end
	
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "lua\\weapons\\weapon_v7lenn_somecrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Unimaginable crowbar"
	SWEP.Author = "Lenn's Weapons"
	SWEP.Purpose = "kill people lol"
	SWEP.Instructions = "Ya click the left mouse, He dies by your crowbar."
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false					 

end

SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 45
SWEP.ViewModel = "models/weapons/c_crowbar.mdl" 
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true

SWEP.HoldType = "melee" 

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.Base = "weapon_base"

SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.WallSound = Sound( "Weapon_Crowbar.Melee_Hit" )

SWEP.Primary.Damage = 1000000000000
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.5
SWEP.Primary.DefaultClip = 1 
SWEP.Primary.Automatic = true 
SWEP.Primary.Ammo = "none" 

SWEP.Secondary.ClipSize = -1 
SWEP.Secondary.DefaultClip = -1 
SWEP.Secondary.Damage = 0 
SWEP.Secondary.Automatic = false 	 
SWEP.Secondary.Ammo = "none" 

function SWEP:Initialize() 
util.PrecacheSound(self.MissSound) 
util.PrecacheSound(self.WallSound) 
        self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *1000 )
	tr.filter = self.Owner
	tr.mask = MASK_SHOT
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound( self.WallSound )		
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
	end
	
function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

