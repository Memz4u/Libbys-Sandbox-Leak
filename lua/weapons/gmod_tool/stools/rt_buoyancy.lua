-- "lua\\weapons\\gmod_tool\\stools\\rt_buoyancy.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

TOOL.Category		= "Construction"
TOOL.Name			= "#Buoyancy"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if ( CLIENT ) then
	language.Add( "tool.rt_buoyancy.name", "Buoyancy Tool" )
	language.Add( "tool.rt_buoyancy.desc", "Make things float." )
	language.Add( "tool.rt_buoyancy.0", "Left click to set, right click to copy." )
end

TOOL.ClientConVar[ "ratio" ] = "0"

local function SetBuoyancy( ply, ent, data )
	local ratio = data.Ratio
	
	local phys = ent:GetPhysicsObject()
	if ( phys:IsValid() ) then
		local ratio = math.Clamp( data.Ratio, -1000, 1000 ) / 100
		ent.BuoyancyRatio = ratio
		phys:SetBuoyancyRatio( ratio )
		phys:Wake()
		
		duplicator.StoreEntityModifier( ent, "buoyancy", data ) 
	end
	
	return true
end
duplicator.RegisterEntityModifier( "buoyancy", SetBuoyancy )

function TOOL:LeftClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	SetBuoyancy( self:GetOwner(), ent, { Ratio = self:GetClientNumber( "ratio" ) } )
	
	return true
end
function TOOL:RightClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	local ply = self:GetOwner()
	ply:ConCommand( "rt_buoyancy_ratio " .. ( ( ent.BuoyancyRatio or 0 ) * 100 ) )
	
	return true
end
function TOOL.BuildCPanel( panel )	
	panel:NumSlider( "Percent", "rt_buoyancy_ratio", 0, 100 )
end

if ( SERVER ) then
	local function Set( phys, ratio )
		if ( !phys:IsValid() ) then return end
		phys:SetBuoyancyRatio( ratio )
	end
	local function OnDrop( ply, ent )
		if ( ent.BuoyancyRatio ) then
			local phys = ent:GetPhysicsObject()
			if ( phys:IsValid() ) then
				timer.Simple( 0, function() Set( phys, ent.BuoyancyRatio ) end)
			end
		end
	end
	hook.Add( "PhysgunDrop", "rt_buoyancy", OnDrop )
	hook.Add( "GravGunOnDropped", "rt_buoyancy", OnDrop )
end


-- "lua\\weapons\\gmod_tool\\stools\\rt_buoyancy.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

TOOL.Category		= "Construction"
TOOL.Name			= "#Buoyancy"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if ( CLIENT ) then
	language.Add( "tool.rt_buoyancy.name", "Buoyancy Tool" )
	language.Add( "tool.rt_buoyancy.desc", "Make things float." )
	language.Add( "tool.rt_buoyancy.0", "Left click to set, right click to copy." )
end

TOOL.ClientConVar[ "ratio" ] = "0"

local function SetBuoyancy( ply, ent, data )
	local ratio = data.Ratio
	
	local phys = ent:GetPhysicsObject()
	if ( phys:IsValid() ) then
		local ratio = math.Clamp( data.Ratio, -1000, 1000 ) / 100
		ent.BuoyancyRatio = ratio
		phys:SetBuoyancyRatio( ratio )
		phys:Wake()
		
		duplicator.StoreEntityModifier( ent, "buoyancy", data ) 
	end
	
	return true
end
duplicator.RegisterEntityModifier( "buoyancy", SetBuoyancy )

function TOOL:LeftClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	SetBuoyancy( self:GetOwner(), ent, { Ratio = self:GetClientNumber( "ratio" ) } )
	
	return true
end
function TOOL:RightClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	local ply = self:GetOwner()
	ply:ConCommand( "rt_buoyancy_ratio " .. ( ( ent.BuoyancyRatio or 0 ) * 100 ) )
	
	return true
end
function TOOL.BuildCPanel( panel )	
	panel:NumSlider( "Percent", "rt_buoyancy_ratio", 0, 100 )
end

if ( SERVER ) then
	local function Set( phys, ratio )
		if ( !phys:IsValid() ) then return end
		phys:SetBuoyancyRatio( ratio )
	end
	local function OnDrop( ply, ent )
		if ( ent.BuoyancyRatio ) then
			local phys = ent:GetPhysicsObject()
			if ( phys:IsValid() ) then
				timer.Simple( 0, function() Set( phys, ent.BuoyancyRatio ) end)
			end
		end
	end
	hook.Add( "PhysgunDrop", "rt_buoyancy", OnDrop )
	hook.Add( "GravGunOnDropped", "rt_buoyancy", OnDrop )
end


-- "lua\\weapons\\gmod_tool\\stools\\rt_buoyancy.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

TOOL.Category		= "Construction"
TOOL.Name			= "#Buoyancy"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if ( CLIENT ) then
	language.Add( "tool.rt_buoyancy.name", "Buoyancy Tool" )
	language.Add( "tool.rt_buoyancy.desc", "Make things float." )
	language.Add( "tool.rt_buoyancy.0", "Left click to set, right click to copy." )
end

TOOL.ClientConVar[ "ratio" ] = "0"

local function SetBuoyancy( ply, ent, data )
	local ratio = data.Ratio
	
	local phys = ent:GetPhysicsObject()
	if ( phys:IsValid() ) then
		local ratio = math.Clamp( data.Ratio, -1000, 1000 ) / 100
		ent.BuoyancyRatio = ratio
		phys:SetBuoyancyRatio( ratio )
		phys:Wake()
		
		duplicator.StoreEntityModifier( ent, "buoyancy", data ) 
	end
	
	return true
end
duplicator.RegisterEntityModifier( "buoyancy", SetBuoyancy )

function TOOL:LeftClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	SetBuoyancy( self:GetOwner(), ent, { Ratio = self:GetClientNumber( "ratio" ) } )
	
	return true
end
function TOOL:RightClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	local ply = self:GetOwner()
	ply:ConCommand( "rt_buoyancy_ratio " .. ( ( ent.BuoyancyRatio or 0 ) * 100 ) )
	
	return true
end
function TOOL.BuildCPanel( panel )	
	panel:NumSlider( "Percent", "rt_buoyancy_ratio", 0, 100 )
end

if ( SERVER ) then
	local function Set( phys, ratio )
		if ( !phys:IsValid() ) then return end
		phys:SetBuoyancyRatio( ratio )
	end
	local function OnDrop( ply, ent )
		if ( ent.BuoyancyRatio ) then
			local phys = ent:GetPhysicsObject()
			if ( phys:IsValid() ) then
				timer.Simple( 0, function() Set( phys, ent.BuoyancyRatio ) end)
			end
		end
	end
	hook.Add( "PhysgunDrop", "rt_buoyancy", OnDrop )
	hook.Add( "GravGunOnDropped", "rt_buoyancy", OnDrop )
end


-- "lua\\weapons\\gmod_tool\\stools\\rt_buoyancy.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

TOOL.Category		= "Construction"
TOOL.Name			= "#Buoyancy"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if ( CLIENT ) then
	language.Add( "tool.rt_buoyancy.name", "Buoyancy Tool" )
	language.Add( "tool.rt_buoyancy.desc", "Make things float." )
	language.Add( "tool.rt_buoyancy.0", "Left click to set, right click to copy." )
end

TOOL.ClientConVar[ "ratio" ] = "0"

local function SetBuoyancy( ply, ent, data )
	local ratio = data.Ratio
	
	local phys = ent:GetPhysicsObject()
	if ( phys:IsValid() ) then
		local ratio = math.Clamp( data.Ratio, -1000, 1000 ) / 100
		ent.BuoyancyRatio = ratio
		phys:SetBuoyancyRatio( ratio )
		phys:Wake()
		
		duplicator.StoreEntityModifier( ent, "buoyancy", data ) 
	end
	
	return true
end
duplicator.RegisterEntityModifier( "buoyancy", SetBuoyancy )

function TOOL:LeftClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	SetBuoyancy( self:GetOwner(), ent, { Ratio = self:GetClientNumber( "ratio" ) } )
	
	return true
end
function TOOL:RightClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	local ply = self:GetOwner()
	ply:ConCommand( "rt_buoyancy_ratio " .. ( ( ent.BuoyancyRatio or 0 ) * 100 ) )
	
	return true
end
function TOOL.BuildCPanel( panel )	
	panel:NumSlider( "Percent", "rt_buoyancy_ratio", 0, 100 )
end

if ( SERVER ) then
	local function Set( phys, ratio )
		if ( !phys:IsValid() ) then return end
		phys:SetBuoyancyRatio( ratio )
	end
	local function OnDrop( ply, ent )
		if ( ent.BuoyancyRatio ) then
			local phys = ent:GetPhysicsObject()
			if ( phys:IsValid() ) then
				timer.Simple( 0, function() Set( phys, ent.BuoyancyRatio ) end)
			end
		end
	end
	hook.Add( "PhysgunDrop", "rt_buoyancy", OnDrop )
	hook.Add( "GravGunOnDropped", "rt_buoyancy", OnDrop )
end


-- "lua\\weapons\\gmod_tool\\stools\\rt_buoyancy.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

TOOL.Category		= "Construction"
TOOL.Name			= "#Buoyancy"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if ( CLIENT ) then
	language.Add( "tool.rt_buoyancy.name", "Buoyancy Tool" )
	language.Add( "tool.rt_buoyancy.desc", "Make things float." )
	language.Add( "tool.rt_buoyancy.0", "Left click to set, right click to copy." )
end

TOOL.ClientConVar[ "ratio" ] = "0"

local function SetBuoyancy( ply, ent, data )
	local ratio = data.Ratio
	
	local phys = ent:GetPhysicsObject()
	if ( phys:IsValid() ) then
		local ratio = math.Clamp( data.Ratio, -1000, 1000 ) / 100
		ent.BuoyancyRatio = ratio
		phys:SetBuoyancyRatio( ratio )
		phys:Wake()
		
		duplicator.StoreEntityModifier( ent, "buoyancy", data ) 
	end
	
	return true
end
duplicator.RegisterEntityModifier( "buoyancy", SetBuoyancy )

function TOOL:LeftClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	SetBuoyancy( self:GetOwner(), ent, { Ratio = self:GetClientNumber( "ratio" ) } )
	
	return true
end
function TOOL:RightClick( trace )
	local ent = trace.Entity
	if ( !ent || !ent:IsValid() ) then return false end
	if ( CLIENT ) then return true end
	
	local ply = self:GetOwner()
	ply:ConCommand( "rt_buoyancy_ratio " .. ( ( ent.BuoyancyRatio or 0 ) * 100 ) )
	
	return true
end
function TOOL.BuildCPanel( panel )	
	panel:NumSlider( "Percent", "rt_buoyancy_ratio", 0, 100 )
end

if ( SERVER ) then
	local function Set( phys, ratio )
		if ( !phys:IsValid() ) then return end
		phys:SetBuoyancyRatio( ratio )
	end
	local function OnDrop( ply, ent )
		if ( ent.BuoyancyRatio ) then
			local phys = ent:GetPhysicsObject()
			if ( phys:IsValid() ) then
				timer.Simple( 0, function() Set( phys, ent.BuoyancyRatio ) end)
			end
		end
	end
	hook.Add( "PhysgunDrop", "rt_buoyancy", OnDrop )
	hook.Add( "GravGunOnDropped", "rt_buoyancy", OnDrop )
end


