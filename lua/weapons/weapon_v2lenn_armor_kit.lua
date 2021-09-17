-- "lua\\weapons\\weapon_v2lenn_armor_kit.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

AddCSLuaFile()

SWEP.PrintName = "Armor Kit"
SWEP.Author = "Created By Lenn"
SWEP.Purpose = "Gives people armor, that's all, meh,"
SWEP.Instructions = "Press right click to give yourself armor."
SWEP.DrawCrosshair = false
SWEP.Category = "Lenn's Weapon's (Heal)"

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 20
SWEP.MaxAmmo = 50

local HealSound = Sound( "items/battery_pickup.wav" )
local DenySound = Sound( "HL1/fvox/activated.wav" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end


	timer.Create( "medkit_ammo" .. self:EntIndex(), 0.5, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 1, self.MaxAmmo ) ) end
	end )

end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	local ent = tr.Entity

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxArmor() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ( ent:IsPlayer() or ent:IsNPC() ) && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxArmor(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 1 )

	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self.Owner

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ent:Armor() < ent:GetMaxHealth() ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxHealth(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 0.5 )

	end

end



function SWEP:Initialize()
     self:SetColor(Color(42, 77, 87, 255)) -- Paints world model
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end


-- "lua\\weapons\\weapon_v2lenn_armor_kit.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

AddCSLuaFile()

SWEP.PrintName = "Armor Kit"
SWEP.Author = "Created By Lenn"
SWEP.Purpose = "Gives people armor, that's all, meh,"
SWEP.Instructions = "Press right click to give yourself armor."
SWEP.DrawCrosshair = false
SWEP.Category = "Lenn's Weapon's (Heal)"

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 20
SWEP.MaxAmmo = 50

local HealSound = Sound( "items/battery_pickup.wav" )
local DenySound = Sound( "HL1/fvox/activated.wav" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end


	timer.Create( "medkit_ammo" .. self:EntIndex(), 0.5, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 1, self.MaxAmmo ) ) end
	end )

end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	local ent = tr.Entity

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxArmor() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ( ent:IsPlayer() or ent:IsNPC() ) && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxArmor(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 1 )

	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self.Owner

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ent:Armor() < ent:GetMaxHealth() ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxHealth(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 0.5 )

	end

end



function SWEP:Initialize()
     self:SetColor(Color(42, 77, 87, 255)) -- Paints world model
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end


-- "lua\\weapons\\weapon_v2lenn_armor_kit.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

AddCSLuaFile()

SWEP.PrintName = "Armor Kit"
SWEP.Author = "Created By Lenn"
SWEP.Purpose = "Gives people armor, that's all, meh,"
SWEP.Instructions = "Press right click to give yourself armor."
SWEP.DrawCrosshair = false
SWEP.Category = "Lenn's Weapon's (Heal)"

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 20
SWEP.MaxAmmo = 50

local HealSound = Sound( "items/battery_pickup.wav" )
local DenySound = Sound( "HL1/fvox/activated.wav" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end


	timer.Create( "medkit_ammo" .. self:EntIndex(), 0.5, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 1, self.MaxAmmo ) ) end
	end )

end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	local ent = tr.Entity

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxArmor() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ( ent:IsPlayer() or ent:IsNPC() ) && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxArmor(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 1 )

	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self.Owner

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ent:Armor() < ent:GetMaxHealth() ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxHealth(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 0.5 )

	end

end



function SWEP:Initialize()
     self:SetColor(Color(42, 77, 87, 255)) -- Paints world model
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end


-- "lua\\weapons\\weapon_v2lenn_armor_kit.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

AddCSLuaFile()

SWEP.PrintName = "Armor Kit"
SWEP.Author = "Created By Lenn"
SWEP.Purpose = "Gives people armor, that's all, meh,"
SWEP.Instructions = "Press right click to give yourself armor."
SWEP.DrawCrosshair = false
SWEP.Category = "Lenn's Weapon's (Heal)"

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 20
SWEP.MaxAmmo = 50

local HealSound = Sound( "items/battery_pickup.wav" )
local DenySound = Sound( "HL1/fvox/activated.wav" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end


	timer.Create( "medkit_ammo" .. self:EntIndex(), 0.5, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 1, self.MaxAmmo ) ) end
	end )

end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	local ent = tr.Entity

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxArmor() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ( ent:IsPlayer() or ent:IsNPC() ) && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxArmor(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 1 )

	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self.Owner

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ent:Armor() < ent:GetMaxHealth() ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxHealth(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 0.5 )

	end

end



function SWEP:Initialize()
     self:SetColor(Color(42, 77, 87, 255)) -- Paints world model
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end


-- "lua\\weapons\\weapon_v2lenn_armor_kit.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

AddCSLuaFile()

SWEP.PrintName = "Armor Kit"
SWEP.Author = "Created By Lenn"
SWEP.Purpose = "Gives people armor, that's all, meh,"
SWEP.Instructions = "Press right click to give yourself armor."
SWEP.DrawCrosshair = false
SWEP.Category = "Lenn's Weapon's (Heal)"

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 20
SWEP.MaxAmmo = 50

local HealSound = Sound( "items/battery_pickup.wav" )
local DenySound = Sound( "HL1/fvox/activated.wav" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end


	timer.Create( "medkit_ammo" .. self:EntIndex(), 0.5, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 1, self.MaxAmmo ) ) end
	end )

end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	local ent = tr.Entity

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxArmor() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ( ent:IsPlayer() or ent:IsNPC() ) && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxArmor(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 1 )

	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self.Owner

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ent:Armor() < ent:GetMaxHealth() ) then

		self:TakePrimaryAmmo( need )

		ent:SetArmor( math.min( ent:GetMaxHealth(), ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0.75, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 0.5 )

	end

end



function SWEP:Initialize()
     self:SetColor(Color(42, 77, 87, 255)) -- Paints world model
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end


