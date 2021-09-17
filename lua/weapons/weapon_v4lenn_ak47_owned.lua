-- "lua\\weapons\\weapon_v4lenn_ak47_owned.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = false;
   SWEP.AutoSwitchFrom = false;

end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "Some Weapon";
   SWEP.Slot = 0;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= true
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.IconLetter                = "b"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands 						= true

SWEP.HoldType                = "smg"
SWEP.ViewModelFlip            = false 

SWEP.Primary.ClipSize        = 99999
SWEP.Primary.DefaultClip    = 99999
SWEP.Primary.Delay            = 0.05
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "ar2"

SWEP.Primary.Sound = Sound ("Weapon_AK47.Single")
SWEP.Primary.Recoil            = 2
SWEP.Primary.Damage            = 999999999999999
SWEP.Primary.NumShots        = 2
SWEP.Primary.Cone            = 0
SWEP.Primary.Spread = 0.1

SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo            = "none"

function SWEP:Initialize()

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
	

    end
	self:SetHoldType(self.HoldType)
	
end

function SWEP:SecondaryAttack()
if self.On != true then
self.On = true
else
self.On = false
end
end
SWEP.Aimbot = {}
SWEP.Aimbot.Target = nil
SWEP.Aimbot.DeathSequences = {
    ["models/barnacle.mdl"]            = {4,15},
    ["models/antlion_guard.mdl"]    = {44},
    ["models/hunter.mdl"]            = {124,125,126,127,128},
}

function SWEP:GetHeadPos(ent)
    local model = ent:GetModel() or ""
    if model:find("crow") or model:find("seagull") or model:find("pigeon") then
        return ent:LocalToWorld(ent:OBBCenter() + Vector(0,0,-5))
    elseif ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        return ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    else
        return ent:LocalToWorld(ent:OBBCenter())
    end
end

function SWEP:Visible(ent)
    local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = self:GetHeadPos(ent)
    trace.filter = {self.Owner,ent}
    trace.mask = MASK_SHOT
    local tr = util.TraceLine(trace)
    return tr.Fraction >= 0.99 and true or false
end

function SWEP:CheckTarget(ent)
    if ent:IsPlayer() then
        if !ent:IsValid() then return false end
        if ent:Health() < 1 then return false end
        if ent == self.Owner then return false end    
        return true
    end
    if ent:IsNPC() then
        if ent:GetMoveType() == 0 then return false end
        if table.HasValue(self.Aimbot.DeathSequences[string.lower(ent:GetModel() or "")] or {},ent:GetSequence()) then return false end
        return true
    end
    return false
end

function SWEP:GetTargets()
    local tbl = {}
    for k,ent in pairs(ents.GetAll()) do
        if self:CheckTarget(ent) == true then
            table.insert(tbl,ent)
        end
    end
    return tbl
end

function SWEP:GetClosestTarget()
    local pos = self.Owner:GetPos()
    local ang = self.Owner:GetAimVector()
    local closest = {0,0}
    for k,ent in pairs(self:GetTargets()) do
        local diff = (ent:GetPos()-pos)
		diff:Normalize()
        diff = diff - ang
        diff = diff:Length()
        diff = math.abs(diff)
        if (diff < closest[2]) or (closest[1] == 0) then
            closest = {ent,diff}
        end
    end
    return closest[1]
end

function SWEP:Think()
    local ent = self:GetClosestTarget()
    self.Aimbot.Target = ent ~= 0 and ent or nil
	


hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
if self.On == true then
        return true
    end
end)
end


function SWEP:OnRemove()
self.On = false
timer.Remove("aimbotspin")

end
function SWEP:Holster()
self.On = false
timer.Remove("aimbotspin")
return true
end



function SWEP:PrimaryAttack()
 
    if self.Aimbot.Target ~= nil then
   -- self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    
   local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetPos()
    bullet.Dir = ( self.Aimbot.Target:LocalToWorld( self.Aimbot.Target:OBBCenter() ) - self.Owner:GetPos()  )
    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    end
    
   if (!self:CanPrimaryAttack()) then return end

  
     self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    self.Weapon:EmitSound(self.Primary.Sound)

    self:TakePrimaryAmmo(1) 
end


function SWEP:ShouldDropOnDie()
    return false
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	
    draw.SimpleText("AIMBOT ON","Arial",x + wide/2,y + tall*0.35,Color(255,0,0,255),TEXT_ALIGN_CENTER)
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap)
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

function SWEP:GetCoordiantes(ent)
    local min,max = ent:OBBMins(),ent:OBBMaxs()
    local corners = {
        Vector(min.x,min.y,min.z),
        Vector(min.x,min.y,max.z),
        Vector(min.x,max.y,min.z),
        Vector(min.x,max.y,max.z),
        Vector(max.x,min.y,min.z),
        Vector(max.x,min.y,max.z),
        Vector(max.x,max.y,min.z),
        Vector(max.x,max.y,max.z)
    }

    local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
    for _,corner in pairs(corners) do
        local screen = ent:LocalToWorld(corner):ToScreen()
        minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
        maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
    end
    return minx,miny,maxx,maxy
end



-- "lua\\weapons\\weapon_v4lenn_ak47_owned.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = false;
   SWEP.AutoSwitchFrom = false;

end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "Some Weapon";
   SWEP.Slot = 0;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= true
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.IconLetter                = "b"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands 						= true

SWEP.HoldType                = "smg"
SWEP.ViewModelFlip            = false 

SWEP.Primary.ClipSize        = 99999
SWEP.Primary.DefaultClip    = 99999
SWEP.Primary.Delay            = 0.05
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "ar2"

SWEP.Primary.Sound = Sound ("Weapon_AK47.Single")
SWEP.Primary.Recoil            = 2
SWEP.Primary.Damage            = 999999999999999
SWEP.Primary.NumShots        = 2
SWEP.Primary.Cone            = 0
SWEP.Primary.Spread = 0.1

SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo            = "none"

function SWEP:Initialize()

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
	

    end
	self:SetHoldType(self.HoldType)
	
end

function SWEP:SecondaryAttack()
if self.On != true then
self.On = true
else
self.On = false
end
end
SWEP.Aimbot = {}
SWEP.Aimbot.Target = nil
SWEP.Aimbot.DeathSequences = {
    ["models/barnacle.mdl"]            = {4,15},
    ["models/antlion_guard.mdl"]    = {44},
    ["models/hunter.mdl"]            = {124,125,126,127,128},
}

function SWEP:GetHeadPos(ent)
    local model = ent:GetModel() or ""
    if model:find("crow") or model:find("seagull") or model:find("pigeon") then
        return ent:LocalToWorld(ent:OBBCenter() + Vector(0,0,-5))
    elseif ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        return ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    else
        return ent:LocalToWorld(ent:OBBCenter())
    end
end

function SWEP:Visible(ent)
    local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = self:GetHeadPos(ent)
    trace.filter = {self.Owner,ent}
    trace.mask = MASK_SHOT
    local tr = util.TraceLine(trace)
    return tr.Fraction >= 0.99 and true or false
end

function SWEP:CheckTarget(ent)
    if ent:IsPlayer() then
        if !ent:IsValid() then return false end
        if ent:Health() < 1 then return false end
        if ent == self.Owner then return false end    
        return true
    end
    if ent:IsNPC() then
        if ent:GetMoveType() == 0 then return false end
        if table.HasValue(self.Aimbot.DeathSequences[string.lower(ent:GetModel() or "")] or {},ent:GetSequence()) then return false end
        return true
    end
    return false
end

function SWEP:GetTargets()
    local tbl = {}
    for k,ent in pairs(ents.GetAll()) do
        if self:CheckTarget(ent) == true then
            table.insert(tbl,ent)
        end
    end
    return tbl
end

function SWEP:GetClosestTarget()
    local pos = self.Owner:GetPos()
    local ang = self.Owner:GetAimVector()
    local closest = {0,0}
    for k,ent in pairs(self:GetTargets()) do
        local diff = (ent:GetPos()-pos)
		diff:Normalize()
        diff = diff - ang
        diff = diff:Length()
        diff = math.abs(diff)
        if (diff < closest[2]) or (closest[1] == 0) then
            closest = {ent,diff}
        end
    end
    return closest[1]
end

function SWEP:Think()
    local ent = self:GetClosestTarget()
    self.Aimbot.Target = ent ~= 0 and ent or nil
	


hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
if self.On == true then
        return true
    end
end)
end


function SWEP:OnRemove()
self.On = false
timer.Remove("aimbotspin")

end
function SWEP:Holster()
self.On = false
timer.Remove("aimbotspin")
return true
end



function SWEP:PrimaryAttack()
 
    if self.Aimbot.Target ~= nil then
   -- self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    
   local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetPos()
    bullet.Dir = ( self.Aimbot.Target:LocalToWorld( self.Aimbot.Target:OBBCenter() ) - self.Owner:GetPos()  )
    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    end
    
   if (!self:CanPrimaryAttack()) then return end

  
     self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    self.Weapon:EmitSound(self.Primary.Sound)

    self:TakePrimaryAmmo(1) 
end


function SWEP:ShouldDropOnDie()
    return false
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	
    draw.SimpleText("AIMBOT ON","Arial",x + wide/2,y + tall*0.35,Color(255,0,0,255),TEXT_ALIGN_CENTER)
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap)
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

function SWEP:GetCoordiantes(ent)
    local min,max = ent:OBBMins(),ent:OBBMaxs()
    local corners = {
        Vector(min.x,min.y,min.z),
        Vector(min.x,min.y,max.z),
        Vector(min.x,max.y,min.z),
        Vector(min.x,max.y,max.z),
        Vector(max.x,min.y,min.z),
        Vector(max.x,min.y,max.z),
        Vector(max.x,max.y,min.z),
        Vector(max.x,max.y,max.z)
    }

    local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
    for _,corner in pairs(corners) do
        local screen = ent:LocalToWorld(corner):ToScreen()
        minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
        maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
    end
    return minx,miny,maxx,maxy
end



-- "lua\\weapons\\weapon_v4lenn_ak47_owned.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = false;
   SWEP.AutoSwitchFrom = false;

end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "Some Weapon";
   SWEP.Slot = 0;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= true
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.IconLetter                = "b"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands 						= true

SWEP.HoldType                = "smg"
SWEP.ViewModelFlip            = false 

SWEP.Primary.ClipSize        = 99999
SWEP.Primary.DefaultClip    = 99999
SWEP.Primary.Delay            = 0.05
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "ar2"

SWEP.Primary.Sound = Sound ("Weapon_AK47.Single")
SWEP.Primary.Recoil            = 2
SWEP.Primary.Damage            = 999999999999999
SWEP.Primary.NumShots        = 2
SWEP.Primary.Cone            = 0
SWEP.Primary.Spread = 0.1

SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo            = "none"

function SWEP:Initialize()

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
	

    end
	self:SetHoldType(self.HoldType)
	
end

function SWEP:SecondaryAttack()
if self.On != true then
self.On = true
else
self.On = false
end
end
SWEP.Aimbot = {}
SWEP.Aimbot.Target = nil
SWEP.Aimbot.DeathSequences = {
    ["models/barnacle.mdl"]            = {4,15},
    ["models/antlion_guard.mdl"]    = {44},
    ["models/hunter.mdl"]            = {124,125,126,127,128},
}

function SWEP:GetHeadPos(ent)
    local model = ent:GetModel() or ""
    if model:find("crow") or model:find("seagull") or model:find("pigeon") then
        return ent:LocalToWorld(ent:OBBCenter() + Vector(0,0,-5))
    elseif ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        return ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    else
        return ent:LocalToWorld(ent:OBBCenter())
    end
end

function SWEP:Visible(ent)
    local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = self:GetHeadPos(ent)
    trace.filter = {self.Owner,ent}
    trace.mask = MASK_SHOT
    local tr = util.TraceLine(trace)
    return tr.Fraction >= 0.99 and true or false
end

function SWEP:CheckTarget(ent)
    if ent:IsPlayer() then
        if !ent:IsValid() then return false end
        if ent:Health() < 1 then return false end
        if ent == self.Owner then return false end    
        return true
    end
    if ent:IsNPC() then
        if ent:GetMoveType() == 0 then return false end
        if table.HasValue(self.Aimbot.DeathSequences[string.lower(ent:GetModel() or "")] or {},ent:GetSequence()) then return false end
        return true
    end
    return false
end

function SWEP:GetTargets()
    local tbl = {}
    for k,ent in pairs(ents.GetAll()) do
        if self:CheckTarget(ent) == true then
            table.insert(tbl,ent)
        end
    end
    return tbl
end

function SWEP:GetClosestTarget()
    local pos = self.Owner:GetPos()
    local ang = self.Owner:GetAimVector()
    local closest = {0,0}
    for k,ent in pairs(self:GetTargets()) do
        local diff = (ent:GetPos()-pos)
		diff:Normalize()
        diff = diff - ang
        diff = diff:Length()
        diff = math.abs(diff)
        if (diff < closest[2]) or (closest[1] == 0) then
            closest = {ent,diff}
        end
    end
    return closest[1]
end

function SWEP:Think()
    local ent = self:GetClosestTarget()
    self.Aimbot.Target = ent ~= 0 and ent or nil
	


hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
if self.On == true then
        return true
    end
end)
end


function SWEP:OnRemove()
self.On = false
timer.Remove("aimbotspin")

end
function SWEP:Holster()
self.On = false
timer.Remove("aimbotspin")
return true
end



function SWEP:PrimaryAttack()
 
    if self.Aimbot.Target ~= nil then
   -- self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    
   local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetPos()
    bullet.Dir = ( self.Aimbot.Target:LocalToWorld( self.Aimbot.Target:OBBCenter() ) - self.Owner:GetPos()  )
    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    end
    
   if (!self:CanPrimaryAttack()) then return end

  
     self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    self.Weapon:EmitSound(self.Primary.Sound)

    self:TakePrimaryAmmo(1) 
end


function SWEP:ShouldDropOnDie()
    return false
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	
    draw.SimpleText("AIMBOT ON","Arial",x + wide/2,y + tall*0.35,Color(255,0,0,255),TEXT_ALIGN_CENTER)
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap)
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

function SWEP:GetCoordiantes(ent)
    local min,max = ent:OBBMins(),ent:OBBMaxs()
    local corners = {
        Vector(min.x,min.y,min.z),
        Vector(min.x,min.y,max.z),
        Vector(min.x,max.y,min.z),
        Vector(min.x,max.y,max.z),
        Vector(max.x,min.y,min.z),
        Vector(max.x,min.y,max.z),
        Vector(max.x,max.y,min.z),
        Vector(max.x,max.y,max.z)
    }

    local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
    for _,corner in pairs(corners) do
        local screen = ent:LocalToWorld(corner):ToScreen()
        minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
        maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
    end
    return minx,miny,maxx,maxy
end



-- "lua\\weapons\\weapon_v4lenn_ak47_owned.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = false;
   SWEP.AutoSwitchFrom = false;

end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "Some Weapon";
   SWEP.Slot = 0;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= true
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.IconLetter                = "b"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands 						= true

SWEP.HoldType                = "smg"
SWEP.ViewModelFlip            = false 

SWEP.Primary.ClipSize        = 99999
SWEP.Primary.DefaultClip    = 99999
SWEP.Primary.Delay            = 0.05
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "ar2"

SWEP.Primary.Sound = Sound ("Weapon_AK47.Single")
SWEP.Primary.Recoil            = 2
SWEP.Primary.Damage            = 999999999999999
SWEP.Primary.NumShots        = 2
SWEP.Primary.Cone            = 0
SWEP.Primary.Spread = 0.1

SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo            = "none"

function SWEP:Initialize()

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
	

    end
	self:SetHoldType(self.HoldType)
	
end

function SWEP:SecondaryAttack()
if self.On != true then
self.On = true
else
self.On = false
end
end
SWEP.Aimbot = {}
SWEP.Aimbot.Target = nil
SWEP.Aimbot.DeathSequences = {
    ["models/barnacle.mdl"]            = {4,15},
    ["models/antlion_guard.mdl"]    = {44},
    ["models/hunter.mdl"]            = {124,125,126,127,128},
}

function SWEP:GetHeadPos(ent)
    local model = ent:GetModel() or ""
    if model:find("crow") or model:find("seagull") or model:find("pigeon") then
        return ent:LocalToWorld(ent:OBBCenter() + Vector(0,0,-5))
    elseif ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        return ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    else
        return ent:LocalToWorld(ent:OBBCenter())
    end
end

function SWEP:Visible(ent)
    local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = self:GetHeadPos(ent)
    trace.filter = {self.Owner,ent}
    trace.mask = MASK_SHOT
    local tr = util.TraceLine(trace)
    return tr.Fraction >= 0.99 and true or false
end

function SWEP:CheckTarget(ent)
    if ent:IsPlayer() then
        if !ent:IsValid() then return false end
        if ent:Health() < 1 then return false end
        if ent == self.Owner then return false end    
        return true
    end
    if ent:IsNPC() then
        if ent:GetMoveType() == 0 then return false end
        if table.HasValue(self.Aimbot.DeathSequences[string.lower(ent:GetModel() or "")] or {},ent:GetSequence()) then return false end
        return true
    end
    return false
end

function SWEP:GetTargets()
    local tbl = {}
    for k,ent in pairs(ents.GetAll()) do
        if self:CheckTarget(ent) == true then
            table.insert(tbl,ent)
        end
    end
    return tbl
end

function SWEP:GetClosestTarget()
    local pos = self.Owner:GetPos()
    local ang = self.Owner:GetAimVector()
    local closest = {0,0}
    for k,ent in pairs(self:GetTargets()) do
        local diff = (ent:GetPos()-pos)
		diff:Normalize()
        diff = diff - ang
        diff = diff:Length()
        diff = math.abs(diff)
        if (diff < closest[2]) or (closest[1] == 0) then
            closest = {ent,diff}
        end
    end
    return closest[1]
end

function SWEP:Think()
    local ent = self:GetClosestTarget()
    self.Aimbot.Target = ent ~= 0 and ent or nil
	


hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
if self.On == true then
        return true
    end
end)
end


function SWEP:OnRemove()
self.On = false
timer.Remove("aimbotspin")

end
function SWEP:Holster()
self.On = false
timer.Remove("aimbotspin")
return true
end



function SWEP:PrimaryAttack()
 
    if self.Aimbot.Target ~= nil then
   -- self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    
   local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetPos()
    bullet.Dir = ( self.Aimbot.Target:LocalToWorld( self.Aimbot.Target:OBBCenter() ) - self.Owner:GetPos()  )
    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    end
    
   if (!self:CanPrimaryAttack()) then return end

  
     self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    self.Weapon:EmitSound(self.Primary.Sound)

    self:TakePrimaryAmmo(1) 
end


function SWEP:ShouldDropOnDie()
    return false
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	
    draw.SimpleText("AIMBOT ON","Arial",x + wide/2,y + tall*0.35,Color(255,0,0,255),TEXT_ALIGN_CENTER)
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap)
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

function SWEP:GetCoordiantes(ent)
    local min,max = ent:OBBMins(),ent:OBBMaxs()
    local corners = {
        Vector(min.x,min.y,min.z),
        Vector(min.x,min.y,max.z),
        Vector(min.x,max.y,min.z),
        Vector(min.x,max.y,max.z),
        Vector(max.x,min.y,min.z),
        Vector(max.x,min.y,max.z),
        Vector(max.x,max.y,min.z),
        Vector(max.x,max.y,max.z)
    }

    local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
    for _,corner in pairs(corners) do
        local screen = ent:LocalToWorld(corner):ToScreen()
        minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
        maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
    end
    return minx,miny,maxx,maxy
end



-- "lua\\weapons\\weapon_v4lenn_ak47_owned.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = false;
   SWEP.AutoSwitchFrom = false;

end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "Some Weapon";
   SWEP.Slot = 0;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= true
SWEP.Category = "Lenn's Weapons (ADMINS STUFF)"
SWEP.IconLetter                = "b"

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands 						= true

SWEP.HoldType                = "smg"
SWEP.ViewModelFlip            = false 

SWEP.Primary.ClipSize        = 99999
SWEP.Primary.DefaultClip    = 99999
SWEP.Primary.Delay            = 0.05
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "ar2"

SWEP.Primary.Sound = Sound ("Weapon_AK47.Single")
SWEP.Primary.Recoil            = 2
SWEP.Primary.Damage            = 999999999999999
SWEP.Primary.NumShots        = 2
SWEP.Primary.Cone            = 0
SWEP.Primary.Spread = 0.1

SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo            = "none"

function SWEP:Initialize()

    if CLIENT then
	surface.CreateFont( "Arial",
	{
	font = "Arial",
	size = ScreenScale(10),
	weight = 400
	})   
	

    end
	self:SetHoldType(self.HoldType)
	
end

function SWEP:SecondaryAttack()
if self.On != true then
self.On = true
else
self.On = false
end
end
SWEP.Aimbot = {}
SWEP.Aimbot.Target = nil
SWEP.Aimbot.DeathSequences = {
    ["models/barnacle.mdl"]            = {4,15},
    ["models/antlion_guard.mdl"]    = {44},
    ["models/hunter.mdl"]            = {124,125,126,127,128},
}

function SWEP:GetHeadPos(ent)
    local model = ent:GetModel() or ""
    if model:find("crow") or model:find("seagull") or model:find("pigeon") then
        return ent:LocalToWorld(ent:OBBCenter() + Vector(0,0,-5))
    elseif ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        return ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    else
        return ent:LocalToWorld(ent:OBBCenter())
    end
end

function SWEP:Visible(ent)
    local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = self:GetHeadPos(ent)
    trace.filter = {self.Owner,ent}
    trace.mask = MASK_SHOT
    local tr = util.TraceLine(trace)
    return tr.Fraction >= 0.99 and true or false
end

function SWEP:CheckTarget(ent)
    if ent:IsPlayer() then
        if !ent:IsValid() then return false end
        if ent:Health() < 1 then return false end
        if ent == self.Owner then return false end    
        return true
    end
    if ent:IsNPC() then
        if ent:GetMoveType() == 0 then return false end
        if table.HasValue(self.Aimbot.DeathSequences[string.lower(ent:GetModel() or "")] or {},ent:GetSequence()) then return false end
        return true
    end
    return false
end

function SWEP:GetTargets()
    local tbl = {}
    for k,ent in pairs(ents.GetAll()) do
        if self:CheckTarget(ent) == true then
            table.insert(tbl,ent)
        end
    end
    return tbl
end

function SWEP:GetClosestTarget()
    local pos = self.Owner:GetPos()
    local ang = self.Owner:GetAimVector()
    local closest = {0,0}
    for k,ent in pairs(self:GetTargets()) do
        local diff = (ent:GetPos()-pos)
		diff:Normalize()
        diff = diff - ang
        diff = diff:Length()
        diff = math.abs(diff)
        if (diff < closest[2]) or (closest[1] == 0) then
            closest = {ent,diff}
        end
    end
    return closest[1]
end

function SWEP:Think()
    local ent = self:GetClosestTarget()
    self.Aimbot.Target = ent ~= 0 and ent or nil
	


hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
if self.On == true then
        return true
    end
end)
end


function SWEP:OnRemove()
self.On = false
timer.Remove("aimbotspin")

end
function SWEP:Holster()
self.On = false
timer.Remove("aimbotspin")
return true
end



function SWEP:PrimaryAttack()
 
    if self.Aimbot.Target ~= nil then
   -- self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    
   local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetPos()
    bullet.Dir = ( self.Aimbot.Target:LocalToWorld( self.Aimbot.Target:OBBCenter() ) - self.Owner:GetPos()  )
    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    end
    
   if (!self:CanPrimaryAttack()) then return end

  
     self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    self.Weapon:EmitSound(self.Primary.Sound)

    self:TakePrimaryAmmo(1) 
end


function SWEP:ShouldDropOnDie()
    return false
end

function SWEP:DrawWeaponSelection(x,y,wide,tall,alpha)
	
    draw.SimpleText("AIMBOT ON","Arial",x + wide/2,y + tall*0.35,Color(255,0,0,255),TEXT_ALIGN_CENTER)
end

function SWEP:DrawRotatingCrosshair(x,y,time,length,gap)
    surface.DrawLine(
        x + (math.sin(math.rad(time)) * length),
        y + (math.cos(math.rad(time)) * length),
        x + (math.sin(math.rad(time)) * gap),
        y + (math.cos(math.rad(time)) * gap)
    )
end

function SWEP:GetCoordiantes(ent)
    local min,max = ent:OBBMins(),ent:OBBMaxs()
    local corners = {
        Vector(min.x,min.y,min.z),
        Vector(min.x,min.y,max.z),
        Vector(min.x,max.y,min.z),
        Vector(min.x,max.y,max.z),
        Vector(max.x,min.y,min.z),
        Vector(max.x,min.y,max.z),
        Vector(max.x,max.y,min.z),
        Vector(max.x,max.y,max.z)
    }

    local minx,miny,maxx,maxy = ScrW() * 2,ScrH() * 2,0,0
    for _,corner in pairs(corners) do
        local screen = ent:LocalToWorld(corner):ToScreen()
        minx,miny = math.min(minx,screen.x),math.min(miny,screen.y)
        maxx,maxy = math.max(maxx,screen.x),math.max(maxy,screen.y)
    end
    return minx,miny,maxx,maxy
end



