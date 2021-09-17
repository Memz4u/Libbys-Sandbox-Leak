-- "lua\\weapons\\weapon_v2lenn_health_vial_lvl_8.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "Level 8 Vial Spammer";
        SWEP.Slot = 0;
        SWEP.SlotPos = 5;
        SWEP.DrawAmmo = true;
        SWEP.DrawCrosshair = false;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author               = "Created By Lenn"
SWEP.Instructions       = "Press left click to heal your friends, Press right click to heal yourself,"
SWEP.Contact        = ""
SWEP.Purpose        = "We call this the health spammer, That mean's its automatic, Some health vial that gives you only 30 hp, max = 200 and has a delay (0.5 seconds)"
SWEP.Category = "Lenn's Weapon's (Heal)"
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable          = true

SWEP.Sound = Sound( "items/smallmedkit1.wav" );
 
SWEP.NextStrike = 0;

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )

SWEP.Primary.ClipSize      = -1                                   // Size of a clip
SWEP.Primary.DefaultClip        = -1                    // Default number of bullets in a clip
SWEP.Primary.Automatic    = true            // Automatic/Semi Auto
SWEP.Primary.Ammo                     = ""
 
SWEP.Secondary.ClipSize  = -1                    // Size of a clip
SWEP.Secondary.DefaultClip      = -1            // Default number of bullets in a clip
SWEP.Secondary.Automatic        = true    // Automatic/Semi Auto
SWEP.Secondary.Ammo               = ""
 
 
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "melee" );
        
        end
end



function SWEP:Initialize()
     self:SetColor(Color(38, 101, 255, 255)) -- Paints world model
end
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
 
        if( not trace.Entity:IsValid() ) then
               return;
        end
        
        if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
                return;
        end
        
        if( SERVER ) then 
        
                local hp = trace.Entity:Health();
                if( hp >= 200 ) then return; end
                if( hp <= 200 ) then hp = hp + 30 end
                
                self.Owner:EmitSound( self.Sound );

                trace.Entity:SetHealth( hp );
                
        end
 
 
  end
 
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()
 
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
        
        if( SERVER ) then 
        
                local hpp = self.Owner:Health();
                if( hpp >= 200 ) then return; end
                if( hpp <= 200 ) then hpp = hpp + 30 end
                
                self.Owner:EmitSound( self.Sound );
                
                self.Owner:SetHealth( hpp );
                
        end
 
  end

-- "lua\\weapons\\weapon_v2lenn_health_vial_lvl_8.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "Level 8 Vial Spammer";
        SWEP.Slot = 0;
        SWEP.SlotPos = 5;
        SWEP.DrawAmmo = true;
        SWEP.DrawCrosshair = false;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author               = "Created By Lenn"
SWEP.Instructions       = "Press left click to heal your friends, Press right click to heal yourself,"
SWEP.Contact        = ""
SWEP.Purpose        = "We call this the health spammer, That mean's its automatic, Some health vial that gives you only 30 hp, max = 200 and has a delay (0.5 seconds)"
SWEP.Category = "Lenn's Weapon's (Heal)"
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable          = true

SWEP.Sound = Sound( "items/smallmedkit1.wav" );
 
SWEP.NextStrike = 0;

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )

SWEP.Primary.ClipSize      = -1                                   // Size of a clip
SWEP.Primary.DefaultClip        = -1                    // Default number of bullets in a clip
SWEP.Primary.Automatic    = true            // Automatic/Semi Auto
SWEP.Primary.Ammo                     = ""
 
SWEP.Secondary.ClipSize  = -1                    // Size of a clip
SWEP.Secondary.DefaultClip      = -1            // Default number of bullets in a clip
SWEP.Secondary.Automatic        = true    // Automatic/Semi Auto
SWEP.Secondary.Ammo               = ""
 
 
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "melee" );
        
        end
end



function SWEP:Initialize()
     self:SetColor(Color(38, 101, 255, 255)) -- Paints world model
end
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
 
        if( not trace.Entity:IsValid() ) then
               return;
        end
        
        if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
                return;
        end
        
        if( SERVER ) then 
        
                local hp = trace.Entity:Health();
                if( hp >= 200 ) then return; end
                if( hp <= 200 ) then hp = hp + 30 end
                
                self.Owner:EmitSound( self.Sound );

                trace.Entity:SetHealth( hp );
                
        end
 
 
  end
 
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()
 
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
        
        if( SERVER ) then 
        
                local hpp = self.Owner:Health();
                if( hpp >= 200 ) then return; end
                if( hpp <= 200 ) then hpp = hpp + 30 end
                
                self.Owner:EmitSound( self.Sound );
                
                self.Owner:SetHealth( hpp );
                
        end
 
  end

-- "lua\\weapons\\weapon_v2lenn_health_vial_lvl_8.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "Level 8 Vial Spammer";
        SWEP.Slot = 0;
        SWEP.SlotPos = 5;
        SWEP.DrawAmmo = true;
        SWEP.DrawCrosshair = false;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author               = "Created By Lenn"
SWEP.Instructions       = "Press left click to heal your friends, Press right click to heal yourself,"
SWEP.Contact        = ""
SWEP.Purpose        = "We call this the health spammer, That mean's its automatic, Some health vial that gives you only 30 hp, max = 200 and has a delay (0.5 seconds)"
SWEP.Category = "Lenn's Weapon's (Heal)"
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable          = true

SWEP.Sound = Sound( "items/smallmedkit1.wav" );
 
SWEP.NextStrike = 0;

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )

SWEP.Primary.ClipSize      = -1                                   // Size of a clip
SWEP.Primary.DefaultClip        = -1                    // Default number of bullets in a clip
SWEP.Primary.Automatic    = true            // Automatic/Semi Auto
SWEP.Primary.Ammo                     = ""
 
SWEP.Secondary.ClipSize  = -1                    // Size of a clip
SWEP.Secondary.DefaultClip      = -1            // Default number of bullets in a clip
SWEP.Secondary.Automatic        = true    // Automatic/Semi Auto
SWEP.Secondary.Ammo               = ""
 
 
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "melee" );
        
        end
end



function SWEP:Initialize()
     self:SetColor(Color(38, 101, 255, 255)) -- Paints world model
end
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
 
        if( not trace.Entity:IsValid() ) then
               return;
        end
        
        if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
                return;
        end
        
        if( SERVER ) then 
        
                local hp = trace.Entity:Health();
                if( hp >= 200 ) then return; end
                if( hp <= 200 ) then hp = hp + 30 end
                
                self.Owner:EmitSound( self.Sound );

                trace.Entity:SetHealth( hp );
                
        end
 
 
  end
 
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()
 
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
        
        if( SERVER ) then 
        
                local hpp = self.Owner:Health();
                if( hpp >= 200 ) then return; end
                if( hpp <= 200 ) then hpp = hpp + 30 end
                
                self.Owner:EmitSound( self.Sound );
                
                self.Owner:SetHealth( hpp );
                
        end
 
  end

-- "lua\\weapons\\weapon_v2lenn_health_vial_lvl_8.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "Level 8 Vial Spammer";
        SWEP.Slot = 0;
        SWEP.SlotPos = 5;
        SWEP.DrawAmmo = true;
        SWEP.DrawCrosshair = false;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author               = "Created By Lenn"
SWEP.Instructions       = "Press left click to heal your friends, Press right click to heal yourself,"
SWEP.Contact        = ""
SWEP.Purpose        = "We call this the health spammer, That mean's its automatic, Some health vial that gives you only 30 hp, max = 200 and has a delay (0.5 seconds)"
SWEP.Category = "Lenn's Weapon's (Heal)"
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable          = true

SWEP.Sound = Sound( "items/smallmedkit1.wav" );
 
SWEP.NextStrike = 0;

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )

SWEP.Primary.ClipSize      = -1                                   // Size of a clip
SWEP.Primary.DefaultClip        = -1                    // Default number of bullets in a clip
SWEP.Primary.Automatic    = true            // Automatic/Semi Auto
SWEP.Primary.Ammo                     = ""
 
SWEP.Secondary.ClipSize  = -1                    // Size of a clip
SWEP.Secondary.DefaultClip      = -1            // Default number of bullets in a clip
SWEP.Secondary.Automatic        = true    // Automatic/Semi Auto
SWEP.Secondary.Ammo               = ""
 
 
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "melee" );
        
        end
end



function SWEP:Initialize()
     self:SetColor(Color(38, 101, 255, 255)) -- Paints world model
end
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
 
        if( not trace.Entity:IsValid() ) then
               return;
        end
        
        if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
                return;
        end
        
        if( SERVER ) then 
        
                local hp = trace.Entity:Health();
                if( hp >= 200 ) then return; end
                if( hp <= 200 ) then hp = hp + 30 end
                
                self.Owner:EmitSound( self.Sound );

                trace.Entity:SetHealth( hp );
                
        end
 
 
  end
 
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()
 
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
        
        if( SERVER ) then 
        
                local hpp = self.Owner:Health();
                if( hpp >= 200 ) then return; end
                if( hpp <= 200 ) then hpp = hpp + 30 end
                
                self.Owner:EmitSound( self.Sound );
                
                self.Owner:SetHealth( hpp );
                
        end
 
  end

-- "lua\\weapons\\weapon_v2lenn_health_vial_lvl_8.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "Level 8 Vial Spammer";
        SWEP.Slot = 0;
        SWEP.SlotPos = 5;
        SWEP.DrawAmmo = true;
        SWEP.DrawCrosshair = false;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author               = "Created By Lenn"
SWEP.Instructions       = "Press left click to heal your friends, Press right click to heal yourself,"
SWEP.Contact        = ""
SWEP.Purpose        = "We call this the health spammer, That mean's its automatic, Some health vial that gives you only 30 hp, max = 200 and has a delay (0.5 seconds)"
SWEP.Category = "Lenn's Weapon's (Heal)"
 
SWEP.Spawnable      = true
SWEP.AdminSpawnable          = true

SWEP.Sound = Sound( "items/smallmedkit1.wav" );
 
SWEP.NextStrike = 0;

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )

SWEP.Primary.ClipSize      = -1                                   // Size of a clip
SWEP.Primary.DefaultClip        = -1                    // Default number of bullets in a clip
SWEP.Primary.Automatic    = true            // Automatic/Semi Auto
SWEP.Primary.Ammo                     = ""
 
SWEP.Secondary.ClipSize  = -1                    // Size of a clip
SWEP.Secondary.DefaultClip      = -1            // Default number of bullets in a clip
SWEP.Secondary.Automatic        = true    // Automatic/Semi Auto
SWEP.Secondary.Ammo               = ""
 
 
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then
        
                self:SetWeaponHoldType( "melee" );
        
        end
end



function SWEP:Initialize()
     self:SetColor(Color(38, 101, 255, 255)) -- Paints world model
end
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
 
        if( not trace.Entity:IsValid() ) then
               return;
        end
        
        if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
                return;
        end
        
        if( SERVER ) then 
        
                local hp = trace.Entity:Health();
                if( hp >= 200 ) then return; end
                if( hp <= 200 ) then hp = hp + 30 end
                
                self.Owner:EmitSound( self.Sound );

                trace.Entity:SetHealth( hp );
                
        end
 
 
  end
 
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()
 
        if( CurTime() < self.NextStrike ) then return; end
 
        self.NextStrike = ( CurTime() + 0.5 );
        
        if( CLIENT ) then return; end
        
        if( SERVER ) then 
        
                local hpp = self.Owner:Health();
                if( hpp >= 200 ) then return; end
                if( hpp <= 200 ) then hpp = hpp + 30 end
                
                self.Owner:EmitSound( self.Sound );
                
                self.Owner:SetHealth( hpp );
                
        end
 
  end

