-- "addons\\toyboxstuff\\lua\\entities\\washingmachine.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Washing Machine"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

ENT.Information        = "A Washing Machine, Cleans Props"

ENT.Spawnable            = true
ENT.AdminSpawnable        = true

ENT.Running = false
ENT.Item = NULL

//sounds
//ambient/levels/labs/machine_moving_loop4.wav
//HL1/fvox/bell.wav

ENT.Sound = NULL

local TimeToFinish = 0
local WASHTIME = 4

//Structure
--[[
    SERVER
]]--
if SERVER then

    function ENT:Initialize()
        
        self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl")
        
        self:PhysicsInit(SOLID_VPHYSICS)
        
        self:SetMoveType(MOVETYPE_VPHYSICS)
        
        self:GetPhysicsObject():Wake()
        
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        
    end

    function ENT:SpawnFunction( ply, tr )

        if ( !tr.Hit ) then return end
        
        local SpawnPos = tr.HitPos + tr.HitNormal * 64
        
        local ent = ents.Create( ClassName )
            ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        
        return ent
        
    end

    function ENT:StartTouch(other)
        if other:GetClass() != "prop_physics" then return end
        if self.Item == NULL and !self.Running then
            self.Item = other
            other:SetNoDraw(true)
            other:SetNotSolid(true)
            other:SetPos(self:GetPos())
            other:SetParent(self)
        end
    end
    
    function ENT:Use(ply)
        if self.Item == NULL or self.Running then return end
        
        self.Running = true
        TimeToFinish = CurTime() + WASHTIME
        
        self.Sound:Play()
    end
    
    function ENT:Think()
        if self.Running then
            self:GetPhysicsObject():AddVelocity(VectorRand()*50)
            
            if TimeToFinish < CurTime() then
                self:Fin()
            end
        end
    end
    
    function ENT:Fin()
        self.Running = false
        self.Sound:Stop()
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        self:EmitSound(Sound("HL1/fvox/bell.wav"))
        if !IsValid(self.Item) then
            return 
        end
        self.Item:SetColor(Color(255,255,255,255))
        self.Item:SetMaterial("")
        BroadcastLua("RunConsoleCommand('r_cleardecals')")
        
        self.Item:SetParent()
        self.Item:SetPos(self:GetPos() + Vector(0,0,50))
        self.Item:SetNoDraw(false)
        self.Item:SetNotSolid(false)
        
        self.Item:GetPhysicsObject():SetVelocityInstantaneous(Vector(0,0,250) + self:GetForward()*100)
        
        self.Item = NULL
    end
    
    function ENT:OnRemove()
        //self.Sound:Remove()
    end
--[[
    CLIENT
]]--
elseif CLIENT then

--[[
    SHARED
]]--
end

-- "addons\\toyboxstuff\\lua\\entities\\washingmachine.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Washing Machine"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

ENT.Information        = "A Washing Machine, Cleans Props"

ENT.Spawnable            = true
ENT.AdminSpawnable        = true

ENT.Running = false
ENT.Item = NULL

//sounds
//ambient/levels/labs/machine_moving_loop4.wav
//HL1/fvox/bell.wav

ENT.Sound = NULL

local TimeToFinish = 0
local WASHTIME = 4

//Structure
--[[
    SERVER
]]--
if SERVER then

    function ENT:Initialize()
        
        self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl")
        
        self:PhysicsInit(SOLID_VPHYSICS)
        
        self:SetMoveType(MOVETYPE_VPHYSICS)
        
        self:GetPhysicsObject():Wake()
        
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        
    end

    function ENT:SpawnFunction( ply, tr )

        if ( !tr.Hit ) then return end
        
        local SpawnPos = tr.HitPos + tr.HitNormal * 64
        
        local ent = ents.Create( ClassName )
            ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        
        return ent
        
    end

    function ENT:StartTouch(other)
        if other:GetClass() != "prop_physics" then return end
        if self.Item == NULL and !self.Running then
            self.Item = other
            other:SetNoDraw(true)
            other:SetNotSolid(true)
            other:SetPos(self:GetPos())
            other:SetParent(self)
        end
    end
    
    function ENT:Use(ply)
        if self.Item == NULL or self.Running then return end
        
        self.Running = true
        TimeToFinish = CurTime() + WASHTIME
        
        self.Sound:Play()
    end
    
    function ENT:Think()
        if self.Running then
            self:GetPhysicsObject():AddVelocity(VectorRand()*50)
            
            if TimeToFinish < CurTime() then
                self:Fin()
            end
        end
    end
    
    function ENT:Fin()
        self.Running = false
        self.Sound:Stop()
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        self:EmitSound(Sound("HL1/fvox/bell.wav"))
        if !IsValid(self.Item) then
            return 
        end
        self.Item:SetColor(Color(255,255,255,255))
        self.Item:SetMaterial("")
        BroadcastLua("RunConsoleCommand('r_cleardecals')")
        
        self.Item:SetParent()
        self.Item:SetPos(self:GetPos() + Vector(0,0,50))
        self.Item:SetNoDraw(false)
        self.Item:SetNotSolid(false)
        
        self.Item:GetPhysicsObject():SetVelocityInstantaneous(Vector(0,0,250) + self:GetForward()*100)
        
        self.Item = NULL
    end
    
    function ENT:OnRemove()
        //self.Sound:Remove()
    end
--[[
    CLIENT
]]--
elseif CLIENT then

--[[
    SHARED
]]--
end

-- "addons\\toyboxstuff\\lua\\entities\\washingmachine.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Washing Machine"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

ENT.Information        = "A Washing Machine, Cleans Props"

ENT.Spawnable            = true
ENT.AdminSpawnable        = true

ENT.Running = false
ENT.Item = NULL

//sounds
//ambient/levels/labs/machine_moving_loop4.wav
//HL1/fvox/bell.wav

ENT.Sound = NULL

local TimeToFinish = 0
local WASHTIME = 4

//Structure
--[[
    SERVER
]]--
if SERVER then

    function ENT:Initialize()
        
        self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl")
        
        self:PhysicsInit(SOLID_VPHYSICS)
        
        self:SetMoveType(MOVETYPE_VPHYSICS)
        
        self:GetPhysicsObject():Wake()
        
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        
    end

    function ENT:SpawnFunction( ply, tr )

        if ( !tr.Hit ) then return end
        
        local SpawnPos = tr.HitPos + tr.HitNormal * 64
        
        local ent = ents.Create( ClassName )
            ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        
        return ent
        
    end

    function ENT:StartTouch(other)
        if other:GetClass() != "prop_physics" then return end
        if self.Item == NULL and !self.Running then
            self.Item = other
            other:SetNoDraw(true)
            other:SetNotSolid(true)
            other:SetPos(self:GetPos())
            other:SetParent(self)
        end
    end
    
    function ENT:Use(ply)
        if self.Item == NULL or self.Running then return end
        
        self.Running = true
        TimeToFinish = CurTime() + WASHTIME
        
        self.Sound:Play()
    end
    
    function ENT:Think()
        if self.Running then
            self:GetPhysicsObject():AddVelocity(VectorRand()*50)
            
            if TimeToFinish < CurTime() then
                self:Fin()
            end
        end
    end
    
    function ENT:Fin()
        self.Running = false
        self.Sound:Stop()
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        self:EmitSound(Sound("HL1/fvox/bell.wav"))
        if !IsValid(self.Item) then
            return 
        end
        self.Item:SetColor(Color(255,255,255,255))
        self.Item:SetMaterial("")
        BroadcastLua("RunConsoleCommand('r_cleardecals')")
        
        self.Item:SetParent()
        self.Item:SetPos(self:GetPos() + Vector(0,0,50))
        self.Item:SetNoDraw(false)
        self.Item:SetNotSolid(false)
        
        self.Item:GetPhysicsObject():SetVelocityInstantaneous(Vector(0,0,250) + self:GetForward()*100)
        
        self.Item = NULL
    end
    
    function ENT:OnRemove()
        //self.Sound:Remove()
    end
--[[
    CLIENT
]]--
elseif CLIENT then

--[[
    SHARED
]]--
end

-- "addons\\toyboxstuff\\lua\\entities\\washingmachine.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Washing Machine"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

ENT.Information        = "A Washing Machine, Cleans Props"

ENT.Spawnable            = true
ENT.AdminSpawnable        = true

ENT.Running = false
ENT.Item = NULL

//sounds
//ambient/levels/labs/machine_moving_loop4.wav
//HL1/fvox/bell.wav

ENT.Sound = NULL

local TimeToFinish = 0
local WASHTIME = 4

//Structure
--[[
    SERVER
]]--
if SERVER then

    function ENT:Initialize()
        
        self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl")
        
        self:PhysicsInit(SOLID_VPHYSICS)
        
        self:SetMoveType(MOVETYPE_VPHYSICS)
        
        self:GetPhysicsObject():Wake()
        
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        
    end

    function ENT:SpawnFunction( ply, tr )

        if ( !tr.Hit ) then return end
        
        local SpawnPos = tr.HitPos + tr.HitNormal * 64
        
        local ent = ents.Create( ClassName )
            ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        
        return ent
        
    end

    function ENT:StartTouch(other)
        if other:GetClass() != "prop_physics" then return end
        if self.Item == NULL and !self.Running then
            self.Item = other
            other:SetNoDraw(true)
            other:SetNotSolid(true)
            other:SetPos(self:GetPos())
            other:SetParent(self)
        end
    end
    
    function ENT:Use(ply)
        if self.Item == NULL or self.Running then return end
        
        self.Running = true
        TimeToFinish = CurTime() + WASHTIME
        
        self.Sound:Play()
    end
    
    function ENT:Think()
        if self.Running then
            self:GetPhysicsObject():AddVelocity(VectorRand()*50)
            
            if TimeToFinish < CurTime() then
                self:Fin()
            end
        end
    end
    
    function ENT:Fin()
        self.Running = false
        self.Sound:Stop()
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        self:EmitSound(Sound("HL1/fvox/bell.wav"))
        if !IsValid(self.Item) then
            return 
        end
        self.Item:SetColor(Color(255,255,255,255))
        self.Item:SetMaterial("")
        BroadcastLua("RunConsoleCommand('r_cleardecals')")
        
        self.Item:SetParent()
        self.Item:SetPos(self:GetPos() + Vector(0,0,50))
        self.Item:SetNoDraw(false)
        self.Item:SetNotSolid(false)
        
        self.Item:GetPhysicsObject():SetVelocityInstantaneous(Vector(0,0,250) + self:GetForward()*100)
        
        self.Item = NULL
    end
    
    function ENT:OnRemove()
        //self.Sound:Remove()
    end
--[[
    CLIENT
]]--
elseif CLIENT then

--[[
    SHARED
]]--
end

-- "addons\\toyboxstuff\\lua\\entities\\washingmachine.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Washing Machine"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

ENT.Information        = "A Washing Machine, Cleans Props"

ENT.Spawnable            = true
ENT.AdminSpawnable        = true

ENT.Running = false
ENT.Item = NULL

//sounds
//ambient/levels/labs/machine_moving_loop4.wav
//HL1/fvox/bell.wav

ENT.Sound = NULL

local TimeToFinish = 0
local WASHTIME = 4

//Structure
--[[
    SERVER
]]--
if SERVER then

    function ENT:Initialize()
        
        self:SetModel("models/props_c17/FurnitureWashingmachine001a.mdl")
        
        self:PhysicsInit(SOLID_VPHYSICS)
        
        self:SetMoveType(MOVETYPE_VPHYSICS)
        
        self:GetPhysicsObject():Wake()
        
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        
    end

    function ENT:SpawnFunction( ply, tr )

        if ( !tr.Hit ) then return end
        
        local SpawnPos = tr.HitPos + tr.HitNormal * 64
        
        local ent = ents.Create( ClassName )
            ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        
        return ent
        
    end

    function ENT:StartTouch(other)
        if other:GetClass() != "prop_physics" then return end
        if self.Item == NULL and !self.Running then
            self.Item = other
            other:SetNoDraw(true)
            other:SetNotSolid(true)
            other:SetPos(self:GetPos())
            other:SetParent(self)
        end
    end
    
    function ENT:Use(ply)
        if self.Item == NULL or self.Running then return end
        
        self.Running = true
        TimeToFinish = CurTime() + WASHTIME
        
        self.Sound:Play()
    end
    
    function ENT:Think()
        if self.Running then
            self:GetPhysicsObject():AddVelocity(VectorRand()*50)
            
            if TimeToFinish < CurTime() then
                self:Fin()
            end
        end
    end
    
    function ENT:Fin()
        self.Running = false
        self.Sound:Stop()
        self.Sound = CreateSound(self, Sound("ambient/levels/labs/machine_moving_loop4.wav"))
        self:EmitSound(Sound("HL1/fvox/bell.wav"))
        if !IsValid(self.Item) then
            return 
        end
        self.Item:SetColor(Color(255,255,255,255))
        self.Item:SetMaterial("")
        BroadcastLua("RunConsoleCommand('r_cleardecals')")
        
        self.Item:SetParent()
        self.Item:SetPos(self:GetPos() + Vector(0,0,50))
        self.Item:SetNoDraw(false)
        self.Item:SetNotSolid(false)
        
        self.Item:GetPhysicsObject():SetVelocityInstantaneous(Vector(0,0,250) + self:GetForward()*100)
        
        self.Item = NULL
    end
    
    function ENT:OnRemove()
        //self.Sound:Remove()
    end
--[[
    CLIENT
]]--
elseif CLIENT then

--[[
    SHARED
]]--
end

