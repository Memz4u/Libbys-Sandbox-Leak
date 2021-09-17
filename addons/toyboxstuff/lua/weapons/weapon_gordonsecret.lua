-- "addons\\toyboxstuff\\lua\\weapons\\weapon_gordonsecret.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- 4/11/2021 removed wallbang from lenn

AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.AutoSwitchTo        = true
SWEP.AutoSwitchFrom        = false
SWEP.HoldType            = "crowbar"
SWEP.DrawCrosshair        = true
SWEP.PrintName            = "Gordon's Secret"

SWEP.Author            = "CryoShocked"
SWEP.Contact        = "Don't."
SWEP.Purpose        = "To destroy all those around you."
SWEP.Instructions    = "Left click, hold right click, and drool over the amazingness that is this SWEP."

SWEP.ViewModel            = "models/weapons/c_crowbar.mdl"
SWEP.BobScale            = 2
SWEP.SwayScale            = 2
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize        = -1 
SWEP.Primary.DefaultClip    = -1 
SWEP.Primary.Automatic        = true 
SWEP.Primary.Ammo            = "none" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = false 
SWEP.Secondary.Ammo            = "none"

SWEP.Sound = Sound ("disco/disco_sound.wav")

SWEP.Volume = 30
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 0
SWEP.RandomEffectsDelay = 0.1

function SWEP:PrimaryAttack()

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    bullet = {}
    bullet.Num    = 1
    bullet.Src    = self.Owner:GetShootPos()
    bullet.Dir    = self.Owner:GetAimVector()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 0
    bullet.Force  = 100
    bullet.Damage = 6
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 );
self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
else
        self.Weapon:EmitSound("ambient/water_splash1.wav")
    self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end

function SWEP:Initialize()
	self:SetHoldType("melee")
    if ( SERVER ) then 
         self:SetWeaponHoldType( self.HoldType ) 
     end 
util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
    util.PrecacheSound("ambient/water_splash1.wav")
end

function SWEP:SecondaryAttack() end

SWEP.RandomEffects = {
    {function (npc,pl)
        npc:Fire ("ignite","120",0)
        npc:SetHealth (math.Clamp (npc:Health(), 5, 25))
        npc:AddEntityRelationship (pl,D_FR,99)
    end, 1},
    {function (npc)
        local explos = ents.Create ("env_Explosion")
        explos:SetPos (npc:GetPos() + Vector (0,0,4))
        explos:SetKeyValue ("iMagnitude", 1500)
        explos:SetKeyValue ("iRadiusOverride", 200)
        explos:Spawn ()
        explos:Fire ("explode", "", 0)
        explos:Fire ("kill", "", 0.1)
    end, 0.1},
    {function (npc)
        
    end, 0.1},
}

function SWEP:Think ()
    if SERVER then
        self.LastFrame = self.LastFrame or CurTime()
        self.LastRandomEffects = self.LastRandomEffects or 0
        
        if self.Owner:KeyDown (IN_ATTACK2) and self.LastSoundRelease + self.RestartDelay < CurTime() then
            if not self.SoundObject then
                self:CreateSound()
            end
            self.SoundObject:PlayEx(5, 100)
            
            self.Volume = math.Clamp (self.Volume + CurTime() - self.LastFrame, 0, 2)
            self.Influence = math.Clamp (self.Influence + (CurTime() - self.LastFrame) / 2, 0, 1)
            self.SoundObject:ChangeVolume (self.Volume)
            
            self.SoundPlaying = true
        else
            if self.SoundObject and self.SoundPlaying then
                self.SoundObject:FadeOut (0.8)            
                self.SoundPlaying = false
                self.LastSoundRelease = CurTime()
                self.Volume = 0
                self.Influence = 0
            end
        end
        self.LastFrame = CurTime()
        self.Weapon:SetNWBool("on", self.SoundPlaying)
        
        if self.Influence > 0.5 and self.LastRandomEffects + self.RandomEffectsDelay < CurTime() then
            --print ("influence: "..self.Influence)
            for _,npc in pairs (ents.FindInSphere (self.Owner:GetPos(), 768)) do
                if npc:IsNPC() and npc:Health() > 0 then
                    print (tostring(npc))
                    --we want only NPCs vaguely in view to be affected, so players can always see their torture victims. also, it's more loyal to the chaingun-esque original shown in video.
                    local vec1 = ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Normalize()
                    local vec2 = self.Owner:GetAimVector()
                    local dot = vec1:DotProduct (vec2)
                    print (dot)
                    if dot > 0.5 then --good enough for fov 90
                        --apply random effects.
                        local chanceMul = self.Influence * (768 - ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Length()) / 1000
                        print (chanceMul)
                        for k,v in pairs (self.RandomEffects) do
                            npc.effects = npc.effects or {}
                            if math.random() < chanceMul * v[2] * dot and not npc.effects[k] then
                                print ("effect "..k)
                                v[1](npc,self.Owner)
                                --npc.effects[k] = true
                                done = true
                            end
                        end
                    end
                end
            end
            self.LastRandomEffects = CurTime()
            print ("\n")
        end
    end
end

function SWEP:CreateSound ()
    self.SoundObject = CreateSound (self.Weapon, self.Sound)
    self.SoundObject:Play()
end

function SWEP:Holster() 
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 200, 400)

    end
    self:EndSound()
    return true
end

function SWEP:OwnerChanged() self:EndSound() end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:EndSound ()
    if self.SoundObject then
        self.SoundObject:Stop()
    end
end

function SWEP:Deploy()
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 400, 800)

    end
    return true
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_gordonsecret.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- 4/11/2021 removed wallbang from lenn

AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.AutoSwitchTo        = true
SWEP.AutoSwitchFrom        = false
SWEP.HoldType            = "crowbar"
SWEP.DrawCrosshair        = true
SWEP.PrintName            = "Gordon's Secret"

SWEP.Author            = "CryoShocked"
SWEP.Contact        = "Don't."
SWEP.Purpose        = "To destroy all those around you."
SWEP.Instructions    = "Left click, hold right click, and drool over the amazingness that is this SWEP."

SWEP.ViewModel            = "models/weapons/c_crowbar.mdl"
SWEP.BobScale            = 2
SWEP.SwayScale            = 2
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize        = -1 
SWEP.Primary.DefaultClip    = -1 
SWEP.Primary.Automatic        = true 
SWEP.Primary.Ammo            = "none" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = false 
SWEP.Secondary.Ammo            = "none"

SWEP.Sound = Sound ("disco/disco_sound.wav")

SWEP.Volume = 30
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 0
SWEP.RandomEffectsDelay = 0.1

function SWEP:PrimaryAttack()

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    bullet = {}
    bullet.Num    = 1
    bullet.Src    = self.Owner:GetShootPos()
    bullet.Dir    = self.Owner:GetAimVector()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 0
    bullet.Force  = 100
    bullet.Damage = 6
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 );
self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
else
        self.Weapon:EmitSound("ambient/water_splash1.wav")
    self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end

function SWEP:Initialize()
	self:SetHoldType("melee")
    if ( SERVER ) then 
         self:SetWeaponHoldType( self.HoldType ) 
     end 
util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
    util.PrecacheSound("ambient/water_splash1.wav")
end

function SWEP:SecondaryAttack() end

SWEP.RandomEffects = {
    {function (npc,pl)
        npc:Fire ("ignite","120",0)
        npc:SetHealth (math.Clamp (npc:Health(), 5, 25))
        npc:AddEntityRelationship (pl,D_FR,99)
    end, 1},
    {function (npc)
        local explos = ents.Create ("env_Explosion")
        explos:SetPos (npc:GetPos() + Vector (0,0,4))
        explos:SetKeyValue ("iMagnitude", 1500)
        explos:SetKeyValue ("iRadiusOverride", 200)
        explos:Spawn ()
        explos:Fire ("explode", "", 0)
        explos:Fire ("kill", "", 0.1)
    end, 0.1},
    {function (npc)
        
    end, 0.1},
}

function SWEP:Think ()
    if SERVER then
        self.LastFrame = self.LastFrame or CurTime()
        self.LastRandomEffects = self.LastRandomEffects or 0
        
        if self.Owner:KeyDown (IN_ATTACK2) and self.LastSoundRelease + self.RestartDelay < CurTime() then
            if not self.SoundObject then
                self:CreateSound()
            end
            self.SoundObject:PlayEx(5, 100)
            
            self.Volume = math.Clamp (self.Volume + CurTime() - self.LastFrame, 0, 2)
            self.Influence = math.Clamp (self.Influence + (CurTime() - self.LastFrame) / 2, 0, 1)
            self.SoundObject:ChangeVolume (self.Volume)
            
            self.SoundPlaying = true
        else
            if self.SoundObject and self.SoundPlaying then
                self.SoundObject:FadeOut (0.8)            
                self.SoundPlaying = false
                self.LastSoundRelease = CurTime()
                self.Volume = 0
                self.Influence = 0
            end
        end
        self.LastFrame = CurTime()
        self.Weapon:SetNWBool("on", self.SoundPlaying)
        
        if self.Influence > 0.5 and self.LastRandomEffects + self.RandomEffectsDelay < CurTime() then
            --print ("influence: "..self.Influence)
            for _,npc in pairs (ents.FindInSphere (self.Owner:GetPos(), 768)) do
                if npc:IsNPC() and npc:Health() > 0 then
                    print (tostring(npc))
                    --we want only NPCs vaguely in view to be affected, so players can always see their torture victims. also, it's more loyal to the chaingun-esque original shown in video.
                    local vec1 = ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Normalize()
                    local vec2 = self.Owner:GetAimVector()
                    local dot = vec1:DotProduct (vec2)
                    print (dot)
                    if dot > 0.5 then --good enough for fov 90
                        --apply random effects.
                        local chanceMul = self.Influence * (768 - ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Length()) / 1000
                        print (chanceMul)
                        for k,v in pairs (self.RandomEffects) do
                            npc.effects = npc.effects or {}
                            if math.random() < chanceMul * v[2] * dot and not npc.effects[k] then
                                print ("effect "..k)
                                v[1](npc,self.Owner)
                                --npc.effects[k] = true
                                done = true
                            end
                        end
                    end
                end
            end
            self.LastRandomEffects = CurTime()
            print ("\n")
        end
    end
end

function SWEP:CreateSound ()
    self.SoundObject = CreateSound (self.Weapon, self.Sound)
    self.SoundObject:Play()
end

function SWEP:Holster() 
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 200, 400)

    end
    self:EndSound()
    return true
end

function SWEP:OwnerChanged() self:EndSound() end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:EndSound ()
    if self.SoundObject then
        self.SoundObject:Stop()
    end
end

function SWEP:Deploy()
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 400, 800)

    end
    return true
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_gordonsecret.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- 4/11/2021 removed wallbang from lenn

AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.AutoSwitchTo        = true
SWEP.AutoSwitchFrom        = false
SWEP.HoldType            = "crowbar"
SWEP.DrawCrosshair        = true
SWEP.PrintName            = "Gordon's Secret"

SWEP.Author            = "CryoShocked"
SWEP.Contact        = "Don't."
SWEP.Purpose        = "To destroy all those around you."
SWEP.Instructions    = "Left click, hold right click, and drool over the amazingness that is this SWEP."

SWEP.ViewModel            = "models/weapons/c_crowbar.mdl"
SWEP.BobScale            = 2
SWEP.SwayScale            = 2
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize        = -1 
SWEP.Primary.DefaultClip    = -1 
SWEP.Primary.Automatic        = true 
SWEP.Primary.Ammo            = "none" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = false 
SWEP.Secondary.Ammo            = "none"

SWEP.Sound = Sound ("disco/disco_sound.wav")

SWEP.Volume = 30
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 0
SWEP.RandomEffectsDelay = 0.1

function SWEP:PrimaryAttack()

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    bullet = {}
    bullet.Num    = 1
    bullet.Src    = self.Owner:GetShootPos()
    bullet.Dir    = self.Owner:GetAimVector()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 0
    bullet.Force  = 100
    bullet.Damage = 6
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 );
self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
else
        self.Weapon:EmitSound("ambient/water_splash1.wav")
    self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end

function SWEP:Initialize()
	self:SetHoldType("melee")
    if ( SERVER ) then 
         self:SetWeaponHoldType( self.HoldType ) 
     end 
util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
    util.PrecacheSound("ambient/water_splash1.wav")
end

function SWEP:SecondaryAttack() end

SWEP.RandomEffects = {
    {function (npc,pl)
        npc:Fire ("ignite","120",0)
        npc:SetHealth (math.Clamp (npc:Health(), 5, 25))
        npc:AddEntityRelationship (pl,D_FR,99)
    end, 1},
    {function (npc)
        local explos = ents.Create ("env_Explosion")
        explos:SetPos (npc:GetPos() + Vector (0,0,4))
        explos:SetKeyValue ("iMagnitude", 1500)
        explos:SetKeyValue ("iRadiusOverride", 200)
        explos:Spawn ()
        explos:Fire ("explode", "", 0)
        explos:Fire ("kill", "", 0.1)
    end, 0.1},
    {function (npc)
        
    end, 0.1},
}

function SWEP:Think ()
    if SERVER then
        self.LastFrame = self.LastFrame or CurTime()
        self.LastRandomEffects = self.LastRandomEffects or 0
        
        if self.Owner:KeyDown (IN_ATTACK2) and self.LastSoundRelease + self.RestartDelay < CurTime() then
            if not self.SoundObject then
                self:CreateSound()
            end
            self.SoundObject:PlayEx(5, 100)
            
            self.Volume = math.Clamp (self.Volume + CurTime() - self.LastFrame, 0, 2)
            self.Influence = math.Clamp (self.Influence + (CurTime() - self.LastFrame) / 2, 0, 1)
            self.SoundObject:ChangeVolume (self.Volume)
            
            self.SoundPlaying = true
        else
            if self.SoundObject and self.SoundPlaying then
                self.SoundObject:FadeOut (0.8)            
                self.SoundPlaying = false
                self.LastSoundRelease = CurTime()
                self.Volume = 0
                self.Influence = 0
            end
        end
        self.LastFrame = CurTime()
        self.Weapon:SetNWBool("on", self.SoundPlaying)
        
        if self.Influence > 0.5 and self.LastRandomEffects + self.RandomEffectsDelay < CurTime() then
            --print ("influence: "..self.Influence)
            for _,npc in pairs (ents.FindInSphere (self.Owner:GetPos(), 768)) do
                if npc:IsNPC() and npc:Health() > 0 then
                    print (tostring(npc))
                    --we want only NPCs vaguely in view to be affected, so players can always see their torture victims. also, it's more loyal to the chaingun-esque original shown in video.
                    local vec1 = ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Normalize()
                    local vec2 = self.Owner:GetAimVector()
                    local dot = vec1:DotProduct (vec2)
                    print (dot)
                    if dot > 0.5 then --good enough for fov 90
                        --apply random effects.
                        local chanceMul = self.Influence * (768 - ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Length()) / 1000
                        print (chanceMul)
                        for k,v in pairs (self.RandomEffects) do
                            npc.effects = npc.effects or {}
                            if math.random() < chanceMul * v[2] * dot and not npc.effects[k] then
                                print ("effect "..k)
                                v[1](npc,self.Owner)
                                --npc.effects[k] = true
                                done = true
                            end
                        end
                    end
                end
            end
            self.LastRandomEffects = CurTime()
            print ("\n")
        end
    end
end

function SWEP:CreateSound ()
    self.SoundObject = CreateSound (self.Weapon, self.Sound)
    self.SoundObject:Play()
end

function SWEP:Holster() 
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 200, 400)

    end
    self:EndSound()
    return true
end

function SWEP:OwnerChanged() self:EndSound() end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:EndSound ()
    if self.SoundObject then
        self.SoundObject:Stop()
    end
end

function SWEP:Deploy()
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 400, 800)

    end
    return true
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_gordonsecret.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- 4/11/2021 removed wallbang from lenn

AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.AutoSwitchTo        = true
SWEP.AutoSwitchFrom        = false
SWEP.HoldType            = "crowbar"
SWEP.DrawCrosshair        = true
SWEP.PrintName            = "Gordon's Secret"

SWEP.Author            = "CryoShocked"
SWEP.Contact        = "Don't."
SWEP.Purpose        = "To destroy all those around you."
SWEP.Instructions    = "Left click, hold right click, and drool over the amazingness that is this SWEP."

SWEP.ViewModel            = "models/weapons/c_crowbar.mdl"
SWEP.BobScale            = 2
SWEP.SwayScale            = 2
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize        = -1 
SWEP.Primary.DefaultClip    = -1 
SWEP.Primary.Automatic        = true 
SWEP.Primary.Ammo            = "none" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = false 
SWEP.Secondary.Ammo            = "none"

SWEP.Sound = Sound ("disco/disco_sound.wav")

SWEP.Volume = 30
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 0
SWEP.RandomEffectsDelay = 0.1

function SWEP:PrimaryAttack()

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    bullet = {}
    bullet.Num    = 1
    bullet.Src    = self.Owner:GetShootPos()
    bullet.Dir    = self.Owner:GetAimVector()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 0
    bullet.Force  = 100
    bullet.Damage = 6
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 );
self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
else
        self.Weapon:EmitSound("ambient/water_splash1.wav")
    self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end

function SWEP:Initialize()
	self:SetHoldType("melee")
    if ( SERVER ) then 
         self:SetWeaponHoldType( self.HoldType ) 
     end 
util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
    util.PrecacheSound("ambient/water_splash1.wav")
end

function SWEP:SecondaryAttack() end

SWEP.RandomEffects = {
    {function (npc,pl)
        npc:Fire ("ignite","120",0)
        npc:SetHealth (math.Clamp (npc:Health(), 5, 25))
        npc:AddEntityRelationship (pl,D_FR,99)
    end, 1},
    {function (npc)
        local explos = ents.Create ("env_Explosion")
        explos:SetPos (npc:GetPos() + Vector (0,0,4))
        explos:SetKeyValue ("iMagnitude", 1500)
        explos:SetKeyValue ("iRadiusOverride", 200)
        explos:Spawn ()
        explos:Fire ("explode", "", 0)
        explos:Fire ("kill", "", 0.1)
    end, 0.1},
    {function (npc)
        
    end, 0.1},
}

function SWEP:Think ()
    if SERVER then
        self.LastFrame = self.LastFrame or CurTime()
        self.LastRandomEffects = self.LastRandomEffects or 0
        
        if self.Owner:KeyDown (IN_ATTACK2) and self.LastSoundRelease + self.RestartDelay < CurTime() then
            if not self.SoundObject then
                self:CreateSound()
            end
            self.SoundObject:PlayEx(5, 100)
            
            self.Volume = math.Clamp (self.Volume + CurTime() - self.LastFrame, 0, 2)
            self.Influence = math.Clamp (self.Influence + (CurTime() - self.LastFrame) / 2, 0, 1)
            self.SoundObject:ChangeVolume (self.Volume)
            
            self.SoundPlaying = true
        else
            if self.SoundObject and self.SoundPlaying then
                self.SoundObject:FadeOut (0.8)            
                self.SoundPlaying = false
                self.LastSoundRelease = CurTime()
                self.Volume = 0
                self.Influence = 0
            end
        end
        self.LastFrame = CurTime()
        self.Weapon:SetNWBool("on", self.SoundPlaying)
        
        if self.Influence > 0.5 and self.LastRandomEffects + self.RandomEffectsDelay < CurTime() then
            --print ("influence: "..self.Influence)
            for _,npc in pairs (ents.FindInSphere (self.Owner:GetPos(), 768)) do
                if npc:IsNPC() and npc:Health() > 0 then
                    print (tostring(npc))
                    --we want only NPCs vaguely in view to be affected, so players can always see their torture victims. also, it's more loyal to the chaingun-esque original shown in video.
                    local vec1 = ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Normalize()
                    local vec2 = self.Owner:GetAimVector()
                    local dot = vec1:DotProduct (vec2)
                    print (dot)
                    if dot > 0.5 then --good enough for fov 90
                        --apply random effects.
                        local chanceMul = self.Influence * (768 - ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Length()) / 1000
                        print (chanceMul)
                        for k,v in pairs (self.RandomEffects) do
                            npc.effects = npc.effects or {}
                            if math.random() < chanceMul * v[2] * dot and not npc.effects[k] then
                                print ("effect "..k)
                                v[1](npc,self.Owner)
                                --npc.effects[k] = true
                                done = true
                            end
                        end
                    end
                end
            end
            self.LastRandomEffects = CurTime()
            print ("\n")
        end
    end
end

function SWEP:CreateSound ()
    self.SoundObject = CreateSound (self.Weapon, self.Sound)
    self.SoundObject:Play()
end

function SWEP:Holster() 
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 200, 400)

    end
    self:EndSound()
    return true
end

function SWEP:OwnerChanged() self:EndSound() end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:EndSound ()
    if self.SoundObject then
        self.SoundObject:Stop()
    end
end

function SWEP:Deploy()
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 400, 800)

    end
    return true
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_gordonsecret.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- 4/11/2021 removed wallbang from lenn

AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.AutoSwitchTo        = true
SWEP.AutoSwitchFrom        = false
SWEP.HoldType            = "crowbar"
SWEP.DrawCrosshair        = true
SWEP.PrintName            = "Gordon's Secret"

SWEP.Author            = "CryoShocked"
SWEP.Contact        = "Don't."
SWEP.Purpose        = "To destroy all those around you."
SWEP.Instructions    = "Left click, hold right click, and drool over the amazingness that is this SWEP."

SWEP.ViewModel            = "models/weapons/c_crowbar.mdl"
SWEP.BobScale            = 2
SWEP.SwayScale            = 2
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize        = -1 
SWEP.Primary.DefaultClip    = -1 
SWEP.Primary.Automatic        = true 
SWEP.Primary.Ammo            = "none" 

SWEP.Secondary.ClipSize        = -1 
SWEP.Secondary.DefaultClip    = -1 
SWEP.Secondary.Automatic    = false 
SWEP.Secondary.Ammo            = "none"

SWEP.Sound = Sound ("disco/disco_sound.wav")

SWEP.Volume = 30
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 0
SWEP.RandomEffectsDelay = 0.1

function SWEP:PrimaryAttack()

local trace = self.Owner:GetEyeTrace()

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    bullet = {}
    bullet.Num    = 1
    bullet.Src    = self.Owner:GetShootPos()
    bullet.Dir    = self.Owner:GetAimVector()
    bullet.Spread = Vector(0, 0, 0)
    bullet.Tracer = 0
    bullet.Force  = 100
    bullet.Damage = 6
self.Owner:FireBullets(bullet)
self.Owner:SetAnimation( PLAYER_ATTACK1 );
self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
else
        self.Weapon:EmitSound("ambient/water_splash1.wav")
    self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end

end

function SWEP:Initialize()
	self:SetHoldType("melee")
    if ( SERVER ) then 
         self:SetWeaponHoldType( self.HoldType ) 
     end 
util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
    util.PrecacheSound("ambient/water_splash1.wav")
end

function SWEP:SecondaryAttack() end

SWEP.RandomEffects = {
    {function (npc,pl)
        npc:Fire ("ignite","120",0)
        npc:SetHealth (math.Clamp (npc:Health(), 5, 25))
        npc:AddEntityRelationship (pl,D_FR,99)
    end, 1},
    {function (npc)
        local explos = ents.Create ("env_Explosion")
        explos:SetPos (npc:GetPos() + Vector (0,0,4))
        explos:SetKeyValue ("iMagnitude", 1500)
        explos:SetKeyValue ("iRadiusOverride", 200)
        explos:Spawn ()
        explos:Fire ("explode", "", 0)
        explos:Fire ("kill", "", 0.1)
    end, 0.1},
    {function (npc)
        
    end, 0.1},
}

function SWEP:Think ()
    if SERVER then
        self.LastFrame = self.LastFrame or CurTime()
        self.LastRandomEffects = self.LastRandomEffects or 0
        
        if self.Owner:KeyDown (IN_ATTACK2) and self.LastSoundRelease + self.RestartDelay < CurTime() then
            if not self.SoundObject then
                self:CreateSound()
            end
            self.SoundObject:PlayEx(5, 100)
            
            self.Volume = math.Clamp (self.Volume + CurTime() - self.LastFrame, 0, 2)
            self.Influence = math.Clamp (self.Influence + (CurTime() - self.LastFrame) / 2, 0, 1)
            self.SoundObject:ChangeVolume (self.Volume)
            
            self.SoundPlaying = true
        else
            if self.SoundObject and self.SoundPlaying then
                self.SoundObject:FadeOut (0.8)            
                self.SoundPlaying = false
                self.LastSoundRelease = CurTime()
                self.Volume = 0
                self.Influence = 0
            end
        end
        self.LastFrame = CurTime()
        self.Weapon:SetNWBool("on", self.SoundPlaying)
        
        if self.Influence > 0.5 and self.LastRandomEffects + self.RandomEffectsDelay < CurTime() then
            --print ("influence: "..self.Influence)
            for _,npc in pairs (ents.FindInSphere (self.Owner:GetPos(), 768)) do
                if npc:IsNPC() and npc:Health() > 0 then
                    print (tostring(npc))
                    --we want only NPCs vaguely in view to be affected, so players can always see their torture victims. also, it's more loyal to the chaingun-esque original shown in video.
                    local vec1 = ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Normalize()
                    local vec2 = self.Owner:GetAimVector()
                    local dot = vec1:DotProduct (vec2)
                    print (dot)
                    if dot > 0.5 then --good enough for fov 90
                        --apply random effects.
                        local chanceMul = self.Influence * (768 - ((npc:GetShootPos() or npc:GetPos()) - self.Owner:GetShootPos()):Length()) / 1000
                        print (chanceMul)
                        for k,v in pairs (self.RandomEffects) do
                            npc.effects = npc.effects or {}
                            if math.random() < chanceMul * v[2] * dot and not npc.effects[k] then
                                print ("effect "..k)
                                v[1](npc,self.Owner)
                                --npc.effects[k] = true
                                done = true
                            end
                        end
                    end
                end
            end
            self.LastRandomEffects = CurTime()
            print ("\n")
        end
    end
end

function SWEP:CreateSound ()
    self.SoundObject = CreateSound (self.Weapon, self.Sound)
    self.SoundObject:Play()
end

function SWEP:Holster() 
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 200, 400)

    end
    self:EndSound()
    return true
end

function SWEP:OwnerChanged() self:EndSound() end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:EndSound ()
    if self.SoundObject then
        self.SoundObject:Stop()
    end
end

function SWEP:Deploy()
    if SERVER then

        GAMEMODE:SetPlayerSpeed(self.Owner, 400, 800)

    end
    return true
end

