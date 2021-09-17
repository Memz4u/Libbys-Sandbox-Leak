-- "lua\\weapons\\weapon_lenn_aimbot_crossbow.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//---- Created by Tenshi (STEAM_0:1:47827646) - Credit to LuaStoned for the aimbot code -------
//---------------------------------------------------------------------------------------------
// Edited by lenn.

if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = true;
   SWEP.AutoSwitchFrom = false;
end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "The Aimbot Crossbow 2";
   SWEP.Slot = 1;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= false
SWEP.Category 				= "Lenn's Weapons (RARE)"
SWEP.Author                    = "Lenn"
SWEP.Purpose                = "A IMAGINARY AK47 THAT SHOOTS CROSSBOW AND HAS AUTO-AIMBOT. THIS ONE IS PRETTY FUCKIEN TOUGH SO BEWARE OF AIMBOT CROSSBOWERS."
SWEP.Instructions            = "Use left click to fire your weapon,  Use right click to zoom."

SWEP.ViewModel                = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel                = "models/weapons/w_rif_ak47.mdl"

SWEP.HoldType                = "crossbow"
SWEP.ViewModelFlip            = false -- I don't like left-side SWEPs either.

SWEP.Primary.ClipSize        = 60 -- (NEW VERSION) +5 clipsize, because why not.
SWEP.Primary.DefaultClip    = 150
SWEP.Primary.Delay            = 0.20
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "crossbow"
-- There was a bug here that occured when I removed the sound. Should be fixed now.
SWEP.Primary.Sound = Sound ("Weapon_Crossbow.Single") -- If someone's got a better idea than this sound I'll try it out.
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 3
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0.0

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
end
----------------------------------------------------------------------------------------------------
-- The rest of the code I don't have to really bother with as the following is aimbot code.
----------------------------------------------------------------------------------------------------

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
end

function SWEP:Reload()
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:PrimaryAttack()
    if self.Aimbot.Target ~= nil then
        self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    end
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if (!self:CanPrimaryAttack()) then return end
    self.Weapon:EmitSound(self.Primary.Sound)

    local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone,self.Primary.Cone,0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    self.Weapon:SendWeaponAnim(ACT_VM_THROW)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    self:TakePrimaryAmmo(1) -- I know I broke my promise, but I want this gun to be a wee bit less dissapointing..
end

function SWEP:SecondaryAttack()    
end

function SWEP:ShouldDropOnDie()
    return false
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

function SWEP:FixName(ent)
    if ent:IsPlayer() then return ent:Name() end
    if ent:IsNPC() then return ent:GetClass():sub(5,-1) end
    return ""
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(0,0,0,235))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,255,10,230))
    surface.DrawLine(w, h - 2, w, h + 3)
    surface.DrawLine(w - 2, h, w + 3, h)

    local time = CurTime() * -180        
    local scale = 10 * 0.02 -- self.Cone
    local gap = 40 * scale
    local length = gap + 20 * scale

    surface.SetDrawColor(0,255,0,150)

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
    
    if self.Aimbot.Target ~= nil then
        local text = "TARGET LOCKED ON THIS STUPID FUCKER: ("..self:FixName(self.Aimbot.Target)..")"
        surface.SetFont("Default")
        local size = surface.GetTextSize(text)
        draw.RoundedBox(4,36,y-135,size+10,20,Color(0,0,0,100))
        draw.DrawText(text,"Default",40,y-132,Color(255,255,255,200),TEXT_ALIGN_LEFT)
        local x1,y1,x2,y2 = self:GetCoordiantes(self.Aimbot.Target)
        local edgesize = 8
        surface.SetDrawColor(Color(255,0,0,200))
        
        -- Top left.
        surface.DrawLine(x1,y1,math.min(x1 + edgesize,x2),y1)
        surface.DrawLine(x1,y1,x1,math.min(y1 + edgesize,y2))

        -- Top right.
        surface.DrawLine(x2,y1,math.max(x2 - edgesize,x1),y1)
        surface.DrawLine(x2,y1,x2,math.min(y1 + edgesize,y2))

        -- Bottom left.
        surface.DrawLine(x1,y2,math.min(x1 + edgesize,x2),y2)
        surface.DrawLine(x1,y2,x1,math.max(y2 - edgesize,y1))

        -- Bottom right.
        surface.DrawLine(x2,y2,math.max(x2 - edgesize,x1),y2)
        surface.DrawLine(x2,y2,x2,math.max(y2 - edgesize,y1))
    end
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
 
end



-- "lua\\weapons\\weapon_lenn_aimbot_crossbow.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//---- Created by Tenshi (STEAM_0:1:47827646) - Credit to LuaStoned for the aimbot code -------
//---------------------------------------------------------------------------------------------
// Edited by lenn.

if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = true;
   SWEP.AutoSwitchFrom = false;
end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "The Aimbot Crossbow 2";
   SWEP.Slot = 1;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= false
SWEP.Category 				= "Lenn's Weapons (RARE)"
SWEP.Author                    = "Lenn"
SWEP.Purpose                = "A IMAGINARY AK47 THAT SHOOTS CROSSBOW AND HAS AUTO-AIMBOT. THIS ONE IS PRETTY FUCKIEN TOUGH SO BEWARE OF AIMBOT CROSSBOWERS."
SWEP.Instructions            = "Use left click to fire your weapon,  Use right click to zoom."

SWEP.ViewModel                = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel                = "models/weapons/w_rif_ak47.mdl"

SWEP.HoldType                = "crossbow"
SWEP.ViewModelFlip            = false -- I don't like left-side SWEPs either.

SWEP.Primary.ClipSize        = 60 -- (NEW VERSION) +5 clipsize, because why not.
SWEP.Primary.DefaultClip    = 150
SWEP.Primary.Delay            = 0.20
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "crossbow"
-- There was a bug here that occured when I removed the sound. Should be fixed now.
SWEP.Primary.Sound = Sound ("Weapon_Crossbow.Single") -- If someone's got a better idea than this sound I'll try it out.
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 3
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0.0

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
end
----------------------------------------------------------------------------------------------------
-- The rest of the code I don't have to really bother with as the following is aimbot code.
----------------------------------------------------------------------------------------------------

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
end

function SWEP:Reload()
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:PrimaryAttack()
    if self.Aimbot.Target ~= nil then
        self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    end
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if (!self:CanPrimaryAttack()) then return end
    self.Weapon:EmitSound(self.Primary.Sound)

    local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone,self.Primary.Cone,0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    self.Weapon:SendWeaponAnim(ACT_VM_THROW)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    self:TakePrimaryAmmo(1) -- I know I broke my promise, but I want this gun to be a wee bit less dissapointing..
end

function SWEP:SecondaryAttack()    
end

function SWEP:ShouldDropOnDie()
    return false
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

function SWEP:FixName(ent)
    if ent:IsPlayer() then return ent:Name() end
    if ent:IsNPC() then return ent:GetClass():sub(5,-1) end
    return ""
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(0,0,0,235))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,255,10,230))
    surface.DrawLine(w, h - 2, w, h + 3)
    surface.DrawLine(w - 2, h, w + 3, h)

    local time = CurTime() * -180        
    local scale = 10 * 0.02 -- self.Cone
    local gap = 40 * scale
    local length = gap + 20 * scale

    surface.SetDrawColor(0,255,0,150)

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
    
    if self.Aimbot.Target ~= nil then
        local text = "TARGET LOCKED ON THIS STUPID FUCKER: ("..self:FixName(self.Aimbot.Target)..")"
        surface.SetFont("Default")
        local size = surface.GetTextSize(text)
        draw.RoundedBox(4,36,y-135,size+10,20,Color(0,0,0,100))
        draw.DrawText(text,"Default",40,y-132,Color(255,255,255,200),TEXT_ALIGN_LEFT)
        local x1,y1,x2,y2 = self:GetCoordiantes(self.Aimbot.Target)
        local edgesize = 8
        surface.SetDrawColor(Color(255,0,0,200))
        
        -- Top left.
        surface.DrawLine(x1,y1,math.min(x1 + edgesize,x2),y1)
        surface.DrawLine(x1,y1,x1,math.min(y1 + edgesize,y2))

        -- Top right.
        surface.DrawLine(x2,y1,math.max(x2 - edgesize,x1),y1)
        surface.DrawLine(x2,y1,x2,math.min(y1 + edgesize,y2))

        -- Bottom left.
        surface.DrawLine(x1,y2,math.min(x1 + edgesize,x2),y2)
        surface.DrawLine(x1,y2,x1,math.max(y2 - edgesize,y1))

        -- Bottom right.
        surface.DrawLine(x2,y2,math.max(x2 - edgesize,x1),y2)
        surface.DrawLine(x2,y2,x2,math.max(y2 - edgesize,y1))
    end
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
 
end



-- "lua\\weapons\\weapon_lenn_aimbot_crossbow.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//---- Created by Tenshi (STEAM_0:1:47827646) - Credit to LuaStoned for the aimbot code -------
//---------------------------------------------------------------------------------------------
// Edited by lenn.

if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = true;
   SWEP.AutoSwitchFrom = false;
end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "The Aimbot Crossbow 2";
   SWEP.Slot = 1;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= false
SWEP.Category 				= "Lenn's Weapons (RARE)"
SWEP.Author                    = "Lenn"
SWEP.Purpose                = "A IMAGINARY AK47 THAT SHOOTS CROSSBOW AND HAS AUTO-AIMBOT. THIS ONE IS PRETTY FUCKIEN TOUGH SO BEWARE OF AIMBOT CROSSBOWERS."
SWEP.Instructions            = "Use left click to fire your weapon,  Use right click to zoom."

SWEP.ViewModel                = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel                = "models/weapons/w_rif_ak47.mdl"

SWEP.HoldType                = "crossbow"
SWEP.ViewModelFlip            = false -- I don't like left-side SWEPs either.

SWEP.Primary.ClipSize        = 60 -- (NEW VERSION) +5 clipsize, because why not.
SWEP.Primary.DefaultClip    = 150
SWEP.Primary.Delay            = 0.20
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "crossbow"
-- There was a bug here that occured when I removed the sound. Should be fixed now.
SWEP.Primary.Sound = Sound ("Weapon_Crossbow.Single") -- If someone's got a better idea than this sound I'll try it out.
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 3
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0.0

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
end
----------------------------------------------------------------------------------------------------
-- The rest of the code I don't have to really bother with as the following is aimbot code.
----------------------------------------------------------------------------------------------------

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
end

function SWEP:Reload()
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:PrimaryAttack()
    if self.Aimbot.Target ~= nil then
        self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    end
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if (!self:CanPrimaryAttack()) then return end
    self.Weapon:EmitSound(self.Primary.Sound)

    local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone,self.Primary.Cone,0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    self.Weapon:SendWeaponAnim(ACT_VM_THROW)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    self:TakePrimaryAmmo(1) -- I know I broke my promise, but I want this gun to be a wee bit less dissapointing..
end

function SWEP:SecondaryAttack()    
end

function SWEP:ShouldDropOnDie()
    return false
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

function SWEP:FixName(ent)
    if ent:IsPlayer() then return ent:Name() end
    if ent:IsNPC() then return ent:GetClass():sub(5,-1) end
    return ""
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(0,0,0,235))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,255,10,230))
    surface.DrawLine(w, h - 2, w, h + 3)
    surface.DrawLine(w - 2, h, w + 3, h)

    local time = CurTime() * -180        
    local scale = 10 * 0.02 -- self.Cone
    local gap = 40 * scale
    local length = gap + 20 * scale

    surface.SetDrawColor(0,255,0,150)

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
    
    if self.Aimbot.Target ~= nil then
        local text = "TARGET LOCKED ON THIS STUPID FUCKER: ("..self:FixName(self.Aimbot.Target)..")"
        surface.SetFont("Default")
        local size = surface.GetTextSize(text)
        draw.RoundedBox(4,36,y-135,size+10,20,Color(0,0,0,100))
        draw.DrawText(text,"Default",40,y-132,Color(255,255,255,200),TEXT_ALIGN_LEFT)
        local x1,y1,x2,y2 = self:GetCoordiantes(self.Aimbot.Target)
        local edgesize = 8
        surface.SetDrawColor(Color(255,0,0,200))
        
        -- Top left.
        surface.DrawLine(x1,y1,math.min(x1 + edgesize,x2),y1)
        surface.DrawLine(x1,y1,x1,math.min(y1 + edgesize,y2))

        -- Top right.
        surface.DrawLine(x2,y1,math.max(x2 - edgesize,x1),y1)
        surface.DrawLine(x2,y1,x2,math.min(y1 + edgesize,y2))

        -- Bottom left.
        surface.DrawLine(x1,y2,math.min(x1 + edgesize,x2),y2)
        surface.DrawLine(x1,y2,x1,math.max(y2 - edgesize,y1))

        -- Bottom right.
        surface.DrawLine(x2,y2,math.max(x2 - edgesize,x1),y2)
        surface.DrawLine(x2,y2,x2,math.max(y2 - edgesize,y1))
    end
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
 
end



-- "lua\\weapons\\weapon_lenn_aimbot_crossbow.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//---- Created by Tenshi (STEAM_0:1:47827646) - Credit to LuaStoned for the aimbot code -------
//---------------------------------------------------------------------------------------------
// Edited by lenn.

if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = true;
   SWEP.AutoSwitchFrom = false;
end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "The Aimbot Crossbow 2";
   SWEP.Slot = 1;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= false
SWEP.Category 				= "Lenn's Weapons (RARE)"
SWEP.Author                    = "Lenn"
SWEP.Purpose                = "A IMAGINARY AK47 THAT SHOOTS CROSSBOW AND HAS AUTO-AIMBOT. THIS ONE IS PRETTY FUCKIEN TOUGH SO BEWARE OF AIMBOT CROSSBOWERS."
SWEP.Instructions            = "Use left click to fire your weapon,  Use right click to zoom."

SWEP.ViewModel                = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel                = "models/weapons/w_rif_ak47.mdl"

SWEP.HoldType                = "crossbow"
SWEP.ViewModelFlip            = false -- I don't like left-side SWEPs either.

SWEP.Primary.ClipSize        = 60 -- (NEW VERSION) +5 clipsize, because why not.
SWEP.Primary.DefaultClip    = 150
SWEP.Primary.Delay            = 0.20
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "crossbow"
-- There was a bug here that occured when I removed the sound. Should be fixed now.
SWEP.Primary.Sound = Sound ("Weapon_Crossbow.Single") -- If someone's got a better idea than this sound I'll try it out.
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 3
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0.0

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
end
----------------------------------------------------------------------------------------------------
-- The rest of the code I don't have to really bother with as the following is aimbot code.
----------------------------------------------------------------------------------------------------

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
end

function SWEP:Reload()
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:PrimaryAttack()
    if self.Aimbot.Target ~= nil then
        self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    end
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if (!self:CanPrimaryAttack()) then return end
    self.Weapon:EmitSound(self.Primary.Sound)

    local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone,self.Primary.Cone,0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    self.Weapon:SendWeaponAnim(ACT_VM_THROW)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    self:TakePrimaryAmmo(1) -- I know I broke my promise, but I want this gun to be a wee bit less dissapointing..
end

function SWEP:SecondaryAttack()    
end

function SWEP:ShouldDropOnDie()
    return false
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

function SWEP:FixName(ent)
    if ent:IsPlayer() then return ent:Name() end
    if ent:IsNPC() then return ent:GetClass():sub(5,-1) end
    return ""
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(0,0,0,235))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,255,10,230))
    surface.DrawLine(w, h - 2, w, h + 3)
    surface.DrawLine(w - 2, h, w + 3, h)

    local time = CurTime() * -180        
    local scale = 10 * 0.02 -- self.Cone
    local gap = 40 * scale
    local length = gap + 20 * scale

    surface.SetDrawColor(0,255,0,150)

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
    
    if self.Aimbot.Target ~= nil then
        local text = "TARGET LOCKED ON THIS STUPID FUCKER: ("..self:FixName(self.Aimbot.Target)..")"
        surface.SetFont("Default")
        local size = surface.GetTextSize(text)
        draw.RoundedBox(4,36,y-135,size+10,20,Color(0,0,0,100))
        draw.DrawText(text,"Default",40,y-132,Color(255,255,255,200),TEXT_ALIGN_LEFT)
        local x1,y1,x2,y2 = self:GetCoordiantes(self.Aimbot.Target)
        local edgesize = 8
        surface.SetDrawColor(Color(255,0,0,200))
        
        -- Top left.
        surface.DrawLine(x1,y1,math.min(x1 + edgesize,x2),y1)
        surface.DrawLine(x1,y1,x1,math.min(y1 + edgesize,y2))

        -- Top right.
        surface.DrawLine(x2,y1,math.max(x2 - edgesize,x1),y1)
        surface.DrawLine(x2,y1,x2,math.min(y1 + edgesize,y2))

        -- Bottom left.
        surface.DrawLine(x1,y2,math.min(x1 + edgesize,x2),y2)
        surface.DrawLine(x1,y2,x1,math.max(y2 - edgesize,y1))

        -- Bottom right.
        surface.DrawLine(x2,y2,math.max(x2 - edgesize,x1),y2)
        surface.DrawLine(x2,y2,x2,math.max(y2 - edgesize,y1))
    end
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
 
end



-- "lua\\weapons\\weapon_lenn_aimbot_crossbow.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
//---- Created by Tenshi (STEAM_0:1:47827646) - Credit to LuaStoned for the aimbot code -------
//---------------------------------------------------------------------------------------------
// Edited by lenn.

if (SERVER) then --the init.lua stuff goes in here
	AddCSLuaFile ()
   SWEP.Weight = 5;
   SWEP.AutoSwitchTo = true;
   SWEP.AutoSwitchFrom = false;
end
 
if (CLIENT) then --the cl_init.lua stuff goes in here
 
 
   SWEP.PrintName = "The Aimbot Crossbow 2";
   SWEP.Slot = 1;
   SWEP.SlotPos = 1;
   SWEP.DrawAmmo = false;
   SWEP.DrawCrosshair = false;
 
end

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;
SWEP.AdminOnly		= false
SWEP.Category 				= "Lenn's Weapons (RARE)"
SWEP.Author                    = "Lenn"
SWEP.Purpose                = "A IMAGINARY AK47 THAT SHOOTS CROSSBOW AND HAS AUTO-AIMBOT. THIS ONE IS PRETTY FUCKIEN TOUGH SO BEWARE OF AIMBOT CROSSBOWERS."
SWEP.Instructions            = "Use left click to fire your weapon,  Use right click to zoom."

SWEP.ViewModel                = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel                = "models/weapons/w_rif_ak47.mdl"

SWEP.HoldType                = "crossbow"
SWEP.ViewModelFlip            = false -- I don't like left-side SWEPs either.

SWEP.Primary.ClipSize        = 60 -- (NEW VERSION) +5 clipsize, because why not.
SWEP.Primary.DefaultClip    = 150
SWEP.Primary.Delay            = 0.20
SWEP.Primary.Automatic        = true
SWEP.Primary.Ammo            = "crossbow"
-- There was a bug here that occured when I removed the sound. Should be fixed now.
SWEP.Primary.Sound = Sound ("Weapon_Crossbow.Single") -- If someone's got a better idea than this sound I'll try it out.
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 3
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0.0

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
end
----------------------------------------------------------------------------------------------------
-- The rest of the code I don't have to really bother with as the following is aimbot code.
----------------------------------------------------------------------------------------------------

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
end

function SWEP:Reload()
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:PrimaryAttack()
    if self.Aimbot.Target ~= nil then
        self.Owner:SetEyeAngles((self:GetHeadPos(self.Aimbot.Target) - self.Owner:GetShootPos()):Angle())
    end
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if (!self:CanPrimaryAttack()) then return end
    self.Weapon:EmitSound(self.Primary.Sound)

    local bullet = {}
    bullet.Num = self.Primary.NumShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector(self.Primary.Cone,self.Primary.Cone,0)
    bullet.Tracer = 1
    bullet.Force = 10
    bullet.Damage = self.Primary.Damage

    self.Owner:FireBullets(bullet)
    self.Weapon:SendWeaponAnim(ACT_VM_THROW)
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    self:TakePrimaryAmmo(1) -- I know I broke my promise, but I want this gun to be a wee bit less dissapointing..
end

function SWEP:SecondaryAttack()    
end

function SWEP:ShouldDropOnDie()
    return false
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

function SWEP:FixName(ent)
    if ent:IsPlayer() then return ent:Name() end
    if ent:IsNPC() then return ent:GetClass():sub(5,-1) end
    return ""
end

function SWEP:DrawHUD()
    local x,y = ScrW(),ScrH()
    local w,h = x/2,y/2
    
    surface.SetDrawColor(Color(0,0,0,235))
    surface.DrawRect(w - 1, h - 3, 3, 7)
    surface.DrawRect(w - 3, h - 1, 7, 3)

    surface.SetDrawColor(Color(0,255,10,230))
    surface.DrawLine(w, h - 2, w, h + 3)
    surface.DrawLine(w - 2, h, w + 3, h)

    local time = CurTime() * -180        
    local scale = 10 * 0.02 -- self.Cone
    local gap = 40 * scale
    local length = gap + 20 * scale

    surface.SetDrawColor(0,255,0,150)

    self:DrawRotatingCrosshair(w,h,time,      length,gap)
    self:DrawRotatingCrosshair(w,h,time + 90, length,gap)
    self:DrawRotatingCrosshair(w,h,time + 180,length,gap)
    self:DrawRotatingCrosshair(w,h,time + 270,length,gap)
    
    if self.Aimbot.Target ~= nil then
        local text = "TARGET LOCKED ON THIS STUPID FUCKER: ("..self:FixName(self.Aimbot.Target)..")"
        surface.SetFont("Default")
        local size = surface.GetTextSize(text)
        draw.RoundedBox(4,36,y-135,size+10,20,Color(0,0,0,100))
        draw.DrawText(text,"Default",40,y-132,Color(255,255,255,200),TEXT_ALIGN_LEFT)
        local x1,y1,x2,y2 = self:GetCoordiantes(self.Aimbot.Target)
        local edgesize = 8
        surface.SetDrawColor(Color(255,0,0,200))
        
        -- Top left.
        surface.DrawLine(x1,y1,math.min(x1 + edgesize,x2),y1)
        surface.DrawLine(x1,y1,x1,math.min(y1 + edgesize,y2))

        -- Top right.
        surface.DrawLine(x2,y1,math.max(x2 - edgesize,x1),y1)
        surface.DrawLine(x2,y1,x2,math.min(y1 + edgesize,y2))

        -- Bottom left.
        surface.DrawLine(x1,y2,math.min(x1 + edgesize,x2),y2)
        surface.DrawLine(x1,y2,x1,math.max(y2 - edgesize,y1))

        -- Bottom right.
        surface.DrawLine(x2,y2,math.max(x2 - edgesize,x1),y2)
        surface.DrawLine(x2,y2,x2,math.max(y2 - edgesize,y1))
    end
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	//The variable "ScopeLevel" tells how far the scope has zoomed.
	//This SWEP has 2 zoom levels.
	if(ScopeLevel == 0) then
 
		if(SERVER) then
			self.Owner:SetFOV( 40, 0 )
			//SetFOV changes the field of view, or zoom. First argument is the
			//number of degrees in the player's view (lower numbers zoom farther,)
			//and the second is the duration it takes in seconds.
		end	
 
		ScopeLevel = 1
		//This is zoom level 1.
 
	else if(ScopeLevel == 1) then
 
		if(SERVER) then
			self.Owner:SetFOV( 20, 0 )
		end	
 
		ScopeLevel = 2
		//This is zoom level 2.
 
	else
		//If the user is zoomed in all the way, reset their view.
		if(SERVER) then
			self.Owner:SetFOV( 0, 0 )
			//Setting the FOV to zero resets the player's view, AFAIK
		end		
 
		ScopeLevel = 0
		//There is no zoom.
 
	end
	end
 
end



