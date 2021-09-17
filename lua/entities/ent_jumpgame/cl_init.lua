-- "lua\\entities\\ent_jumpgame\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathc = math.cos
local mathr = math.rad

function ENT:Initialize()
	
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end

function ENT:CheckForSpace(pos)
	local filterfun = function( ent ) 
		if  ent:GetClass() == "prop_physics" then
			return false
		elseif ent:GetClass()=="Player" then
			return false
		end 
	end

	local tr = util.TraceHull( {
		start = self:GetNWVector("LastPos",self:GetPos()), 
		endpos = pos, 
		mins = Vector( -50, -50, -10 ), 
		maxs = Vector( 50, 50, 10+60 ), 
		filter = filterfun
	} )
	return tr
end


local rat = Material("effects/com_shield002a")
function ENT:Draw()
	render.MaterialOverride(Material("models/player/shared/gold_player"))
	self:DrawModel()
	render.MaterialOverride()
	local s = maths(SysTime())
	if !type(LocalPlayer())=="nil" then return end
	local dis = LocalPlayer():GetPos():Distance(self:GetPos())
	if dis < 60 or dis>1000 then return end
	if self:GetNWFloat("InGame",0) == 0  then
		render.SetMaterial(Material("vgui/entities/ent_jumpgame"))
		render.DrawQuadEasy(self:GetPos()+Vector(0,0,40+s*4),-EyeAngles():Forward(),32+s*2,32+s*2,Color(255,255,255),180)
	end
	
	local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
	local list = {}
	if type(GetJumpGameScore)=="function" then
		list = GetJumpGameScore()
	end
	cam.Start3D2D(self:GetPos()+Vector(0,0,80),Angle(0,y+90,90),0.1)

		surface.SetDrawColor(Color(0,0,0,220))
		
		surface.DrawRect(-250,-250,500,440)
		surface.SetMaterial(rat)
		surface.SetDrawColor(Color(150,150,150))
		surface.DrawTexturedRect(-245,-245,490,430)

		local t = "Jump Game"
		surface.SetTextColor(Color(200,200,255))
		if self:GetNWFloat("InGame",0) == 1 then
			t = "In Use"
			surface.SetTextColor(Color(200,50*s+50,50*s+50))
		end
		surface.SetFont("Jump_Game")
		
		surface.SetTextPos(-surface.GetTextSize(t)/2,-240)
		surface.DrawText(t)


		surface.SetFont("Jump_Game_Small")
		
		if type(list[1])!="nil" then
			local t = list[1][2]..": "..list[1][1]
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		else
			local t = "No Data"
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		end
		local x,y = 0,0
		for k, v in pairs( list ) do
			
			if k!=1 and k!=20 then
				y = y+1
				if y >9 then 
					y = 1
					x = 1
				end
				local t = k..") "..string.sub(v[2],0,9)
				surface.SetFont("Jump_Game_Mini")
				surface.SetTextColor(Color(255,255, 255))
				surface.SetTextPos(-230+(x*250),-160+(y*34))
				surface.DrawText(t)
				surface.SetTextPos(-60+(x*250),-160+(y*34))
				surface.DrawText(v[1])
			end
		end

	cam.End3D2D()
end

-- "lua\\entities\\ent_jumpgame\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathc = math.cos
local mathr = math.rad

function ENT:Initialize()
	
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end

function ENT:CheckForSpace(pos)
	local filterfun = function( ent ) 
		if  ent:GetClass() == "prop_physics" then
			return false
		elseif ent:GetClass()=="Player" then
			return false
		end 
	end

	local tr = util.TraceHull( {
		start = self:GetNWVector("LastPos",self:GetPos()), 
		endpos = pos, 
		mins = Vector( -50, -50, -10 ), 
		maxs = Vector( 50, 50, 10+60 ), 
		filter = filterfun
	} )
	return tr
end


local rat = Material("effects/com_shield002a")
function ENT:Draw()
	render.MaterialOverride(Material("models/player/shared/gold_player"))
	self:DrawModel()
	render.MaterialOverride()
	local s = maths(SysTime())
	if !type(LocalPlayer())=="nil" then return end
	local dis = LocalPlayer():GetPos():Distance(self:GetPos())
	if dis < 60 or dis>1000 then return end
	if self:GetNWFloat("InGame",0) == 0  then
		render.SetMaterial(Material("vgui/entities/ent_jumpgame"))
		render.DrawQuadEasy(self:GetPos()+Vector(0,0,40+s*4),-EyeAngles():Forward(),32+s*2,32+s*2,Color(255,255,255),180)
	end
	
	local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
	local list = {}
	if type(GetJumpGameScore)=="function" then
		list = GetJumpGameScore()
	end
	cam.Start3D2D(self:GetPos()+Vector(0,0,80),Angle(0,y+90,90),0.1)

		surface.SetDrawColor(Color(0,0,0,220))
		
		surface.DrawRect(-250,-250,500,440)
		surface.SetMaterial(rat)
		surface.SetDrawColor(Color(150,150,150))
		surface.DrawTexturedRect(-245,-245,490,430)

		local t = "Jump Game"
		surface.SetTextColor(Color(200,200,255))
		if self:GetNWFloat("InGame",0) == 1 then
			t = "In Use"
			surface.SetTextColor(Color(200,50*s+50,50*s+50))
		end
		surface.SetFont("Jump_Game")
		
		surface.SetTextPos(-surface.GetTextSize(t)/2,-240)
		surface.DrawText(t)


		surface.SetFont("Jump_Game_Small")
		
		if type(list[1])!="nil" then
			local t = list[1][2]..": "..list[1][1]
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		else
			local t = "No Data"
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		end
		local x,y = 0,0
		for k, v in pairs( list ) do
			
			if k!=1 and k!=20 then
				y = y+1
				if y >9 then 
					y = 1
					x = 1
				end
				local t = k..") "..string.sub(v[2],0,9)
				surface.SetFont("Jump_Game_Mini")
				surface.SetTextColor(Color(255,255, 255))
				surface.SetTextPos(-230+(x*250),-160+(y*34))
				surface.DrawText(t)
				surface.SetTextPos(-60+(x*250),-160+(y*34))
				surface.DrawText(v[1])
			end
		end

	cam.End3D2D()
end

-- "lua\\entities\\ent_jumpgame\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathc = math.cos
local mathr = math.rad

function ENT:Initialize()
	
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end

function ENT:CheckForSpace(pos)
	local filterfun = function( ent ) 
		if  ent:GetClass() == "prop_physics" then
			return false
		elseif ent:GetClass()=="Player" then
			return false
		end 
	end

	local tr = util.TraceHull( {
		start = self:GetNWVector("LastPos",self:GetPos()), 
		endpos = pos, 
		mins = Vector( -50, -50, -10 ), 
		maxs = Vector( 50, 50, 10+60 ), 
		filter = filterfun
	} )
	return tr
end


local rat = Material("effects/com_shield002a")
function ENT:Draw()
	render.MaterialOverride(Material("models/player/shared/gold_player"))
	self:DrawModel()
	render.MaterialOverride()
	local s = maths(SysTime())
	if !type(LocalPlayer())=="nil" then return end
	local dis = LocalPlayer():GetPos():Distance(self:GetPos())
	if dis < 60 or dis>1000 then return end
	if self:GetNWFloat("InGame",0) == 0  then
		render.SetMaterial(Material("vgui/entities/ent_jumpgame"))
		render.DrawQuadEasy(self:GetPos()+Vector(0,0,40+s*4),-EyeAngles():Forward(),32+s*2,32+s*2,Color(255,255,255),180)
	end
	
	local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
	local list = {}
	if type(GetJumpGameScore)=="function" then
		list = GetJumpGameScore()
	end
	cam.Start3D2D(self:GetPos()+Vector(0,0,80),Angle(0,y+90,90),0.1)

		surface.SetDrawColor(Color(0,0,0,220))
		
		surface.DrawRect(-250,-250,500,440)
		surface.SetMaterial(rat)
		surface.SetDrawColor(Color(150,150,150))
		surface.DrawTexturedRect(-245,-245,490,430)

		local t = "Jump Game"
		surface.SetTextColor(Color(200,200,255))
		if self:GetNWFloat("InGame",0) == 1 then
			t = "In Use"
			surface.SetTextColor(Color(200,50*s+50,50*s+50))
		end
		surface.SetFont("Jump_Game")
		
		surface.SetTextPos(-surface.GetTextSize(t)/2,-240)
		surface.DrawText(t)


		surface.SetFont("Jump_Game_Small")
		
		if type(list[1])!="nil" then
			local t = list[1][2]..": "..list[1][1]
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		else
			local t = "No Data"
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		end
		local x,y = 0,0
		for k, v in pairs( list ) do
			
			if k!=1 and k!=20 then
				y = y+1
				if y >9 then 
					y = 1
					x = 1
				end
				local t = k..") "..string.sub(v[2],0,9)
				surface.SetFont("Jump_Game_Mini")
				surface.SetTextColor(Color(255,255, 255))
				surface.SetTextPos(-230+(x*250),-160+(y*34))
				surface.DrawText(t)
				surface.SetTextPos(-60+(x*250),-160+(y*34))
				surface.DrawText(v[1])
			end
		end

	cam.End3D2D()
end

-- "lua\\entities\\ent_jumpgame\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathc = math.cos
local mathr = math.rad

function ENT:Initialize()
	
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end

function ENT:CheckForSpace(pos)
	local filterfun = function( ent ) 
		if  ent:GetClass() == "prop_physics" then
			return false
		elseif ent:GetClass()=="Player" then
			return false
		end 
	end

	local tr = util.TraceHull( {
		start = self:GetNWVector("LastPos",self:GetPos()), 
		endpos = pos, 
		mins = Vector( -50, -50, -10 ), 
		maxs = Vector( 50, 50, 10+60 ), 
		filter = filterfun
	} )
	return tr
end


local rat = Material("effects/com_shield002a")
function ENT:Draw()
	render.MaterialOverride(Material("models/player/shared/gold_player"))
	self:DrawModel()
	render.MaterialOverride()
	local s = maths(SysTime())
	if !type(LocalPlayer())=="nil" then return end
	local dis = LocalPlayer():GetPos():Distance(self:GetPos())
	if dis < 60 or dis>1000 then return end
	if self:GetNWFloat("InGame",0) == 0  then
		render.SetMaterial(Material("vgui/entities/ent_jumpgame"))
		render.DrawQuadEasy(self:GetPos()+Vector(0,0,40+s*4),-EyeAngles():Forward(),32+s*2,32+s*2,Color(255,255,255),180)
	end
	
	local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
	local list = {}
	if type(GetJumpGameScore)=="function" then
		list = GetJumpGameScore()
	end
	cam.Start3D2D(self:GetPos()+Vector(0,0,80),Angle(0,y+90,90),0.1)

		surface.SetDrawColor(Color(0,0,0,220))
		
		surface.DrawRect(-250,-250,500,440)
		surface.SetMaterial(rat)
		surface.SetDrawColor(Color(150,150,150))
		surface.DrawTexturedRect(-245,-245,490,430)

		local t = "Jump Game"
		surface.SetTextColor(Color(200,200,255))
		if self:GetNWFloat("InGame",0) == 1 then
			t = "In Use"
			surface.SetTextColor(Color(200,50*s+50,50*s+50))
		end
		surface.SetFont("Jump_Game")
		
		surface.SetTextPos(-surface.GetTextSize(t)/2,-240)
		surface.DrawText(t)


		surface.SetFont("Jump_Game_Small")
		
		if type(list[1])!="nil" then
			local t = list[1][2]..": "..list[1][1]
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		else
			local t = "No Data"
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		end
		local x,y = 0,0
		for k, v in pairs( list ) do
			
			if k!=1 and k!=20 then
				y = y+1
				if y >9 then 
					y = 1
					x = 1
				end
				local t = k..") "..string.sub(v[2],0,9)
				surface.SetFont("Jump_Game_Mini")
				surface.SetTextColor(Color(255,255, 255))
				surface.SetTextPos(-230+(x*250),-160+(y*34))
				surface.DrawText(t)
				surface.SetTextPos(-60+(x*250),-160+(y*34))
				surface.DrawText(v[1])
			end
		end

	cam.End3D2D()
end

-- "lua\\entities\\ent_jumpgame\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathc = math.cos
local mathr = math.rad

function ENT:Initialize()
	
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end

function ENT:CheckForSpace(pos)
	local filterfun = function( ent ) 
		if  ent:GetClass() == "prop_physics" then
			return false
		elseif ent:GetClass()=="Player" then
			return false
		end 
	end

	local tr = util.TraceHull( {
		start = self:GetNWVector("LastPos",self:GetPos()), 
		endpos = pos, 
		mins = Vector( -50, -50, -10 ), 
		maxs = Vector( 50, 50, 10+60 ), 
		filter = filterfun
	} )
	return tr
end


local rat = Material("effects/com_shield002a")
function ENT:Draw()
	render.MaterialOverride(Material("models/player/shared/gold_player"))
	self:DrawModel()
	render.MaterialOverride()
	local s = maths(SysTime())
	if !type(LocalPlayer())=="nil" then return end
	local dis = LocalPlayer():GetPos():Distance(self:GetPos())
	if dis < 60 or dis>1000 then return end
	if self:GetNWFloat("InGame",0) == 0  then
		render.SetMaterial(Material("vgui/entities/ent_jumpgame"))
		render.DrawQuadEasy(self:GetPos()+Vector(0,0,40+s*4),-EyeAngles():Forward(),32+s*2,32+s*2,Color(255,255,255),180)
	end
	
	local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
	local list = {}
	if type(GetJumpGameScore)=="function" then
		list = GetJumpGameScore()
	end
	cam.Start3D2D(self:GetPos()+Vector(0,0,80),Angle(0,y+90,90),0.1)

		surface.SetDrawColor(Color(0,0,0,220))
		
		surface.DrawRect(-250,-250,500,440)
		surface.SetMaterial(rat)
		surface.SetDrawColor(Color(150,150,150))
		surface.DrawTexturedRect(-245,-245,490,430)

		local t = "Jump Game"
		surface.SetTextColor(Color(200,200,255))
		if self:GetNWFloat("InGame",0) == 1 then
			t = "In Use"
			surface.SetTextColor(Color(200,50*s+50,50*s+50))
		end
		surface.SetFont("Jump_Game")
		
		surface.SetTextPos(-surface.GetTextSize(t)/2,-240)
		surface.DrawText(t)


		surface.SetFont("Jump_Game_Small")
		
		if type(list[1])!="nil" then
			local t = list[1][2]..": "..list[1][1]
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		else
			local t = "No Data"
			surface.SetTextColor(Color(255, 215, 0))
			surface.SetTextPos(-surface.GetTextSize(t)/2,-170)
			surface.DrawText(t)
		end
		local x,y = 0,0
		for k, v in pairs( list ) do
			
			if k!=1 and k!=20 then
				y = y+1
				if y >9 then 
					y = 1
					x = 1
				end
				local t = k..") "..string.sub(v[2],0,9)
				surface.SetFont("Jump_Game_Mini")
				surface.SetTextColor(Color(255,255, 255))
				surface.SetTextPos(-230+(x*250),-160+(y*34))
				surface.DrawText(t)
				surface.SetTextPos(-60+(x*250),-160+(y*34))
				surface.DrawText(v[1])
			end
		end

	cam.End3D2D()
end

