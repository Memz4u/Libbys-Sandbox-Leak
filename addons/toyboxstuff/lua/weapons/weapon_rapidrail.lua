-- "addons\\toyboxstuff\\lua\\weapons\\weapon_rapidrail.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author                     = "Levybreak"
SWEP.Contact            = "Facepunch"
SWEP.Purpose            = "Railgunz iz gunna burn a hola through ya!"
SWEP.Instructions       = "Primary fire for rapid laz0rs. Secondary for a massive burst!"

SWEP.PrintName                  = "Asteroid Assault Railgun"                     
SWEP.Slot                               = 4
SWEP.SlotPos                    = 4
SWEP.DrawAmmo                   = true
SWEP.DrawCrosshair              = true

SWEP.Weight                             = 15
SWEP.AutoSwitchTo               = true
SWEP.AutoSwitchFrom             = true

SWEP.ViewModel                  = "models/weapons/c_rpg.mdl"
SWEP.WorldModel                 = "models/Weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = 0
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo                       = "none"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo                     = "none"

SWEP.HoldType = "rpg"

SWEP.PrimaryFireRate = 0.5
SWEP.SecondaryFireRate = 45

SWEP.PrimaryHook = (ClassName or "railcanon").."PrimaryFire"
SWEP.SecondaryHook = (ClassName or "railcanon").."SecondaryFire"

function SWEP:Initialize()
	self:SetHoldType("rpg")
    if (SERVER) then
        self:SetWeaponHoldType( self.HoldType )
    else
        self.Bar1Per = 100
        self.Bar2Per = 100
        self.Bar2TS = 0
        self.Bar1TS = 0
        usermessage.Hook(self.PrimaryHook,function(um)
            if (self.Bar1TS or 0) <= CurTime() then
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + (self.PrimaryFireRate or 0.5)
            end
        end)
        usermessage.Hook(self.SecondaryHook,function(um)
            if self.Bar2TS <= CurTime() then
                self.Bar2Per = 0
                self.Bar2TS = CurTime() + self.SecondaryFireRate
                timer.Simple(1,function() LocalPlayer().BlindingLight = 1 end)
                timer.Simple(3,function() LocalPlayer().BlindingLight = nil end)
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + self.PrimaryFireRate
            end
        end)
    end
end
if CLIENT then surface.CreateFont("HL2WeaponSelectIcons", {font = "HalfLife2", size = ScreenScale(60), weight = 500, antialias = true, additive = true}) end
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
    
        draw.SimpleText( "i", "HL2WeaponSelectIcons", x + wide*0.5, y + tall*0.2, Color( 0, 10, 200, 255 ), TEXT_ALIGN_CENTER )
    
end

function SWEP:Reload()
       
end

function SWEP:Think()

end

local zerovec = Vector(0,0,0)
local BoxSize = Vector(20,20,20)
local MaxHits = 7

local RecoilAng = Angle(-4,0,0)
function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire(CurTime() + self.PrimaryFireRate)
    if SERVER then SendUserMessage(self.PrimaryHook,self.Owner) end
   
   
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:ViewPunch(RecoilAng)
   
    local ply = self.Owner

    if CLIENT and IsFirstTimePredicted() then
   
    local data = EffectData()
    local wep = ply:GetViewModel()
    local pos = Vector()
    if wep and wep:IsValid() and game.SinglePlayer() then
        pos = wep:GetAttachment(3).Pos
        ang = wep:GetAttachment(3).Ang 
        local vect = ply:OBBMaxs()
        pos=pos+Vector(0,0,vect.z-7)
    elseif wep and wep:IsValid() and !game.SinglePlayer() then
    	PrintTable(wep:GetAttachments())
        pos = wep:GetAttachment(2).Pos
        ang = wep:GetAttachment(2).Ang 
        local vect = ply:OBBMaxs()
        pos=pos + ply:GetUp() * 5
    end
    local ang = ply:GetAimVector():Angle()

    local data = EffectData()
    data:SetOrigin(pos)
    data:SetAngles(ang)
    util.Effect("railgun_shot",data)

	end

    if (!SERVER) then return end

    self.Owner:EmitSound("PropJeep.FireChargedCannon",SNDLVL_20dB,100)
   
    local pos = ply:GetShootPos()
    local ang = ply:GetAimVector()
    local tracedata = {}
    tracedata.start = pos
    tracedata.endpos = pos+(ang*10000)
    tracedata.filter = ply
    tracedata.mins = BoxSize*-1
    tracedata.maxs = BoxSize
    local trace = util.TraceHull(tracedata)
   
    local HitEnts = {}
    if trace.Entity then
        table.insert(HitEnts,trace.Entity)
    end
   
    for i=1,(MaxHits-1) do
        tracedata = {}
        tracedata.start = trace.HitPos
        tracedata.endpos = trace.HitPos+(ang*10000)
        tracedata.filter = {ply,unpack(HitEnts)}
        tracedata.mins = BoxSize*-1
        tracedata.maxs = BoxSize
        trace = util.TraceHull(tracedata)
        if trace.Entity then
            table.insert(HitEnts,trace.Entity)
        end
    end
   
    for k,v in ipairs(HitEnts) do
        if v:IsValid() and v:Health() > 0 then
            v:TakeDamage(math.random(25,35),self.Owner,self)
        end
    end
end

local function SupahFireScreenWhiteness()
    if LocalPlayer().BlindingLight then  
        local tab = {}
        tab[ "$pp_colour_addr" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addg" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addb" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_brightness" ] = 0
        tab[ "$pp_colour_contrast" ] = 1
        tab[ "$pp_colour_colour" ] = 1
        tab[ "$pp_colour_mulr" ] = 0
        tab[ "$pp_colour_mulg" ] = 0
        tab[ "$pp_colour_mulb" ] = 0

        DrawColorModify( tab )
        LocalPlayer().BlindingLight = math.Clamp(LocalPlayer().BlindingLight-0.05,0,1)
    end
end
hook.Add( "RenderScreenspaceEffects", "SupahFireScreenWhiteness", SupahFireScreenWhiteness )



hook.Add("DoPlayerDeath", "dontlockmerailgunpls", function(ply)
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_rapidrail" then
		ply:UnLock()
		ply:StopSound("WeaponDissolve.Charge")
		hook.Remove("Think", ply:Nick().."ScreenShake")
	end
end)

function SWEP:SecondaryAttack()
    self.Weapon:SetNextSecondaryFire(CurTime() + self.SecondaryFireRate)

    if SERVER then SendUserMessage(self.SecondaryHook,self.Owner) end
   
    if (!SERVER) then return end
    self.Owner:EmitSound("WeaponDissolve.Charge",SNDLVL_GUNFIRE,100)
    self.Owner:Lock()
    timer.Simple(3,function() if !IsValid(self) then return end if !IsValid(self.Owner) then return end self.Owner:UnLock() hook.Remove("Think",self.Owner:Nick().."ScreenShake") end)
    hook.Add("Think", self.Owner:Nick().."ScreenShake", function() 
    	if !IsValid(self) then return end 
    	if !IsValid(self.Owner) then return end 
    	self.Owner:ViewPunch(Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),math.Rand(-0.5,0.5))) 
    end)
   
    timer.Simple(1,function()
    		if !IsValid(self) then return end
            local MaxDist = 1500
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:StopSound("WeaponDissolve.Charge")
            self:EmitSound("explode_7",SNDLVL_GUNFIRE,100)
            local ply = self.Owner
           
            local tbl = ents.FindInCone(ply:EyePos(), ply:GetAimVector(), MaxDist, math.cos(math.rad( 70 ))) -- OH JESUS CHRIST WHY MUST THIS METHOD BE USED IT'S HORRIBLY OUTDATED AND I HAVE NO OTHER
           
            local data = EffectData()
            local wep = ply:GetViewModel()
            local pos = Vector()
            if wep and wep:IsValid() then
                    pos = wep:GetAttachment(1).Pos
                    ang = wep:GetAttachment(1).Ang 
                    local vect = ply:OBBMaxs()
                    pos=pos+Vector(0,0,vect.z-7)
            end
            local ang = ply:GetAimVector():Angle()
           
            local data = EffectData()
            data:SetOrigin(pos)
            data:SetAngles(ang)
            util.Effect("railgun_burst",data)
           
            for k,v in ipairs(tbl) do
                if v:IsValid() and v:IsPlayer() then --I'm a lazy mofo
                        v:SendLua("LocalPlayer().BlindingLight = 1 timer.Simple(2,function() LocalPlayer().BlindingLight = nil end)")
                elseif v:IsValid() and v:Health() > 0 then
                    local MaxDamage = 1000
                    local dist = self.Owner:GetShootPos():Distance(v:GetPos())
                    if dist < 500 then
                        v:TakeDamage(MaxDamage,self.Owner,self)
                    else
                        v:TakeDamage(MaxDamage*(1-(dist/MaxDist)),self.Owner,self)
                    end
                end
                local phys = v:GetPhysicsObject()
                if v and v:IsValid() and phys and phys:IsValid() then
                    phys:ApplyForceCenter((self.Owner:GetShootPos()-v:GetPos()):GetNormalized()*-100000)
                end
            end
    end)
end


function SWEP:ShouldDropOnDie()
        return false
end

local color_gray = Color(0,0,0,150)
local color_white = Color(250,250,250,255)
local color_green = Color(0,255,0,255)

function SWEP:DrawHUD()

        if (!CLIENT) then return end
       
        draw.RoundedBox(4,ScrW()-78,ScrH()-108,22,106,color_gray)
        draw.RoundedBox(4,ScrW()-50,ScrH()-108,22,106,color_gray)
       
        self.Bar2Per = 100-((math.Clamp(self.Bar2TS-CurTime(),0,self.SecondaryFireRate)/self.SecondaryFireRate)*100)
        self.Bar1Per = 100-((math.Clamp(self.Bar1TS-CurTime(),0,self.PrimaryFireRate)/self.PrimaryFireRate)*100)
       
        local pcol 
        if self.Bar1Per >= 100 then pcol = color_green else pcol = color_white end
        local scol
        if self.Bar2Per >= 100 then scol = color_green else scol = color_white end
        draw.RoundedBox(4,ScrW()-76,ScrH()-104+(100-math.Clamp(self.Bar1Per,8,100)),18,math.Clamp(self.Bar1Per,8,100),pcol)
        draw.RoundedBox(4,ScrW()-48,ScrH()-104+(100-math.Clamp(self.Bar2Per,8,100)),18,math.Clamp(self.Bar2Per,8,100),scol)

end

if CLIENT then
local EFFECT = {}
local Laser = Material("effects/energysplash")
local maxv = Vector(1,1,1)*17000
function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)
    self.Entity:SetRenderBounds( maxv*-1, maxv )
    local Lifetime = 2
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
   
    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.Pos+(self.Ang:Forward()*1500), 700*frac, 0.5, 1, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_burst",true)

local EFFECT = {}
local Laser = Material("effects/energysplash")

function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)

    self.Entity:SetRenderBounds( maxv*-1, maxv )

    local Lifetime = 1
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
        

    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.tr.HitPos, 40*frac, 0.5, 0.7, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_shot",true)

killicon.AddFont(ClassName or "railcanon", "HL2MPTypeDeath", "3", Color( 0, 20, 255, 255 ))
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_rapidrail.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author                     = "Levybreak"
SWEP.Contact            = "Facepunch"
SWEP.Purpose            = "Railgunz iz gunna burn a hola through ya!"
SWEP.Instructions       = "Primary fire for rapid laz0rs. Secondary for a massive burst!"

SWEP.PrintName                  = "Asteroid Assault Railgun"                     
SWEP.Slot                               = 4
SWEP.SlotPos                    = 4
SWEP.DrawAmmo                   = true
SWEP.DrawCrosshair              = true

SWEP.Weight                             = 15
SWEP.AutoSwitchTo               = true
SWEP.AutoSwitchFrom             = true

SWEP.ViewModel                  = "models/weapons/c_rpg.mdl"
SWEP.WorldModel                 = "models/Weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = 0
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo                       = "none"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo                     = "none"

SWEP.HoldType = "rpg"

SWEP.PrimaryFireRate = 0.5
SWEP.SecondaryFireRate = 45

SWEP.PrimaryHook = (ClassName or "railcanon").."PrimaryFire"
SWEP.SecondaryHook = (ClassName or "railcanon").."SecondaryFire"

function SWEP:Initialize()
	self:SetHoldType("rpg")
    if (SERVER) then
        self:SetWeaponHoldType( self.HoldType )
    else
        self.Bar1Per = 100
        self.Bar2Per = 100
        self.Bar2TS = 0
        self.Bar1TS = 0
        usermessage.Hook(self.PrimaryHook,function(um)
            if (self.Bar1TS or 0) <= CurTime() then
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + (self.PrimaryFireRate or 0.5)
            end
        end)
        usermessage.Hook(self.SecondaryHook,function(um)
            if self.Bar2TS <= CurTime() then
                self.Bar2Per = 0
                self.Bar2TS = CurTime() + self.SecondaryFireRate
                timer.Simple(1,function() LocalPlayer().BlindingLight = 1 end)
                timer.Simple(3,function() LocalPlayer().BlindingLight = nil end)
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + self.PrimaryFireRate
            end
        end)
    end
end
if CLIENT then surface.CreateFont("HL2WeaponSelectIcons", {font = "HalfLife2", size = ScreenScale(60), weight = 500, antialias = true, additive = true}) end
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
    
        draw.SimpleText( "i", "HL2WeaponSelectIcons", x + wide*0.5, y + tall*0.2, Color( 0, 10, 200, 255 ), TEXT_ALIGN_CENTER )
    
end

function SWEP:Reload()
       
end

function SWEP:Think()

end

local zerovec = Vector(0,0,0)
local BoxSize = Vector(20,20,20)
local MaxHits = 7

local RecoilAng = Angle(-4,0,0)
function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire(CurTime() + self.PrimaryFireRate)
    if SERVER then SendUserMessage(self.PrimaryHook,self.Owner) end
   
   
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:ViewPunch(RecoilAng)
   
    local ply = self.Owner

    if CLIENT and IsFirstTimePredicted() then
   
    local data = EffectData()
    local wep = ply:GetViewModel()
    local pos = Vector()
    if wep and wep:IsValid() and game.SinglePlayer() then
        pos = wep:GetAttachment(3).Pos
        ang = wep:GetAttachment(3).Ang 
        local vect = ply:OBBMaxs()
        pos=pos+Vector(0,0,vect.z-7)
    elseif wep and wep:IsValid() and !game.SinglePlayer() then
    	PrintTable(wep:GetAttachments())
        pos = wep:GetAttachment(2).Pos
        ang = wep:GetAttachment(2).Ang 
        local vect = ply:OBBMaxs()
        pos=pos + ply:GetUp() * 5
    end
    local ang = ply:GetAimVector():Angle()

    local data = EffectData()
    data:SetOrigin(pos)
    data:SetAngles(ang)
    util.Effect("railgun_shot",data)

	end

    if (!SERVER) then return end

    self.Owner:EmitSound("PropJeep.FireChargedCannon",SNDLVL_20dB,100)
   
    local pos = ply:GetShootPos()
    local ang = ply:GetAimVector()
    local tracedata = {}
    tracedata.start = pos
    tracedata.endpos = pos+(ang*10000)
    tracedata.filter = ply
    tracedata.mins = BoxSize*-1
    tracedata.maxs = BoxSize
    local trace = util.TraceHull(tracedata)
   
    local HitEnts = {}
    if trace.Entity then
        table.insert(HitEnts,trace.Entity)
    end
   
    for i=1,(MaxHits-1) do
        tracedata = {}
        tracedata.start = trace.HitPos
        tracedata.endpos = trace.HitPos+(ang*10000)
        tracedata.filter = {ply,unpack(HitEnts)}
        tracedata.mins = BoxSize*-1
        tracedata.maxs = BoxSize
        trace = util.TraceHull(tracedata)
        if trace.Entity then
            table.insert(HitEnts,trace.Entity)
        end
    end
   
    for k,v in ipairs(HitEnts) do
        if v:IsValid() and v:Health() > 0 then
            v:TakeDamage(math.random(25,35),self.Owner,self)
        end
    end
end

local function SupahFireScreenWhiteness()
    if LocalPlayer().BlindingLight then  
        local tab = {}
        tab[ "$pp_colour_addr" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addg" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addb" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_brightness" ] = 0
        tab[ "$pp_colour_contrast" ] = 1
        tab[ "$pp_colour_colour" ] = 1
        tab[ "$pp_colour_mulr" ] = 0
        tab[ "$pp_colour_mulg" ] = 0
        tab[ "$pp_colour_mulb" ] = 0

        DrawColorModify( tab )
        LocalPlayer().BlindingLight = math.Clamp(LocalPlayer().BlindingLight-0.05,0,1)
    end
end
hook.Add( "RenderScreenspaceEffects", "SupahFireScreenWhiteness", SupahFireScreenWhiteness )



hook.Add("DoPlayerDeath", "dontlockmerailgunpls", function(ply)
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_rapidrail" then
		ply:UnLock()
		ply:StopSound("WeaponDissolve.Charge")
		hook.Remove("Think", ply:Nick().."ScreenShake")
	end
end)

function SWEP:SecondaryAttack()
    self.Weapon:SetNextSecondaryFire(CurTime() + self.SecondaryFireRate)

    if SERVER then SendUserMessage(self.SecondaryHook,self.Owner) end
   
    if (!SERVER) then return end
    self.Owner:EmitSound("WeaponDissolve.Charge",SNDLVL_GUNFIRE,100)
    self.Owner:Lock()
    timer.Simple(3,function() if !IsValid(self) then return end if !IsValid(self.Owner) then return end self.Owner:UnLock() hook.Remove("Think",self.Owner:Nick().."ScreenShake") end)
    hook.Add("Think", self.Owner:Nick().."ScreenShake", function() 
    	if !IsValid(self) then return end 
    	if !IsValid(self.Owner) then return end 
    	self.Owner:ViewPunch(Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),math.Rand(-0.5,0.5))) 
    end)
   
    timer.Simple(1,function()
    		if !IsValid(self) then return end
            local MaxDist = 1500
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:StopSound("WeaponDissolve.Charge")
            self:EmitSound("explode_7",SNDLVL_GUNFIRE,100)
            local ply = self.Owner
           
            local tbl = ents.FindInCone(ply:EyePos(), ply:GetAimVector(), MaxDist, math.cos(math.rad( 70 ))) -- OH JESUS CHRIST WHY MUST THIS METHOD BE USED IT'S HORRIBLY OUTDATED AND I HAVE NO OTHER
           
            local data = EffectData()
            local wep = ply:GetViewModel()
            local pos = Vector()
            if wep and wep:IsValid() then
                    pos = wep:GetAttachment(1).Pos
                    ang = wep:GetAttachment(1).Ang 
                    local vect = ply:OBBMaxs()
                    pos=pos+Vector(0,0,vect.z-7)
            end
            local ang = ply:GetAimVector():Angle()
           
            local data = EffectData()
            data:SetOrigin(pos)
            data:SetAngles(ang)
            util.Effect("railgun_burst",data)
           
            for k,v in ipairs(tbl) do
                if v:IsValid() and v:IsPlayer() then --I'm a lazy mofo
                        v:SendLua("LocalPlayer().BlindingLight = 1 timer.Simple(2,function() LocalPlayer().BlindingLight = nil end)")
                elseif v:IsValid() and v:Health() > 0 then
                    local MaxDamage = 1000
                    local dist = self.Owner:GetShootPos():Distance(v:GetPos())
                    if dist < 500 then
                        v:TakeDamage(MaxDamage,self.Owner,self)
                    else
                        v:TakeDamage(MaxDamage*(1-(dist/MaxDist)),self.Owner,self)
                    end
                end
                local phys = v:GetPhysicsObject()
                if v and v:IsValid() and phys and phys:IsValid() then
                    phys:ApplyForceCenter((self.Owner:GetShootPos()-v:GetPos()):GetNormalized()*-100000)
                end
            end
    end)
end


function SWEP:ShouldDropOnDie()
        return false
end

local color_gray = Color(0,0,0,150)
local color_white = Color(250,250,250,255)
local color_green = Color(0,255,0,255)

function SWEP:DrawHUD()

        if (!CLIENT) then return end
       
        draw.RoundedBox(4,ScrW()-78,ScrH()-108,22,106,color_gray)
        draw.RoundedBox(4,ScrW()-50,ScrH()-108,22,106,color_gray)
       
        self.Bar2Per = 100-((math.Clamp(self.Bar2TS-CurTime(),0,self.SecondaryFireRate)/self.SecondaryFireRate)*100)
        self.Bar1Per = 100-((math.Clamp(self.Bar1TS-CurTime(),0,self.PrimaryFireRate)/self.PrimaryFireRate)*100)
       
        local pcol 
        if self.Bar1Per >= 100 then pcol = color_green else pcol = color_white end
        local scol
        if self.Bar2Per >= 100 then scol = color_green else scol = color_white end
        draw.RoundedBox(4,ScrW()-76,ScrH()-104+(100-math.Clamp(self.Bar1Per,8,100)),18,math.Clamp(self.Bar1Per,8,100),pcol)
        draw.RoundedBox(4,ScrW()-48,ScrH()-104+(100-math.Clamp(self.Bar2Per,8,100)),18,math.Clamp(self.Bar2Per,8,100),scol)

end

if CLIENT then
local EFFECT = {}
local Laser = Material("effects/energysplash")
local maxv = Vector(1,1,1)*17000
function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)
    self.Entity:SetRenderBounds( maxv*-1, maxv )
    local Lifetime = 2
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
   
    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.Pos+(self.Ang:Forward()*1500), 700*frac, 0.5, 1, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_burst",true)

local EFFECT = {}
local Laser = Material("effects/energysplash")

function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)

    self.Entity:SetRenderBounds( maxv*-1, maxv )

    local Lifetime = 1
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
        

    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.tr.HitPos, 40*frac, 0.5, 0.7, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_shot",true)

killicon.AddFont(ClassName or "railcanon", "HL2MPTypeDeath", "3", Color( 0, 20, 255, 255 ))
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_rapidrail.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author                     = "Levybreak"
SWEP.Contact            = "Facepunch"
SWEP.Purpose            = "Railgunz iz gunna burn a hola through ya!"
SWEP.Instructions       = "Primary fire for rapid laz0rs. Secondary for a massive burst!"

SWEP.PrintName                  = "Asteroid Assault Railgun"                     
SWEP.Slot                               = 4
SWEP.SlotPos                    = 4
SWEP.DrawAmmo                   = true
SWEP.DrawCrosshair              = true

SWEP.Weight                             = 15
SWEP.AutoSwitchTo               = true
SWEP.AutoSwitchFrom             = true

SWEP.ViewModel                  = "models/weapons/c_rpg.mdl"
SWEP.WorldModel                 = "models/Weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = 0
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo                       = "none"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo                     = "none"

SWEP.HoldType = "rpg"

SWEP.PrimaryFireRate = 0.5
SWEP.SecondaryFireRate = 45

SWEP.PrimaryHook = (ClassName or "railcanon").."PrimaryFire"
SWEP.SecondaryHook = (ClassName or "railcanon").."SecondaryFire"

function SWEP:Initialize()
	self:SetHoldType("rpg")
    if (SERVER) then
        self:SetWeaponHoldType( self.HoldType )
    else
        self.Bar1Per = 100
        self.Bar2Per = 100
        self.Bar2TS = 0
        self.Bar1TS = 0
        usermessage.Hook(self.PrimaryHook,function(um)
            if (self.Bar1TS or 0) <= CurTime() then
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + (self.PrimaryFireRate or 0.5)
            end
        end)
        usermessage.Hook(self.SecondaryHook,function(um)
            if self.Bar2TS <= CurTime() then
                self.Bar2Per = 0
                self.Bar2TS = CurTime() + self.SecondaryFireRate
                timer.Simple(1,function() LocalPlayer().BlindingLight = 1 end)
                timer.Simple(3,function() LocalPlayer().BlindingLight = nil end)
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + self.PrimaryFireRate
            end
        end)
    end
end
if CLIENT then surface.CreateFont("HL2WeaponSelectIcons", {font = "HalfLife2", size = ScreenScale(60), weight = 500, antialias = true, additive = true}) end
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
    
        draw.SimpleText( "i", "HL2WeaponSelectIcons", x + wide*0.5, y + tall*0.2, Color( 0, 10, 200, 255 ), TEXT_ALIGN_CENTER )
    
end

function SWEP:Reload()
       
end

function SWEP:Think()

end

local zerovec = Vector(0,0,0)
local BoxSize = Vector(20,20,20)
local MaxHits = 7

local RecoilAng = Angle(-4,0,0)
function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire(CurTime() + self.PrimaryFireRate)
    if SERVER then SendUserMessage(self.PrimaryHook,self.Owner) end
   
   
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:ViewPunch(RecoilAng)
   
    local ply = self.Owner

    if CLIENT and IsFirstTimePredicted() then
   
    local data = EffectData()
    local wep = ply:GetViewModel()
    local pos = Vector()
    if wep and wep:IsValid() and game.SinglePlayer() then
        pos = wep:GetAttachment(3).Pos
        ang = wep:GetAttachment(3).Ang 
        local vect = ply:OBBMaxs()
        pos=pos+Vector(0,0,vect.z-7)
    elseif wep and wep:IsValid() and !game.SinglePlayer() then
    	PrintTable(wep:GetAttachments())
        pos = wep:GetAttachment(2).Pos
        ang = wep:GetAttachment(2).Ang 
        local vect = ply:OBBMaxs()
        pos=pos + ply:GetUp() * 5
    end
    local ang = ply:GetAimVector():Angle()

    local data = EffectData()
    data:SetOrigin(pos)
    data:SetAngles(ang)
    util.Effect("railgun_shot",data)

	end

    if (!SERVER) then return end

    self.Owner:EmitSound("PropJeep.FireChargedCannon",SNDLVL_20dB,100)
   
    local pos = ply:GetShootPos()
    local ang = ply:GetAimVector()
    local tracedata = {}
    tracedata.start = pos
    tracedata.endpos = pos+(ang*10000)
    tracedata.filter = ply
    tracedata.mins = BoxSize*-1
    tracedata.maxs = BoxSize
    local trace = util.TraceHull(tracedata)
   
    local HitEnts = {}
    if trace.Entity then
        table.insert(HitEnts,trace.Entity)
    end
   
    for i=1,(MaxHits-1) do
        tracedata = {}
        tracedata.start = trace.HitPos
        tracedata.endpos = trace.HitPos+(ang*10000)
        tracedata.filter = {ply,unpack(HitEnts)}
        tracedata.mins = BoxSize*-1
        tracedata.maxs = BoxSize
        trace = util.TraceHull(tracedata)
        if trace.Entity then
            table.insert(HitEnts,trace.Entity)
        end
    end
   
    for k,v in ipairs(HitEnts) do
        if v:IsValid() and v:Health() > 0 then
            v:TakeDamage(math.random(25,35),self.Owner,self)
        end
    end
end

local function SupahFireScreenWhiteness()
    if LocalPlayer().BlindingLight then  
        local tab = {}
        tab[ "$pp_colour_addr" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addg" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addb" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_brightness" ] = 0
        tab[ "$pp_colour_contrast" ] = 1
        tab[ "$pp_colour_colour" ] = 1
        tab[ "$pp_colour_mulr" ] = 0
        tab[ "$pp_colour_mulg" ] = 0
        tab[ "$pp_colour_mulb" ] = 0

        DrawColorModify( tab )
        LocalPlayer().BlindingLight = math.Clamp(LocalPlayer().BlindingLight-0.05,0,1)
    end
end
hook.Add( "RenderScreenspaceEffects", "SupahFireScreenWhiteness", SupahFireScreenWhiteness )



hook.Add("DoPlayerDeath", "dontlockmerailgunpls", function(ply)
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_rapidrail" then
		ply:UnLock()
		ply:StopSound("WeaponDissolve.Charge")
		hook.Remove("Think", ply:Nick().."ScreenShake")
	end
end)

function SWEP:SecondaryAttack()
    self.Weapon:SetNextSecondaryFire(CurTime() + self.SecondaryFireRate)

    if SERVER then SendUserMessage(self.SecondaryHook,self.Owner) end
   
    if (!SERVER) then return end
    self.Owner:EmitSound("WeaponDissolve.Charge",SNDLVL_GUNFIRE,100)
    self.Owner:Lock()
    timer.Simple(3,function() if !IsValid(self) then return end if !IsValid(self.Owner) then return end self.Owner:UnLock() hook.Remove("Think",self.Owner:Nick().."ScreenShake") end)
    hook.Add("Think", self.Owner:Nick().."ScreenShake", function() 
    	if !IsValid(self) then return end 
    	if !IsValid(self.Owner) then return end 
    	self.Owner:ViewPunch(Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),math.Rand(-0.5,0.5))) 
    end)
   
    timer.Simple(1,function()
    		if !IsValid(self) then return end
            local MaxDist = 1500
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:StopSound("WeaponDissolve.Charge")
            self:EmitSound("explode_7",SNDLVL_GUNFIRE,100)
            local ply = self.Owner
           
            local tbl = ents.FindInCone(ply:EyePos(), ply:GetAimVector(), MaxDist, math.cos(math.rad( 70 ))) -- OH JESUS CHRIST WHY MUST THIS METHOD BE USED IT'S HORRIBLY OUTDATED AND I HAVE NO OTHER
           
            local data = EffectData()
            local wep = ply:GetViewModel()
            local pos = Vector()
            if wep and wep:IsValid() then
                    pos = wep:GetAttachment(1).Pos
                    ang = wep:GetAttachment(1).Ang 
                    local vect = ply:OBBMaxs()
                    pos=pos+Vector(0,0,vect.z-7)
            end
            local ang = ply:GetAimVector():Angle()
           
            local data = EffectData()
            data:SetOrigin(pos)
            data:SetAngles(ang)
            util.Effect("railgun_burst",data)
           
            for k,v in ipairs(tbl) do
                if v:IsValid() and v:IsPlayer() then --I'm a lazy mofo
                        v:SendLua("LocalPlayer().BlindingLight = 1 timer.Simple(2,function() LocalPlayer().BlindingLight = nil end)")
                elseif v:IsValid() and v:Health() > 0 then
                    local MaxDamage = 1000
                    local dist = self.Owner:GetShootPos():Distance(v:GetPos())
                    if dist < 500 then
                        v:TakeDamage(MaxDamage,self.Owner,self)
                    else
                        v:TakeDamage(MaxDamage*(1-(dist/MaxDist)),self.Owner,self)
                    end
                end
                local phys = v:GetPhysicsObject()
                if v and v:IsValid() and phys and phys:IsValid() then
                    phys:ApplyForceCenter((self.Owner:GetShootPos()-v:GetPos()):GetNormalized()*-100000)
                end
            end
    end)
end


function SWEP:ShouldDropOnDie()
        return false
end

local color_gray = Color(0,0,0,150)
local color_white = Color(250,250,250,255)
local color_green = Color(0,255,0,255)

function SWEP:DrawHUD()

        if (!CLIENT) then return end
       
        draw.RoundedBox(4,ScrW()-78,ScrH()-108,22,106,color_gray)
        draw.RoundedBox(4,ScrW()-50,ScrH()-108,22,106,color_gray)
       
        self.Bar2Per = 100-((math.Clamp(self.Bar2TS-CurTime(),0,self.SecondaryFireRate)/self.SecondaryFireRate)*100)
        self.Bar1Per = 100-((math.Clamp(self.Bar1TS-CurTime(),0,self.PrimaryFireRate)/self.PrimaryFireRate)*100)
       
        local pcol 
        if self.Bar1Per >= 100 then pcol = color_green else pcol = color_white end
        local scol
        if self.Bar2Per >= 100 then scol = color_green else scol = color_white end
        draw.RoundedBox(4,ScrW()-76,ScrH()-104+(100-math.Clamp(self.Bar1Per,8,100)),18,math.Clamp(self.Bar1Per,8,100),pcol)
        draw.RoundedBox(4,ScrW()-48,ScrH()-104+(100-math.Clamp(self.Bar2Per,8,100)),18,math.Clamp(self.Bar2Per,8,100),scol)

end

if CLIENT then
local EFFECT = {}
local Laser = Material("effects/energysplash")
local maxv = Vector(1,1,1)*17000
function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)
    self.Entity:SetRenderBounds( maxv*-1, maxv )
    local Lifetime = 2
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
   
    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.Pos+(self.Ang:Forward()*1500), 700*frac, 0.5, 1, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_burst",true)

local EFFECT = {}
local Laser = Material("effects/energysplash")

function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)

    self.Entity:SetRenderBounds( maxv*-1, maxv )

    local Lifetime = 1
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
        

    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.tr.HitPos, 40*frac, 0.5, 0.7, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_shot",true)

killicon.AddFont(ClassName or "railcanon", "HL2MPTypeDeath", "3", Color( 0, 20, 255, 255 ))
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_rapidrail.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author                     = "Levybreak"
SWEP.Contact            = "Facepunch"
SWEP.Purpose            = "Railgunz iz gunna burn a hola through ya!"
SWEP.Instructions       = "Primary fire for rapid laz0rs. Secondary for a massive burst!"

SWEP.PrintName                  = "Asteroid Assault Railgun"                     
SWEP.Slot                               = 4
SWEP.SlotPos                    = 4
SWEP.DrawAmmo                   = true
SWEP.DrawCrosshair              = true

SWEP.Weight                             = 15
SWEP.AutoSwitchTo               = true
SWEP.AutoSwitchFrom             = true

SWEP.ViewModel                  = "models/weapons/c_rpg.mdl"
SWEP.WorldModel                 = "models/Weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = 0
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo                       = "none"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo                     = "none"

SWEP.HoldType = "rpg"

SWEP.PrimaryFireRate = 0.5
SWEP.SecondaryFireRate = 45

SWEP.PrimaryHook = (ClassName or "railcanon").."PrimaryFire"
SWEP.SecondaryHook = (ClassName or "railcanon").."SecondaryFire"

function SWEP:Initialize()
	self:SetHoldType("rpg")
    if (SERVER) then
        self:SetWeaponHoldType( self.HoldType )
    else
        self.Bar1Per = 100
        self.Bar2Per = 100
        self.Bar2TS = 0
        self.Bar1TS = 0
        usermessage.Hook(self.PrimaryHook,function(um)
            if (self.Bar1TS or 0) <= CurTime() then
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + (self.PrimaryFireRate or 0.5)
            end
        end)
        usermessage.Hook(self.SecondaryHook,function(um)
            if self.Bar2TS <= CurTime() then
                self.Bar2Per = 0
                self.Bar2TS = CurTime() + self.SecondaryFireRate
                timer.Simple(1,function() LocalPlayer().BlindingLight = 1 end)
                timer.Simple(3,function() LocalPlayer().BlindingLight = nil end)
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + self.PrimaryFireRate
            end
        end)
    end
end
if CLIENT then surface.CreateFont("HL2WeaponSelectIcons", {font = "HalfLife2", size = ScreenScale(60), weight = 500, antialias = true, additive = true}) end
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
    
        draw.SimpleText( "i", "HL2WeaponSelectIcons", x + wide*0.5, y + tall*0.2, Color( 0, 10, 200, 255 ), TEXT_ALIGN_CENTER )
    
end

function SWEP:Reload()
       
end

function SWEP:Think()

end

local zerovec = Vector(0,0,0)
local BoxSize = Vector(20,20,20)
local MaxHits = 7

local RecoilAng = Angle(-4,0,0)
function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire(CurTime() + self.PrimaryFireRate)
    if SERVER then SendUserMessage(self.PrimaryHook,self.Owner) end
   
   
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:ViewPunch(RecoilAng)
   
    local ply = self.Owner

    if CLIENT and IsFirstTimePredicted() then
   
    local data = EffectData()
    local wep = ply:GetViewModel()
    local pos = Vector()
    if wep and wep:IsValid() and game.SinglePlayer() then
        pos = wep:GetAttachment(3).Pos
        ang = wep:GetAttachment(3).Ang 
        local vect = ply:OBBMaxs()
        pos=pos+Vector(0,0,vect.z-7)
    elseif wep and wep:IsValid() and !game.SinglePlayer() then
    	PrintTable(wep:GetAttachments())
        pos = wep:GetAttachment(2).Pos
        ang = wep:GetAttachment(2).Ang 
        local vect = ply:OBBMaxs()
        pos=pos + ply:GetUp() * 5
    end
    local ang = ply:GetAimVector():Angle()

    local data = EffectData()
    data:SetOrigin(pos)
    data:SetAngles(ang)
    util.Effect("railgun_shot",data)

	end

    if (!SERVER) then return end

    self.Owner:EmitSound("PropJeep.FireChargedCannon",SNDLVL_20dB,100)
   
    local pos = ply:GetShootPos()
    local ang = ply:GetAimVector()
    local tracedata = {}
    tracedata.start = pos
    tracedata.endpos = pos+(ang*10000)
    tracedata.filter = ply
    tracedata.mins = BoxSize*-1
    tracedata.maxs = BoxSize
    local trace = util.TraceHull(tracedata)
   
    local HitEnts = {}
    if trace.Entity then
        table.insert(HitEnts,trace.Entity)
    end
   
    for i=1,(MaxHits-1) do
        tracedata = {}
        tracedata.start = trace.HitPos
        tracedata.endpos = trace.HitPos+(ang*10000)
        tracedata.filter = {ply,unpack(HitEnts)}
        tracedata.mins = BoxSize*-1
        tracedata.maxs = BoxSize
        trace = util.TraceHull(tracedata)
        if trace.Entity then
            table.insert(HitEnts,trace.Entity)
        end
    end
   
    for k,v in ipairs(HitEnts) do
        if v:IsValid() and v:Health() > 0 then
            v:TakeDamage(math.random(25,35),self.Owner,self)
        end
    end
end

local function SupahFireScreenWhiteness()
    if LocalPlayer().BlindingLight then  
        local tab = {}
        tab[ "$pp_colour_addr" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addg" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addb" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_brightness" ] = 0
        tab[ "$pp_colour_contrast" ] = 1
        tab[ "$pp_colour_colour" ] = 1
        tab[ "$pp_colour_mulr" ] = 0
        tab[ "$pp_colour_mulg" ] = 0
        tab[ "$pp_colour_mulb" ] = 0

        DrawColorModify( tab )
        LocalPlayer().BlindingLight = math.Clamp(LocalPlayer().BlindingLight-0.05,0,1)
    end
end
hook.Add( "RenderScreenspaceEffects", "SupahFireScreenWhiteness", SupahFireScreenWhiteness )



hook.Add("DoPlayerDeath", "dontlockmerailgunpls", function(ply)
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_rapidrail" then
		ply:UnLock()
		ply:StopSound("WeaponDissolve.Charge")
		hook.Remove("Think", ply:Nick().."ScreenShake")
	end
end)

function SWEP:SecondaryAttack()
    self.Weapon:SetNextSecondaryFire(CurTime() + self.SecondaryFireRate)

    if SERVER then SendUserMessage(self.SecondaryHook,self.Owner) end
   
    if (!SERVER) then return end
    self.Owner:EmitSound("WeaponDissolve.Charge",SNDLVL_GUNFIRE,100)
    self.Owner:Lock()
    timer.Simple(3,function() if !IsValid(self) then return end if !IsValid(self.Owner) then return end self.Owner:UnLock() hook.Remove("Think",self.Owner:Nick().."ScreenShake") end)
    hook.Add("Think", self.Owner:Nick().."ScreenShake", function() 
    	if !IsValid(self) then return end 
    	if !IsValid(self.Owner) then return end 
    	self.Owner:ViewPunch(Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),math.Rand(-0.5,0.5))) 
    end)
   
    timer.Simple(1,function()
    		if !IsValid(self) then return end
            local MaxDist = 1500
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:StopSound("WeaponDissolve.Charge")
            self:EmitSound("explode_7",SNDLVL_GUNFIRE,100)
            local ply = self.Owner
           
            local tbl = ents.FindInCone(ply:EyePos(), ply:GetAimVector(), MaxDist, math.cos(math.rad( 70 ))) -- OH JESUS CHRIST WHY MUST THIS METHOD BE USED IT'S HORRIBLY OUTDATED AND I HAVE NO OTHER
           
            local data = EffectData()
            local wep = ply:GetViewModel()
            local pos = Vector()
            if wep and wep:IsValid() then
                    pos = wep:GetAttachment(1).Pos
                    ang = wep:GetAttachment(1).Ang 
                    local vect = ply:OBBMaxs()
                    pos=pos+Vector(0,0,vect.z-7)
            end
            local ang = ply:GetAimVector():Angle()
           
            local data = EffectData()
            data:SetOrigin(pos)
            data:SetAngles(ang)
            util.Effect("railgun_burst",data)
           
            for k,v in ipairs(tbl) do
                if v:IsValid() and v:IsPlayer() then --I'm a lazy mofo
                        v:SendLua("LocalPlayer().BlindingLight = 1 timer.Simple(2,function() LocalPlayer().BlindingLight = nil end)")
                elseif v:IsValid() and v:Health() > 0 then
                    local MaxDamage = 1000
                    local dist = self.Owner:GetShootPos():Distance(v:GetPos())
                    if dist < 500 then
                        v:TakeDamage(MaxDamage,self.Owner,self)
                    else
                        v:TakeDamage(MaxDamage*(1-(dist/MaxDist)),self.Owner,self)
                    end
                end
                local phys = v:GetPhysicsObject()
                if v and v:IsValid() and phys and phys:IsValid() then
                    phys:ApplyForceCenter((self.Owner:GetShootPos()-v:GetPos()):GetNormalized()*-100000)
                end
            end
    end)
end


function SWEP:ShouldDropOnDie()
        return false
end

local color_gray = Color(0,0,0,150)
local color_white = Color(250,250,250,255)
local color_green = Color(0,255,0,255)

function SWEP:DrawHUD()

        if (!CLIENT) then return end
       
        draw.RoundedBox(4,ScrW()-78,ScrH()-108,22,106,color_gray)
        draw.RoundedBox(4,ScrW()-50,ScrH()-108,22,106,color_gray)
       
        self.Bar2Per = 100-((math.Clamp(self.Bar2TS-CurTime(),0,self.SecondaryFireRate)/self.SecondaryFireRate)*100)
        self.Bar1Per = 100-((math.Clamp(self.Bar1TS-CurTime(),0,self.PrimaryFireRate)/self.PrimaryFireRate)*100)
       
        local pcol 
        if self.Bar1Per >= 100 then pcol = color_green else pcol = color_white end
        local scol
        if self.Bar2Per >= 100 then scol = color_green else scol = color_white end
        draw.RoundedBox(4,ScrW()-76,ScrH()-104+(100-math.Clamp(self.Bar1Per,8,100)),18,math.Clamp(self.Bar1Per,8,100),pcol)
        draw.RoundedBox(4,ScrW()-48,ScrH()-104+(100-math.Clamp(self.Bar2Per,8,100)),18,math.Clamp(self.Bar2Per,8,100),scol)

end

if CLIENT then
local EFFECT = {}
local Laser = Material("effects/energysplash")
local maxv = Vector(1,1,1)*17000
function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)
    self.Entity:SetRenderBounds( maxv*-1, maxv )
    local Lifetime = 2
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
   
    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.Pos+(self.Ang:Forward()*1500), 700*frac, 0.5, 1, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_burst",true)

local EFFECT = {}
local Laser = Material("effects/energysplash")

function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)

    self.Entity:SetRenderBounds( maxv*-1, maxv )

    local Lifetime = 1
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
        

    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.tr.HitPos, 40*frac, 0.5, 0.7, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_shot",true)

killicon.AddFont(ClassName or "railcanon", "HL2MPTypeDeath", "3", Color( 0, 20, 255, 255 ))
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_rapidrail.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Toybox Classics"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false

SWEP.Author                     = "Levybreak"
SWEP.Contact            = "Facepunch"
SWEP.Purpose            = "Railgunz iz gunna burn a hola through ya!"
SWEP.Instructions       = "Primary fire for rapid laz0rs. Secondary for a massive burst!"

SWEP.PrintName                  = "Asteroid Assault Railgun"                     
SWEP.Slot                               = 4
SWEP.SlotPos                    = 4
SWEP.DrawAmmo                   = true
SWEP.DrawCrosshair              = true

SWEP.Weight                             = 15
SWEP.AutoSwitchTo               = true
SWEP.AutoSwitchFrom             = true

SWEP.ViewModel                  = "models/weapons/c_rpg.mdl"
SWEP.WorldModel                 = "models/Weapons/w_rocket_launcher.mdl"
SWEP.UseHands = true

SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = 0
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo                       = "none"

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo                     = "none"

SWEP.HoldType = "rpg"

SWEP.PrimaryFireRate = 0.5
SWEP.SecondaryFireRate = 45

SWEP.PrimaryHook = (ClassName or "railcanon").."PrimaryFire"
SWEP.SecondaryHook = (ClassName or "railcanon").."SecondaryFire"

function SWEP:Initialize()
	self:SetHoldType("rpg")
    if (SERVER) then
        self:SetWeaponHoldType( self.HoldType )
    else
        self.Bar1Per = 100
        self.Bar2Per = 100
        self.Bar2TS = 0
        self.Bar1TS = 0
        usermessage.Hook(self.PrimaryHook,function(um)
            if (self.Bar1TS or 0) <= CurTime() then
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + (self.PrimaryFireRate or 0.5)
            end
        end)
        usermessage.Hook(self.SecondaryHook,function(um)
            if self.Bar2TS <= CurTime() then
                self.Bar2Per = 0
                self.Bar2TS = CurTime() + self.SecondaryFireRate
                timer.Simple(1,function() LocalPlayer().BlindingLight = 1 end)
                timer.Simple(3,function() LocalPlayer().BlindingLight = nil end)
                self.Bar1Per = 0
                self.Bar1TS = CurTime() + self.PrimaryFireRate
            end
        end)
    end
end
if CLIENT then surface.CreateFont("HL2WeaponSelectIcons", {font = "HalfLife2", size = ScreenScale(60), weight = 500, antialias = true, additive = true}) end
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
    
        draw.SimpleText( "i", "HL2WeaponSelectIcons", x + wide*0.5, y + tall*0.2, Color( 0, 10, 200, 255 ), TEXT_ALIGN_CENTER )
    
end

function SWEP:Reload()
       
end

function SWEP:Think()

end

local zerovec = Vector(0,0,0)
local BoxSize = Vector(20,20,20)
local MaxHits = 7

local RecoilAng = Angle(-4,0,0)
function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire(CurTime() + self.PrimaryFireRate)
    if SERVER then SendUserMessage(self.PrimaryHook,self.Owner) end
   
   
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:ViewPunch(RecoilAng)
   
    local ply = self.Owner

    if CLIENT and IsFirstTimePredicted() then
   
    local data = EffectData()
    local wep = ply:GetViewModel()
    local pos = Vector()
    if wep and wep:IsValid() and game.SinglePlayer() then
        pos = wep:GetAttachment(3).Pos
        ang = wep:GetAttachment(3).Ang 
        local vect = ply:OBBMaxs()
        pos=pos+Vector(0,0,vect.z-7)
    elseif wep and wep:IsValid() and !game.SinglePlayer() then
    	PrintTable(wep:GetAttachments())
        pos = wep:GetAttachment(2).Pos
        ang = wep:GetAttachment(2).Ang 
        local vect = ply:OBBMaxs()
        pos=pos + ply:GetUp() * 5
    end
    local ang = ply:GetAimVector():Angle()

    local data = EffectData()
    data:SetOrigin(pos)
    data:SetAngles(ang)
    util.Effect("railgun_shot",data)

	end

    if (!SERVER) then return end

    self.Owner:EmitSound("PropJeep.FireChargedCannon",SNDLVL_20dB,100)
   
    local pos = ply:GetShootPos()
    local ang = ply:GetAimVector()
    local tracedata = {}
    tracedata.start = pos
    tracedata.endpos = pos+(ang*10000)
    tracedata.filter = ply
    tracedata.mins = BoxSize*-1
    tracedata.maxs = BoxSize
    local trace = util.TraceHull(tracedata)
   
    local HitEnts = {}
    if trace.Entity then
        table.insert(HitEnts,trace.Entity)
    end
   
    for i=1,(MaxHits-1) do
        tracedata = {}
        tracedata.start = trace.HitPos
        tracedata.endpos = trace.HitPos+(ang*10000)
        tracedata.filter = {ply,unpack(HitEnts)}
        tracedata.mins = BoxSize*-1
        tracedata.maxs = BoxSize
        trace = util.TraceHull(tracedata)
        if trace.Entity then
            table.insert(HitEnts,trace.Entity)
        end
    end
   
    for k,v in ipairs(HitEnts) do
        if v:IsValid() and v:Health() > 0 then
            v:TakeDamage(math.random(25,35),self.Owner,self)
        end
    end
end

local function SupahFireScreenWhiteness()
    if LocalPlayer().BlindingLight then  
        local tab = {}
        tab[ "$pp_colour_addr" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addg" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_addb" ] = LocalPlayer().BlindingLight
        tab[ "$pp_colour_brightness" ] = 0
        tab[ "$pp_colour_contrast" ] = 1
        tab[ "$pp_colour_colour" ] = 1
        tab[ "$pp_colour_mulr" ] = 0
        tab[ "$pp_colour_mulg" ] = 0
        tab[ "$pp_colour_mulb" ] = 0

        DrawColorModify( tab )
        LocalPlayer().BlindingLight = math.Clamp(LocalPlayer().BlindingLight-0.05,0,1)
    end
end
hook.Add( "RenderScreenspaceEffects", "SupahFireScreenWhiteness", SupahFireScreenWhiteness )



hook.Add("DoPlayerDeath", "dontlockmerailgunpls", function(ply)
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_rapidrail" then
		ply:UnLock()
		ply:StopSound("WeaponDissolve.Charge")
		hook.Remove("Think", ply:Nick().."ScreenShake")
	end
end)

function SWEP:SecondaryAttack()
    self.Weapon:SetNextSecondaryFire(CurTime() + self.SecondaryFireRate)

    if SERVER then SendUserMessage(self.SecondaryHook,self.Owner) end
   
    if (!SERVER) then return end
    self.Owner:EmitSound("WeaponDissolve.Charge",SNDLVL_GUNFIRE,100)
    self.Owner:Lock()
    timer.Simple(3,function() if !IsValid(self) then return end if !IsValid(self.Owner) then return end self.Owner:UnLock() hook.Remove("Think",self.Owner:Nick().."ScreenShake") end)
    hook.Add("Think", self.Owner:Nick().."ScreenShake", function() 
    	if !IsValid(self) then return end 
    	if !IsValid(self.Owner) then return end 
    	self.Owner:ViewPunch(Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),math.Rand(-0.5,0.5))) 
    end)
   
    timer.Simple(1,function()
    		if !IsValid(self) then return end
            local MaxDist = 1500
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:StopSound("WeaponDissolve.Charge")
            self:EmitSound("explode_7",SNDLVL_GUNFIRE,100)
            local ply = self.Owner
           
            local tbl = ents.FindInCone(ply:EyePos(), ply:GetAimVector(), MaxDist, math.cos(math.rad( 70 ))) -- OH JESUS CHRIST WHY MUST THIS METHOD BE USED IT'S HORRIBLY OUTDATED AND I HAVE NO OTHER
           
            local data = EffectData()
            local wep = ply:GetViewModel()
            local pos = Vector()
            if wep and wep:IsValid() then
                    pos = wep:GetAttachment(1).Pos
                    ang = wep:GetAttachment(1).Ang 
                    local vect = ply:OBBMaxs()
                    pos=pos+Vector(0,0,vect.z-7)
            end
            local ang = ply:GetAimVector():Angle()
           
            local data = EffectData()
            data:SetOrigin(pos)
            data:SetAngles(ang)
            util.Effect("railgun_burst",data)
           
            for k,v in ipairs(tbl) do
                if v:IsValid() and v:IsPlayer() then --I'm a lazy mofo
                        v:SendLua("LocalPlayer().BlindingLight = 1 timer.Simple(2,function() LocalPlayer().BlindingLight = nil end)")
                elseif v:IsValid() and v:Health() > 0 then
                    local MaxDamage = 1000
                    local dist = self.Owner:GetShootPos():Distance(v:GetPos())
                    if dist < 500 then
                        v:TakeDamage(MaxDamage,self.Owner,self)
                    else
                        v:TakeDamage(MaxDamage*(1-(dist/MaxDist)),self.Owner,self)
                    end
                end
                local phys = v:GetPhysicsObject()
                if v and v:IsValid() and phys and phys:IsValid() then
                    phys:ApplyForceCenter((self.Owner:GetShootPos()-v:GetPos()):GetNormalized()*-100000)
                end
            end
    end)
end


function SWEP:ShouldDropOnDie()
        return false
end

local color_gray = Color(0,0,0,150)
local color_white = Color(250,250,250,255)
local color_green = Color(0,255,0,255)

function SWEP:DrawHUD()

        if (!CLIENT) then return end
       
        draw.RoundedBox(4,ScrW()-78,ScrH()-108,22,106,color_gray)
        draw.RoundedBox(4,ScrW()-50,ScrH()-108,22,106,color_gray)
       
        self.Bar2Per = 100-((math.Clamp(self.Bar2TS-CurTime(),0,self.SecondaryFireRate)/self.SecondaryFireRate)*100)
        self.Bar1Per = 100-((math.Clamp(self.Bar1TS-CurTime(),0,self.PrimaryFireRate)/self.PrimaryFireRate)*100)
       
        local pcol 
        if self.Bar1Per >= 100 then pcol = color_green else pcol = color_white end
        local scol
        if self.Bar2Per >= 100 then scol = color_green else scol = color_white end
        draw.RoundedBox(4,ScrW()-76,ScrH()-104+(100-math.Clamp(self.Bar1Per,8,100)),18,math.Clamp(self.Bar1Per,8,100),pcol)
        draw.RoundedBox(4,ScrW()-48,ScrH()-104+(100-math.Clamp(self.Bar2Per,8,100)),18,math.Clamp(self.Bar2Per,8,100),scol)

end

if CLIENT then
local EFFECT = {}
local Laser = Material("effects/energysplash")
local maxv = Vector(1,1,1)*17000
function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)
    self.Entity:SetRenderBounds( maxv*-1, maxv )
    local Lifetime = 2
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
   
    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.Pos+(self.Ang:Forward()*1500), 700*frac, 0.5, 1, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_burst",true)

local EFFECT = {}
local Laser = Material("effects/energysplash")

function EFFECT:Init( data )
        

    self.Pos = data:GetOrigin()
    self.Ang = data:GetAngles()
    
    local trace = {}
    trace.start = self.Pos
    trace.endpos = self.Pos+(self.Ang:Forward()*10000)
    trace.mask = MASK_SOLID_BRUSHONLY
    
    self.tr = util.TraceLine(trace)

    self.Entity:SetRenderBounds( maxv*-1, maxv )

    local Lifetime = 1
    
    self.EndTime = CurTime() + Lifetime
    
    self.Entity:SetPos(LocalPlayer():GetShootPos())

end


/*---------------------------------------------------------
   THINK
   Returning false makes the entity die
---------------------------------------------------------*/
function EFFECT:Think( )
        

    if CurTime() >= self.EndTime then return false end
    return true
        
end


/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()

    local frac = math.Clamp((self.EndTime-CurTime())/2,0,1)
    render.SetMaterial( Laser )
    
    render.DrawBeam( self.Pos, self.tr.HitPos, 40*frac, 0.5, 0.7, Color(255,255,255,(255*frac)) )

end 
effects.Register(EFFECT,"railgun_shot",true)

killicon.AddFont(ClassName or "railcanon", "HL2MPTypeDeath", "3", Color( 0, 20, 255, 255 ))
end

