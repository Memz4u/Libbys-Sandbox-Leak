-- "lua\\weapons\\weapon_v2lenn_tear_wiper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Tear Wiper (read instructions)"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click too wipe your tears"
SWEP.Purpose = "Did you start crying because you dropped a baby? Well this tear wiper will help your tears begoned!"
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/balloon_classic.mdl"
SWEP.WorldModel                 = "models/maxofs2d/balloon_classic.mdl"




function SWEP:PrimaryAttack()
        self.Weapon:SetNextPrimaryFire( CurTime() + 6 )	
        self.Owner:ConCommand("pp_mat_overlay  rip")
        self.Owner:ConCommand("play  ambient/water/drip2.wav")
        self.Owner:ConCommand("say  ah yes, My tears are gone! I can finally see.")
end


function SWEP:SecondaryAttack()
      self.Weapon:SetNextSecondaryFire( CurTime() + 6 )	
      self.Owner:ConCommand("pp_mat_overlay  rip")
      self.Owner:ConCommand("play  ambient/water/drip1.wav")
      self.Owner:ConCommand("say  My tears are gone? Wow.")
end

-- "lua\\weapons\\weapon_v2lenn_tear_wiper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Tear Wiper (read instructions)"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click too wipe your tears"
SWEP.Purpose = "Did you start crying because you dropped a baby? Well this tear wiper will help your tears begoned!"
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/balloon_classic.mdl"
SWEP.WorldModel                 = "models/maxofs2d/balloon_classic.mdl"




function SWEP:PrimaryAttack()
        self.Weapon:SetNextPrimaryFire( CurTime() + 6 )	
        self.Owner:ConCommand("pp_mat_overlay  rip")
        self.Owner:ConCommand("play  ambient/water/drip2.wav")
        self.Owner:ConCommand("say  ah yes, My tears are gone! I can finally see.")
end


function SWEP:SecondaryAttack()
      self.Weapon:SetNextSecondaryFire( CurTime() + 6 )	
      self.Owner:ConCommand("pp_mat_overlay  rip")
      self.Owner:ConCommand("play  ambient/water/drip1.wav")
      self.Owner:ConCommand("say  My tears are gone? Wow.")
end

-- "lua\\weapons\\weapon_v2lenn_tear_wiper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Tear Wiper (read instructions)"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click too wipe your tears"
SWEP.Purpose = "Did you start crying because you dropped a baby? Well this tear wiper will help your tears begoned!"
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/balloon_classic.mdl"
SWEP.WorldModel                 = "models/maxofs2d/balloon_classic.mdl"




function SWEP:PrimaryAttack()
        self.Weapon:SetNextPrimaryFire( CurTime() + 6 )	
        self.Owner:ConCommand("pp_mat_overlay  rip")
        self.Owner:ConCommand("play  ambient/water/drip2.wav")
        self.Owner:ConCommand("say  ah yes, My tears are gone! I can finally see.")
end


function SWEP:SecondaryAttack()
      self.Weapon:SetNextSecondaryFire( CurTime() + 6 )	
      self.Owner:ConCommand("pp_mat_overlay  rip")
      self.Owner:ConCommand("play  ambient/water/drip1.wav")
      self.Owner:ConCommand("say  My tears are gone? Wow.")
end

-- "lua\\weapons\\weapon_v2lenn_tear_wiper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Tear Wiper (read instructions)"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click too wipe your tears"
SWEP.Purpose = "Did you start crying because you dropped a baby? Well this tear wiper will help your tears begoned!"
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/balloon_classic.mdl"
SWEP.WorldModel                 = "models/maxofs2d/balloon_classic.mdl"




function SWEP:PrimaryAttack()
        self.Weapon:SetNextPrimaryFire( CurTime() + 6 )	
        self.Owner:ConCommand("pp_mat_overlay  rip")
        self.Owner:ConCommand("play  ambient/water/drip2.wav")
        self.Owner:ConCommand("say  ah yes, My tears are gone! I can finally see.")
end


function SWEP:SecondaryAttack()
      self.Weapon:SetNextSecondaryFire( CurTime() + 6 )	
      self.Owner:ConCommand("pp_mat_overlay  rip")
      self.Owner:ConCommand("play  ambient/water/drip1.wav")
      self.Owner:ConCommand("say  My tears are gone? Wow.")
end

-- "lua\\weapons\\weapon_v2lenn_tear_wiper.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SWEP.PrintName		= "Tear Wiper (read instructions)"
SWEP.Author			= "credits too buddy148©, edited by lenn."
SWEP.Instructions 	= "Press left click too wipe your tears"
SWEP.Purpose = "Did you start crying because you dropped a baby? Well this tear wiper will help your tears begoned!"
SWEP.Category = "Lenn's Weapons (RARE)"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.UseHands			= true

SWEP.HoldType = "fist"

SWEP.ViewModel			= "models/maxofs2d/balloon_classic.mdl"
SWEP.WorldModel                 = "models/maxofs2d/balloon_classic.mdl"




function SWEP:PrimaryAttack()
        self.Weapon:SetNextPrimaryFire( CurTime() + 6 )	
        self.Owner:ConCommand("pp_mat_overlay  rip")
        self.Owner:ConCommand("play  ambient/water/drip2.wav")
        self.Owner:ConCommand("say  ah yes, My tears are gone! I can finally see.")
end


function SWEP:SecondaryAttack()
      self.Weapon:SetNextSecondaryFire( CurTime() + 6 )	
      self.Owner:ConCommand("pp_mat_overlay  rip")
      self.Owner:ConCommand("play  ambient/water/drip1.wav")
      self.Owner:ConCommand("say  My tears are gone? Wow.")
end

