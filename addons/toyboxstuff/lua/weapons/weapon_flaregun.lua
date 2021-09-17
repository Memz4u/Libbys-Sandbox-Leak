-- "addons\\toyboxstuff\\lua\\weapons\\weapon_flaregun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()


SWEP.Spawnable            = true
SWEP.AdminSpawnable        = false
SWEP.Category = "Toybox Classics"
SWEP.Author            = "Johnny"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = ""

SWEP.ViewModelFOV    = 62
SWEP.ViewModelFlip    = false


SWEP.Primary.ClipSize        = 1                // Size of a clip
SWEP.Primary.DefaultClip    = 20                // Default number of bullets in a clip
SWEP.Primary.Automatic        = false                // Automatic/Semi Auto
SWEP.Primary.Ammo            = "Pistol"

SWEP.Secondary.Ammo            = false

SWEP.PrintName            = "FlareGun"        // 'Nice' Weapon name (Shown on HUD)    
SWEP.Slot                = 0                        // Slot in the weapon selection menu
SWEP.SlotPos            = 10                    // Position in the slot
SWEP.DrawAmmo            = true                    // Should draw the default HL2 ammo counter
SWEP.DrawCrosshair        = true                     // Should draw the default crosshair
SWEP.DrawWeaponInfoBox    = true                    // Should draw the weapon info box
SWEP.BounceWeaponIcon   = true                    // Should the weapon icon bounce?
SWEP.SwayScale            = 1.0                    // The scale of the viewmodel sway
SWEP.BobScale            = 1.0                    // The scale of the viewmodel bob

SWEP.RenderGroup         = RENDERGROUP_OPAQUE

SWEP.ViewModel        = "models/jmodels/v_flaregun.mdl"
SWEP.WorldModel        = "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix        = "python"
SWEP.UseHands = true



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
    
end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/

local FLARE = {};
function FLARE:flareBurn(self, timerstr)
	if !IsValid(self) then return end
    if ((self:WaterLevel() > 0) or (self:OnGround())) then
        timer.Destroy(timerstr);
        return
    end
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart( vPoint )
    effectdata:SetOrigin( vPoint )
    effectdata:SetScale( 1 )
    util.Effect( "WheelDust", effectdata )    

    local entz = ents.FindInSphere( self:GetPos(), 10 );
    local destroy = false;
    if (table.Count(entz) > 1) then
        //self:Fire("kill","",0);
        for i,v in pairs(entz) do
            if ((v != self) and (v != self:GetOwner())) then
                if (v:IsPlayer()) then

                    //if( v:Team() ~= 1001 ) then 
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    //end
                else
                    if (v:IsNPC()) then
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    end
                end
            end
        end
        if (destroy == true) then
            timer.Destroy(timerstr);
            self:Fire("kill","",0);
        end
    end
end

function SWEP:PrimaryAttack()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    timer.Create("fireFlare", 0.7, 1, function() if IsValid(self) then self:fireFlare() end end)
end

function SWEP:fireFlare()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end

    // Play shoot sound
    self.Weapon:EmitSound("Weapon_AR2.Single")
    
    // Shoot 9 bullets, 150 damage, 0.75 aimcone
    //self:ShootBullet( 9999, 1, 0.01 )

    // Remove 1 bullet from our clip
    self:TakePrimaryAmmo( 1 )
    
    // Punch the players view
    self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

    self.Owner:MuzzleFlash()

    if CLIENT then return end

    local e = ents.Create("env_flare");
    e:SetKeyValue("scale", "10");
    e:SetKeyValue("duration", "2");
    e:SetKeyValue("spawnflags", "2");
    e:SetAngles( self.Owner:GetAimVector():Angle() );
    e:SetPos(self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 2));
    e:SetOwner(self.Owner);
    e:Spawn();
    e:Activate();
    e:Fire( "launch", "2000", 0 );
    timer.Create(self.Owner:UniqueID()..e:EntIndex(), 0.01, 200, function() if IsValid(e) then FLARE:flareBurn(e, self.Owner:UniqueID()..e:EntIndex()) end end);
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	if IsValid(self.Owner) and IsValid(self.Owner:GetViewModel()) then
		local vm = self.Owner:GetViewModel()
		vm:SetSubMaterial(0, "")
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:PostDrawViewModel(vm)
	if vm:GetSubMaterial(0) ~= "color" then -- remove hev
		vm:SetSubMaterial(0, "color")
	end
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_flaregun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()


SWEP.Spawnable            = true
SWEP.AdminSpawnable        = false
SWEP.Category = "Toybox Classics"
SWEP.Author            = "Johnny"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = ""

SWEP.ViewModelFOV    = 62
SWEP.ViewModelFlip    = false


SWEP.Primary.ClipSize        = 1                // Size of a clip
SWEP.Primary.DefaultClip    = 20                // Default number of bullets in a clip
SWEP.Primary.Automatic        = false                // Automatic/Semi Auto
SWEP.Primary.Ammo            = "Pistol"

SWEP.Secondary.Ammo            = false

SWEP.PrintName            = "FlareGun"        // 'Nice' Weapon name (Shown on HUD)    
SWEP.Slot                = 0                        // Slot in the weapon selection menu
SWEP.SlotPos            = 10                    // Position in the slot
SWEP.DrawAmmo            = true                    // Should draw the default HL2 ammo counter
SWEP.DrawCrosshair        = true                     // Should draw the default crosshair
SWEP.DrawWeaponInfoBox    = true                    // Should draw the weapon info box
SWEP.BounceWeaponIcon   = true                    // Should the weapon icon bounce?
SWEP.SwayScale            = 1.0                    // The scale of the viewmodel sway
SWEP.BobScale            = 1.0                    // The scale of the viewmodel bob

SWEP.RenderGroup         = RENDERGROUP_OPAQUE

SWEP.ViewModel        = "models/jmodels/v_flaregun.mdl"
SWEP.WorldModel        = "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix        = "python"
SWEP.UseHands = true



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
    
end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/

local FLARE = {};
function FLARE:flareBurn(self, timerstr)
	if !IsValid(self) then return end
    if ((self:WaterLevel() > 0) or (self:OnGround())) then
        timer.Destroy(timerstr);
        return
    end
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart( vPoint )
    effectdata:SetOrigin( vPoint )
    effectdata:SetScale( 1 )
    util.Effect( "WheelDust", effectdata )    

    local entz = ents.FindInSphere( self:GetPos(), 10 );
    local destroy = false;
    if (table.Count(entz) > 1) then
        //self:Fire("kill","",0);
        for i,v in pairs(entz) do
            if ((v != self) and (v != self:GetOwner())) then
                if (v:IsPlayer()) then

                    //if( v:Team() ~= 1001 ) then 
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    //end
                else
                    if (v:IsNPC()) then
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    end
                end
            end
        end
        if (destroy == true) then
            timer.Destroy(timerstr);
            self:Fire("kill","",0);
        end
    end
end

function SWEP:PrimaryAttack()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    timer.Create("fireFlare", 0.7, 1, function() if IsValid(self) then self:fireFlare() end end)
end

function SWEP:fireFlare()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end

    // Play shoot sound
    self.Weapon:EmitSound("Weapon_AR2.Single")
    
    // Shoot 9 bullets, 150 damage, 0.75 aimcone
    //self:ShootBullet( 9999, 1, 0.01 )

    // Remove 1 bullet from our clip
    self:TakePrimaryAmmo( 1 )
    
    // Punch the players view
    self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

    self.Owner:MuzzleFlash()

    if CLIENT then return end

    local e = ents.Create("env_flare");
    e:SetKeyValue("scale", "10");
    e:SetKeyValue("duration", "2");
    e:SetKeyValue("spawnflags", "2");
    e:SetAngles( self.Owner:GetAimVector():Angle() );
    e:SetPos(self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 2));
    e:SetOwner(self.Owner);
    e:Spawn();
    e:Activate();
    e:Fire( "launch", "2000", 0 );
    timer.Create(self.Owner:UniqueID()..e:EntIndex(), 0.01, 200, function() if IsValid(e) then FLARE:flareBurn(e, self.Owner:UniqueID()..e:EntIndex()) end end);
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	if IsValid(self.Owner) and IsValid(self.Owner:GetViewModel()) then
		local vm = self.Owner:GetViewModel()
		vm:SetSubMaterial(0, "")
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:PostDrawViewModel(vm)
	if vm:GetSubMaterial(0) ~= "color" then -- remove hev
		vm:SetSubMaterial(0, "color")
	end
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_flaregun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()


SWEP.Spawnable            = true
SWEP.AdminSpawnable        = false
SWEP.Category = "Toybox Classics"
SWEP.Author            = "Johnny"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = ""

SWEP.ViewModelFOV    = 62
SWEP.ViewModelFlip    = false


SWEP.Primary.ClipSize        = 1                // Size of a clip
SWEP.Primary.DefaultClip    = 20                // Default number of bullets in a clip
SWEP.Primary.Automatic        = false                // Automatic/Semi Auto
SWEP.Primary.Ammo            = "Pistol"

SWEP.Secondary.Ammo            = false

SWEP.PrintName            = "FlareGun"        // 'Nice' Weapon name (Shown on HUD)    
SWEP.Slot                = 0                        // Slot in the weapon selection menu
SWEP.SlotPos            = 10                    // Position in the slot
SWEP.DrawAmmo            = true                    // Should draw the default HL2 ammo counter
SWEP.DrawCrosshair        = true                     // Should draw the default crosshair
SWEP.DrawWeaponInfoBox    = true                    // Should draw the weapon info box
SWEP.BounceWeaponIcon   = true                    // Should the weapon icon bounce?
SWEP.SwayScale            = 1.0                    // The scale of the viewmodel sway
SWEP.BobScale            = 1.0                    // The scale of the viewmodel bob

SWEP.RenderGroup         = RENDERGROUP_OPAQUE

SWEP.ViewModel        = "models/jmodels/v_flaregun.mdl"
SWEP.WorldModel        = "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix        = "python"
SWEP.UseHands = true



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
    
end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/

local FLARE = {};
function FLARE:flareBurn(self, timerstr)
	if !IsValid(self) then return end
    if ((self:WaterLevel() > 0) or (self:OnGround())) then
        timer.Destroy(timerstr);
        return
    end
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart( vPoint )
    effectdata:SetOrigin( vPoint )
    effectdata:SetScale( 1 )
    util.Effect( "WheelDust", effectdata )    

    local entz = ents.FindInSphere( self:GetPos(), 10 );
    local destroy = false;
    if (table.Count(entz) > 1) then
        //self:Fire("kill","",0);
        for i,v in pairs(entz) do
            if ((v != self) and (v != self:GetOwner())) then
                if (v:IsPlayer()) then

                    //if( v:Team() ~= 1001 ) then 
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    //end
                else
                    if (v:IsNPC()) then
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    end
                end
            end
        end
        if (destroy == true) then
            timer.Destroy(timerstr);
            self:Fire("kill","",0);
        end
    end
end

function SWEP:PrimaryAttack()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    timer.Create("fireFlare", 0.7, 1, function() if IsValid(self) then self:fireFlare() end end)
end

function SWEP:fireFlare()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end

    // Play shoot sound
    self.Weapon:EmitSound("Weapon_AR2.Single")
    
    // Shoot 9 bullets, 150 damage, 0.75 aimcone
    //self:ShootBullet( 9999, 1, 0.01 )

    // Remove 1 bullet from our clip
    self:TakePrimaryAmmo( 1 )
    
    // Punch the players view
    self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

    self.Owner:MuzzleFlash()

    if CLIENT then return end

    local e = ents.Create("env_flare");
    e:SetKeyValue("scale", "10");
    e:SetKeyValue("duration", "2");
    e:SetKeyValue("spawnflags", "2");
    e:SetAngles( self.Owner:GetAimVector():Angle() );
    e:SetPos(self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 2));
    e:SetOwner(self.Owner);
    e:Spawn();
    e:Activate();
    e:Fire( "launch", "2000", 0 );
    timer.Create(self.Owner:UniqueID()..e:EntIndex(), 0.01, 200, function() if IsValid(e) then FLARE:flareBurn(e, self.Owner:UniqueID()..e:EntIndex()) end end);
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	if IsValid(self.Owner) and IsValid(self.Owner:GetViewModel()) then
		local vm = self.Owner:GetViewModel()
		vm:SetSubMaterial(0, "")
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:PostDrawViewModel(vm)
	if vm:GetSubMaterial(0) ~= "color" then -- remove hev
		vm:SetSubMaterial(0, "color")
	end
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_flaregun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()


SWEP.Spawnable            = true
SWEP.AdminSpawnable        = false
SWEP.Category = "Toybox Classics"
SWEP.Author            = "Johnny"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = ""

SWEP.ViewModelFOV    = 62
SWEP.ViewModelFlip    = false


SWEP.Primary.ClipSize        = 1                // Size of a clip
SWEP.Primary.DefaultClip    = 20                // Default number of bullets in a clip
SWEP.Primary.Automatic        = false                // Automatic/Semi Auto
SWEP.Primary.Ammo            = "Pistol"

SWEP.Secondary.Ammo            = false

SWEP.PrintName            = "FlareGun"        // 'Nice' Weapon name (Shown on HUD)    
SWEP.Slot                = 0                        // Slot in the weapon selection menu
SWEP.SlotPos            = 10                    // Position in the slot
SWEP.DrawAmmo            = true                    // Should draw the default HL2 ammo counter
SWEP.DrawCrosshair        = true                     // Should draw the default crosshair
SWEP.DrawWeaponInfoBox    = true                    // Should draw the weapon info box
SWEP.BounceWeaponIcon   = true                    // Should the weapon icon bounce?
SWEP.SwayScale            = 1.0                    // The scale of the viewmodel sway
SWEP.BobScale            = 1.0                    // The scale of the viewmodel bob

SWEP.RenderGroup         = RENDERGROUP_OPAQUE

SWEP.ViewModel        = "models/jmodels/v_flaregun.mdl"
SWEP.WorldModel        = "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix        = "python"
SWEP.UseHands = true



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
    
end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/

local FLARE = {};
function FLARE:flareBurn(self, timerstr)
	if !IsValid(self) then return end
    if ((self:WaterLevel() > 0) or (self:OnGround())) then
        timer.Destroy(timerstr);
        return
    end
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart( vPoint )
    effectdata:SetOrigin( vPoint )
    effectdata:SetScale( 1 )
    util.Effect( "WheelDust", effectdata )    

    local entz = ents.FindInSphere( self:GetPos(), 10 );
    local destroy = false;
    if (table.Count(entz) > 1) then
        //self:Fire("kill","",0);
        for i,v in pairs(entz) do
            if ((v != self) and (v != self:GetOwner())) then
                if (v:IsPlayer()) then

                    //if( v:Team() ~= 1001 ) then 
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    //end
                else
                    if (v:IsNPC()) then
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    end
                end
            end
        end
        if (destroy == true) then
            timer.Destroy(timerstr);
            self:Fire("kill","",0);
        end
    end
end

function SWEP:PrimaryAttack()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    timer.Create("fireFlare", 0.7, 1, function() if IsValid(self) then self:fireFlare() end end)
end

function SWEP:fireFlare()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end

    // Play shoot sound
    self.Weapon:EmitSound("Weapon_AR2.Single")
    
    // Shoot 9 bullets, 150 damage, 0.75 aimcone
    //self:ShootBullet( 9999, 1, 0.01 )

    // Remove 1 bullet from our clip
    self:TakePrimaryAmmo( 1 )
    
    // Punch the players view
    self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

    self.Owner:MuzzleFlash()

    if CLIENT then return end

    local e = ents.Create("env_flare");
    e:SetKeyValue("scale", "10");
    e:SetKeyValue("duration", "2");
    e:SetKeyValue("spawnflags", "2");
    e:SetAngles( self.Owner:GetAimVector():Angle() );
    e:SetPos(self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 2));
    e:SetOwner(self.Owner);
    e:Spawn();
    e:Activate();
    e:Fire( "launch", "2000", 0 );
    timer.Create(self.Owner:UniqueID()..e:EntIndex(), 0.01, 200, function() if IsValid(e) then FLARE:flareBurn(e, self.Owner:UniqueID()..e:EntIndex()) end end);
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	if IsValid(self.Owner) and IsValid(self.Owner:GetViewModel()) then
		local vm = self.Owner:GetViewModel()
		vm:SetSubMaterial(0, "")
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:PostDrawViewModel(vm)
	if vm:GetSubMaterial(0) ~= "color" then -- remove hev
		vm:SetSubMaterial(0, "color")
	end
end

-- "addons\\toyboxstuff\\lua\\weapons\\weapon_flaregun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()


SWEP.Spawnable            = true
SWEP.AdminSpawnable        = false
SWEP.Category = "Toybox Classics"
SWEP.Author            = "Johnny"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = ""

SWEP.ViewModelFOV    = 62
SWEP.ViewModelFlip    = false


SWEP.Primary.ClipSize        = 1                // Size of a clip
SWEP.Primary.DefaultClip    = 20                // Default number of bullets in a clip
SWEP.Primary.Automatic        = false                // Automatic/Semi Auto
SWEP.Primary.Ammo            = "Pistol"

SWEP.Secondary.Ammo            = false

SWEP.PrintName            = "FlareGun"        // 'Nice' Weapon name (Shown on HUD)    
SWEP.Slot                = 0                        // Slot in the weapon selection menu
SWEP.SlotPos            = 10                    // Position in the slot
SWEP.DrawAmmo            = true                    // Should draw the default HL2 ammo counter
SWEP.DrawCrosshair        = true                     // Should draw the default crosshair
SWEP.DrawWeaponInfoBox    = true                    // Should draw the weapon info box
SWEP.BounceWeaponIcon   = true                    // Should the weapon icon bounce?
SWEP.SwayScale            = 1.0                    // The scale of the viewmodel sway
SWEP.BobScale            = 1.0                    // The scale of the viewmodel bob

SWEP.RenderGroup         = RENDERGROUP_OPAQUE

SWEP.ViewModel        = "models/jmodels/v_flaregun.mdl"
SWEP.WorldModel        = "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix        = "python"
SWEP.UseHands = true



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
    
end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/

local FLARE = {};
function FLARE:flareBurn(self, timerstr)
	if !IsValid(self) then return end
    if ((self:WaterLevel() > 0) or (self:OnGround())) then
        timer.Destroy(timerstr);
        return
    end
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart( vPoint )
    effectdata:SetOrigin( vPoint )
    effectdata:SetScale( 1 )
    util.Effect( "WheelDust", effectdata )    

    local entz = ents.FindInSphere( self:GetPos(), 10 );
    local destroy = false;
    if (table.Count(entz) > 1) then
        //self:Fire("kill","",0);
        for i,v in pairs(entz) do
            if ((v != self) and (v != self:GetOwner())) then
                if (v:IsPlayer()) then

                    //if( v:Team() ~= 1001 ) then 
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    //end
                else
                    if (v:IsNPC()) then
                        v:Fire("ignitelifetime","5",0);
                        v:TakeDamage( 15 ,self:GetOwner() );
                        destroy = true;
                    end
                end
            end
        end
        if (destroy == true) then
            timer.Destroy(timerstr);
            self:Fire("kill","",0);
        end
    end
end

function SWEP:PrimaryAttack()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK ) 
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    timer.Create("fireFlare", 0.7, 1, function() if IsValid(self) then self:fireFlare() end end)
end

function SWEP:fireFlare()
    // Make sure we can shoot first
    if ( !self:CanPrimaryAttack() ) then return end

    // Play shoot sound
    self.Weapon:EmitSound("Weapon_AR2.Single")
    
    // Shoot 9 bullets, 150 damage, 0.75 aimcone
    //self:ShootBullet( 9999, 1, 0.01 )

    // Remove 1 bullet from our clip
    self:TakePrimaryAmmo( 1 )
    
    // Punch the players view
    self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

    self.Owner:MuzzleFlash()

    if CLIENT then return end

    local e = ents.Create("env_flare");
    e:SetKeyValue("scale", "10");
    e:SetKeyValue("duration", "2");
    e:SetKeyValue("spawnflags", "2");
    e:SetAngles( self.Owner:GetAimVector():Angle() );
    e:SetPos(self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 2));
    e:SetOwner(self.Owner);
    e:Spawn();
    e:Activate();
    e:Fire( "launch", "2000", 0 );
    timer.Create(self.Owner:UniqueID()..e:EntIndex(), 0.01, 200, function() if IsValid(e) then FLARE:flareBurn(e, self.Owner:UniqueID()..e:EntIndex()) end end);
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	if IsValid(self.Owner) and IsValid(self.Owner:GetViewModel()) then
		local vm = self.Owner:GetViewModel()
		vm:SetSubMaterial(0, "")
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:PostDrawViewModel(vm)
	if vm:GetSubMaterial(0) ~= "color" then -- remove hev
		vm:SetSubMaterial(0, "color")
	end
end

