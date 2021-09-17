-- "lua\\weapons\\weapon_v7lenn_fastasfcrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Fast asf crowbarr"
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

SWEP.Primary.Damage = 6
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.10
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
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
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

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 250
SWEP.RunSpeed = 450

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

-- "lua\\weapons\\weapon_v7lenn_fastasfcrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Fast asf crowbarr"
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

SWEP.Primary.Damage = 6
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.10
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
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
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

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 250
SWEP.RunSpeed = 450

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

-- "lua\\weapons\\weapon_v7lenn_fastasfcrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Fast asf crowbarr"
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

SWEP.Primary.Damage = 6
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.10
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
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
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

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 250
SWEP.RunSpeed = 450

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

-- "lua\\weapons\\weapon_v7lenn_fastasfcrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Fast asf crowbarr"
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

SWEP.Primary.Damage = 6
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.10
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
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
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

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 250
SWEP.RunSpeed = 450

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

-- "lua\\weapons\\weapon_v7lenn_fastasfcrowbar.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if ( SERVER ) then
	AddCSLuaFile( "opcrowbar.lua" )
	SWEP.HoldType = "melee"
end

if ( CLIENT ) then
	SWEP.PrintName = "Fast asf crowbarr"
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

SWEP.Primary.Damage = 6
SWEP.Primary.ClipSize = -1 
SWEP.Primary.Delay = 0.10
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
	tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() *100 )
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

// New walk and runspeed for the v4 lenn update, makes it look like csgo again


-- default walkspeed / runspeed for gmod sandbox,
-- default walkspeed / runspeed for darkrp would be 150 walkspeed and 300 or 250 runspeed, who knows?
-- we need this kind of value for the deploy!!
SWEP.WalkSpeed = 250
SWEP.RunSpeed = 450

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

