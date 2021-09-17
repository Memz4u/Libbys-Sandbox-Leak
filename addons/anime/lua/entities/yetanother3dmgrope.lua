-- "addons\\anime\\lua\\entities\\yetanother3dmgrope.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 3DMG/OMG Rope
// Author: mmys
// See the main 3DMG file for header.

AddCSLuaFile()

ENT.Type = "anim"; // Default, but let's be safe.
ENT.ClassName = "yetanother3dmgrope"

////////////////////////////////////////////////////////////////////////////////
// Constants

local HOOKED_SOUND = Sound( "Metal.SawbladeStick" )

local CABLE_MATERIAL = Material("cable/cable");
local CABLE_COLOUR = Color(180,180,180,255);
local CABLE_SPEED = 5000.0;

function ENT:Initialize()
	self.Entity:DrawShadow(false);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetNWFloat("stretchDist", 0.0);
	self.Entity:SetNWBool("hooked", false);
	self.curTime = CurTime();
	self.hooked = false;
end
function ENT:Draw()	
	local owner = self.Entity:GetOwner()
	if(!IsValid(owner))then
		return;
	end
	
	// I don't know if I need a local client check here.
	
	local origin = self.Entity:GetPos();
	origin.z = origin.z - 28.0;	// very hacky
	local destination = self:GetDestination();
	self:DrawCable(origin,destination);
end

function ENT:DrawCable(startPos, endPos)
	render.SetMaterial(CABLE_MATERIAL);
	if(self.hooked)then
		render.DrawBeam(startPos,endPos,2.0,0.0,endPos:Distance(startPos),CABLE_COLOUR)
	else
		local distance = endPos:Distance(startPos);
		local stretched = self.Entity:GetNWFloat("stretchDist");
		local nowTime = CurTime();
		stretched = stretched + (CABLE_SPEED * (nowTime - self.curTime));
		if(stretched > distance)then
			self:EmitSound(HOOKED_SOUND);
			stretched = distance;
			self.hooked = true;
		end
		
		render.DrawBeam(startPos,startPos + (endPos - startPos) * (stretched / distance),2.0,0.0,stretched,CABLE_COLOUR);
		
		self.curTime = nowTime;
		self.Entity:SetNWFloat("stretchDist", stretched);
	end
end

function ENT:SetDestination(pos)
	self.Entity:SetNWVector("destination", pos);
end
function ENT:GetDestination()
	return self.Entity:GetNWVector("destination");
end
function ENT:IsHooked()
	return self.hooked;
end

// The empty stub of shame. Don't look at it. It's too sad. :(
function ENT:Think()
	// ...
end


-- "addons\\anime\\lua\\entities\\yetanother3dmgrope.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 3DMG/OMG Rope
// Author: mmys
// See the main 3DMG file for header.

AddCSLuaFile()

ENT.Type = "anim"; // Default, but let's be safe.
ENT.ClassName = "yetanother3dmgrope"

////////////////////////////////////////////////////////////////////////////////
// Constants

local HOOKED_SOUND = Sound( "Metal.SawbladeStick" )

local CABLE_MATERIAL = Material("cable/cable");
local CABLE_COLOUR = Color(180,180,180,255);
local CABLE_SPEED = 5000.0;

function ENT:Initialize()
	self.Entity:DrawShadow(false);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetNWFloat("stretchDist", 0.0);
	self.Entity:SetNWBool("hooked", false);
	self.curTime = CurTime();
	self.hooked = false;
end
function ENT:Draw()	
	local owner = self.Entity:GetOwner()
	if(!IsValid(owner))then
		return;
	end
	
	// I don't know if I need a local client check here.
	
	local origin = self.Entity:GetPos();
	origin.z = origin.z - 28.0;	// very hacky
	local destination = self:GetDestination();
	self:DrawCable(origin,destination);
end

function ENT:DrawCable(startPos, endPos)
	render.SetMaterial(CABLE_MATERIAL);
	if(self.hooked)then
		render.DrawBeam(startPos,endPos,2.0,0.0,endPos:Distance(startPos),CABLE_COLOUR)
	else
		local distance = endPos:Distance(startPos);
		local stretched = self.Entity:GetNWFloat("stretchDist");
		local nowTime = CurTime();
		stretched = stretched + (CABLE_SPEED * (nowTime - self.curTime));
		if(stretched > distance)then
			self:EmitSound(HOOKED_SOUND);
			stretched = distance;
			self.hooked = true;
		end
		
		render.DrawBeam(startPos,startPos + (endPos - startPos) * (stretched / distance),2.0,0.0,stretched,CABLE_COLOUR);
		
		self.curTime = nowTime;
		self.Entity:SetNWFloat("stretchDist", stretched);
	end
end

function ENT:SetDestination(pos)
	self.Entity:SetNWVector("destination", pos);
end
function ENT:GetDestination()
	return self.Entity:GetNWVector("destination");
end
function ENT:IsHooked()
	return self.hooked;
end

// The empty stub of shame. Don't look at it. It's too sad. :(
function ENT:Think()
	// ...
end


-- "addons\\anime\\lua\\entities\\yetanother3dmgrope.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 3DMG/OMG Rope
// Author: mmys
// See the main 3DMG file for header.

AddCSLuaFile()

ENT.Type = "anim"; // Default, but let's be safe.
ENT.ClassName = "yetanother3dmgrope"

////////////////////////////////////////////////////////////////////////////////
// Constants

local HOOKED_SOUND = Sound( "Metal.SawbladeStick" )

local CABLE_MATERIAL = Material("cable/cable");
local CABLE_COLOUR = Color(180,180,180,255);
local CABLE_SPEED = 5000.0;

function ENT:Initialize()
	self.Entity:DrawShadow(false);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetNWFloat("stretchDist", 0.0);
	self.Entity:SetNWBool("hooked", false);
	self.curTime = CurTime();
	self.hooked = false;
end
function ENT:Draw()	
	local owner = self.Entity:GetOwner()
	if(!IsValid(owner))then
		return;
	end
	
	// I don't know if I need a local client check here.
	
	local origin = self.Entity:GetPos();
	origin.z = origin.z - 28.0;	// very hacky
	local destination = self:GetDestination();
	self:DrawCable(origin,destination);
end

function ENT:DrawCable(startPos, endPos)
	render.SetMaterial(CABLE_MATERIAL);
	if(self.hooked)then
		render.DrawBeam(startPos,endPos,2.0,0.0,endPos:Distance(startPos),CABLE_COLOUR)
	else
		local distance = endPos:Distance(startPos);
		local stretched = self.Entity:GetNWFloat("stretchDist");
		local nowTime = CurTime();
		stretched = stretched + (CABLE_SPEED * (nowTime - self.curTime));
		if(stretched > distance)then
			self:EmitSound(HOOKED_SOUND);
			stretched = distance;
			self.hooked = true;
		end
		
		render.DrawBeam(startPos,startPos + (endPos - startPos) * (stretched / distance),2.0,0.0,stretched,CABLE_COLOUR);
		
		self.curTime = nowTime;
		self.Entity:SetNWFloat("stretchDist", stretched);
	end
end

function ENT:SetDestination(pos)
	self.Entity:SetNWVector("destination", pos);
end
function ENT:GetDestination()
	return self.Entity:GetNWVector("destination");
end
function ENT:IsHooked()
	return self.hooked;
end

// The empty stub of shame. Don't look at it. It's too sad. :(
function ENT:Think()
	// ...
end


-- "addons\\anime\\lua\\entities\\yetanother3dmgrope.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 3DMG/OMG Rope
// Author: mmys
// See the main 3DMG file for header.

AddCSLuaFile()

ENT.Type = "anim"; // Default, but let's be safe.
ENT.ClassName = "yetanother3dmgrope"

////////////////////////////////////////////////////////////////////////////////
// Constants

local HOOKED_SOUND = Sound( "Metal.SawbladeStick" )

local CABLE_MATERIAL = Material("cable/cable");
local CABLE_COLOUR = Color(180,180,180,255);
local CABLE_SPEED = 5000.0;

function ENT:Initialize()
	self.Entity:DrawShadow(false);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetNWFloat("stretchDist", 0.0);
	self.Entity:SetNWBool("hooked", false);
	self.curTime = CurTime();
	self.hooked = false;
end
function ENT:Draw()	
	local owner = self.Entity:GetOwner()
	if(!IsValid(owner))then
		return;
	end
	
	// I don't know if I need a local client check here.
	
	local origin = self.Entity:GetPos();
	origin.z = origin.z - 28.0;	// very hacky
	local destination = self:GetDestination();
	self:DrawCable(origin,destination);
end

function ENT:DrawCable(startPos, endPos)
	render.SetMaterial(CABLE_MATERIAL);
	if(self.hooked)then
		render.DrawBeam(startPos,endPos,2.0,0.0,endPos:Distance(startPos),CABLE_COLOUR)
	else
		local distance = endPos:Distance(startPos);
		local stretched = self.Entity:GetNWFloat("stretchDist");
		local nowTime = CurTime();
		stretched = stretched + (CABLE_SPEED * (nowTime - self.curTime));
		if(stretched > distance)then
			self:EmitSound(HOOKED_SOUND);
			stretched = distance;
			self.hooked = true;
		end
		
		render.DrawBeam(startPos,startPos + (endPos - startPos) * (stretched / distance),2.0,0.0,stretched,CABLE_COLOUR);
		
		self.curTime = nowTime;
		self.Entity:SetNWFloat("stretchDist", stretched);
	end
end

function ENT:SetDestination(pos)
	self.Entity:SetNWVector("destination", pos);
end
function ENT:GetDestination()
	return self.Entity:GetNWVector("destination");
end
function ENT:IsHooked()
	return self.hooked;
end

// The empty stub of shame. Don't look at it. It's too sad. :(
function ENT:Think()
	// ...
end


-- "addons\\anime\\lua\\entities\\yetanother3dmgrope.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 3DMG/OMG Rope
// Author: mmys
// See the main 3DMG file for header.

AddCSLuaFile()

ENT.Type = "anim"; // Default, but let's be safe.
ENT.ClassName = "yetanother3dmgrope"

////////////////////////////////////////////////////////////////////////////////
// Constants

local HOOKED_SOUND = Sound( "Metal.SawbladeStick" )

local CABLE_MATERIAL = Material("cable/cable");
local CABLE_COLOUR = Color(180,180,180,255);
local CABLE_SPEED = 5000.0;

function ENT:Initialize()
	self.Entity:DrawShadow(false);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetNWFloat("stretchDist", 0.0);
	self.Entity:SetNWBool("hooked", false);
	self.curTime = CurTime();
	self.hooked = false;
end
function ENT:Draw()	
	local owner = self.Entity:GetOwner()
	if(!IsValid(owner))then
		return;
	end
	
	// I don't know if I need a local client check here.
	
	local origin = self.Entity:GetPos();
	origin.z = origin.z - 28.0;	// very hacky
	local destination = self:GetDestination();
	self:DrawCable(origin,destination);
end

function ENT:DrawCable(startPos, endPos)
	render.SetMaterial(CABLE_MATERIAL);
	if(self.hooked)then
		render.DrawBeam(startPos,endPos,2.0,0.0,endPos:Distance(startPos),CABLE_COLOUR)
	else
		local distance = endPos:Distance(startPos);
		local stretched = self.Entity:GetNWFloat("stretchDist");
		local nowTime = CurTime();
		stretched = stretched + (CABLE_SPEED * (nowTime - self.curTime));
		if(stretched > distance)then
			self:EmitSound(HOOKED_SOUND);
			stretched = distance;
			self.hooked = true;
		end
		
		render.DrawBeam(startPos,startPos + (endPos - startPos) * (stretched / distance),2.0,0.0,stretched,CABLE_COLOUR);
		
		self.curTime = nowTime;
		self.Entity:SetNWFloat("stretchDist", stretched);
	end
end

function ENT:SetDestination(pos)
	self.Entity:SetNWVector("destination", pos);
end
function ENT:GetDestination()
	return self.Entity:GetNWVector("destination");
end
function ENT:IsHooked()
	return self.hooked;
end

// The empty stub of shame. Don't look at it. It's too sad. :(
function ENT:Think()
	// ...
end


