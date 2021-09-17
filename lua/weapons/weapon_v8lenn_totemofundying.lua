-- "lua\\weapons\\weapon_v8lenn_totemofundying.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
> Nah needs to be fixed rofl so we're gonna screw the code up right here just by adding this single one damn stupid ass line.

//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Totem Of Undying"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end


SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "When this weapon is equipped. you shall not die and therefore you are immortal, if this weapon is not equipped. you will be mortal"
SWEP.Instructions            = "Equip it. and you will become immortal!"

SWEP.ViewModel = "models/hunter/blocks/cube025x025x025.mdl" 
SWEP.WorldModel = "models/hunter/blocks/cube025x025x025.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
  
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 

function SWEP:PrimaryAttack()
self.Owner:SetHealth("100000000")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end



-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize() 
     self.Owner:EmitSound("ambient/weather/thunder1.wav")
     self:SetHoldType( "fist" );
     self.Owner:ChatPrint("You obtained the totem of undying!")
end


function SWEP:Deploy() 
     self.Owner:ChatPrint("You have the totem of undying in your hands. you cannot die now until you stop using it.")
     self:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetMaterial("models/shiny")
     timer.Simple(0.05, function()self.Owner:ConCommand("+attack") end)
     timer.Simple(0.1, function()self.Owner:ConCommand("-attack") end)
end

function SWEP:Holster() 
     self.Owner:SetHealth("100")
     self.Owner:ChatPrint("You no longer have the totem of undying in your hands. you are vulnerable to death")
     self.Owner:SetMaterial("")
     self:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- "lua\\weapons\\weapon_v8lenn_totemofundying.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
> Nah needs to be fixed rofl so we're gonna screw the code up right here just by adding this single one damn stupid ass line.

//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Totem Of Undying"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end


SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "When this weapon is equipped. you shall not die and therefore you are immortal, if this weapon is not equipped. you will be mortal"
SWEP.Instructions            = "Equip it. and you will become immortal!"

SWEP.ViewModel = "models/hunter/blocks/cube025x025x025.mdl" 
SWEP.WorldModel = "models/hunter/blocks/cube025x025x025.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
  
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 

function SWEP:PrimaryAttack()
self.Owner:SetHealth("100000000")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end



-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize() 
     self.Owner:EmitSound("ambient/weather/thunder1.wav")
     self:SetHoldType( "fist" );
     self.Owner:ChatPrint("You obtained the totem of undying!")
end


function SWEP:Deploy() 
     self.Owner:ChatPrint("You have the totem of undying in your hands. you cannot die now until you stop using it.")
     self:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetMaterial("models/shiny")
     timer.Simple(0.05, function()self.Owner:ConCommand("+attack") end)
     timer.Simple(0.1, function()self.Owner:ConCommand("-attack") end)
end

function SWEP:Holster() 
     self.Owner:SetHealth("100")
     self.Owner:ChatPrint("You no longer have the totem of undying in your hands. you are vulnerable to death")
     self.Owner:SetMaterial("")
     self:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- "lua\\weapons\\weapon_v8lenn_totemofundying.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
> Nah needs to be fixed rofl so we're gonna screw the code up right here just by adding this single one damn stupid ass line.

//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Totem Of Undying"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end


SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "When this weapon is equipped. you shall not die and therefore you are immortal, if this weapon is not equipped. you will be mortal"
SWEP.Instructions            = "Equip it. and you will become immortal!"

SWEP.ViewModel = "models/hunter/blocks/cube025x025x025.mdl" 
SWEP.WorldModel = "models/hunter/blocks/cube025x025x025.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
  
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 

function SWEP:PrimaryAttack()
self.Owner:SetHealth("100000000")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end



-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize() 
     self.Owner:EmitSound("ambient/weather/thunder1.wav")
     self:SetHoldType( "fist" );
     self.Owner:ChatPrint("You obtained the totem of undying!")
end


function SWEP:Deploy() 
     self.Owner:ChatPrint("You have the totem of undying in your hands. you cannot die now until you stop using it.")
     self:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetMaterial("models/shiny")
     timer.Simple(0.05, function()self.Owner:ConCommand("+attack") end)
     timer.Simple(0.1, function()self.Owner:ConCommand("-attack") end)
end

function SWEP:Holster() 
     self.Owner:SetHealth("100")
     self.Owner:ChatPrint("You no longer have the totem of undying in your hands. you are vulnerable to death")
     self.Owner:SetMaterial("")
     self:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- "lua\\weapons\\weapon_v8lenn_totemofundying.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
> Nah needs to be fixed rofl so we're gonna screw the code up right here just by adding this single one damn stupid ass line.

//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Totem Of Undying"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end


SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "When this weapon is equipped. you shall not die and therefore you are immortal, if this weapon is not equipped. you will be mortal"
SWEP.Instructions            = "Equip it. and you will become immortal!"

SWEP.ViewModel = "models/hunter/blocks/cube025x025x025.mdl" 
SWEP.WorldModel = "models/hunter/blocks/cube025x025x025.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
  
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 

function SWEP:PrimaryAttack()
self.Owner:SetHealth("100000000")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end



-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize() 
     self.Owner:EmitSound("ambient/weather/thunder1.wav")
     self:SetHoldType( "fist" );
     self.Owner:ChatPrint("You obtained the totem of undying!")
end


function SWEP:Deploy() 
     self.Owner:ChatPrint("You have the totem of undying in your hands. you cannot die now until you stop using it.")
     self:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetMaterial("models/shiny")
     timer.Simple(0.05, function()self.Owner:ConCommand("+attack") end)
     timer.Simple(0.1, function()self.Owner:ConCommand("-attack") end)
end

function SWEP:Holster() 
     self.Owner:SetHealth("100")
     self.Owner:ChatPrint("You no longer have the totem of undying in your hands. you are vulnerable to death")
     self.Owner:SetMaterial("")
     self:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

-- "lua\\weapons\\weapon_v8lenn_totemofundying.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
> Nah needs to be fixed rofl so we're gonna screw the code up right here just by adding this single one damn stupid ass line.

//General Settings \\ 

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "Smg"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Totem Of Undying"			
	SWEP.Author			= "Created by Lenn"

	SWEP.Slot			= 1
	SWEP.SlotPos			= 1
	SWEP.iconletter			= "f"
	
	local Color_Icon = Color( 255, 80, 0, 128 )

end


SWEP.Base			= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly = false

SWEP.Purpose                = "When this weapon is equipped. you shall not die and therefore you are immortal, if this weapon is not equipped. you will be mortal"
SWEP.Instructions            = "Equip it. and you will become immortal!"

SWEP.ViewModel = "models/hunter/blocks/cube025x025x025.mdl" 
SWEP.WorldModel = "models/hunter/blocks/cube025x025x025.mdl"
SWEP.ViewModelFlip 		= false

SWEP.Weight			= 20
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false


SWEP.HoldType = "pistol" // How the weapon is holding in your hands.  example: Smg Ar2 Pistol 357
 
 
SWEP.Weight = 20 // Chooses the weight of the weapon. how heavy it is
 
SWEP.DrawCrosshair = true // If true then it will show a crosshair. If false then it won't show a crosshair. crosshair = dot on the middle or square
 
SWEP.Category = "Lenn's Weapons (MINECRAFT)" // Category name, used to get it from the weapon list.
  
SWEP.base = "weapon_base" 

SWEP.CSMuzzleFlashes = false

SWEP.UseHands = true

//General settings\\
 

function SWEP:PrimaryAttack()
self.Owner:SetHealth("100000000")
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end



-- When we have the weapon in our hands, we COLOR IT.
function SWEP:Initialize() 
     self.Owner:EmitSound("ambient/weather/thunder1.wav")
     self:SetHoldType( "fist" );
     self.Owner:ChatPrint("You obtained the totem of undying!")
end


function SWEP:Deploy() 
     self.Owner:ChatPrint("You have the totem of undying in your hands. you cannot die now until you stop using it.")
     self:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 191, 0, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetMaterial("models/shiny")
     timer.Simple(0.05, function()self.Owner:ConCommand("+attack") end)
     timer.Simple(0.1, function()self.Owner:ConCommand("-attack") end)
end

function SWEP:Holster() 
     self.Owner:SetHealth("100")
     self.Owner:ChatPrint("You no longer have the totem of undying in your hands. you are vulnerable to death")
     self.Owner:SetMaterial("")
     self:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
     self.Owner:SetColor(Color(255, 255, 255, 255)) -- Paints world model (r, g, b, r = red g = green b = blue, pick a value from 0 to 255 or use the RGB chart)
return true -- So we can switch weapons. duh.
end

