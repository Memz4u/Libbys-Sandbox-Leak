-- "addons\\toyboxstuff\\lua\\entities\\chrikscannon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Old Cannon"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

    if ( SERVER ) then
                self.Entity:SetModel( "models/props_phx/cannon.mdl" )
            self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys and phys:IsValid() then phys:Wake() end
 
        if SERVER and WireLib then
                self.Inputs = WireLib.CreateInputs(self.Entity, { "Fire"})
            self.Outputs = Wire_CreateOutputs(self.Entity, {"Reloaded"})
        end
    end
    
end

function ENT:Use(activator,caller)
    if not self.NextUse or self.NextUse < CurTime() then
        
        self.NextUse = CurTime() + 3
        if self.Reloaded then
            self.NextUse = CurTime() + 6
                      if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",0)
            end
            self.Reloaded = false
            local s = ents.Create("env_flare")
            s:SetPos(self:LocalToWorld(Vector(-58.3845, -0.0228, 93.2971)))
            s:SetParent(self)
            s:Spawn()
            s:EmitSound("weapon.ImpactSoft")
            s:Fire("kill",1,3)
            timer.Simple(3, function()  if not IsValid(self) then return end
                    local found = true
                    local ent = nil
                    for k,v in pairs(ents.FindInSphere(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)), 30)) do if v != self and v:GetPhysicsObject():IsValid() then
                                ent = v
                                found = false
                            end
                        end

                            if  found then
         ent = ents.Create("prop_physics")
    
        ent:SetPos(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)))
        ent:SetAngles(self:GetAngles())
    ent:SetModel("models/props_phx/cannonball.mdl")
                        ent:Spawn()
                end
        
     
                 self:EmitSound((math.random(1,2) and "explode_4" or "explode_3"))
            local e = EffectData()
            e:SetOrigin(self:LocalToWorld(Vector(150,0,33)))
            self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -400000 + (self:GetUp() * 200000))
            e:SetMagnitude(10)
            e:SetScale(1)
            util.Effect("HelicopterMegaBomb",e)
            ent:Fire("kill",1,20)
            ent:GetPhysicsObject():AddGameFlag(FVPHYSICS_DMG_SLICE)
            local p = self:GetForward()   
            ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))
                    timer.Simple(0.2, function() if IsValid(self) and IsValid(ent) then  ent:GetPhysicsObject():EnableGravity(false)   ent.OldMass = ent:GetPhysicsObject():GetMass() ent:GetPhysicsObject():SetMass(5000) ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000)) end end)
                    timer.Simple(0.4, function() if IsValid(self) and IsValid(ent) then     ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))  ent:GetPhysicsObject():EnableGravity(true)  ent:GetPhysicsObject():SetMass(ent.OldMass) end end)
        end)
        else
        self.Reloaded = true
            if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",1)
            end
        self:EmitSound("NPC_dog.Roll_1")
    end
    
end
    
end
 function ENT:OnRemove()
    if SERVER then
    if WireLib then
    Wire_Remove(self.Entity)
    end
    end
end
if SERVER then
   
function ENT:TriggerInput(iname, value)
        if (iname == "Fire") then
            self:Use()
        end
end 
end

 
 

-- "addons\\toyboxstuff\\lua\\entities\\chrikscannon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Old Cannon"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

    if ( SERVER ) then
                self.Entity:SetModel( "models/props_phx/cannon.mdl" )
            self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys and phys:IsValid() then phys:Wake() end
 
        if SERVER and WireLib then
                self.Inputs = WireLib.CreateInputs(self.Entity, { "Fire"})
            self.Outputs = Wire_CreateOutputs(self.Entity, {"Reloaded"})
        end
    end
    
end

function ENT:Use(activator,caller)
    if not self.NextUse or self.NextUse < CurTime() then
        
        self.NextUse = CurTime() + 3
        if self.Reloaded then
            self.NextUse = CurTime() + 6
                      if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",0)
            end
            self.Reloaded = false
            local s = ents.Create("env_flare")
            s:SetPos(self:LocalToWorld(Vector(-58.3845, -0.0228, 93.2971)))
            s:SetParent(self)
            s:Spawn()
            s:EmitSound("weapon.ImpactSoft")
            s:Fire("kill",1,3)
            timer.Simple(3, function()  if not IsValid(self) then return end
                    local found = true
                    local ent = nil
                    for k,v in pairs(ents.FindInSphere(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)), 30)) do if v != self and v:GetPhysicsObject():IsValid() then
                                ent = v
                                found = false
                            end
                        end

                            if  found then
         ent = ents.Create("prop_physics")
    
        ent:SetPos(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)))
        ent:SetAngles(self:GetAngles())
    ent:SetModel("models/props_phx/cannonball.mdl")
                        ent:Spawn()
                end
        
     
                 self:EmitSound((math.random(1,2) and "explode_4" or "explode_3"))
            local e = EffectData()
            e:SetOrigin(self:LocalToWorld(Vector(150,0,33)))
            self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -400000 + (self:GetUp() * 200000))
            e:SetMagnitude(10)
            e:SetScale(1)
            util.Effect("HelicopterMegaBomb",e)
            ent:Fire("kill",1,20)
            ent:GetPhysicsObject():AddGameFlag(FVPHYSICS_DMG_SLICE)
            local p = self:GetForward()   
            ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))
                    timer.Simple(0.2, function() if IsValid(self) and IsValid(ent) then  ent:GetPhysicsObject():EnableGravity(false)   ent.OldMass = ent:GetPhysicsObject():GetMass() ent:GetPhysicsObject():SetMass(5000) ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000)) end end)
                    timer.Simple(0.4, function() if IsValid(self) and IsValid(ent) then     ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))  ent:GetPhysicsObject():EnableGravity(true)  ent:GetPhysicsObject():SetMass(ent.OldMass) end end)
        end)
        else
        self.Reloaded = true
            if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",1)
            end
        self:EmitSound("NPC_dog.Roll_1")
    end
    
end
    
end
 function ENT:OnRemove()
    if SERVER then
    if WireLib then
    Wire_Remove(self.Entity)
    end
    end
end
if SERVER then
   
function ENT:TriggerInput(iname, value)
        if (iname == "Fire") then
            self:Use()
        end
end 
end

 
 

-- "addons\\toyboxstuff\\lua\\entities\\chrikscannon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Old Cannon"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

    if ( SERVER ) then
                self.Entity:SetModel( "models/props_phx/cannon.mdl" )
            self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys and phys:IsValid() then phys:Wake() end
 
        if SERVER and WireLib then
                self.Inputs = WireLib.CreateInputs(self.Entity, { "Fire"})
            self.Outputs = Wire_CreateOutputs(self.Entity, {"Reloaded"})
        end
    end
    
end

function ENT:Use(activator,caller)
    if not self.NextUse or self.NextUse < CurTime() then
        
        self.NextUse = CurTime() + 3
        if self.Reloaded then
            self.NextUse = CurTime() + 6
                      if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",0)
            end
            self.Reloaded = false
            local s = ents.Create("env_flare")
            s:SetPos(self:LocalToWorld(Vector(-58.3845, -0.0228, 93.2971)))
            s:SetParent(self)
            s:Spawn()
            s:EmitSound("weapon.ImpactSoft")
            s:Fire("kill",1,3)
            timer.Simple(3, function()  if not IsValid(self) then return end
                    local found = true
                    local ent = nil
                    for k,v in pairs(ents.FindInSphere(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)), 30)) do if v != self and v:GetPhysicsObject():IsValid() then
                                ent = v
                                found = false
                            end
                        end

                            if  found then
         ent = ents.Create("prop_physics")
    
        ent:SetPos(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)))
        ent:SetAngles(self:GetAngles())
    ent:SetModel("models/props_phx/cannonball.mdl")
                        ent:Spawn()
                end
        
     
                 self:EmitSound((math.random(1,2) and "explode_4" or "explode_3"))
            local e = EffectData()
            e:SetOrigin(self:LocalToWorld(Vector(150,0,33)))
            self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -400000 + (self:GetUp() * 200000))
            e:SetMagnitude(10)
            e:SetScale(1)
            util.Effect("HelicopterMegaBomb",e)
            ent:Fire("kill",1,20)
            ent:GetPhysicsObject():AddGameFlag(FVPHYSICS_DMG_SLICE)
            local p = self:GetForward()   
            ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))
                    timer.Simple(0.2, function() if IsValid(self) and IsValid(ent) then  ent:GetPhysicsObject():EnableGravity(false)   ent.OldMass = ent:GetPhysicsObject():GetMass() ent:GetPhysicsObject():SetMass(5000) ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000)) end end)
                    timer.Simple(0.4, function() if IsValid(self) and IsValid(ent) then     ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))  ent:GetPhysicsObject():EnableGravity(true)  ent:GetPhysicsObject():SetMass(ent.OldMass) end end)
        end)
        else
        self.Reloaded = true
            if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",1)
            end
        self:EmitSound("NPC_dog.Roll_1")
    end
    
end
    
end
 function ENT:OnRemove()
    if SERVER then
    if WireLib then
    Wire_Remove(self.Entity)
    end
    end
end
if SERVER then
   
function ENT:TriggerInput(iname, value)
        if (iname == "Fire") then
            self:Use()
        end
end 
end

 
 

-- "addons\\toyboxstuff\\lua\\entities\\chrikscannon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Old Cannon"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

    if ( SERVER ) then
                self.Entity:SetModel( "models/props_phx/cannon.mdl" )
            self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys and phys:IsValid() then phys:Wake() end
 
        if SERVER and WireLib then
                self.Inputs = WireLib.CreateInputs(self.Entity, { "Fire"})
            self.Outputs = Wire_CreateOutputs(self.Entity, {"Reloaded"})
        end
    end
    
end

function ENT:Use(activator,caller)
    if not self.NextUse or self.NextUse < CurTime() then
        
        self.NextUse = CurTime() + 3
        if self.Reloaded then
            self.NextUse = CurTime() + 6
                      if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",0)
            end
            self.Reloaded = false
            local s = ents.Create("env_flare")
            s:SetPos(self:LocalToWorld(Vector(-58.3845, -0.0228, 93.2971)))
            s:SetParent(self)
            s:Spawn()
            s:EmitSound("weapon.ImpactSoft")
            s:Fire("kill",1,3)
            timer.Simple(3, function()  if not IsValid(self) then return end
                    local found = true
                    local ent = nil
                    for k,v in pairs(ents.FindInSphere(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)), 30)) do if v != self and v:GetPhysicsObject():IsValid() then
                                ent = v
                                found = false
                            end
                        end

                            if  found then
         ent = ents.Create("prop_physics")
    
        ent:SetPos(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)))
        ent:SetAngles(self:GetAngles())
    ent:SetModel("models/props_phx/cannonball.mdl")
                        ent:Spawn()
                end
        
     
                 self:EmitSound((math.random(1,2) and "explode_4" or "explode_3"))
            local e = EffectData()
            e:SetOrigin(self:LocalToWorld(Vector(150,0,33)))
            self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -400000 + (self:GetUp() * 200000))
            e:SetMagnitude(10)
            e:SetScale(1)
            util.Effect("HelicopterMegaBomb",e)
            ent:Fire("kill",1,20)
            ent:GetPhysicsObject():AddGameFlag(FVPHYSICS_DMG_SLICE)
            local p = self:GetForward()   
            ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))
                    timer.Simple(0.2, function() if IsValid(self) and IsValid(ent) then  ent:GetPhysicsObject():EnableGravity(false)   ent.OldMass = ent:GetPhysicsObject():GetMass() ent:GetPhysicsObject():SetMass(5000) ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000)) end end)
                    timer.Simple(0.4, function() if IsValid(self) and IsValid(ent) then     ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))  ent:GetPhysicsObject():EnableGravity(true)  ent:GetPhysicsObject():SetMass(ent.OldMass) end end)
        end)
        else
        self.Reloaded = true
            if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",1)
            end
        self:EmitSound("NPC_dog.Roll_1")
    end
    
end
    
end
 function ENT:OnRemove()
    if SERVER then
    if WireLib then
    Wire_Remove(self.Entity)
    end
    end
end
if SERVER then
   
function ENT:TriggerInput(iname, value)
        if (iname == "Fire") then
            self:Use()
        end
end 
end

 
 

-- "addons\\toyboxstuff\\lua\\entities\\chrikscannon.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "Old Cannon"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

    if ( SERVER ) then
                self.Entity:SetModel( "models/props_phx/cannon.mdl" )
            self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys and phys:IsValid() then phys:Wake() end
 
        if SERVER and WireLib then
                self.Inputs = WireLib.CreateInputs(self.Entity, { "Fire"})
            self.Outputs = Wire_CreateOutputs(self.Entity, {"Reloaded"})
        end
    end
    
end

function ENT:Use(activator,caller)
    if not self.NextUse or self.NextUse < CurTime() then
        
        self.NextUse = CurTime() + 3
        if self.Reloaded then
            self.NextUse = CurTime() + 6
                      if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",0)
            end
            self.Reloaded = false
            local s = ents.Create("env_flare")
            s:SetPos(self:LocalToWorld(Vector(-58.3845, -0.0228, 93.2971)))
            s:SetParent(self)
            s:Spawn()
            s:EmitSound("weapon.ImpactSoft")
            s:Fire("kill",1,3)
            timer.Simple(3, function()  if not IsValid(self) then return end
                    local found = true
                    local ent = nil
                    for k,v in pairs(ents.FindInSphere(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)), 30)) do if v != self and v:GetPhysicsObject():IsValid() then
                                ent = v
                                found = false
                            end
                        end

                            if  found then
         ent = ents.Create("prop_physics")
    
        ent:SetPos(self:LocalToWorld(Vector(-53.8063, -1.8623, 33.9034)))
        ent:SetAngles(self:GetAngles())
    ent:SetModel("models/props_phx/cannonball.mdl")
                        ent:Spawn()
                end
        
     
                 self:EmitSound((math.random(1,2) and "explode_4" or "explode_3"))
            local e = EffectData()
            e:SetOrigin(self:LocalToWorld(Vector(150,0,33)))
            self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -400000 + (self:GetUp() * 200000))
            e:SetMagnitude(10)
            e:SetScale(1)
            util.Effect("HelicopterMegaBomb",e)
            ent:Fire("kill",1,20)
            ent:GetPhysicsObject():AddGameFlag(FVPHYSICS_DMG_SLICE)
            local p = self:GetForward()   
            ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))
                    timer.Simple(0.2, function() if IsValid(self) and IsValid(ent) then  ent:GetPhysicsObject():EnableGravity(false)   ent.OldMass = ent:GetPhysicsObject():GetMass() ent:GetPhysicsObject():SetMass(5000) ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000)) end end)
                    timer.Simple(0.4, function() if IsValid(self) and IsValid(ent) then     ent:GetPhysicsObject():ApplyForceCenter(p * 999999999999999999900000000000 + Vector(0,0,100000000000))  ent:GetPhysicsObject():EnableGravity(true)  ent:GetPhysicsObject():SetMass(ent.OldMass) end end)
        end)
        else
        self.Reloaded = true
            if WireLib then
                Wire_TriggerOutput(self.Entity, "Reloaded",1)
            end
        self:EmitSound("NPC_dog.Roll_1")
    end
    
end
    
end
 function ENT:OnRemove()
    if SERVER then
    if WireLib then
    Wire_Remove(self.Entity)
    end
    end
end
if SERVER then
   
function ENT:TriggerInput(iname, value)
        if (iname == "Fire") then
            self:Use()
        end
end 
end

 
 

