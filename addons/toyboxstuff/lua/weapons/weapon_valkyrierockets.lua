-- "addons\\toyboxstuff\\lua\\weapons\\weapon_valkyrierockets.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

if CLIENT then
	language.Add( "weapon_valkyrierockets", "Valkyrie Rockets" )
	surface.CreateFont("ArialNarrow18", {font = "Arial Narrow", size = 18, weight = 600})
end	

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.PrintName = "Valkyrie Rockets"
SWEP.Purpose = "Control Valkyrie rockets from Call of Duty: Black Ops."
SWEP.Instructions = "Primary to fire rocket. When rocket is in air, use mouse or movement keys to control rocket, primary fire to toggle boost and secondary fire to detonate in air."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false

SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

SWEP.Author = "SiPlus, Treyarch"
SWEP.Contact = "http://steamcommunity.com/id/SiPlus"

function SWEP:Initialize()
    util.PrecacheSound("weapons/rpg/rocketfire1.wav")
    self:SetWeaponHoldType("rpg")
    self:SetDeploySpeed(1)
end

function SWEP:Deploy()
    self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:PrimaryAttack()
    if SERVER then
        if self.Owner:WaterLevel() >= 2 then return end
        if self.Owner.CanFireNewRocket == false then return end
        self.Rocket = ents.Create("toybox_629_valkyrie_cr")
        local SpawnOrExplode = {}
        SpawnOrExplode.Start = self.Owner:GetPos()
        SpawnOrExplode.Endpos = self.Owner:GetPos()+(self.Owner:GetAimVector()*40)
        SpawnOrExplode.Filter = { self.Owner }
        local SpawnOrExplodeTrace = util.TraceLine(SpawnOrExplode)
        if SpawnOrExplodeTrace.Hit == true then
            self.Rocket:SetPos(self.Owner:GetPos()+(self.Owner:GetForward()*60)+Vector(0,0,36))
        else
            self.Rocket:SetPos(self.Owner:GetPos()+Vector(0,0,36))
        end
        self.Rocket:SetAngles(self.Owner:GetAngles())
        self.Rocket:SetVar("MissileOwner",self.Owner)
        self.Rocket:SetVar("MissileLauncher",self)
        self.Rocket:SetVar("OldMoveType",self.Owner:GetMoveType())
        self.Rocket:Spawn()
        if SERVER then
            SendUserMessage("toybox_629_enablehooks", self.Owner)
            self:EmitSound("weapons/rpg/rocketfire1.wav")
            --self.Owner:SendLua("surface.PlaySound('weapons/rpg/rocketfire1.wav')")
            print("ACTIVATE!")
        end
        self.Owner:SetViewEntity(self.Rocket)
        self.Owner:SetMoveType(MOVETYPE_NONE)
        self.Owner.CanFireNewRocket = false
    end
end

function SWEP:Think()
    if SERVER then
        if IsValid(self.Rocket) then
            self.Rocket:SetAngles(Angle(math.Clamp(self.Rocket:GetAngles().p+(self.Owner:GetCurrentCommand():GetMouseY()/32),-89,89),self.Rocket:GetAngles().y-(self.Owner:GetCurrentCommand():GetMouseX()/32),0))
        end
    end
    self:NextThink(0.02)
end

function SWEP:DoReloadingAnimation()
    self:SendWeaponAnim(ACT_VM_RELOAD)
    self:SetNextPrimaryFire(CurTime()+1.5)
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_valkyrierockets.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

if CLIENT then
	language.Add( "weapon_valkyrierockets", "Valkyrie Rockets" )
	surface.CreateFont("ArialNarrow18", {font = "Arial Narrow", size = 18, weight = 600})
end	

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.PrintName = "Valkyrie Rockets"
SWEP.Purpose = "Control Valkyrie rockets from Call of Duty: Black Ops."
SWEP.Instructions = "Primary to fire rocket. When rocket is in air, use mouse or movement keys to control rocket, primary fire to toggle boost and secondary fire to detonate in air."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false

SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

SWEP.Author = "SiPlus, Treyarch"
SWEP.Contact = "http://steamcommunity.com/id/SiPlus"

function SWEP:Initialize()
    util.PrecacheSound("weapons/rpg/rocketfire1.wav")
    self:SetWeaponHoldType("rpg")
    self:SetDeploySpeed(1)
end

function SWEP:Deploy()
    self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:PrimaryAttack()
    if SERVER then
        if self.Owner:WaterLevel() >= 2 then return end
        if self.Owner.CanFireNewRocket == false then return end
        self.Rocket = ents.Create("toybox_629_valkyrie_cr")
        local SpawnOrExplode = {}
        SpawnOrExplode.Start = self.Owner:GetPos()
        SpawnOrExplode.Endpos = self.Owner:GetPos()+(self.Owner:GetAimVector()*40)
        SpawnOrExplode.Filter = { self.Owner }
        local SpawnOrExplodeTrace = util.TraceLine(SpawnOrExplode)
        if SpawnOrExplodeTrace.Hit == true then
            self.Rocket:SetPos(self.Owner:GetPos()+(self.Owner:GetForward()*60)+Vector(0,0,36))
        else
            self.Rocket:SetPos(self.Owner:GetPos()+Vector(0,0,36))
        end
        self.Rocket:SetAngles(self.Owner:GetAngles())
        self.Rocket:SetVar("MissileOwner",self.Owner)
        self.Rocket:SetVar("MissileLauncher",self)
        self.Rocket:SetVar("OldMoveType",self.Owner:GetMoveType())
        self.Rocket:Spawn()
        if SERVER then
            SendUserMessage("toybox_629_enablehooks", self.Owner)
            self:EmitSound("weapons/rpg/rocketfire1.wav")
            --self.Owner:SendLua("surface.PlaySound('weapons/rpg/rocketfire1.wav')")
            print("ACTIVATE!")
        end
        self.Owner:SetViewEntity(self.Rocket)
        self.Owner:SetMoveType(MOVETYPE_NONE)
        self.Owner.CanFireNewRocket = false
    end
end

function SWEP:Think()
    if SERVER then
        if IsValid(self.Rocket) then
            self.Rocket:SetAngles(Angle(math.Clamp(self.Rocket:GetAngles().p+(self.Owner:GetCurrentCommand():GetMouseY()/32),-89,89),self.Rocket:GetAngles().y-(self.Owner:GetCurrentCommand():GetMouseX()/32),0))
        end
    end
    self:NextThink(0.02)
end

function SWEP:DoReloadingAnimation()
    self:SendWeaponAnim(ACT_VM_RELOAD)
    self:SetNextPrimaryFire(CurTime()+1.5)
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_valkyrierockets.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

if CLIENT then
	language.Add( "weapon_valkyrierockets", "Valkyrie Rockets" )
	surface.CreateFont("ArialNarrow18", {font = "Arial Narrow", size = 18, weight = 600})
end	

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.PrintName = "Valkyrie Rockets"
SWEP.Purpose = "Control Valkyrie rockets from Call of Duty: Black Ops."
SWEP.Instructions = "Primary to fire rocket. When rocket is in air, use mouse or movement keys to control rocket, primary fire to toggle boost and secondary fire to detonate in air."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false

SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

SWEP.Author = "SiPlus, Treyarch"
SWEP.Contact = "http://steamcommunity.com/id/SiPlus"

function SWEP:Initialize()
    util.PrecacheSound("weapons/rpg/rocketfire1.wav")
    self:SetWeaponHoldType("rpg")
    self:SetDeploySpeed(1)
end

function SWEP:Deploy()
    self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:PrimaryAttack()
    if SERVER then
        if self.Owner:WaterLevel() >= 2 then return end
        if self.Owner.CanFireNewRocket == false then return end
        self.Rocket = ents.Create("toybox_629_valkyrie_cr")
        local SpawnOrExplode = {}
        SpawnOrExplode.Start = self.Owner:GetPos()
        SpawnOrExplode.Endpos = self.Owner:GetPos()+(self.Owner:GetAimVector()*40)
        SpawnOrExplode.Filter = { self.Owner }
        local SpawnOrExplodeTrace = util.TraceLine(SpawnOrExplode)
        if SpawnOrExplodeTrace.Hit == true then
            self.Rocket:SetPos(self.Owner:GetPos()+(self.Owner:GetForward()*60)+Vector(0,0,36))
        else
            self.Rocket:SetPos(self.Owner:GetPos()+Vector(0,0,36))
        end
        self.Rocket:SetAngles(self.Owner:GetAngles())
        self.Rocket:SetVar("MissileOwner",self.Owner)
        self.Rocket:SetVar("MissileLauncher",self)
        self.Rocket:SetVar("OldMoveType",self.Owner:GetMoveType())
        self.Rocket:Spawn()
        if SERVER then
            SendUserMessage("toybox_629_enablehooks", self.Owner)
            self:EmitSound("weapons/rpg/rocketfire1.wav")
            --self.Owner:SendLua("surface.PlaySound('weapons/rpg/rocketfire1.wav')")
            print("ACTIVATE!")
        end
        self.Owner:SetViewEntity(self.Rocket)
        self.Owner:SetMoveType(MOVETYPE_NONE)
        self.Owner.CanFireNewRocket = false
    end
end

function SWEP:Think()
    if SERVER then
        if IsValid(self.Rocket) then
            self.Rocket:SetAngles(Angle(math.Clamp(self.Rocket:GetAngles().p+(self.Owner:GetCurrentCommand():GetMouseY()/32),-89,89),self.Rocket:GetAngles().y-(self.Owner:GetCurrentCommand():GetMouseX()/32),0))
        end
    end
    self:NextThink(0.02)
end

function SWEP:DoReloadingAnimation()
    self:SendWeaponAnim(ACT_VM_RELOAD)
    self:SetNextPrimaryFire(CurTime()+1.5)
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_valkyrierockets.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

if CLIENT then
	language.Add( "weapon_valkyrierockets", "Valkyrie Rockets" )
	surface.CreateFont("ArialNarrow18", {font = "Arial Narrow", size = 18, weight = 600})
end	

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.PrintName = "Valkyrie Rockets"
SWEP.Purpose = "Control Valkyrie rockets from Call of Duty: Black Ops."
SWEP.Instructions = "Primary to fire rocket. When rocket is in air, use mouse or movement keys to control rocket, primary fire to toggle boost and secondary fire to detonate in air."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false

SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

SWEP.Author = "SiPlus, Treyarch"
SWEP.Contact = "http://steamcommunity.com/id/SiPlus"

function SWEP:Initialize()
    util.PrecacheSound("weapons/rpg/rocketfire1.wav")
    self:SetWeaponHoldType("rpg")
    self:SetDeploySpeed(1)
end

function SWEP:Deploy()
    self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:PrimaryAttack()
    if SERVER then
        if self.Owner:WaterLevel() >= 2 then return end
        if self.Owner.CanFireNewRocket == false then return end
        self.Rocket = ents.Create("toybox_629_valkyrie_cr")
        local SpawnOrExplode = {}
        SpawnOrExplode.Start = self.Owner:GetPos()
        SpawnOrExplode.Endpos = self.Owner:GetPos()+(self.Owner:GetAimVector()*40)
        SpawnOrExplode.Filter = { self.Owner }
        local SpawnOrExplodeTrace = util.TraceLine(SpawnOrExplode)
        if SpawnOrExplodeTrace.Hit == true then
            self.Rocket:SetPos(self.Owner:GetPos()+(self.Owner:GetForward()*60)+Vector(0,0,36))
        else
            self.Rocket:SetPos(self.Owner:GetPos()+Vector(0,0,36))
        end
        self.Rocket:SetAngles(self.Owner:GetAngles())
        self.Rocket:SetVar("MissileOwner",self.Owner)
        self.Rocket:SetVar("MissileLauncher",self)
        self.Rocket:SetVar("OldMoveType",self.Owner:GetMoveType())
        self.Rocket:Spawn()
        if SERVER then
            SendUserMessage("toybox_629_enablehooks", self.Owner)
            self:EmitSound("weapons/rpg/rocketfire1.wav")
            --self.Owner:SendLua("surface.PlaySound('weapons/rpg/rocketfire1.wav')")
            print("ACTIVATE!")
        end
        self.Owner:SetViewEntity(self.Rocket)
        self.Owner:SetMoveType(MOVETYPE_NONE)
        self.Owner.CanFireNewRocket = false
    end
end

function SWEP:Think()
    if SERVER then
        if IsValid(self.Rocket) then
            self.Rocket:SetAngles(Angle(math.Clamp(self.Rocket:GetAngles().p+(self.Owner:GetCurrentCommand():GetMouseY()/32),-89,89),self.Rocket:GetAngles().y-(self.Owner:GetCurrentCommand():GetMouseX()/32),0))
        end
    end
    self:NextThink(0.02)
end

function SWEP:DoReloadingAnimation()
    self:SendWeaponAnim(ACT_VM_RELOAD)
    self:SetNextPrimaryFire(CurTime()+1.5)
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_valkyrierockets.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

if CLIENT then
	language.Add( "weapon_valkyrierockets", "Valkyrie Rockets" )
	surface.CreateFont("ArialNarrow18", {font = "Arial Narrow", size = 18, weight = 600})
end	

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.PrintName = "Valkyrie Rockets"
SWEP.Purpose = "Control Valkyrie rockets from Call of Duty: Black Ops."
SWEP.Instructions = "Primary to fire rocket. When rocket is in air, use mouse or movement keys to control rocket, primary fire to toggle boost and secondary fire to detonate in air."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false

SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"

SWEP.Author = "SiPlus, Treyarch"
SWEP.Contact = "http://steamcommunity.com/id/SiPlus"

function SWEP:Initialize()
    util.PrecacheSound("weapons/rpg/rocketfire1.wav")
    self:SetWeaponHoldType("rpg")
    self:SetDeploySpeed(1)
end

function SWEP:Deploy()
    self:SetNextPrimaryFire(CurTime()+1)
end

function SWEP:PrimaryAttack()
    if SERVER then
        if self.Owner:WaterLevel() >= 2 then return end
        if self.Owner.CanFireNewRocket == false then return end
        self.Rocket = ents.Create("toybox_629_valkyrie_cr")
        local SpawnOrExplode = {}
        SpawnOrExplode.Start = self.Owner:GetPos()
        SpawnOrExplode.Endpos = self.Owner:GetPos()+(self.Owner:GetAimVector()*40)
        SpawnOrExplode.Filter = { self.Owner }
        local SpawnOrExplodeTrace = util.TraceLine(SpawnOrExplode)
        if SpawnOrExplodeTrace.Hit == true then
            self.Rocket:SetPos(self.Owner:GetPos()+(self.Owner:GetForward()*60)+Vector(0,0,36))
        else
            self.Rocket:SetPos(self.Owner:GetPos()+Vector(0,0,36))
        end
        self.Rocket:SetAngles(self.Owner:GetAngles())
        self.Rocket:SetVar("MissileOwner",self.Owner)
        self.Rocket:SetVar("MissileLauncher",self)
        self.Rocket:SetVar("OldMoveType",self.Owner:GetMoveType())
        self.Rocket:Spawn()
        if SERVER then
            SendUserMessage("toybox_629_enablehooks", self.Owner)
            self:EmitSound("weapons/rpg/rocketfire1.wav")
            --self.Owner:SendLua("surface.PlaySound('weapons/rpg/rocketfire1.wav')")
            print("ACTIVATE!")
        end
        self.Owner:SetViewEntity(self.Rocket)
        self.Owner:SetMoveType(MOVETYPE_NONE)
        self.Owner.CanFireNewRocket = false
    end
end

function SWEP:Think()
    if SERVER then
        if IsValid(self.Rocket) then
            self.Rocket:SetAngles(Angle(math.Clamp(self.Rocket:GetAngles().p+(self.Owner:GetCurrentCommand():GetMouseY()/32),-89,89),self.Rocket:GetAngles().y-(self.Owner:GetCurrentCommand():GetMouseX()/32),0))
        end
    end
    self:NextThink(0.02)
end

function SWEP:DoReloadingAnimation()
    self:SendWeaponAnim(ACT_VM_RELOAD)
    self:SetNextPrimaryFire(CurTime()+1.5)
end

function SWEP:SecondaryAttack() end
function SWEP:Reload() end

