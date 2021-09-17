-- "addons\\toyboxstuff\\lua\\entities\\armymaker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "ArmyMaker"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

if SERVER then
    function AM_Respond(ply,v)

        umsg.Start( "ArmyMakerRespond", ply )
                    umsg.String( v )
        umsg.End( )
    end
else
    usermessage.Hook( "ArmyMakerRespond", function( um )
local DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
DermaPanel:SetPos( 50,50 ) -- Position on the players screen
DermaPanel:SetSize( 800, 44 ) -- Size of the frame
DermaPanel:SetTitle(um:ReadString()) -- Title of the frame
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true ) -- Draggable by mouse?
DermaPanel:ShowCloseButton( true ) -- Show the close button?
DermaPanel:MakePopup() -- Show the frame
local myText = vgui.Create("DTextEntry", DermaPanel)
myText:SetPos( 0,22 )            
myText:SetText("")
            myText.OnEnter = function(self) RunConsoleCommand("ArmyMakerInput",myText:GetText()) DermaPanel:Close() end
    end )
end

function ENT:Initialize()

    if ( SERVER ) then
        ArmyMaker_mode=0
        self.Entity:SetModel( "models/props_c17/cashregister01a.mdl" )
        self.Entity:PhysicsInitSphere( 16, "metal_bouncy" )
        self.Entity:SetUseType(SIMPLE_USE)
        self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
      
    end
    
end
function CreateArmy(cn,am)
    local p=0
    local R=3200
        while p<am do
        --This should fix map-specific errors.
    local SpawnPos = Vector( math.random(-R,R), math.random(-R,R),64 )
    
    local ent = ents.Create( cn )
        ent:SetPos( SpawnPos )
    ent:SetKeyValue( "additionalequipment", "weapon_smg1" )
    ent:Spawn()
    ent:Activate()
    p=p+1
    end
end

function ENT:Use(activator, caller)
    AM_Respond(activator,"Army Maker Active-Please type 1 for zombie,2 for Fast Zombie,3 for Combine,or remove me to cancel.")
ArmyMaker_mode=1
end

ArmyMakerTAS={"npc_zombie","npc_fastzombie","npc_combine_s"}
ArmyMakerTBS={"npc_alyx","npc_citizen","npc_barney"}
CreateConVar("ArmyMakerInput", "", {FCVAR_NOTIFY, FCVAR_GAMEDLL})

if (SERVER) then
function AM_Input(ply,old,strText)
    if (strText=="") then return end
    if ArmyMaker_mode==1 then
        ArmyMakerTA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")    
            AM_Respond(ply,"Army Maker Stage 2(allies): Please type 1 for Alyx Army,2 for Citzen Army,or 3 for Barney Army.")
        ArmyMaker_mode=2
        return
    end
    if ArmyMaker_mode==2 then
        ArmyMakerTB=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 3: Now please state the number of units in enemy army.")
        ArmyMaker_mode=3
        return   
    end
    if ArmyMaker_mode==3 then
        ArmyMakerNA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 4: Now please state the number of units in ally army.")
        ArmyMaker_mode=4
        return   
    end        
    if ArmyMaker_mode==4 then
            CreateArmy(ArmyMakerTAS[ArmyMakerTA],ArmyMakerNA)
            CreateArmy(ArmyMakerTBS[ArmyMakerTB],tonumber(strText))
        RunConsoleCommand("ArmyMakerInput","")
            AM_Respond(ply,"Army Maker:If your computer survives to see this,Done!")
        ArmyMaker_mode=0
        return    
    end
end
cvars.AddChangeCallback("ArmyMakerInput", AM_Input)
end

-- "addons\\toyboxstuff\\lua\\entities\\armymaker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "ArmyMaker"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

if SERVER then
    function AM_Respond(ply,v)

        umsg.Start( "ArmyMakerRespond", ply )
                    umsg.String( v )
        umsg.End( )
    end
else
    usermessage.Hook( "ArmyMakerRespond", function( um )
local DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
DermaPanel:SetPos( 50,50 ) -- Position on the players screen
DermaPanel:SetSize( 800, 44 ) -- Size of the frame
DermaPanel:SetTitle(um:ReadString()) -- Title of the frame
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true ) -- Draggable by mouse?
DermaPanel:ShowCloseButton( true ) -- Show the close button?
DermaPanel:MakePopup() -- Show the frame
local myText = vgui.Create("DTextEntry", DermaPanel)
myText:SetPos( 0,22 )            
myText:SetText("")
            myText.OnEnter = function(self) RunConsoleCommand("ArmyMakerInput",myText:GetText()) DermaPanel:Close() end
    end )
end

function ENT:Initialize()

    if ( SERVER ) then
        ArmyMaker_mode=0
        self.Entity:SetModel( "models/props_c17/cashregister01a.mdl" )
        self.Entity:PhysicsInitSphere( 16, "metal_bouncy" )
        self.Entity:SetUseType(SIMPLE_USE)
        self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
      
    end
    
end
function CreateArmy(cn,am)
    local p=0
    local R=3200
        while p<am do
        --This should fix map-specific errors.
    local SpawnPos = Vector( math.random(-R,R), math.random(-R,R),64 )
    
    local ent = ents.Create( cn )
        ent:SetPos( SpawnPos )
    ent:SetKeyValue( "additionalequipment", "weapon_smg1" )
    ent:Spawn()
    ent:Activate()
    p=p+1
    end
end

function ENT:Use(activator, caller)
    AM_Respond(activator,"Army Maker Active-Please type 1 for zombie,2 for Fast Zombie,3 for Combine,or remove me to cancel.")
ArmyMaker_mode=1
end

ArmyMakerTAS={"npc_zombie","npc_fastzombie","npc_combine_s"}
ArmyMakerTBS={"npc_alyx","npc_citizen","npc_barney"}
CreateConVar("ArmyMakerInput", "", {FCVAR_NOTIFY, FCVAR_GAMEDLL})

if (SERVER) then
function AM_Input(ply,old,strText)
    if (strText=="") then return end
    if ArmyMaker_mode==1 then
        ArmyMakerTA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")    
            AM_Respond(ply,"Army Maker Stage 2(allies): Please type 1 for Alyx Army,2 for Citzen Army,or 3 for Barney Army.")
        ArmyMaker_mode=2
        return
    end
    if ArmyMaker_mode==2 then
        ArmyMakerTB=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 3: Now please state the number of units in enemy army.")
        ArmyMaker_mode=3
        return   
    end
    if ArmyMaker_mode==3 then
        ArmyMakerNA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 4: Now please state the number of units in ally army.")
        ArmyMaker_mode=4
        return   
    end        
    if ArmyMaker_mode==4 then
            CreateArmy(ArmyMakerTAS[ArmyMakerTA],ArmyMakerNA)
            CreateArmy(ArmyMakerTBS[ArmyMakerTB],tonumber(strText))
        RunConsoleCommand("ArmyMakerInput","")
            AM_Respond(ply,"Army Maker:If your computer survives to see this,Done!")
        ArmyMaker_mode=0
        return    
    end
end
cvars.AddChangeCallback("ArmyMakerInput", AM_Input)
end

-- "addons\\toyboxstuff\\lua\\entities\\armymaker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "ArmyMaker"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

if SERVER then
    function AM_Respond(ply,v)

        umsg.Start( "ArmyMakerRespond", ply )
                    umsg.String( v )
        umsg.End( )
    end
else
    usermessage.Hook( "ArmyMakerRespond", function( um )
local DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
DermaPanel:SetPos( 50,50 ) -- Position on the players screen
DermaPanel:SetSize( 800, 44 ) -- Size of the frame
DermaPanel:SetTitle(um:ReadString()) -- Title of the frame
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true ) -- Draggable by mouse?
DermaPanel:ShowCloseButton( true ) -- Show the close button?
DermaPanel:MakePopup() -- Show the frame
local myText = vgui.Create("DTextEntry", DermaPanel)
myText:SetPos( 0,22 )            
myText:SetText("")
            myText.OnEnter = function(self) RunConsoleCommand("ArmyMakerInput",myText:GetText()) DermaPanel:Close() end
    end )
end

function ENT:Initialize()

    if ( SERVER ) then
        ArmyMaker_mode=0
        self.Entity:SetModel( "models/props_c17/cashregister01a.mdl" )
        self.Entity:PhysicsInitSphere( 16, "metal_bouncy" )
        self.Entity:SetUseType(SIMPLE_USE)
        self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
      
    end
    
end
function CreateArmy(cn,am)
    local p=0
    local R=3200
        while p<am do
        --This should fix map-specific errors.
    local SpawnPos = Vector( math.random(-R,R), math.random(-R,R),64 )
    
    local ent = ents.Create( cn )
        ent:SetPos( SpawnPos )
    ent:SetKeyValue( "additionalequipment", "weapon_smg1" )
    ent:Spawn()
    ent:Activate()
    p=p+1
    end
end

function ENT:Use(activator, caller)
    AM_Respond(activator,"Army Maker Active-Please type 1 for zombie,2 for Fast Zombie,3 for Combine,or remove me to cancel.")
ArmyMaker_mode=1
end

ArmyMakerTAS={"npc_zombie","npc_fastzombie","npc_combine_s"}
ArmyMakerTBS={"npc_alyx","npc_citizen","npc_barney"}
CreateConVar("ArmyMakerInput", "", {FCVAR_NOTIFY, FCVAR_GAMEDLL})

if (SERVER) then
function AM_Input(ply,old,strText)
    if (strText=="") then return end
    if ArmyMaker_mode==1 then
        ArmyMakerTA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")    
            AM_Respond(ply,"Army Maker Stage 2(allies): Please type 1 for Alyx Army,2 for Citzen Army,or 3 for Barney Army.")
        ArmyMaker_mode=2
        return
    end
    if ArmyMaker_mode==2 then
        ArmyMakerTB=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 3: Now please state the number of units in enemy army.")
        ArmyMaker_mode=3
        return   
    end
    if ArmyMaker_mode==3 then
        ArmyMakerNA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 4: Now please state the number of units in ally army.")
        ArmyMaker_mode=4
        return   
    end        
    if ArmyMaker_mode==4 then
            CreateArmy(ArmyMakerTAS[ArmyMakerTA],ArmyMakerNA)
            CreateArmy(ArmyMakerTBS[ArmyMakerTB],tonumber(strText))
        RunConsoleCommand("ArmyMakerInput","")
            AM_Respond(ply,"Army Maker:If your computer survives to see this,Done!")
        ArmyMaker_mode=0
        return    
    end
end
cvars.AddChangeCallback("ArmyMakerInput", AM_Input)
end

-- "addons\\toyboxstuff\\lua\\entities\\armymaker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "ArmyMaker"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

if SERVER then
    function AM_Respond(ply,v)

        umsg.Start( "ArmyMakerRespond", ply )
                    umsg.String( v )
        umsg.End( )
    end
else
    usermessage.Hook( "ArmyMakerRespond", function( um )
local DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
DermaPanel:SetPos( 50,50 ) -- Position on the players screen
DermaPanel:SetSize( 800, 44 ) -- Size of the frame
DermaPanel:SetTitle(um:ReadString()) -- Title of the frame
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true ) -- Draggable by mouse?
DermaPanel:ShowCloseButton( true ) -- Show the close button?
DermaPanel:MakePopup() -- Show the frame
local myText = vgui.Create("DTextEntry", DermaPanel)
myText:SetPos( 0,22 )            
myText:SetText("")
            myText.OnEnter = function(self) RunConsoleCommand("ArmyMakerInput",myText:GetText()) DermaPanel:Close() end
    end )
end

function ENT:Initialize()

    if ( SERVER ) then
        ArmyMaker_mode=0
        self.Entity:SetModel( "models/props_c17/cashregister01a.mdl" )
        self.Entity:PhysicsInitSphere( 16, "metal_bouncy" )
        self.Entity:SetUseType(SIMPLE_USE)
        self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
      
    end
    
end
function CreateArmy(cn,am)
    local p=0
    local R=3200
        while p<am do
        --This should fix map-specific errors.
    local SpawnPos = Vector( math.random(-R,R), math.random(-R,R),64 )
    
    local ent = ents.Create( cn )
        ent:SetPos( SpawnPos )
    ent:SetKeyValue( "additionalequipment", "weapon_smg1" )
    ent:Spawn()
    ent:Activate()
    p=p+1
    end
end

function ENT:Use(activator, caller)
    AM_Respond(activator,"Army Maker Active-Please type 1 for zombie,2 for Fast Zombie,3 for Combine,or remove me to cancel.")
ArmyMaker_mode=1
end

ArmyMakerTAS={"npc_zombie","npc_fastzombie","npc_combine_s"}
ArmyMakerTBS={"npc_alyx","npc_citizen","npc_barney"}
CreateConVar("ArmyMakerInput", "", {FCVAR_NOTIFY, FCVAR_GAMEDLL})

if (SERVER) then
function AM_Input(ply,old,strText)
    if (strText=="") then return end
    if ArmyMaker_mode==1 then
        ArmyMakerTA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")    
            AM_Respond(ply,"Army Maker Stage 2(allies): Please type 1 for Alyx Army,2 for Citzen Army,or 3 for Barney Army.")
        ArmyMaker_mode=2
        return
    end
    if ArmyMaker_mode==2 then
        ArmyMakerTB=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 3: Now please state the number of units in enemy army.")
        ArmyMaker_mode=3
        return   
    end
    if ArmyMaker_mode==3 then
        ArmyMakerNA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 4: Now please state the number of units in ally army.")
        ArmyMaker_mode=4
        return   
    end        
    if ArmyMaker_mode==4 then
            CreateArmy(ArmyMakerTAS[ArmyMakerTA],ArmyMakerNA)
            CreateArmy(ArmyMakerTBS[ArmyMakerTB],tonumber(strText))
        RunConsoleCommand("ArmyMakerInput","")
            AM_Respond(ply,"Army Maker:If your computer survives to see this,Done!")
        ArmyMaker_mode=0
        return    
    end
end
cvars.AddChangeCallback("ArmyMakerInput", AM_Input)
end

-- "addons\\toyboxstuff\\lua\\entities\\armymaker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "Toybox Classics"
ENT.PrintName           = "ArmyMaker"
ENT.RenderGroup         = RENDERGROUP_TRANSLUCENT

if SERVER then
    function AM_Respond(ply,v)

        umsg.Start( "ArmyMakerRespond", ply )
                    umsg.String( v )
        umsg.End( )
    end
else
    usermessage.Hook( "ArmyMakerRespond", function( um )
local DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself
DermaPanel:SetPos( 50,50 ) -- Position on the players screen
DermaPanel:SetSize( 800, 44 ) -- Size of the frame
DermaPanel:SetTitle(um:ReadString()) -- Title of the frame
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true ) -- Draggable by mouse?
DermaPanel:ShowCloseButton( true ) -- Show the close button?
DermaPanel:MakePopup() -- Show the frame
local myText = vgui.Create("DTextEntry", DermaPanel)
myText:SetPos( 0,22 )            
myText:SetText("")
            myText.OnEnter = function(self) RunConsoleCommand("ArmyMakerInput",myText:GetText()) DermaPanel:Close() end
    end )
end

function ENT:Initialize()

    if ( SERVER ) then
        ArmyMaker_mode=0
        self.Entity:SetModel( "models/props_c17/cashregister01a.mdl" )
        self.Entity:PhysicsInitSphere( 16, "metal_bouncy" )
        self.Entity:SetUseType(SIMPLE_USE)
        self.Entity:SetCollisionBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) )
      
    end
    
end
function CreateArmy(cn,am)
    local p=0
    local R=3200
        while p<am do
        --This should fix map-specific errors.
    local SpawnPos = Vector( math.random(-R,R), math.random(-R,R),64 )
    
    local ent = ents.Create( cn )
        ent:SetPos( SpawnPos )
    ent:SetKeyValue( "additionalequipment", "weapon_smg1" )
    ent:Spawn()
    ent:Activate()
    p=p+1
    end
end

function ENT:Use(activator, caller)
    AM_Respond(activator,"Army Maker Active-Please type 1 for zombie,2 for Fast Zombie,3 for Combine,or remove me to cancel.")
ArmyMaker_mode=1
end

ArmyMakerTAS={"npc_zombie","npc_fastzombie","npc_combine_s"}
ArmyMakerTBS={"npc_alyx","npc_citizen","npc_barney"}
CreateConVar("ArmyMakerInput", "", {FCVAR_NOTIFY, FCVAR_GAMEDLL})

if (SERVER) then
function AM_Input(ply,old,strText)
    if (strText=="") then return end
    if ArmyMaker_mode==1 then
        ArmyMakerTA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")    
            AM_Respond(ply,"Army Maker Stage 2(allies): Please type 1 for Alyx Army,2 for Citzen Army,or 3 for Barney Army.")
        ArmyMaker_mode=2
        return
    end
    if ArmyMaker_mode==2 then
        ArmyMakerTB=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 3: Now please state the number of units in enemy army.")
        ArmyMaker_mode=3
        return   
    end
    if ArmyMaker_mode==3 then
        ArmyMakerNA=tonumber(strText)
        RunConsoleCommand("ArmyMakerInput","")  
            AM_Respond(ply,"Army Maker Stage 4: Now please state the number of units in ally army.")
        ArmyMaker_mode=4
        return   
    end        
    if ArmyMaker_mode==4 then
            CreateArmy(ArmyMakerTAS[ArmyMakerTA],ArmyMakerNA)
            CreateArmy(ArmyMakerTBS[ArmyMakerTB],tonumber(strText))
        RunConsoleCommand("ArmyMakerInput","")
            AM_Respond(ply,"Army Maker:If your computer survives to see this,Done!")
        ArmyMaker_mode=0
        return    
    end
end
cvars.AddChangeCallback("ArmyMakerInput", AM_Input)
end

