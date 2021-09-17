-- "lua\\entities\\ent_jgplatform\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion( false )
	end
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end
local maths = math.sin

local rat = Material("effects/com_shield002a")
function ENT:Draw()
	local N = self:GetNWFloat("Shake",0)
	local A = self:GetAngles()
	if N>0 then
		render.SuppressEngineLighting( true )
		local t = (maths(SysTime()*5)+1)/3+0.2
		render.SetBlend( t )
		self:DrawModel()
		render.SuppressEngineLighting( false )
	else
		self:DrawModel()
	end

	local _point = self:GetNWString("Point","")
	if _point!="" then
		local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
		local l = 100-LocalPlayer():GetPos():Distance(self:GetPos())
		l = math.Clamp(l,0,100)
		local a = Angle(0,y+90,90) -- Goto the right
		local pos = self:GetPos()+Vector(0,0,80)+a:Forward()*l
		cam.Start3D2D(pos,Angle(0,y+90,90),0.1)
			surface.SetDrawColor(Color(0,0,0,220))
			
			surface.DrawRect(-250,-50,500,150)
			surface.SetMaterial(rat)
			surface.SetDrawColor(Color(150,150,150))
			surface.DrawTexturedRect(-250,-50,500,150)

			local TA = string.Explode("|",_point)
			surface.SetTextColor(Color(200,200,255))
			surface.SetFont("Jump_Game")
			
			surface.SetTextPos(-surface.GetTextSize(TA[1])/2,-40)
			surface.DrawText(TA[1])
			surface.SetTextPos(-surface.GetTextSize(TA[2] or "")/2,20)
			surface.DrawText(TA[2] or "")

		cam.End3D2D()
	end
end


-- "lua\\entities\\ent_jgplatform\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion( false )
	end
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end
local maths = math.sin

local rat = Material("effects/com_shield002a")
function ENT:Draw()
	local N = self:GetNWFloat("Shake",0)
	local A = self:GetAngles()
	if N>0 then
		render.SuppressEngineLighting( true )
		local t = (maths(SysTime()*5)+1)/3+0.2
		render.SetBlend( t )
		self:DrawModel()
		render.SuppressEngineLighting( false )
	else
		self:DrawModel()
	end

	local _point = self:GetNWString("Point","")
	if _point!="" then
		local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
		local l = 100-LocalPlayer():GetPos():Distance(self:GetPos())
		l = math.Clamp(l,0,100)
		local a = Angle(0,y+90,90) -- Goto the right
		local pos = self:GetPos()+Vector(0,0,80)+a:Forward()*l
		cam.Start3D2D(pos,Angle(0,y+90,90),0.1)
			surface.SetDrawColor(Color(0,0,0,220))
			
			surface.DrawRect(-250,-50,500,150)
			surface.SetMaterial(rat)
			surface.SetDrawColor(Color(150,150,150))
			surface.DrawTexturedRect(-250,-50,500,150)

			local TA = string.Explode("|",_point)
			surface.SetTextColor(Color(200,200,255))
			surface.SetFont("Jump_Game")
			
			surface.SetTextPos(-surface.GetTextSize(TA[1])/2,-40)
			surface.DrawText(TA[1])
			surface.SetTextPos(-surface.GetTextSize(TA[2] or "")/2,20)
			surface.DrawText(TA[2] or "")

		cam.End3D2D()
	end
end


-- "lua\\entities\\ent_jgplatform\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion( false )
	end
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end
local maths = math.sin

local rat = Material("effects/com_shield002a")
function ENT:Draw()
	local N = self:GetNWFloat("Shake",0)
	local A = self:GetAngles()
	if N>0 then
		render.SuppressEngineLighting( true )
		local t = (maths(SysTime()*5)+1)/3+0.2
		render.SetBlend( t )
		self:DrawModel()
		render.SuppressEngineLighting( false )
	else
		self:DrawModel()
	end

	local _point = self:GetNWString("Point","")
	if _point!="" then
		local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
		local l = 100-LocalPlayer():GetPos():Distance(self:GetPos())
		l = math.Clamp(l,0,100)
		local a = Angle(0,y+90,90) -- Goto the right
		local pos = self:GetPos()+Vector(0,0,80)+a:Forward()*l
		cam.Start3D2D(pos,Angle(0,y+90,90),0.1)
			surface.SetDrawColor(Color(0,0,0,220))
			
			surface.DrawRect(-250,-50,500,150)
			surface.SetMaterial(rat)
			surface.SetDrawColor(Color(150,150,150))
			surface.DrawTexturedRect(-250,-50,500,150)

			local TA = string.Explode("|",_point)
			surface.SetTextColor(Color(200,200,255))
			surface.SetFont("Jump_Game")
			
			surface.SetTextPos(-surface.GetTextSize(TA[1])/2,-40)
			surface.DrawText(TA[1])
			surface.SetTextPos(-surface.GetTextSize(TA[2] or "")/2,20)
			surface.DrawText(TA[2] or "")

		cam.End3D2D()
	end
end


-- "lua\\entities\\ent_jgplatform\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion( false )
	end
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end
local maths = math.sin

local rat = Material("effects/com_shield002a")
function ENT:Draw()
	local N = self:GetNWFloat("Shake",0)
	local A = self:GetAngles()
	if N>0 then
		render.SuppressEngineLighting( true )
		local t = (maths(SysTime()*5)+1)/3+0.2
		render.SetBlend( t )
		self:DrawModel()
		render.SuppressEngineLighting( false )
	else
		self:DrawModel()
	end

	local _point = self:GetNWString("Point","")
	if _point!="" then
		local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
		local l = 100-LocalPlayer():GetPos():Distance(self:GetPos())
		l = math.Clamp(l,0,100)
		local a = Angle(0,y+90,90) -- Goto the right
		local pos = self:GetPos()+Vector(0,0,80)+a:Forward()*l
		cam.Start3D2D(pos,Angle(0,y+90,90),0.1)
			surface.SetDrawColor(Color(0,0,0,220))
			
			surface.DrawRect(-250,-50,500,150)
			surface.SetMaterial(rat)
			surface.SetDrawColor(Color(150,150,150))
			surface.DrawTexturedRect(-250,-50,500,150)

			local TA = string.Explode("|",_point)
			surface.SetTextColor(Color(200,200,255))
			surface.SetFont("Jump_Game")
			
			surface.SetTextPos(-surface.GetTextSize(TA[1])/2,-40)
			surface.DrawText(TA[1])
			surface.SetTextPos(-surface.GetTextSize(TA[2] or "")/2,20)
			surface.DrawText(TA[2] or "")

		cam.End3D2D()
	end
end


-- "lua\\entities\\ent_jgplatform\\cl_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("shared.lua")

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion( false )
	end
end

function ENT:Think()
	
end

function ENT:OnRemove( )
	
end
local maths = math.sin

local rat = Material("effects/com_shield002a")
function ENT:Draw()
	local N = self:GetNWFloat("Shake",0)
	local A = self:GetAngles()
	if N>0 then
		render.SuppressEngineLighting( true )
		local t = (maths(SysTime()*5)+1)/3+0.2
		render.SetBlend( t )
		self:DrawModel()
		render.SuppressEngineLighting( false )
	else
		self:DrawModel()
	end

	local _point = self:GetNWString("Point","")
	if _point!="" then
		local y = (LocalPlayer():GetPos()-self:GetPos()):Angle().y
		local l = 100-LocalPlayer():GetPos():Distance(self:GetPos())
		l = math.Clamp(l,0,100)
		local a = Angle(0,y+90,90) -- Goto the right
		local pos = self:GetPos()+Vector(0,0,80)+a:Forward()*l
		cam.Start3D2D(pos,Angle(0,y+90,90),0.1)
			surface.SetDrawColor(Color(0,0,0,220))
			
			surface.DrawRect(-250,-50,500,150)
			surface.SetMaterial(rat)
			surface.SetDrawColor(Color(150,150,150))
			surface.DrawTexturedRect(-250,-50,500,150)

			local TA = string.Explode("|",_point)
			surface.SetTextColor(Color(200,200,255))
			surface.SetFont("Jump_Game")
			
			surface.SetTextPos(-surface.GetTextSize(TA[1])/2,-40)
			surface.DrawText(TA[1])
			surface.SetTextPos(-surface.GetTextSize(TA[2] or "")/2,20)
			surface.DrawText(TA[2] or "")

		cam.End3D2D()
	end
end


