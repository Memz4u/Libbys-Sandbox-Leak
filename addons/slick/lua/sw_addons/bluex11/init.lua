-- "addons\\slick\\lua\\sw_addons\\bluex11\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Ang0 = Angle()
local Category = "SligWolf's Vehicles"
local Veh_Class = "prop_vehicle_jeep"
local Author = "SligWolf"
local NiceName = "BlueX11"

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

SW_ADDON.NetworkaddonID = "SW_"..SW_ADDON.Addonname
SW_ADDON.Category = Category 
SW_ADDON.Author = Author 
SW_ADDON.NiceName = NiceName 



local V = { 	
	Name = "Blue-X11", 
	Class = Veh_Class,
	Category = Category,
	Author = Author,
	Information = "Blue-x11 made by SligWolf",
	Model = "models/sligwolf/blue-x11/blue-x11.mdl",
	
	SW_Values_BlueX11 = {},
	
	SW_BlueX11_Cams = {
		C1 = {},
		C2 = {},
		C3 = {},
		C4 = {},
	},

	KeyValues = {
		vehiclescript = "scripts/vehicles/sligwolf/sw_blue-x11.txt",
	},
}
list.Set( "Vehicles", "sw_blue-x11_blue", V )



function SW_ADDON:Spawn(ply, vehicle)

if !vehicle.VehicleTable then return end

local Col = Color(2,25,37,255)

if istable(vehicle.VehicleTable.SW_Values_BlueX11) then	
	self:AddToEntList("BlueX11", vehicle)
	vehicle.__IsSW_BlueX11 = true
	vehicle:SetSkin(self:GetVal(vehicle, "Skin", 0))
	vehicle:SetColor(self:GetVal(vehicle, "Color", Col))
	
	self:SetupDupeModifier(vehicle, "SW_BX12", function(f_ent)
		self:SetVal(f_ent, "Skin", f_ent:GetSkin())
		self:SetVal(f_ent, "Color", f_ent:GetColor())
	end, function(f_ent)
		f_ent:SetSkin(self:GetVal(f_ent, "Skin", 0))
		f_ent:SetColor(self:GetVal(f_ent, "Color", Col))
	end)
end

if istable(vehicle.VehicleTable.SW_BlueX11_Cams) then	
	local Ents = vehicle.VehicleTable.SW_BlueX11_Cams

	for k,v in pairs(Ents) do
		local Ent = self:MakeEnt( "prop_physics", ply, vehicle, "Cams_"..k )
		if !IsValid(Ent) then continue end
			
		Ent:SetModel( "models/sligwolf/unique_props/sw_cube_1x1x1.mdl" )
		
		if !self:SetEntAngPosViaAttachment(vehicle, Ent, tostring(k)) then
			self:RemoveEntites({vehicle, Ent})
			return
		end
		
		self:SetupChildEntity( Ent, vehicle, COLLISION_GROUP_IN_VEHICLE )
		Ent:DrawShadow( false )
		Ent:SetSolid( SOLID_NONE )
		Ent.__SW_Blockedprop = true
	end
end

end



if SERVER then

function SW_ADDON:Think()
	self:ForEachInEntList("BlueX11", function(addon, index, ent)
		if !ent.__IsSW_BlueX11 then return end
		self:ThinkPerEnt(ent)		
	end)
end

function SW_ADDON:ThinkPerEnt(ent)

	local ply = ent:GetDriver()
	if !IsValid(ply) then return end
	if !ply:InVehicle() then return end
	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local dir_rgt = self:DirToLocalToWorld(ent, Ang0, "Right")
	local dir_up = self:DirToLocalToWorld(ent, Ang0, "Up")
	
	if ply:KeyDown( IN_SPEED ) then
		phys:ApplyForceCenter( dir_rgt*-15500 - dir_up*5000 )
	end
	
	if ply.__SW_Cam_Mode then
		self:ForEachFilteredChild(ent, "^Cams_", function(f_ent, index, k, v)
			if !IsValid(v) then return end
			v:SetAngles(ply:EyeAngles())
		end)
	end
end

end



function SW_ADDON:Enter( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end

function SW_ADDON:Leave( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end



SW_ADDON:RegisterVehicleOrder("Cam_01", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C3")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_01", KEY_PAD_1, 0.25, "Extra Camera Left", "")

SW_ADDON:RegisterVehicleOrder("Cam_02", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C4")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_02", KEY_PAD_2, 0.25, "Extra Camera Front", "")

SW_ADDON:RegisterVehicleOrder("Cam_03", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C1")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_03", KEY_PAD_3, 0.25, "Extra Camera Right", "")

SW_ADDON:RegisterVehicleOrder("Cam_04", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C2")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_04", KEY_PAD_4, 0.25, "Extra Camera Back", "")

-- "addons\\slick\\lua\\sw_addons\\bluex11\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Ang0 = Angle()
local Category = "SligWolf's Vehicles"
local Veh_Class = "prop_vehicle_jeep"
local Author = "SligWolf"
local NiceName = "BlueX11"

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

SW_ADDON.NetworkaddonID = "SW_"..SW_ADDON.Addonname
SW_ADDON.Category = Category 
SW_ADDON.Author = Author 
SW_ADDON.NiceName = NiceName 



local V = { 	
	Name = "Blue-X11", 
	Class = Veh_Class,
	Category = Category,
	Author = Author,
	Information = "Blue-x11 made by SligWolf",
	Model = "models/sligwolf/blue-x11/blue-x11.mdl",
	
	SW_Values_BlueX11 = {},
	
	SW_BlueX11_Cams = {
		C1 = {},
		C2 = {},
		C3 = {},
		C4 = {},
	},

	KeyValues = {
		vehiclescript = "scripts/vehicles/sligwolf/sw_blue-x11.txt",
	},
}
list.Set( "Vehicles", "sw_blue-x11_blue", V )



function SW_ADDON:Spawn(ply, vehicle)

if !vehicle.VehicleTable then return end

local Col = Color(2,25,37,255)

if istable(vehicle.VehicleTable.SW_Values_BlueX11) then	
	self:AddToEntList("BlueX11", vehicle)
	vehicle.__IsSW_BlueX11 = true
	vehicle:SetSkin(self:GetVal(vehicle, "Skin", 0))
	vehicle:SetColor(self:GetVal(vehicle, "Color", Col))
	
	self:SetupDupeModifier(vehicle, "SW_BX12", function(f_ent)
		self:SetVal(f_ent, "Skin", f_ent:GetSkin())
		self:SetVal(f_ent, "Color", f_ent:GetColor())
	end, function(f_ent)
		f_ent:SetSkin(self:GetVal(f_ent, "Skin", 0))
		f_ent:SetColor(self:GetVal(f_ent, "Color", Col))
	end)
end

if istable(vehicle.VehicleTable.SW_BlueX11_Cams) then	
	local Ents = vehicle.VehicleTable.SW_BlueX11_Cams

	for k,v in pairs(Ents) do
		local Ent = self:MakeEnt( "prop_physics", ply, vehicle, "Cams_"..k )
		if !IsValid(Ent) then continue end
			
		Ent:SetModel( "models/sligwolf/unique_props/sw_cube_1x1x1.mdl" )
		
		if !self:SetEntAngPosViaAttachment(vehicle, Ent, tostring(k)) then
			self:RemoveEntites({vehicle, Ent})
			return
		end
		
		self:SetupChildEntity( Ent, vehicle, COLLISION_GROUP_IN_VEHICLE )
		Ent:DrawShadow( false )
		Ent:SetSolid( SOLID_NONE )
		Ent.__SW_Blockedprop = true
	end
end

end



if SERVER then

function SW_ADDON:Think()
	self:ForEachInEntList("BlueX11", function(addon, index, ent)
		if !ent.__IsSW_BlueX11 then return end
		self:ThinkPerEnt(ent)		
	end)
end

function SW_ADDON:ThinkPerEnt(ent)

	local ply = ent:GetDriver()
	if !IsValid(ply) then return end
	if !ply:InVehicle() then return end
	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local dir_rgt = self:DirToLocalToWorld(ent, Ang0, "Right")
	local dir_up = self:DirToLocalToWorld(ent, Ang0, "Up")
	
	if ply:KeyDown( IN_SPEED ) then
		phys:ApplyForceCenter( dir_rgt*-15500 - dir_up*5000 )
	end
	
	if ply.__SW_Cam_Mode then
		self:ForEachFilteredChild(ent, "^Cams_", function(f_ent, index, k, v)
			if !IsValid(v) then return end
			v:SetAngles(ply:EyeAngles())
		end)
	end
end

end



function SW_ADDON:Enter( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end

function SW_ADDON:Leave( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end



SW_ADDON:RegisterVehicleOrder("Cam_01", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C3")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_01", KEY_PAD_1, 0.25, "Extra Camera Left", "")

SW_ADDON:RegisterVehicleOrder("Cam_02", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C4")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_02", KEY_PAD_2, 0.25, "Extra Camera Front", "")

SW_ADDON:RegisterVehicleOrder("Cam_03", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C1")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_03", KEY_PAD_3, 0.25, "Extra Camera Right", "")

SW_ADDON:RegisterVehicleOrder("Cam_04", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C2")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_04", KEY_PAD_4, 0.25, "Extra Camera Back", "")

-- "addons\\slick\\lua\\sw_addons\\bluex11\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Ang0 = Angle()
local Category = "SligWolf's Vehicles"
local Veh_Class = "prop_vehicle_jeep"
local Author = "SligWolf"
local NiceName = "BlueX11"

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

SW_ADDON.NetworkaddonID = "SW_"..SW_ADDON.Addonname
SW_ADDON.Category = Category 
SW_ADDON.Author = Author 
SW_ADDON.NiceName = NiceName 



local V = { 	
	Name = "Blue-X11", 
	Class = Veh_Class,
	Category = Category,
	Author = Author,
	Information = "Blue-x11 made by SligWolf",
	Model = "models/sligwolf/blue-x11/blue-x11.mdl",
	
	SW_Values_BlueX11 = {},
	
	SW_BlueX11_Cams = {
		C1 = {},
		C2 = {},
		C3 = {},
		C4 = {},
	},

	KeyValues = {
		vehiclescript = "scripts/vehicles/sligwolf/sw_blue-x11.txt",
	},
}
list.Set( "Vehicles", "sw_blue-x11_blue", V )



function SW_ADDON:Spawn(ply, vehicle)

if !vehicle.VehicleTable then return end

local Col = Color(2,25,37,255)

if istable(vehicle.VehicleTable.SW_Values_BlueX11) then	
	self:AddToEntList("BlueX11", vehicle)
	vehicle.__IsSW_BlueX11 = true
	vehicle:SetSkin(self:GetVal(vehicle, "Skin", 0))
	vehicle:SetColor(self:GetVal(vehicle, "Color", Col))
	
	self:SetupDupeModifier(vehicle, "SW_BX12", function(f_ent)
		self:SetVal(f_ent, "Skin", f_ent:GetSkin())
		self:SetVal(f_ent, "Color", f_ent:GetColor())
	end, function(f_ent)
		f_ent:SetSkin(self:GetVal(f_ent, "Skin", 0))
		f_ent:SetColor(self:GetVal(f_ent, "Color", Col))
	end)
end

if istable(vehicle.VehicleTable.SW_BlueX11_Cams) then	
	local Ents = vehicle.VehicleTable.SW_BlueX11_Cams

	for k,v in pairs(Ents) do
		local Ent = self:MakeEnt( "prop_physics", ply, vehicle, "Cams_"..k )
		if !IsValid(Ent) then continue end
			
		Ent:SetModel( "models/sligwolf/unique_props/sw_cube_1x1x1.mdl" )
		
		if !self:SetEntAngPosViaAttachment(vehicle, Ent, tostring(k)) then
			self:RemoveEntites({vehicle, Ent})
			return
		end
		
		self:SetupChildEntity( Ent, vehicle, COLLISION_GROUP_IN_VEHICLE )
		Ent:DrawShadow( false )
		Ent:SetSolid( SOLID_NONE )
		Ent.__SW_Blockedprop = true
	end
end

end



if SERVER then

function SW_ADDON:Think()
	self:ForEachInEntList("BlueX11", function(addon, index, ent)
		if !ent.__IsSW_BlueX11 then return end
		self:ThinkPerEnt(ent)		
	end)
end

function SW_ADDON:ThinkPerEnt(ent)

	local ply = ent:GetDriver()
	if !IsValid(ply) then return end
	if !ply:InVehicle() then return end
	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local dir_rgt = self:DirToLocalToWorld(ent, Ang0, "Right")
	local dir_up = self:DirToLocalToWorld(ent, Ang0, "Up")
	
	if ply:KeyDown( IN_SPEED ) then
		phys:ApplyForceCenter( dir_rgt*-15500 - dir_up*5000 )
	end
	
	if ply.__SW_Cam_Mode then
		self:ForEachFilteredChild(ent, "^Cams_", function(f_ent, index, k, v)
			if !IsValid(v) then return end
			v:SetAngles(ply:EyeAngles())
		end)
	end
end

end



function SW_ADDON:Enter( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end

function SW_ADDON:Leave( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end



SW_ADDON:RegisterVehicleOrder("Cam_01", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C3")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_01", KEY_PAD_1, 0.25, "Extra Camera Left", "")

SW_ADDON:RegisterVehicleOrder("Cam_02", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C4")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_02", KEY_PAD_2, 0.25, "Extra Camera Front", "")

SW_ADDON:RegisterVehicleOrder("Cam_03", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C1")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_03", KEY_PAD_3, 0.25, "Extra Camera Right", "")

SW_ADDON:RegisterVehicleOrder("Cam_04", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C2")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_04", KEY_PAD_4, 0.25, "Extra Camera Back", "")

-- "addons\\slick\\lua\\sw_addons\\bluex11\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Ang0 = Angle()
local Category = "SligWolf's Vehicles"
local Veh_Class = "prop_vehicle_jeep"
local Author = "SligWolf"
local NiceName = "BlueX11"

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

SW_ADDON.NetworkaddonID = "SW_"..SW_ADDON.Addonname
SW_ADDON.Category = Category 
SW_ADDON.Author = Author 
SW_ADDON.NiceName = NiceName 



local V = { 	
	Name = "Blue-X11", 
	Class = Veh_Class,
	Category = Category,
	Author = Author,
	Information = "Blue-x11 made by SligWolf",
	Model = "models/sligwolf/blue-x11/blue-x11.mdl",
	
	SW_Values_BlueX11 = {},
	
	SW_BlueX11_Cams = {
		C1 = {},
		C2 = {},
		C3 = {},
		C4 = {},
	},

	KeyValues = {
		vehiclescript = "scripts/vehicles/sligwolf/sw_blue-x11.txt",
	},
}
list.Set( "Vehicles", "sw_blue-x11_blue", V )



function SW_ADDON:Spawn(ply, vehicle)

if !vehicle.VehicleTable then return end

local Col = Color(2,25,37,255)

if istable(vehicle.VehicleTable.SW_Values_BlueX11) then	
	self:AddToEntList("BlueX11", vehicle)
	vehicle.__IsSW_BlueX11 = true
	vehicle:SetSkin(self:GetVal(vehicle, "Skin", 0))
	vehicle:SetColor(self:GetVal(vehicle, "Color", Col))
	
	self:SetupDupeModifier(vehicle, "SW_BX12", function(f_ent)
		self:SetVal(f_ent, "Skin", f_ent:GetSkin())
		self:SetVal(f_ent, "Color", f_ent:GetColor())
	end, function(f_ent)
		f_ent:SetSkin(self:GetVal(f_ent, "Skin", 0))
		f_ent:SetColor(self:GetVal(f_ent, "Color", Col))
	end)
end

if istable(vehicle.VehicleTable.SW_BlueX11_Cams) then	
	local Ents = vehicle.VehicleTable.SW_BlueX11_Cams

	for k,v in pairs(Ents) do
		local Ent = self:MakeEnt( "prop_physics", ply, vehicle, "Cams_"..k )
		if !IsValid(Ent) then continue end
			
		Ent:SetModel( "models/sligwolf/unique_props/sw_cube_1x1x1.mdl" )
		
		if !self:SetEntAngPosViaAttachment(vehicle, Ent, tostring(k)) then
			self:RemoveEntites({vehicle, Ent})
			return
		end
		
		self:SetupChildEntity( Ent, vehicle, COLLISION_GROUP_IN_VEHICLE )
		Ent:DrawShadow( false )
		Ent:SetSolid( SOLID_NONE )
		Ent.__SW_Blockedprop = true
	end
end

end



if SERVER then

function SW_ADDON:Think()
	self:ForEachInEntList("BlueX11", function(addon, index, ent)
		if !ent.__IsSW_BlueX11 then return end
		self:ThinkPerEnt(ent)		
	end)
end

function SW_ADDON:ThinkPerEnt(ent)

	local ply = ent:GetDriver()
	if !IsValid(ply) then return end
	if !ply:InVehicle() then return end
	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local dir_rgt = self:DirToLocalToWorld(ent, Ang0, "Right")
	local dir_up = self:DirToLocalToWorld(ent, Ang0, "Up")
	
	if ply:KeyDown( IN_SPEED ) then
		phys:ApplyForceCenter( dir_rgt*-15500 - dir_up*5000 )
	end
	
	if ply.__SW_Cam_Mode then
		self:ForEachFilteredChild(ent, "^Cams_", function(f_ent, index, k, v)
			if !IsValid(v) then return end
			v:SetAngles(ply:EyeAngles())
		end)
	end
end

end



function SW_ADDON:Enter( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end

function SW_ADDON:Leave( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end



SW_ADDON:RegisterVehicleOrder("Cam_01", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C3")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_01", KEY_PAD_1, 0.25, "Extra Camera Left", "")

SW_ADDON:RegisterVehicleOrder("Cam_02", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C4")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_02", KEY_PAD_2, 0.25, "Extra Camera Front", "")

SW_ADDON:RegisterVehicleOrder("Cam_03", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C1")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_03", KEY_PAD_3, 0.25, "Extra Camera Right", "")

SW_ADDON:RegisterVehicleOrder("Cam_04", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C2")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_04", KEY_PAD_4, 0.25, "Extra Camera Back", "")

-- "addons\\slick\\lua\\sw_addons\\bluex11\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Ang0 = Angle()
local Category = "SligWolf's Vehicles"
local Veh_Class = "prop_vehicle_jeep"
local Author = "SligWolf"
local NiceName = "BlueX11"

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

SW_ADDON.NetworkaddonID = "SW_"..SW_ADDON.Addonname
SW_ADDON.Category = Category 
SW_ADDON.Author = Author 
SW_ADDON.NiceName = NiceName 



local V = { 	
	Name = "Blue-X11", 
	Class = Veh_Class,
	Category = Category,
	Author = Author,
	Information = "Blue-x11 made by SligWolf",
	Model = "models/sligwolf/blue-x11/blue-x11.mdl",
	
	SW_Values_BlueX11 = {},
	
	SW_BlueX11_Cams = {
		C1 = {},
		C2 = {},
		C3 = {},
		C4 = {},
	},

	KeyValues = {
		vehiclescript = "scripts/vehicles/sligwolf/sw_blue-x11.txt",
	},
}
list.Set( "Vehicles", "sw_blue-x11_blue", V )



function SW_ADDON:Spawn(ply, vehicle)

if !vehicle.VehicleTable then return end

local Col = Color(2,25,37,255)

if istable(vehicle.VehicleTable.SW_Values_BlueX11) then	
	self:AddToEntList("BlueX11", vehicle)
	vehicle.__IsSW_BlueX11 = true
	vehicle:SetSkin(self:GetVal(vehicle, "Skin", 0))
	vehicle:SetColor(self:GetVal(vehicle, "Color", Col))
	
	self:SetupDupeModifier(vehicle, "SW_BX12", function(f_ent)
		self:SetVal(f_ent, "Skin", f_ent:GetSkin())
		self:SetVal(f_ent, "Color", f_ent:GetColor())
	end, function(f_ent)
		f_ent:SetSkin(self:GetVal(f_ent, "Skin", 0))
		f_ent:SetColor(self:GetVal(f_ent, "Color", Col))
	end)
end

if istable(vehicle.VehicleTable.SW_BlueX11_Cams) then	
	local Ents = vehicle.VehicleTable.SW_BlueX11_Cams

	for k,v in pairs(Ents) do
		local Ent = self:MakeEnt( "prop_physics", ply, vehicle, "Cams_"..k )
		if !IsValid(Ent) then continue end
			
		Ent:SetModel( "models/sligwolf/unique_props/sw_cube_1x1x1.mdl" )
		
		if !self:SetEntAngPosViaAttachment(vehicle, Ent, tostring(k)) then
			self:RemoveEntites({vehicle, Ent})
			return
		end
		
		self:SetupChildEntity( Ent, vehicle, COLLISION_GROUP_IN_VEHICLE )
		Ent:DrawShadow( false )
		Ent:SetSolid( SOLID_NONE )
		Ent.__SW_Blockedprop = true
	end
end

end



if SERVER then

function SW_ADDON:Think()
	self:ForEachInEntList("BlueX11", function(addon, index, ent)
		if !ent.__IsSW_BlueX11 then return end
		self:ThinkPerEnt(ent)		
	end)
end

function SW_ADDON:ThinkPerEnt(ent)

	local ply = ent:GetDriver()
	if !IsValid(ply) then return end
	if !ply:InVehicle() then return end
	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local dir_rgt = self:DirToLocalToWorld(ent, Ang0, "Right")
	local dir_up = self:DirToLocalToWorld(ent, Ang0, "Up")
	
	if ply:KeyDown( IN_SPEED ) then
		phys:ApplyForceCenter( dir_rgt*-15500 - dir_up*5000 )
	end
	
	if ply.__SW_Cam_Mode then
		self:ForEachFilteredChild(ent, "^Cams_", function(f_ent, index, k, v)
			if !IsValid(v) then return end
			v:SetAngles(ply:EyeAngles())
		end)
	end
end

end



function SW_ADDON:Enter( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end

function SW_ADDON:Leave( ply,vehicle )
	if CLIENT then return end

    if !IsValid( ply ) then return end
    local vehicle = ply:GetVehicle()
    if !IsValid( vehicle ) then return end
	
	if !vehicle.__IsSW_BlueX11 then return end
	
	self:ViewEnt(ply)
end



SW_ADDON:RegisterVehicleOrder("Cam_01", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C3")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_01", KEY_PAD_1, 0.25, "Extra Camera Left", "")

SW_ADDON:RegisterVehicleOrder("Cam_02", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C4")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_02", KEY_PAD_2, 0.25, "Extra Camera Front", "")

SW_ADDON:RegisterVehicleOrder("Cam_03", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C1")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_03", KEY_PAD_3, 0.25, "Extra Camera Right", "")

SW_ADDON:RegisterVehicleOrder("Cam_04", nil, function(self, ply, veh)
	if !veh.__IsSW_BlueX11 then return end
	
	local Cam = self:GetChild(veh, "Cams_C2")
	if Cam then self:CamControl(ply, Cam) end
end)
SW_ADDON:RegisterKeySettings("Cam_04", KEY_PAD_4, 0.25, "Extra Camera Back", "")

