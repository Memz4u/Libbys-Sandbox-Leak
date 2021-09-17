-- "addons\\anime\\lua\\weapons\\yetanother3dmg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 
// INFORMATION AVAILABLE FOR PUBLIC DISCLOSURE:
//  3D Maneuvering Gear/Omni-directional Maneuver Gear
//  Author: mmys
//  Version: 1.1 (2015-1-1)
// 
// Thank you to InsanityBringer for creating the 3DMG model.
// Thank you to everyone who made a 3DMG or grappling hook SWEP before.
//
// WHAT IS THIS?
//  This is a SWEP for the 3D Maneuver Gear from Attack on Titan/Shingeki no
//  Kyojin. It only replicates the actual maneuver gear--no box cutters at the
//  moment.
// 
// WHY MAKE THIS?
//  I felt the existing options weren't that great (no offense to their
//  creators)--in particular, none of them, from what I saw, allowed the use of
//  two separate hooks. The physics were also strange and slow.
// 
// SO IS IT OK IF I POKE AROUND HERE?
//  Given that I wrote a README section here, yeah, you can go ahead and poke
//  around. You can look through the code if you want--that's fine. If you do
//  use bits and pieces of it, then credit is very much appreciated (I'd also
//  love to see what you're making!)
// 

SWEP.PrintName = "Yet Another 3DMG"
SWEP.Author = "mmys"
SWEP.Purpose = "Swinging around, smacking into buildings, and breaking your legs."
SWEP.Instructions = "3D Maneuver Gear. LMB and RMB fire left and right hooks; hold to keep them. DUCK to try and maintain rope length, for swings. JUMP to speed up rope pulling."

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

// TODO: Implement a gas system.
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.ViewModel			= "models/weapons/v_3DMG.mdl"
SWEP.WorldModel			= "models/weapons/w_3DMG.mdl"

////////////////////////////////////////////////////////////////////////////////
// CONSTANTS
// Well, they're not really constant since you can modify them now, but hey.

// Engine consts
local TIME_DELTA = 0.05;
local ZERO_VECTOR_CONST = Vector(0,0,0);

// Hook related constants.
local MAX_HOOKS = 2;	// Note that simply increasing this won't work;
						//  there are a lot of other stray references you need to update.
local TRACING_DISTANCE = GetConVarNumber("sv_ya3dmg_tracing_distance"); // 20000.0;
local HOOK_DISTANCE = GetConVarNumber("sv_ya3dmg_hook_distance"); // 5000.0;
//local HOOK_AIM_DISTANCE = GetConVarNumber("sv_ya3dmg_hookaim_distance"); // 4300.0;

local HOOK_SPEED = GetConVarNumber("sv_ya3dmg_hookspeed"); //1500.0;
local HOOK_SHORTENED_SPEED = GetConVarNumber("sv_ya3dmg_hookspeedretract"); //2000.0;

local HOOK_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeed_super"); //3000.0;
local HOOK_SHORTENED_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeedretract_super"); // 5000.0;

local HOOK_CENTRIPETAL_MAX = GetConVarNumber("sv_ya3dmg_maxcentripetal");//8300.0;

// Smoke related constants.
local SMOKE_TYPE = 1;	// Dummy value at the moment.
local SMOKE_ENABLED = GetConVarNumber("sv_ya3dmg_smoke_enabled");			// true
local SMOKE_NORMAL_TIME = GetConVarNumber("sv_ya3dmg_smoke_normal_time")	// 0.8
local SMOKE_SUPER_TIME = GetConVarNumber("sv_ya3dmg_smoke_super_time")	// 1.4

// Various other things.
local SHOOT_SOUND = Sound("Weapon_Crossbow.Single")
local BAD_SOUND = Sound("Weapon_SMG1.Empty")

// Aim assist stuff.
local AIM_TRIG_DIVISIONS = 15;
local AIM_ANGLE_BREADTH = 4.0; // One half of how far our aim assist goes, in degrees.

local COLOUR_RED = Color(255, 0, 0);
local COLOUR_GREEN = Color(0, 255, 0);

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//          DON'T EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING!          //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

local AIM_SIN_TABLE = {}
for i=-AIM_TRIG_DIVISIONS,AIM_TRIG_DIVISIONS do
	AIM_SIN_TABLE[i] = math.sin((AIM_ANGLE_BREADTH / AIM_TRIG_DIVISIONS * i) * 0.01745329251994329576923690768489);
end


////////////////////////////////////////////////////////////////////////////////
//   HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// RayTracePoint(Vector, Vector, Table) -> TraceResult
// Traces a ray from 'origin' to 'dest', and returns the result of said ray.
local function RayTracePoint(origin, dest, filters)
	local trace = {};
	
	trace.start = origin;
	trace.endpos = dest;
	trace.filter = filters;
	
	return util.TraceLine(trace);
end

// RayTrace(Vector, Vector, Table) -> TraceResult
// 'direction' should be a unit vector for best results.
// Traces a ray from 'origin', in the direction of 'direction', and returns the result
//  of said ray.
local function RayTrace(origin, direction, filters)
	return RayTracePoint(origin, origin + direction * TRACING_DISTANCE, filters);
end

////////////////////////////////////////////////////////////////////////////////
//   CVAR MONITORING CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:AttachCallbackNum(varn, func)
	local scid = "cl";
	if(SERVER)then
		scid = "sv";
	end
	cvars.AddChangeCallback("sv_ya3dmg_" .. varn, function(n, ov, nv)
		func(tonumber(nv));
		self:SetNWBool("sv_vars_changed", true);
		
		self:CallOnClient("RefreshCVars");
		//net.Start(NET_UPDATE_STRING);
		//	net.WriteBit(true);
		//net.Send(self.Owner);
	end, "sv_ya3dmg_" .. varn .. scid);
	self.callbacks["sv_ya3dmg_" .. varn] = func;
end
function SWEP:PrepareCVarChanges()
	self.callbacks = {};
		
	self:AttachCallbackNum("hookspeed", 		function(v)	
		HOOK_SPEED = v;
	end)
	self:AttachCallbackNum("hookspeedretract", function(v)	HOOK_SHORTENED_SPEED = v; end)
	self:AttachCallbackNum("hookspeed_super", 			function(v)	HOOK_SPEED_SUPER = v; end)
	self:AttachCallbackNum("hookspeedretract_super", 	function(v)	HOOK_SHORTENED_SPEED_SUPER = v; end)
	self:AttachCallbackNum("maxcentripetal", 	function(v)	HOOK_CENTRIPETAL_MAX = v; end)
	self:AttachCallbackNum("hook_distance", 	function(v)	HOOK_DISTANCE = v; end)
	self:AttachCallbackNum("tracing_distance", 	function(v)	TRACING_DISTANCE = v; end)
	self:AttachCallbackNum("smoke_enabled", 	function(v)	
		SMOKE_ENABLED = v; 
	end)
	self:AttachCallbackNum("smoke_normal_time", 	function(v)	SMOKE_NORMAL_TIME = v; end)
	self:AttachCallbackNum("smoke_super_time", 	function(v)	SMOKE_SUPER_TIME = v; end)
end

function SWEP:RefreshCVars()
	for k, v in pairs(self.callbacks) do
		if(ConVarExists(k))then
			v(GetConVar(k):GetFloat());
		end
	end
end

function SWEP:UnregisterCVars()
	for k, _ in pairs(self.callbacks) do
		if(SERVER)then
			cvars.RemoveChangeCallback(k .. "sv");
		else
			cvars.RemoveChangeCallback(k .. "cl");
		end
	end
end

////////////////////////////////////////////////////////////////////////////////
//   CORE CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:Initialize()
	// This is super-ugly, I know, I know.
	self.leftHook = {i = 0, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.rightHook = {i = 1, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.leftHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = 1, drawCol = Color(255, 0, 0)};
	self.rightHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = -1, drawCol = Color(0, 255, 0)};
	
	self.hooks = {left = self.leftHook, right = self.rightHook};
	self.aims = {left = self.leftHookAiming, right = self.rightHookAiming};
	self.timeDetails = {["last"] = CurTime()};
	
	self:SetNWBool("sv_vars_changed", false);
	
	if(!SERVER)then
		self.screenWidth = surface.ScreenWidth();
		self.screenHeight = surface.ScreenHeight();
	end
	
	self:PrepareCVarChanges();
	self:RefreshCVars();
	
	// Prepare to receive the flag.
	//if(CLIENT)then
	//	net.Receive(NET_UPDATE_STRING, function (length, ply)
	//		self:RefreshCVars();
	//	end)
	//end
end

function SWEP:OnExit()
	self:ReleaseHook("left");
	self:ReleaseHook("right");
end

function SWEP:Think()
	if(!self.Owner || self.Owner == NULL)then 
		return 
	end
	
	if(self.Owner:KeyPressed(IN_ATTACK))then
		self:FireLeftHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK))then
		self:ReleaseLeftHook();
	end
	if(self.Owner:KeyPressed(IN_ATTACK2))then
		self:FireRightHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK2))then
		self:ReleaseRightHook();
	end
	
	self:UpdatePhysics();
end

function SWEP:Deploy()
	self:RefreshCVars();
end
function SWEP:Holster()
	self:OnExit();
	return true;
end
function SWEP:OnRemove()
	self:OnExit();
	self:UnregisterCVars();
	return true;
end


////////////////////////////////////////////////////////////////////////////////
//   FIRING CODE
////////////////////////////////////////////////////////////////////////////////

// Extra redundancy, in case think isn't handled at the same time/in the same way.
function SWEP:PrimaryAttack()
	self:FireLeftHook();
end
function SWEP:SecondaryAttack()
	self:FireRightHook();
end

// You shouldn't do this, by the way.
function SWEP:FireLeftHook()
	self:FireHook("left");
end
function SWEP:ReleaseLeftHook()
	self:ReleaseHook("left");
end
function SWEP:FireRightHook()
	self:FireHook("right");
end
function SWEP:ReleaseRightHook()
	self:ReleaseHook("right");
end

function SWEP:FireHook(key)
	local currentHook = self.hooks[key];
	
	if(currentHook.fired)then
		return;
	end
	
	// Both hooks go to the same place right now.
	local currentAim = self.aims[key].aimPos;
	if(currentAim == NULL)then
		return;
	end
		
	// Fire the hooks!
	local origin = self.Owner:GetShootPos();
	
	local hookTrace = RayTracePoint(origin, origin + (currentAim - origin) * 1.1 , { self.Owner, self.Weapon });
	if(!hookTrace.Hit)then
		self:EmitSound(BAD_SOUND);
	else
		local hitPos = hookTrace.HitPos;
		local distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance > HOOK_DISTANCE)then
			self:EmitSound(BAD_SOUND);
			return;
		end
		
		self:EmitSound(SHOOT_SOUND);
		self:AimHook(key);
		
		if(currentHook.rope != NULL)then
			currentHook.rope:Remove();
		end
		
		// Sets up the rope, server-side.
		if(SERVER)then
			currentHook.rope = ents.Create("yetanother3dmgrope");
			currentHook.rope:SetDestination(hitPos);
			
			currentHook.rope:SetParent( self );
			currentHook.rope:SetOwner( self.Owner );
			currentHook.rope:SetPos(ZERO_VECTOR_CONST);
			currentHook.rope:Spawn();
		end
		
		// We add some special handling now if we hit an entity.
		if(IsValid(hookTrace.Entity) && hookTrace.Entity:IsValid())then
			local hooked = hookTrace.Entity;
			
			currentHook.entityHooked = true;
			currentHook.entityTarget = hooked;
			
			local hookedPos = hooked:GetPos();
			currentHook.entityOX = (hitPos - hookedPos):Dot(hooked:GetRight());
			currentHook.entityOY = (hitPos - hookedPos):Dot(hooked:GetUp());
			currentHook.entityOZ = (hitPos - hookedPos):Dot(hooked:GetForward());
		else
			currentHook.entityHooked = false;
			currentHook.entityTarget = NULL;
		end
		
		currentHook.fired = true;
		currentHook.hookPosition = hitPos;
		currentHook.ropeLength = distance;
	end
end

function SWEP:ReleaseHook(key)
	local currentHook = self.hooks[key];
	if(!currentHook.fired)then
		return;
	end	
	if(SERVER)then
		currentHook.rope:Remove();
	end
	currentHook.fired = false;
end

////////////////////////////////////////////////////////////////////////////////
//   PHYSICS CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:UpdatePhysics()
	local time = CurTime();
	
	self:AimHooks();
	if(time - TIME_DELTA >= self.timeDetails.last)then
		self.timeDetails.last = time;
		
		local velocity = Vector(0,0,0);		
		for k,v in pairs(self.hooks) do
			velocity = velocity + self:UpdateHookPhysics(v, k);
		end		
		if(velocity.x != 0 || velocity.y != 0 || velocity.z != 0)then
			self.Owner:SetVelocity(velocity);
		end
	end
end

// SWEP:UpdateHookPhysics(Hook Table) -> Vector
// Updates player physics according to the current hook.
function SWEP:UpdateHookPhysics(cHook, key)
	local origin = self.Owner:GetPos();
	
	if(SMOKE_ENABLED == 1)then
		if(cHook.smokeTimer > 0.0)then
			local apos;
			apos = self.Owner:GetActiveWeapon():GetAttachment(cHook.i + 3);
			
			cHook.smokeTimer = cHook.smokeTimer - TIME_DELTA;
			// TODO: Add extra smoke effects, and change them by intensity.
			ParticleEffect("generic_smoke",apos.Pos,Angle(0,0,0),self.Owner);
		end
	end
	
	if(!cHook.fired)then
		return ZERO_VECTOR_CONST;
	end
	
	if(SERVER)then
		local apos = self.Owner:GetViewModel():GetAttachment(cHook.i + 1);
		cHook.rope:SetPos(apos.Pos);
	end
	
	local velocity = Vector(0,0,0)
	
	if(cHook.entityHooked)then
		local hooked = cHook.entityTarget;
		if(!IsValid(hooked))then
			self:ReleaseHook(key);
			return ZERO_VECTOR_CONST;
		end
		local hookedPos = hooked:GetPos();
		
		local newPos = hookedPos + cHook.entityOX * hooked:GetRight()
								 + cHook.entityOY * hooked:GetUp()
								 + cHook.entityOZ * hooked:GetForward();
		velocity = velocity + (newPos - cHook.hookPosition) / TIME_DELTA;
		cHook.hookPosition = newPos;
		if SERVER then
			cHook.rope:SetDestination(newPos);
		end
	end
	
	local hookVec = (cHook.hookPosition - origin);
	local distance = hookVec:Length();
	local hookDir = hookVec:GetNormalized();
	local hookSpeed;
	
	if(!self.Owner:KeyDown(IN_JUMP) && !self.Owner:KeyDown(IN_SPEED))then
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_NORMAL_TIME)then
			cHook.smokeTimer = SMOKE_NORMAL_TIME;
		end
		hookSpeed = HOOK_SPEED;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED;
		end
	else
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_SUPER_TIME)then
			cHook.smokeTimer = SMOKE_SUPER_TIME;
		end
		hookSpeed = HOOK_SPEED_SUPER;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED_SUPER;
		end
	end
	
	if(cHook.ropeLength > distance)then
		cHook.ropeLength = distance;
	end
	
	local userVelocity = self.Owner:GetVelocity();
	local speed = userVelocity:Length();
	// Apply centripetal force.
	if(self.Owner:KeyDown(IN_DUCK))then
		
		// Get the tangential velocity
		local tangentialSpeed = (userVelocity.x * hookVec.x + userVelocity.y * hookVec.y + userVelocity.z * hookVec.z) / (distance + 100.0);

		tangentialSpeed = math.sqrt(speed^2 - tangentialSpeed^2);
		
		local centripetal = tangentialSpeed^2 / (distance + 100.0);
		if(centripetal > HOOK_CENTRIPETAL_MAX)then
			centripetal = HOOK_CENTRIPETAL_MAX;
		end
		hookSpeed = hookSpeed * 0.3;
		if(cHook.ropeLength > distance)then
			hookSpeed = hookspeed + 2.0*(cHook.ropeLength - distance);
		end
		hookSpeed = hookSpeed + centripetal;
	end
	
	hookSpeed = hookSpeed - (0.000005 * (hookSpeed + speed)^2);
	
	velocity = (hookDir * hookSpeed) * TIME_DELTA;
	return velocity;
end

////////////////////////////////////////////////////////////////////////////////
//   AIM ASSIST CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:ViewModelDrawn()
	self:DrawAims();
	self:DrawModel();
end

function SWEP:DrawWorldModel()
	self:DrawAims();
	self:DrawModel();
end

////////////////////////////////////////////////////////////////////////////////

function SWEP:AimHooks()
	self:AimHook("left");
	self:AimHook("right");
end

function SWEP:DrawAims()
	local drawmaxs = Vector(8,8,8);
	local drawmins = -drawmaxs;

	for k,v in pairs(self.aims) do
		if(v.aimPos != NULL)then
			// TODO: Better norm handling.
			if(v.norm == NULL)then
				render.DrawWireframeBox(v.aimPos, v.norm:Angle(), drawmaxs, drawmins, v.drawCol,true);
			else
				render.DrawWireframeBox(v.aimPos,self.Owner:GetAimVector():Angle() , drawmaxs, drawmins, v.drawCol,true);
			end
		end
	end
end

function SWEP:AimHook(key)
	local aimSet = self.aims[key];
	if(self.hooks[key].fired)then
		return;
	end
	
	local traceDist = HOOK_DISTANCE;
	
	local origin = self.Owner:EyePos();
	local aimVector = self.Owner:GetAimVector():GetNormalized();
	local aimPoint = origin + aimVector * traceDist;
	local filter = {self.Owner, self.Weapon};
		
	local values = {};
	local multiplier = aimSet.mult;
	local trace;
	
	local avr = -aimVector:Angle():Right();
	local avu = aimVector:Angle():Up();
	local offsets = {avr, (multiplier * avu + 0.2 * avr):GetNormalized()}
	
	local desiredIndex = -1;
	local desiredDistance = 1;
	local desiredOffsetIndex = -1;
	
	for oIndex=1,2 do
		local offsetVector = offsets[oIndex];
		local distances = {}
		
		// Perform the traces to solve for distance, first.
		for i=0,AIM_TRIG_DIVISIONS do
			trace = util.TraceLine({start = origin, endpos = aimPoint + offsetVector * AIM_SIN_TABLE[i*multiplier] * traceDist, filter = filter});
			if(!trace.Hit)then
				values[i] = traceDist; // Maybe apply an additional penalty?
				distances[i] = values[i];
			else
				values[i] = trace.HitPos:Distance(origin);
				distances[i] = values[i];
			end
			if(i != 0)then
				values[i-1] = values[i-1] - values[i];
			end
		end
		
		local mean = 0;
		local firstderivs = {};
		// Compute second derivatives.
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			firstderivs[i] = values[i];
			values[i] = values[i] - values[i+1];
			mean = mean + values[i];
		end
		
		mean = mean / (AIM_TRIG_DIVISIONS - 2);
		local stddev = 0;
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			stddev = stddev + (values[i] - mean)^2;
		end
		
		stddev = math.sqrt(stddev / (AIM_TRIG_DIVISIONS - 2));
		
		// TODO: Allow it to consider all candidates in a row, rather than just the first.
		local localdesire = 0;
		if(stddev > 50.0)then
			// Next we proceed directionally until we find a substantial change.
			for i=0,AIM_TRIG_DIVISIONS - 3 do
				// We consider it interesting if it's one standard deviation away.
				if((values[i] - mean) / stddev > 1.0 && firstderivs[i] > 0.0)then
					localdesire = i + 2;
					break;
				end
			end
		end
		
		if(localdesire > 0)then
			if(desiredIndex == -1 || localdesire*(distances[localdesire] / desiredDistance) < desiredIndex)then
				desiredIndex = localdesire;
				desiredDistance = distances[localdesire];
				desiredOffsetIndex = oIndex;
			end
		end
	end
	
	if(desiredIndex == -1)then
		desiredIndex = 0;
	end
	if(desiredOffsetIndex == -1)then
		desiredOffsetIndex = 1;
	end
	
	trace = util.TraceLine({start = origin, endpos = aimPoint + offsets[desiredOffsetIndex] * AIM_SIN_TABLE[desiredIndex*multiplier] * traceDist, filter = filter});
	if(trace.Hit)then
		aimSet.aimPos = trace.HitPos;
		aimSet.norm = trace.HitNorm;
	else
		aimSet.aimPos = NULL;
		aimSet.norm = NULL;
	end
end


function SWEP:DrawHUD()
	local acceptable = false;
	
	// Do a check on the current aim.
	local origin = self.Owner:GetShootPos();
	local hookTrace = RayTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector(), { self.Owner, self.Weapon });
	local distance = -1.0;
		
	if(hookTrace.Hit)then
		local hitPos = hookTrace.HitPos;
		distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance <= HOOK_DISTANCE)then
			acceptable = true;
		end
	end
	
	if(!SERVER)then
		local halfw = self.screenWidth / 2.0;
		local halfh = self.screenHeight / 2.0;
		if(acceptable)then
			surface.DrawCircle(halfw, halfh, 15.0 * (1.0 - distance / HOOK_DISTANCE), COLOUR_GREEN);
		else
			local radius = 5.0 + 20.0 * (distance / HOOK_DISTANCE - 1.0);
			if(radius > 25.0)then
				radius = 25.0;
			end
			if(distance == -1.0)then
				radius = 30.0;
			end
			surface.DrawCircle(halfw, halfh, radius, COLOUR_RED);
		end
	end
	
end



-- "addons\\anime\\lua\\weapons\\yetanother3dmg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 
// INFORMATION AVAILABLE FOR PUBLIC DISCLOSURE:
//  3D Maneuvering Gear/Omni-directional Maneuver Gear
//  Author: mmys
//  Version: 1.1 (2015-1-1)
// 
// Thank you to InsanityBringer for creating the 3DMG model.
// Thank you to everyone who made a 3DMG or grappling hook SWEP before.
//
// WHAT IS THIS?
//  This is a SWEP for the 3D Maneuver Gear from Attack on Titan/Shingeki no
//  Kyojin. It only replicates the actual maneuver gear--no box cutters at the
//  moment.
// 
// WHY MAKE THIS?
//  I felt the existing options weren't that great (no offense to their
//  creators)--in particular, none of them, from what I saw, allowed the use of
//  two separate hooks. The physics were also strange and slow.
// 
// SO IS IT OK IF I POKE AROUND HERE?
//  Given that I wrote a README section here, yeah, you can go ahead and poke
//  around. You can look through the code if you want--that's fine. If you do
//  use bits and pieces of it, then credit is very much appreciated (I'd also
//  love to see what you're making!)
// 

SWEP.PrintName = "Yet Another 3DMG"
SWEP.Author = "mmys"
SWEP.Purpose = "Swinging around, smacking into buildings, and breaking your legs."
SWEP.Instructions = "3D Maneuver Gear. LMB and RMB fire left and right hooks; hold to keep them. DUCK to try and maintain rope length, for swings. JUMP to speed up rope pulling."

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

// TODO: Implement a gas system.
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.ViewModel			= "models/weapons/v_3DMG.mdl"
SWEP.WorldModel			= "models/weapons/w_3DMG.mdl"

////////////////////////////////////////////////////////////////////////////////
// CONSTANTS
// Well, they're not really constant since you can modify them now, but hey.

// Engine consts
local TIME_DELTA = 0.05;
local ZERO_VECTOR_CONST = Vector(0,0,0);

// Hook related constants.
local MAX_HOOKS = 2;	// Note that simply increasing this won't work;
						//  there are a lot of other stray references you need to update.
local TRACING_DISTANCE = GetConVarNumber("sv_ya3dmg_tracing_distance"); // 20000.0;
local HOOK_DISTANCE = GetConVarNumber("sv_ya3dmg_hook_distance"); // 5000.0;
//local HOOK_AIM_DISTANCE = GetConVarNumber("sv_ya3dmg_hookaim_distance"); // 4300.0;

local HOOK_SPEED = GetConVarNumber("sv_ya3dmg_hookspeed"); //1500.0;
local HOOK_SHORTENED_SPEED = GetConVarNumber("sv_ya3dmg_hookspeedretract"); //2000.0;

local HOOK_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeed_super"); //3000.0;
local HOOK_SHORTENED_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeedretract_super"); // 5000.0;

local HOOK_CENTRIPETAL_MAX = GetConVarNumber("sv_ya3dmg_maxcentripetal");//8300.0;

// Smoke related constants.
local SMOKE_TYPE = 1;	// Dummy value at the moment.
local SMOKE_ENABLED = GetConVarNumber("sv_ya3dmg_smoke_enabled");			// true
local SMOKE_NORMAL_TIME = GetConVarNumber("sv_ya3dmg_smoke_normal_time")	// 0.8
local SMOKE_SUPER_TIME = GetConVarNumber("sv_ya3dmg_smoke_super_time")	// 1.4

// Various other things.
local SHOOT_SOUND = Sound("Weapon_Crossbow.Single")
local BAD_SOUND = Sound("Weapon_SMG1.Empty")

// Aim assist stuff.
local AIM_TRIG_DIVISIONS = 15;
local AIM_ANGLE_BREADTH = 4.0; // One half of how far our aim assist goes, in degrees.

local COLOUR_RED = Color(255, 0, 0);
local COLOUR_GREEN = Color(0, 255, 0);

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//          DON'T EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING!          //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

local AIM_SIN_TABLE = {}
for i=-AIM_TRIG_DIVISIONS,AIM_TRIG_DIVISIONS do
	AIM_SIN_TABLE[i] = math.sin((AIM_ANGLE_BREADTH / AIM_TRIG_DIVISIONS * i) * 0.01745329251994329576923690768489);
end


////////////////////////////////////////////////////////////////////////////////
//   HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// RayTracePoint(Vector, Vector, Table) -> TraceResult
// Traces a ray from 'origin' to 'dest', and returns the result of said ray.
local function RayTracePoint(origin, dest, filters)
	local trace = {};
	
	trace.start = origin;
	trace.endpos = dest;
	trace.filter = filters;
	
	return util.TraceLine(trace);
end

// RayTrace(Vector, Vector, Table) -> TraceResult
// 'direction' should be a unit vector for best results.
// Traces a ray from 'origin', in the direction of 'direction', and returns the result
//  of said ray.
local function RayTrace(origin, direction, filters)
	return RayTracePoint(origin, origin + direction * TRACING_DISTANCE, filters);
end

////////////////////////////////////////////////////////////////////////////////
//   CVAR MONITORING CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:AttachCallbackNum(varn, func)
	local scid = "cl";
	if(SERVER)then
		scid = "sv";
	end
	cvars.AddChangeCallback("sv_ya3dmg_" .. varn, function(n, ov, nv)
		func(tonumber(nv));
		self:SetNWBool("sv_vars_changed", true);
		
		self:CallOnClient("RefreshCVars");
		//net.Start(NET_UPDATE_STRING);
		//	net.WriteBit(true);
		//net.Send(self.Owner);
	end, "sv_ya3dmg_" .. varn .. scid);
	self.callbacks["sv_ya3dmg_" .. varn] = func;
end
function SWEP:PrepareCVarChanges()
	self.callbacks = {};
		
	self:AttachCallbackNum("hookspeed", 		function(v)	
		HOOK_SPEED = v;
	end)
	self:AttachCallbackNum("hookspeedretract", function(v)	HOOK_SHORTENED_SPEED = v; end)
	self:AttachCallbackNum("hookspeed_super", 			function(v)	HOOK_SPEED_SUPER = v; end)
	self:AttachCallbackNum("hookspeedretract_super", 	function(v)	HOOK_SHORTENED_SPEED_SUPER = v; end)
	self:AttachCallbackNum("maxcentripetal", 	function(v)	HOOK_CENTRIPETAL_MAX = v; end)
	self:AttachCallbackNum("hook_distance", 	function(v)	HOOK_DISTANCE = v; end)
	self:AttachCallbackNum("tracing_distance", 	function(v)	TRACING_DISTANCE = v; end)
	self:AttachCallbackNum("smoke_enabled", 	function(v)	
		SMOKE_ENABLED = v; 
	end)
	self:AttachCallbackNum("smoke_normal_time", 	function(v)	SMOKE_NORMAL_TIME = v; end)
	self:AttachCallbackNum("smoke_super_time", 	function(v)	SMOKE_SUPER_TIME = v; end)
end

function SWEP:RefreshCVars()
	for k, v in pairs(self.callbacks) do
		if(ConVarExists(k))then
			v(GetConVar(k):GetFloat());
		end
	end
end

function SWEP:UnregisterCVars()
	for k, _ in pairs(self.callbacks) do
		if(SERVER)then
			cvars.RemoveChangeCallback(k .. "sv");
		else
			cvars.RemoveChangeCallback(k .. "cl");
		end
	end
end

////////////////////////////////////////////////////////////////////////////////
//   CORE CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:Initialize()
	// This is super-ugly, I know, I know.
	self.leftHook = {i = 0, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.rightHook = {i = 1, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.leftHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = 1, drawCol = Color(255, 0, 0)};
	self.rightHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = -1, drawCol = Color(0, 255, 0)};
	
	self.hooks = {left = self.leftHook, right = self.rightHook};
	self.aims = {left = self.leftHookAiming, right = self.rightHookAiming};
	self.timeDetails = {["last"] = CurTime()};
	
	self:SetNWBool("sv_vars_changed", false);
	
	if(!SERVER)then
		self.screenWidth = surface.ScreenWidth();
		self.screenHeight = surface.ScreenHeight();
	end
	
	self:PrepareCVarChanges();
	self:RefreshCVars();
	
	// Prepare to receive the flag.
	//if(CLIENT)then
	//	net.Receive(NET_UPDATE_STRING, function (length, ply)
	//		self:RefreshCVars();
	//	end)
	//end
end

function SWEP:OnExit()
	self:ReleaseHook("left");
	self:ReleaseHook("right");
end

function SWEP:Think()
	if(!self.Owner || self.Owner == NULL)then 
		return 
	end
	
	if(self.Owner:KeyPressed(IN_ATTACK))then
		self:FireLeftHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK))then
		self:ReleaseLeftHook();
	end
	if(self.Owner:KeyPressed(IN_ATTACK2))then
		self:FireRightHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK2))then
		self:ReleaseRightHook();
	end
	
	self:UpdatePhysics();
end

function SWEP:Deploy()
	self:RefreshCVars();
end
function SWEP:Holster()
	self:OnExit();
	return true;
end
function SWEP:OnRemove()
	self:OnExit();
	self:UnregisterCVars();
	return true;
end


////////////////////////////////////////////////////////////////////////////////
//   FIRING CODE
////////////////////////////////////////////////////////////////////////////////

// Extra redundancy, in case think isn't handled at the same time/in the same way.
function SWEP:PrimaryAttack()
	self:FireLeftHook();
end
function SWEP:SecondaryAttack()
	self:FireRightHook();
end

// You shouldn't do this, by the way.
function SWEP:FireLeftHook()
	self:FireHook("left");
end
function SWEP:ReleaseLeftHook()
	self:ReleaseHook("left");
end
function SWEP:FireRightHook()
	self:FireHook("right");
end
function SWEP:ReleaseRightHook()
	self:ReleaseHook("right");
end

function SWEP:FireHook(key)
	local currentHook = self.hooks[key];
	
	if(currentHook.fired)then
		return;
	end
	
	// Both hooks go to the same place right now.
	local currentAim = self.aims[key].aimPos;
	if(currentAim == NULL)then
		return;
	end
		
	// Fire the hooks!
	local origin = self.Owner:GetShootPos();
	
	local hookTrace = RayTracePoint(origin, origin + (currentAim - origin) * 1.1 , { self.Owner, self.Weapon });
	if(!hookTrace.Hit)then
		self:EmitSound(BAD_SOUND);
	else
		local hitPos = hookTrace.HitPos;
		local distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance > HOOK_DISTANCE)then
			self:EmitSound(BAD_SOUND);
			return;
		end
		
		self:EmitSound(SHOOT_SOUND);
		self:AimHook(key);
		
		if(currentHook.rope != NULL)then
			currentHook.rope:Remove();
		end
		
		// Sets up the rope, server-side.
		if(SERVER)then
			currentHook.rope = ents.Create("yetanother3dmgrope");
			currentHook.rope:SetDestination(hitPos);
			
			currentHook.rope:SetParent( self );
			currentHook.rope:SetOwner( self.Owner );
			currentHook.rope:SetPos(ZERO_VECTOR_CONST);
			currentHook.rope:Spawn();
		end
		
		// We add some special handling now if we hit an entity.
		if(IsValid(hookTrace.Entity) && hookTrace.Entity:IsValid())then
			local hooked = hookTrace.Entity;
			
			currentHook.entityHooked = true;
			currentHook.entityTarget = hooked;
			
			local hookedPos = hooked:GetPos();
			currentHook.entityOX = (hitPos - hookedPos):Dot(hooked:GetRight());
			currentHook.entityOY = (hitPos - hookedPos):Dot(hooked:GetUp());
			currentHook.entityOZ = (hitPos - hookedPos):Dot(hooked:GetForward());
		else
			currentHook.entityHooked = false;
			currentHook.entityTarget = NULL;
		end
		
		currentHook.fired = true;
		currentHook.hookPosition = hitPos;
		currentHook.ropeLength = distance;
	end
end

function SWEP:ReleaseHook(key)
	local currentHook = self.hooks[key];
	if(!currentHook.fired)then
		return;
	end	
	if(SERVER)then
		currentHook.rope:Remove();
	end
	currentHook.fired = false;
end

////////////////////////////////////////////////////////////////////////////////
//   PHYSICS CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:UpdatePhysics()
	local time = CurTime();
	
	self:AimHooks();
	if(time - TIME_DELTA >= self.timeDetails.last)then
		self.timeDetails.last = time;
		
		local velocity = Vector(0,0,0);		
		for k,v in pairs(self.hooks) do
			velocity = velocity + self:UpdateHookPhysics(v, k);
		end		
		if(velocity.x != 0 || velocity.y != 0 || velocity.z != 0)then
			self.Owner:SetVelocity(velocity);
		end
	end
end

// SWEP:UpdateHookPhysics(Hook Table) -> Vector
// Updates player physics according to the current hook.
function SWEP:UpdateHookPhysics(cHook, key)
	local origin = self.Owner:GetPos();
	
	if(SMOKE_ENABLED == 1)then
		if(cHook.smokeTimer > 0.0)then
			local apos;
			apos = self.Owner:GetActiveWeapon():GetAttachment(cHook.i + 3);
			
			cHook.smokeTimer = cHook.smokeTimer - TIME_DELTA;
			// TODO: Add extra smoke effects, and change them by intensity.
			ParticleEffect("generic_smoke",apos.Pos,Angle(0,0,0),self.Owner);
		end
	end
	
	if(!cHook.fired)then
		return ZERO_VECTOR_CONST;
	end
	
	if(SERVER)then
		local apos = self.Owner:GetViewModel():GetAttachment(cHook.i + 1);
		cHook.rope:SetPos(apos.Pos);
	end
	
	local velocity = Vector(0,0,0)
	
	if(cHook.entityHooked)then
		local hooked = cHook.entityTarget;
		if(!IsValid(hooked))then
			self:ReleaseHook(key);
			return ZERO_VECTOR_CONST;
		end
		local hookedPos = hooked:GetPos();
		
		local newPos = hookedPos + cHook.entityOX * hooked:GetRight()
								 + cHook.entityOY * hooked:GetUp()
								 + cHook.entityOZ * hooked:GetForward();
		velocity = velocity + (newPos - cHook.hookPosition) / TIME_DELTA;
		cHook.hookPosition = newPos;
		if SERVER then
			cHook.rope:SetDestination(newPos);
		end
	end
	
	local hookVec = (cHook.hookPosition - origin);
	local distance = hookVec:Length();
	local hookDir = hookVec:GetNormalized();
	local hookSpeed;
	
	if(!self.Owner:KeyDown(IN_JUMP) && !self.Owner:KeyDown(IN_SPEED))then
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_NORMAL_TIME)then
			cHook.smokeTimer = SMOKE_NORMAL_TIME;
		end
		hookSpeed = HOOK_SPEED;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED;
		end
	else
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_SUPER_TIME)then
			cHook.smokeTimer = SMOKE_SUPER_TIME;
		end
		hookSpeed = HOOK_SPEED_SUPER;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED_SUPER;
		end
	end
	
	if(cHook.ropeLength > distance)then
		cHook.ropeLength = distance;
	end
	
	local userVelocity = self.Owner:GetVelocity();
	local speed = userVelocity:Length();
	// Apply centripetal force.
	if(self.Owner:KeyDown(IN_DUCK))then
		
		// Get the tangential velocity
		local tangentialSpeed = (userVelocity.x * hookVec.x + userVelocity.y * hookVec.y + userVelocity.z * hookVec.z) / (distance + 100.0);

		tangentialSpeed = math.sqrt(speed^2 - tangentialSpeed^2);
		
		local centripetal = tangentialSpeed^2 / (distance + 100.0);
		if(centripetal > HOOK_CENTRIPETAL_MAX)then
			centripetal = HOOK_CENTRIPETAL_MAX;
		end
		hookSpeed = hookSpeed * 0.3;
		if(cHook.ropeLength > distance)then
			hookSpeed = hookspeed + 2.0*(cHook.ropeLength - distance);
		end
		hookSpeed = hookSpeed + centripetal;
	end
	
	hookSpeed = hookSpeed - (0.000005 * (hookSpeed + speed)^2);
	
	velocity = (hookDir * hookSpeed) * TIME_DELTA;
	return velocity;
end

////////////////////////////////////////////////////////////////////////////////
//   AIM ASSIST CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:ViewModelDrawn()
	self:DrawAims();
	self:DrawModel();
end

function SWEP:DrawWorldModel()
	self:DrawAims();
	self:DrawModel();
end

////////////////////////////////////////////////////////////////////////////////

function SWEP:AimHooks()
	self:AimHook("left");
	self:AimHook("right");
end

function SWEP:DrawAims()
	local drawmaxs = Vector(8,8,8);
	local drawmins = -drawmaxs;

	for k,v in pairs(self.aims) do
		if(v.aimPos != NULL)then
			// TODO: Better norm handling.
			if(v.norm == NULL)then
				render.DrawWireframeBox(v.aimPos, v.norm:Angle(), drawmaxs, drawmins, v.drawCol,true);
			else
				render.DrawWireframeBox(v.aimPos,self.Owner:GetAimVector():Angle() , drawmaxs, drawmins, v.drawCol,true);
			end
		end
	end
end

function SWEP:AimHook(key)
	local aimSet = self.aims[key];
	if(self.hooks[key].fired)then
		return;
	end
	
	local traceDist = HOOK_DISTANCE;
	
	local origin = self.Owner:EyePos();
	local aimVector = self.Owner:GetAimVector():GetNormalized();
	local aimPoint = origin + aimVector * traceDist;
	local filter = {self.Owner, self.Weapon};
		
	local values = {};
	local multiplier = aimSet.mult;
	local trace;
	
	local avr = -aimVector:Angle():Right();
	local avu = aimVector:Angle():Up();
	local offsets = {avr, (multiplier * avu + 0.2 * avr):GetNormalized()}
	
	local desiredIndex = -1;
	local desiredDistance = 1;
	local desiredOffsetIndex = -1;
	
	for oIndex=1,2 do
		local offsetVector = offsets[oIndex];
		local distances = {}
		
		// Perform the traces to solve for distance, first.
		for i=0,AIM_TRIG_DIVISIONS do
			trace = util.TraceLine({start = origin, endpos = aimPoint + offsetVector * AIM_SIN_TABLE[i*multiplier] * traceDist, filter = filter});
			if(!trace.Hit)then
				values[i] = traceDist; // Maybe apply an additional penalty?
				distances[i] = values[i];
			else
				values[i] = trace.HitPos:Distance(origin);
				distances[i] = values[i];
			end
			if(i != 0)then
				values[i-1] = values[i-1] - values[i];
			end
		end
		
		local mean = 0;
		local firstderivs = {};
		// Compute second derivatives.
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			firstderivs[i] = values[i];
			values[i] = values[i] - values[i+1];
			mean = mean + values[i];
		end
		
		mean = mean / (AIM_TRIG_DIVISIONS - 2);
		local stddev = 0;
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			stddev = stddev + (values[i] - mean)^2;
		end
		
		stddev = math.sqrt(stddev / (AIM_TRIG_DIVISIONS - 2));
		
		// TODO: Allow it to consider all candidates in a row, rather than just the first.
		local localdesire = 0;
		if(stddev > 50.0)then
			// Next we proceed directionally until we find a substantial change.
			for i=0,AIM_TRIG_DIVISIONS - 3 do
				// We consider it interesting if it's one standard deviation away.
				if((values[i] - mean) / stddev > 1.0 && firstderivs[i] > 0.0)then
					localdesire = i + 2;
					break;
				end
			end
		end
		
		if(localdesire > 0)then
			if(desiredIndex == -1 || localdesire*(distances[localdesire] / desiredDistance) < desiredIndex)then
				desiredIndex = localdesire;
				desiredDistance = distances[localdesire];
				desiredOffsetIndex = oIndex;
			end
		end
	end
	
	if(desiredIndex == -1)then
		desiredIndex = 0;
	end
	if(desiredOffsetIndex == -1)then
		desiredOffsetIndex = 1;
	end
	
	trace = util.TraceLine({start = origin, endpos = aimPoint + offsets[desiredOffsetIndex] * AIM_SIN_TABLE[desiredIndex*multiplier] * traceDist, filter = filter});
	if(trace.Hit)then
		aimSet.aimPos = trace.HitPos;
		aimSet.norm = trace.HitNorm;
	else
		aimSet.aimPos = NULL;
		aimSet.norm = NULL;
	end
end


function SWEP:DrawHUD()
	local acceptable = false;
	
	// Do a check on the current aim.
	local origin = self.Owner:GetShootPos();
	local hookTrace = RayTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector(), { self.Owner, self.Weapon });
	local distance = -1.0;
		
	if(hookTrace.Hit)then
		local hitPos = hookTrace.HitPos;
		distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance <= HOOK_DISTANCE)then
			acceptable = true;
		end
	end
	
	if(!SERVER)then
		local halfw = self.screenWidth / 2.0;
		local halfh = self.screenHeight / 2.0;
		if(acceptable)then
			surface.DrawCircle(halfw, halfh, 15.0 * (1.0 - distance / HOOK_DISTANCE), COLOUR_GREEN);
		else
			local radius = 5.0 + 20.0 * (distance / HOOK_DISTANCE - 1.0);
			if(radius > 25.0)then
				radius = 25.0;
			end
			if(distance == -1.0)then
				radius = 30.0;
			end
			surface.DrawCircle(halfw, halfh, radius, COLOUR_RED);
		end
	end
	
end



-- "addons\\anime\\lua\\weapons\\yetanother3dmg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 
// INFORMATION AVAILABLE FOR PUBLIC DISCLOSURE:
//  3D Maneuvering Gear/Omni-directional Maneuver Gear
//  Author: mmys
//  Version: 1.1 (2015-1-1)
// 
// Thank you to InsanityBringer for creating the 3DMG model.
// Thank you to everyone who made a 3DMG or grappling hook SWEP before.
//
// WHAT IS THIS?
//  This is a SWEP for the 3D Maneuver Gear from Attack on Titan/Shingeki no
//  Kyojin. It only replicates the actual maneuver gear--no box cutters at the
//  moment.
// 
// WHY MAKE THIS?
//  I felt the existing options weren't that great (no offense to their
//  creators)--in particular, none of them, from what I saw, allowed the use of
//  two separate hooks. The physics were also strange and slow.
// 
// SO IS IT OK IF I POKE AROUND HERE?
//  Given that I wrote a README section here, yeah, you can go ahead and poke
//  around. You can look through the code if you want--that's fine. If you do
//  use bits and pieces of it, then credit is very much appreciated (I'd also
//  love to see what you're making!)
// 

SWEP.PrintName = "Yet Another 3DMG"
SWEP.Author = "mmys"
SWEP.Purpose = "Swinging around, smacking into buildings, and breaking your legs."
SWEP.Instructions = "3D Maneuver Gear. LMB and RMB fire left and right hooks; hold to keep them. DUCK to try and maintain rope length, for swings. JUMP to speed up rope pulling."

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

// TODO: Implement a gas system.
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.ViewModel			= "models/weapons/v_3DMG.mdl"
SWEP.WorldModel			= "models/weapons/w_3DMG.mdl"

////////////////////////////////////////////////////////////////////////////////
// CONSTANTS
// Well, they're not really constant since you can modify them now, but hey.

// Engine consts
local TIME_DELTA = 0.05;
local ZERO_VECTOR_CONST = Vector(0,0,0);

// Hook related constants.
local MAX_HOOKS = 2;	// Note that simply increasing this won't work;
						//  there are a lot of other stray references you need to update.
local TRACING_DISTANCE = GetConVarNumber("sv_ya3dmg_tracing_distance"); // 20000.0;
local HOOK_DISTANCE = GetConVarNumber("sv_ya3dmg_hook_distance"); // 5000.0;
//local HOOK_AIM_DISTANCE = GetConVarNumber("sv_ya3dmg_hookaim_distance"); // 4300.0;

local HOOK_SPEED = GetConVarNumber("sv_ya3dmg_hookspeed"); //1500.0;
local HOOK_SHORTENED_SPEED = GetConVarNumber("sv_ya3dmg_hookspeedretract"); //2000.0;

local HOOK_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeed_super"); //3000.0;
local HOOK_SHORTENED_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeedretract_super"); // 5000.0;

local HOOK_CENTRIPETAL_MAX = GetConVarNumber("sv_ya3dmg_maxcentripetal");//8300.0;

// Smoke related constants.
local SMOKE_TYPE = 1;	// Dummy value at the moment.
local SMOKE_ENABLED = GetConVarNumber("sv_ya3dmg_smoke_enabled");			// true
local SMOKE_NORMAL_TIME = GetConVarNumber("sv_ya3dmg_smoke_normal_time")	// 0.8
local SMOKE_SUPER_TIME = GetConVarNumber("sv_ya3dmg_smoke_super_time")	// 1.4

// Various other things.
local SHOOT_SOUND = Sound("Weapon_Crossbow.Single")
local BAD_SOUND = Sound("Weapon_SMG1.Empty")

// Aim assist stuff.
local AIM_TRIG_DIVISIONS = 15;
local AIM_ANGLE_BREADTH = 4.0; // One half of how far our aim assist goes, in degrees.

local COLOUR_RED = Color(255, 0, 0);
local COLOUR_GREEN = Color(0, 255, 0);

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//          DON'T EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING!          //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

local AIM_SIN_TABLE = {}
for i=-AIM_TRIG_DIVISIONS,AIM_TRIG_DIVISIONS do
	AIM_SIN_TABLE[i] = math.sin((AIM_ANGLE_BREADTH / AIM_TRIG_DIVISIONS * i) * 0.01745329251994329576923690768489);
end


////////////////////////////////////////////////////////////////////////////////
//   HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// RayTracePoint(Vector, Vector, Table) -> TraceResult
// Traces a ray from 'origin' to 'dest', and returns the result of said ray.
local function RayTracePoint(origin, dest, filters)
	local trace = {};
	
	trace.start = origin;
	trace.endpos = dest;
	trace.filter = filters;
	
	return util.TraceLine(trace);
end

// RayTrace(Vector, Vector, Table) -> TraceResult
// 'direction' should be a unit vector for best results.
// Traces a ray from 'origin', in the direction of 'direction', and returns the result
//  of said ray.
local function RayTrace(origin, direction, filters)
	return RayTracePoint(origin, origin + direction * TRACING_DISTANCE, filters);
end

////////////////////////////////////////////////////////////////////////////////
//   CVAR MONITORING CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:AttachCallbackNum(varn, func)
	local scid = "cl";
	if(SERVER)then
		scid = "sv";
	end
	cvars.AddChangeCallback("sv_ya3dmg_" .. varn, function(n, ov, nv)
		func(tonumber(nv));
		self:SetNWBool("sv_vars_changed", true);
		
		self:CallOnClient("RefreshCVars");
		//net.Start(NET_UPDATE_STRING);
		//	net.WriteBit(true);
		//net.Send(self.Owner);
	end, "sv_ya3dmg_" .. varn .. scid);
	self.callbacks["sv_ya3dmg_" .. varn] = func;
end
function SWEP:PrepareCVarChanges()
	self.callbacks = {};
		
	self:AttachCallbackNum("hookspeed", 		function(v)	
		HOOK_SPEED = v;
	end)
	self:AttachCallbackNum("hookspeedretract", function(v)	HOOK_SHORTENED_SPEED = v; end)
	self:AttachCallbackNum("hookspeed_super", 			function(v)	HOOK_SPEED_SUPER = v; end)
	self:AttachCallbackNum("hookspeedretract_super", 	function(v)	HOOK_SHORTENED_SPEED_SUPER = v; end)
	self:AttachCallbackNum("maxcentripetal", 	function(v)	HOOK_CENTRIPETAL_MAX = v; end)
	self:AttachCallbackNum("hook_distance", 	function(v)	HOOK_DISTANCE = v; end)
	self:AttachCallbackNum("tracing_distance", 	function(v)	TRACING_DISTANCE = v; end)
	self:AttachCallbackNum("smoke_enabled", 	function(v)	
		SMOKE_ENABLED = v; 
	end)
	self:AttachCallbackNum("smoke_normal_time", 	function(v)	SMOKE_NORMAL_TIME = v; end)
	self:AttachCallbackNum("smoke_super_time", 	function(v)	SMOKE_SUPER_TIME = v; end)
end

function SWEP:RefreshCVars()
	for k, v in pairs(self.callbacks) do
		if(ConVarExists(k))then
			v(GetConVar(k):GetFloat());
		end
	end
end

function SWEP:UnregisterCVars()
	for k, _ in pairs(self.callbacks) do
		if(SERVER)then
			cvars.RemoveChangeCallback(k .. "sv");
		else
			cvars.RemoveChangeCallback(k .. "cl");
		end
	end
end

////////////////////////////////////////////////////////////////////////////////
//   CORE CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:Initialize()
	// This is super-ugly, I know, I know.
	self.leftHook = {i = 0, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.rightHook = {i = 1, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.leftHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = 1, drawCol = Color(255, 0, 0)};
	self.rightHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = -1, drawCol = Color(0, 255, 0)};
	
	self.hooks = {left = self.leftHook, right = self.rightHook};
	self.aims = {left = self.leftHookAiming, right = self.rightHookAiming};
	self.timeDetails = {["last"] = CurTime()};
	
	self:SetNWBool("sv_vars_changed", false);
	
	if(!SERVER)then
		self.screenWidth = surface.ScreenWidth();
		self.screenHeight = surface.ScreenHeight();
	end
	
	self:PrepareCVarChanges();
	self:RefreshCVars();
	
	// Prepare to receive the flag.
	//if(CLIENT)then
	//	net.Receive(NET_UPDATE_STRING, function (length, ply)
	//		self:RefreshCVars();
	//	end)
	//end
end

function SWEP:OnExit()
	self:ReleaseHook("left");
	self:ReleaseHook("right");
end

function SWEP:Think()
	if(!self.Owner || self.Owner == NULL)then 
		return 
	end
	
	if(self.Owner:KeyPressed(IN_ATTACK))then
		self:FireLeftHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK))then
		self:ReleaseLeftHook();
	end
	if(self.Owner:KeyPressed(IN_ATTACK2))then
		self:FireRightHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK2))then
		self:ReleaseRightHook();
	end
	
	self:UpdatePhysics();
end

function SWEP:Deploy()
	self:RefreshCVars();
end
function SWEP:Holster()
	self:OnExit();
	return true;
end
function SWEP:OnRemove()
	self:OnExit();
	self:UnregisterCVars();
	return true;
end


////////////////////////////////////////////////////////////////////////////////
//   FIRING CODE
////////////////////////////////////////////////////////////////////////////////

// Extra redundancy, in case think isn't handled at the same time/in the same way.
function SWEP:PrimaryAttack()
	self:FireLeftHook();
end
function SWEP:SecondaryAttack()
	self:FireRightHook();
end

// You shouldn't do this, by the way.
function SWEP:FireLeftHook()
	self:FireHook("left");
end
function SWEP:ReleaseLeftHook()
	self:ReleaseHook("left");
end
function SWEP:FireRightHook()
	self:FireHook("right");
end
function SWEP:ReleaseRightHook()
	self:ReleaseHook("right");
end

function SWEP:FireHook(key)
	local currentHook = self.hooks[key];
	
	if(currentHook.fired)then
		return;
	end
	
	// Both hooks go to the same place right now.
	local currentAim = self.aims[key].aimPos;
	if(currentAim == NULL)then
		return;
	end
		
	// Fire the hooks!
	local origin = self.Owner:GetShootPos();
	
	local hookTrace = RayTracePoint(origin, origin + (currentAim - origin) * 1.1 , { self.Owner, self.Weapon });
	if(!hookTrace.Hit)then
		self:EmitSound(BAD_SOUND);
	else
		local hitPos = hookTrace.HitPos;
		local distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance > HOOK_DISTANCE)then
			self:EmitSound(BAD_SOUND);
			return;
		end
		
		self:EmitSound(SHOOT_SOUND);
		self:AimHook(key);
		
		if(currentHook.rope != NULL)then
			currentHook.rope:Remove();
		end
		
		// Sets up the rope, server-side.
		if(SERVER)then
			currentHook.rope = ents.Create("yetanother3dmgrope");
			currentHook.rope:SetDestination(hitPos);
			
			currentHook.rope:SetParent( self );
			currentHook.rope:SetOwner( self.Owner );
			currentHook.rope:SetPos(ZERO_VECTOR_CONST);
			currentHook.rope:Spawn();
		end
		
		// We add some special handling now if we hit an entity.
		if(IsValid(hookTrace.Entity) && hookTrace.Entity:IsValid())then
			local hooked = hookTrace.Entity;
			
			currentHook.entityHooked = true;
			currentHook.entityTarget = hooked;
			
			local hookedPos = hooked:GetPos();
			currentHook.entityOX = (hitPos - hookedPos):Dot(hooked:GetRight());
			currentHook.entityOY = (hitPos - hookedPos):Dot(hooked:GetUp());
			currentHook.entityOZ = (hitPos - hookedPos):Dot(hooked:GetForward());
		else
			currentHook.entityHooked = false;
			currentHook.entityTarget = NULL;
		end
		
		currentHook.fired = true;
		currentHook.hookPosition = hitPos;
		currentHook.ropeLength = distance;
	end
end

function SWEP:ReleaseHook(key)
	local currentHook = self.hooks[key];
	if(!currentHook.fired)then
		return;
	end	
	if(SERVER)then
		currentHook.rope:Remove();
	end
	currentHook.fired = false;
end

////////////////////////////////////////////////////////////////////////////////
//   PHYSICS CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:UpdatePhysics()
	local time = CurTime();
	
	self:AimHooks();
	if(time - TIME_DELTA >= self.timeDetails.last)then
		self.timeDetails.last = time;
		
		local velocity = Vector(0,0,0);		
		for k,v in pairs(self.hooks) do
			velocity = velocity + self:UpdateHookPhysics(v, k);
		end		
		if(velocity.x != 0 || velocity.y != 0 || velocity.z != 0)then
			self.Owner:SetVelocity(velocity);
		end
	end
end

// SWEP:UpdateHookPhysics(Hook Table) -> Vector
// Updates player physics according to the current hook.
function SWEP:UpdateHookPhysics(cHook, key)
	local origin = self.Owner:GetPos();
	
	if(SMOKE_ENABLED == 1)then
		if(cHook.smokeTimer > 0.0)then
			local apos;
			apos = self.Owner:GetActiveWeapon():GetAttachment(cHook.i + 3);
			
			cHook.smokeTimer = cHook.smokeTimer - TIME_DELTA;
			// TODO: Add extra smoke effects, and change them by intensity.
			ParticleEffect("generic_smoke",apos.Pos,Angle(0,0,0),self.Owner);
		end
	end
	
	if(!cHook.fired)then
		return ZERO_VECTOR_CONST;
	end
	
	if(SERVER)then
		local apos = self.Owner:GetViewModel():GetAttachment(cHook.i + 1);
		cHook.rope:SetPos(apos.Pos);
	end
	
	local velocity = Vector(0,0,0)
	
	if(cHook.entityHooked)then
		local hooked = cHook.entityTarget;
		if(!IsValid(hooked))then
			self:ReleaseHook(key);
			return ZERO_VECTOR_CONST;
		end
		local hookedPos = hooked:GetPos();
		
		local newPos = hookedPos + cHook.entityOX * hooked:GetRight()
								 + cHook.entityOY * hooked:GetUp()
								 + cHook.entityOZ * hooked:GetForward();
		velocity = velocity + (newPos - cHook.hookPosition) / TIME_DELTA;
		cHook.hookPosition = newPos;
		if SERVER then
			cHook.rope:SetDestination(newPos);
		end
	end
	
	local hookVec = (cHook.hookPosition - origin);
	local distance = hookVec:Length();
	local hookDir = hookVec:GetNormalized();
	local hookSpeed;
	
	if(!self.Owner:KeyDown(IN_JUMP) && !self.Owner:KeyDown(IN_SPEED))then
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_NORMAL_TIME)then
			cHook.smokeTimer = SMOKE_NORMAL_TIME;
		end
		hookSpeed = HOOK_SPEED;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED;
		end
	else
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_SUPER_TIME)then
			cHook.smokeTimer = SMOKE_SUPER_TIME;
		end
		hookSpeed = HOOK_SPEED_SUPER;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED_SUPER;
		end
	end
	
	if(cHook.ropeLength > distance)then
		cHook.ropeLength = distance;
	end
	
	local userVelocity = self.Owner:GetVelocity();
	local speed = userVelocity:Length();
	// Apply centripetal force.
	if(self.Owner:KeyDown(IN_DUCK))then
		
		// Get the tangential velocity
		local tangentialSpeed = (userVelocity.x * hookVec.x + userVelocity.y * hookVec.y + userVelocity.z * hookVec.z) / (distance + 100.0);

		tangentialSpeed = math.sqrt(speed^2 - tangentialSpeed^2);
		
		local centripetal = tangentialSpeed^2 / (distance + 100.0);
		if(centripetal > HOOK_CENTRIPETAL_MAX)then
			centripetal = HOOK_CENTRIPETAL_MAX;
		end
		hookSpeed = hookSpeed * 0.3;
		if(cHook.ropeLength > distance)then
			hookSpeed = hookspeed + 2.0*(cHook.ropeLength - distance);
		end
		hookSpeed = hookSpeed + centripetal;
	end
	
	hookSpeed = hookSpeed - (0.000005 * (hookSpeed + speed)^2);
	
	velocity = (hookDir * hookSpeed) * TIME_DELTA;
	return velocity;
end

////////////////////////////////////////////////////////////////////////////////
//   AIM ASSIST CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:ViewModelDrawn()
	self:DrawAims();
	self:DrawModel();
end

function SWEP:DrawWorldModel()
	self:DrawAims();
	self:DrawModel();
end

////////////////////////////////////////////////////////////////////////////////

function SWEP:AimHooks()
	self:AimHook("left");
	self:AimHook("right");
end

function SWEP:DrawAims()
	local drawmaxs = Vector(8,8,8);
	local drawmins = -drawmaxs;

	for k,v in pairs(self.aims) do
		if(v.aimPos != NULL)then
			// TODO: Better norm handling.
			if(v.norm == NULL)then
				render.DrawWireframeBox(v.aimPos, v.norm:Angle(), drawmaxs, drawmins, v.drawCol,true);
			else
				render.DrawWireframeBox(v.aimPos,self.Owner:GetAimVector():Angle() , drawmaxs, drawmins, v.drawCol,true);
			end
		end
	end
end

function SWEP:AimHook(key)
	local aimSet = self.aims[key];
	if(self.hooks[key].fired)then
		return;
	end
	
	local traceDist = HOOK_DISTANCE;
	
	local origin = self.Owner:EyePos();
	local aimVector = self.Owner:GetAimVector():GetNormalized();
	local aimPoint = origin + aimVector * traceDist;
	local filter = {self.Owner, self.Weapon};
		
	local values = {};
	local multiplier = aimSet.mult;
	local trace;
	
	local avr = -aimVector:Angle():Right();
	local avu = aimVector:Angle():Up();
	local offsets = {avr, (multiplier * avu + 0.2 * avr):GetNormalized()}
	
	local desiredIndex = -1;
	local desiredDistance = 1;
	local desiredOffsetIndex = -1;
	
	for oIndex=1,2 do
		local offsetVector = offsets[oIndex];
		local distances = {}
		
		// Perform the traces to solve for distance, first.
		for i=0,AIM_TRIG_DIVISIONS do
			trace = util.TraceLine({start = origin, endpos = aimPoint + offsetVector * AIM_SIN_TABLE[i*multiplier] * traceDist, filter = filter});
			if(!trace.Hit)then
				values[i] = traceDist; // Maybe apply an additional penalty?
				distances[i] = values[i];
			else
				values[i] = trace.HitPos:Distance(origin);
				distances[i] = values[i];
			end
			if(i != 0)then
				values[i-1] = values[i-1] - values[i];
			end
		end
		
		local mean = 0;
		local firstderivs = {};
		// Compute second derivatives.
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			firstderivs[i] = values[i];
			values[i] = values[i] - values[i+1];
			mean = mean + values[i];
		end
		
		mean = mean / (AIM_TRIG_DIVISIONS - 2);
		local stddev = 0;
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			stddev = stddev + (values[i] - mean)^2;
		end
		
		stddev = math.sqrt(stddev / (AIM_TRIG_DIVISIONS - 2));
		
		// TODO: Allow it to consider all candidates in a row, rather than just the first.
		local localdesire = 0;
		if(stddev > 50.0)then
			// Next we proceed directionally until we find a substantial change.
			for i=0,AIM_TRIG_DIVISIONS - 3 do
				// We consider it interesting if it's one standard deviation away.
				if((values[i] - mean) / stddev > 1.0 && firstderivs[i] > 0.0)then
					localdesire = i + 2;
					break;
				end
			end
		end
		
		if(localdesire > 0)then
			if(desiredIndex == -1 || localdesire*(distances[localdesire] / desiredDistance) < desiredIndex)then
				desiredIndex = localdesire;
				desiredDistance = distances[localdesire];
				desiredOffsetIndex = oIndex;
			end
		end
	end
	
	if(desiredIndex == -1)then
		desiredIndex = 0;
	end
	if(desiredOffsetIndex == -1)then
		desiredOffsetIndex = 1;
	end
	
	trace = util.TraceLine({start = origin, endpos = aimPoint + offsets[desiredOffsetIndex] * AIM_SIN_TABLE[desiredIndex*multiplier] * traceDist, filter = filter});
	if(trace.Hit)then
		aimSet.aimPos = trace.HitPos;
		aimSet.norm = trace.HitNorm;
	else
		aimSet.aimPos = NULL;
		aimSet.norm = NULL;
	end
end


function SWEP:DrawHUD()
	local acceptable = false;
	
	// Do a check on the current aim.
	local origin = self.Owner:GetShootPos();
	local hookTrace = RayTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector(), { self.Owner, self.Weapon });
	local distance = -1.0;
		
	if(hookTrace.Hit)then
		local hitPos = hookTrace.HitPos;
		distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance <= HOOK_DISTANCE)then
			acceptable = true;
		end
	end
	
	if(!SERVER)then
		local halfw = self.screenWidth / 2.0;
		local halfh = self.screenHeight / 2.0;
		if(acceptable)then
			surface.DrawCircle(halfw, halfh, 15.0 * (1.0 - distance / HOOK_DISTANCE), COLOUR_GREEN);
		else
			local radius = 5.0 + 20.0 * (distance / HOOK_DISTANCE - 1.0);
			if(radius > 25.0)then
				radius = 25.0;
			end
			if(distance == -1.0)then
				radius = 30.0;
			end
			surface.DrawCircle(halfw, halfh, radius, COLOUR_RED);
		end
	end
	
end



-- "addons\\anime\\lua\\weapons\\yetanother3dmg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 
// INFORMATION AVAILABLE FOR PUBLIC DISCLOSURE:
//  3D Maneuvering Gear/Omni-directional Maneuver Gear
//  Author: mmys
//  Version: 1.1 (2015-1-1)
// 
// Thank you to InsanityBringer for creating the 3DMG model.
// Thank you to everyone who made a 3DMG or grappling hook SWEP before.
//
// WHAT IS THIS?
//  This is a SWEP for the 3D Maneuver Gear from Attack on Titan/Shingeki no
//  Kyojin. It only replicates the actual maneuver gear--no box cutters at the
//  moment.
// 
// WHY MAKE THIS?
//  I felt the existing options weren't that great (no offense to their
//  creators)--in particular, none of them, from what I saw, allowed the use of
//  two separate hooks. The physics were also strange and slow.
// 
// SO IS IT OK IF I POKE AROUND HERE?
//  Given that I wrote a README section here, yeah, you can go ahead and poke
//  around. You can look through the code if you want--that's fine. If you do
//  use bits and pieces of it, then credit is very much appreciated (I'd also
//  love to see what you're making!)
// 

SWEP.PrintName = "Yet Another 3DMG"
SWEP.Author = "mmys"
SWEP.Purpose = "Swinging around, smacking into buildings, and breaking your legs."
SWEP.Instructions = "3D Maneuver Gear. LMB and RMB fire left and right hooks; hold to keep them. DUCK to try and maintain rope length, for swings. JUMP to speed up rope pulling."

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

// TODO: Implement a gas system.
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.ViewModel			= "models/weapons/v_3DMG.mdl"
SWEP.WorldModel			= "models/weapons/w_3DMG.mdl"

////////////////////////////////////////////////////////////////////////////////
// CONSTANTS
// Well, they're not really constant since you can modify them now, but hey.

// Engine consts
local TIME_DELTA = 0.05;
local ZERO_VECTOR_CONST = Vector(0,0,0);

// Hook related constants.
local MAX_HOOKS = 2;	// Note that simply increasing this won't work;
						//  there are a lot of other stray references you need to update.
local TRACING_DISTANCE = GetConVarNumber("sv_ya3dmg_tracing_distance"); // 20000.0;
local HOOK_DISTANCE = GetConVarNumber("sv_ya3dmg_hook_distance"); // 5000.0;
//local HOOK_AIM_DISTANCE = GetConVarNumber("sv_ya3dmg_hookaim_distance"); // 4300.0;

local HOOK_SPEED = GetConVarNumber("sv_ya3dmg_hookspeed"); //1500.0;
local HOOK_SHORTENED_SPEED = GetConVarNumber("sv_ya3dmg_hookspeedretract"); //2000.0;

local HOOK_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeed_super"); //3000.0;
local HOOK_SHORTENED_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeedretract_super"); // 5000.0;

local HOOK_CENTRIPETAL_MAX = GetConVarNumber("sv_ya3dmg_maxcentripetal");//8300.0;

// Smoke related constants.
local SMOKE_TYPE = 1;	// Dummy value at the moment.
local SMOKE_ENABLED = GetConVarNumber("sv_ya3dmg_smoke_enabled");			// true
local SMOKE_NORMAL_TIME = GetConVarNumber("sv_ya3dmg_smoke_normal_time")	// 0.8
local SMOKE_SUPER_TIME = GetConVarNumber("sv_ya3dmg_smoke_super_time")	// 1.4

// Various other things.
local SHOOT_SOUND = Sound("Weapon_Crossbow.Single")
local BAD_SOUND = Sound("Weapon_SMG1.Empty")

// Aim assist stuff.
local AIM_TRIG_DIVISIONS = 15;
local AIM_ANGLE_BREADTH = 4.0; // One half of how far our aim assist goes, in degrees.

local COLOUR_RED = Color(255, 0, 0);
local COLOUR_GREEN = Color(0, 255, 0);

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//          DON'T EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING!          //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

local AIM_SIN_TABLE = {}
for i=-AIM_TRIG_DIVISIONS,AIM_TRIG_DIVISIONS do
	AIM_SIN_TABLE[i] = math.sin((AIM_ANGLE_BREADTH / AIM_TRIG_DIVISIONS * i) * 0.01745329251994329576923690768489);
end


////////////////////////////////////////////////////////////////////////////////
//   HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// RayTracePoint(Vector, Vector, Table) -> TraceResult
// Traces a ray from 'origin' to 'dest', and returns the result of said ray.
local function RayTracePoint(origin, dest, filters)
	local trace = {};
	
	trace.start = origin;
	trace.endpos = dest;
	trace.filter = filters;
	
	return util.TraceLine(trace);
end

// RayTrace(Vector, Vector, Table) -> TraceResult
// 'direction' should be a unit vector for best results.
// Traces a ray from 'origin', in the direction of 'direction', and returns the result
//  of said ray.
local function RayTrace(origin, direction, filters)
	return RayTracePoint(origin, origin + direction * TRACING_DISTANCE, filters);
end

////////////////////////////////////////////////////////////////////////////////
//   CVAR MONITORING CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:AttachCallbackNum(varn, func)
	local scid = "cl";
	if(SERVER)then
		scid = "sv";
	end
	cvars.AddChangeCallback("sv_ya3dmg_" .. varn, function(n, ov, nv)
		func(tonumber(nv));
		self:SetNWBool("sv_vars_changed", true);
		
		self:CallOnClient("RefreshCVars");
		//net.Start(NET_UPDATE_STRING);
		//	net.WriteBit(true);
		//net.Send(self.Owner);
	end, "sv_ya3dmg_" .. varn .. scid);
	self.callbacks["sv_ya3dmg_" .. varn] = func;
end
function SWEP:PrepareCVarChanges()
	self.callbacks = {};
		
	self:AttachCallbackNum("hookspeed", 		function(v)	
		HOOK_SPEED = v;
	end)
	self:AttachCallbackNum("hookspeedretract", function(v)	HOOK_SHORTENED_SPEED = v; end)
	self:AttachCallbackNum("hookspeed_super", 			function(v)	HOOK_SPEED_SUPER = v; end)
	self:AttachCallbackNum("hookspeedretract_super", 	function(v)	HOOK_SHORTENED_SPEED_SUPER = v; end)
	self:AttachCallbackNum("maxcentripetal", 	function(v)	HOOK_CENTRIPETAL_MAX = v; end)
	self:AttachCallbackNum("hook_distance", 	function(v)	HOOK_DISTANCE = v; end)
	self:AttachCallbackNum("tracing_distance", 	function(v)	TRACING_DISTANCE = v; end)
	self:AttachCallbackNum("smoke_enabled", 	function(v)	
		SMOKE_ENABLED = v; 
	end)
	self:AttachCallbackNum("smoke_normal_time", 	function(v)	SMOKE_NORMAL_TIME = v; end)
	self:AttachCallbackNum("smoke_super_time", 	function(v)	SMOKE_SUPER_TIME = v; end)
end

function SWEP:RefreshCVars()
	for k, v in pairs(self.callbacks) do
		if(ConVarExists(k))then
			v(GetConVar(k):GetFloat());
		end
	end
end

function SWEP:UnregisterCVars()
	for k, _ in pairs(self.callbacks) do
		if(SERVER)then
			cvars.RemoveChangeCallback(k .. "sv");
		else
			cvars.RemoveChangeCallback(k .. "cl");
		end
	end
end

////////////////////////////////////////////////////////////////////////////////
//   CORE CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:Initialize()
	// This is super-ugly, I know, I know.
	self.leftHook = {i = 0, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.rightHook = {i = 1, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.leftHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = 1, drawCol = Color(255, 0, 0)};
	self.rightHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = -1, drawCol = Color(0, 255, 0)};
	
	self.hooks = {left = self.leftHook, right = self.rightHook};
	self.aims = {left = self.leftHookAiming, right = self.rightHookAiming};
	self.timeDetails = {["last"] = CurTime()};
	
	self:SetNWBool("sv_vars_changed", false);
	
	if(!SERVER)then
		self.screenWidth = surface.ScreenWidth();
		self.screenHeight = surface.ScreenHeight();
	end
	
	self:PrepareCVarChanges();
	self:RefreshCVars();
	
	// Prepare to receive the flag.
	//if(CLIENT)then
	//	net.Receive(NET_UPDATE_STRING, function (length, ply)
	//		self:RefreshCVars();
	//	end)
	//end
end

function SWEP:OnExit()
	self:ReleaseHook("left");
	self:ReleaseHook("right");
end

function SWEP:Think()
	if(!self.Owner || self.Owner == NULL)then 
		return 
	end
	
	if(self.Owner:KeyPressed(IN_ATTACK))then
		self:FireLeftHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK))then
		self:ReleaseLeftHook();
	end
	if(self.Owner:KeyPressed(IN_ATTACK2))then
		self:FireRightHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK2))then
		self:ReleaseRightHook();
	end
	
	self:UpdatePhysics();
end

function SWEP:Deploy()
	self:RefreshCVars();
end
function SWEP:Holster()
	self:OnExit();
	return true;
end
function SWEP:OnRemove()
	self:OnExit();
	self:UnregisterCVars();
	return true;
end


////////////////////////////////////////////////////////////////////////////////
//   FIRING CODE
////////////////////////////////////////////////////////////////////////////////

// Extra redundancy, in case think isn't handled at the same time/in the same way.
function SWEP:PrimaryAttack()
	self:FireLeftHook();
end
function SWEP:SecondaryAttack()
	self:FireRightHook();
end

// You shouldn't do this, by the way.
function SWEP:FireLeftHook()
	self:FireHook("left");
end
function SWEP:ReleaseLeftHook()
	self:ReleaseHook("left");
end
function SWEP:FireRightHook()
	self:FireHook("right");
end
function SWEP:ReleaseRightHook()
	self:ReleaseHook("right");
end

function SWEP:FireHook(key)
	local currentHook = self.hooks[key];
	
	if(currentHook.fired)then
		return;
	end
	
	// Both hooks go to the same place right now.
	local currentAim = self.aims[key].aimPos;
	if(currentAim == NULL)then
		return;
	end
		
	// Fire the hooks!
	local origin = self.Owner:GetShootPos();
	
	local hookTrace = RayTracePoint(origin, origin + (currentAim - origin) * 1.1 , { self.Owner, self.Weapon });
	if(!hookTrace.Hit)then
		self:EmitSound(BAD_SOUND);
	else
		local hitPos = hookTrace.HitPos;
		local distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance > HOOK_DISTANCE)then
			self:EmitSound(BAD_SOUND);
			return;
		end
		
		self:EmitSound(SHOOT_SOUND);
		self:AimHook(key);
		
		if(currentHook.rope != NULL)then
			currentHook.rope:Remove();
		end
		
		// Sets up the rope, server-side.
		if(SERVER)then
			currentHook.rope = ents.Create("yetanother3dmgrope");
			currentHook.rope:SetDestination(hitPos);
			
			currentHook.rope:SetParent( self );
			currentHook.rope:SetOwner( self.Owner );
			currentHook.rope:SetPos(ZERO_VECTOR_CONST);
			currentHook.rope:Spawn();
		end
		
		// We add some special handling now if we hit an entity.
		if(IsValid(hookTrace.Entity) && hookTrace.Entity:IsValid())then
			local hooked = hookTrace.Entity;
			
			currentHook.entityHooked = true;
			currentHook.entityTarget = hooked;
			
			local hookedPos = hooked:GetPos();
			currentHook.entityOX = (hitPos - hookedPos):Dot(hooked:GetRight());
			currentHook.entityOY = (hitPos - hookedPos):Dot(hooked:GetUp());
			currentHook.entityOZ = (hitPos - hookedPos):Dot(hooked:GetForward());
		else
			currentHook.entityHooked = false;
			currentHook.entityTarget = NULL;
		end
		
		currentHook.fired = true;
		currentHook.hookPosition = hitPos;
		currentHook.ropeLength = distance;
	end
end

function SWEP:ReleaseHook(key)
	local currentHook = self.hooks[key];
	if(!currentHook.fired)then
		return;
	end	
	if(SERVER)then
		currentHook.rope:Remove();
	end
	currentHook.fired = false;
end

////////////////////////////////////////////////////////////////////////////////
//   PHYSICS CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:UpdatePhysics()
	local time = CurTime();
	
	self:AimHooks();
	if(time - TIME_DELTA >= self.timeDetails.last)then
		self.timeDetails.last = time;
		
		local velocity = Vector(0,0,0);		
		for k,v in pairs(self.hooks) do
			velocity = velocity + self:UpdateHookPhysics(v, k);
		end		
		if(velocity.x != 0 || velocity.y != 0 || velocity.z != 0)then
			self.Owner:SetVelocity(velocity);
		end
	end
end

// SWEP:UpdateHookPhysics(Hook Table) -> Vector
// Updates player physics according to the current hook.
function SWEP:UpdateHookPhysics(cHook, key)
	local origin = self.Owner:GetPos();
	
	if(SMOKE_ENABLED == 1)then
		if(cHook.smokeTimer > 0.0)then
			local apos;
			apos = self.Owner:GetActiveWeapon():GetAttachment(cHook.i + 3);
			
			cHook.smokeTimer = cHook.smokeTimer - TIME_DELTA;
			// TODO: Add extra smoke effects, and change them by intensity.
			ParticleEffect("generic_smoke",apos.Pos,Angle(0,0,0),self.Owner);
		end
	end
	
	if(!cHook.fired)then
		return ZERO_VECTOR_CONST;
	end
	
	if(SERVER)then
		local apos = self.Owner:GetViewModel():GetAttachment(cHook.i + 1);
		cHook.rope:SetPos(apos.Pos);
	end
	
	local velocity = Vector(0,0,0)
	
	if(cHook.entityHooked)then
		local hooked = cHook.entityTarget;
		if(!IsValid(hooked))then
			self:ReleaseHook(key);
			return ZERO_VECTOR_CONST;
		end
		local hookedPos = hooked:GetPos();
		
		local newPos = hookedPos + cHook.entityOX * hooked:GetRight()
								 + cHook.entityOY * hooked:GetUp()
								 + cHook.entityOZ * hooked:GetForward();
		velocity = velocity + (newPos - cHook.hookPosition) / TIME_DELTA;
		cHook.hookPosition = newPos;
		if SERVER then
			cHook.rope:SetDestination(newPos);
		end
	end
	
	local hookVec = (cHook.hookPosition - origin);
	local distance = hookVec:Length();
	local hookDir = hookVec:GetNormalized();
	local hookSpeed;
	
	if(!self.Owner:KeyDown(IN_JUMP) && !self.Owner:KeyDown(IN_SPEED))then
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_NORMAL_TIME)then
			cHook.smokeTimer = SMOKE_NORMAL_TIME;
		end
		hookSpeed = HOOK_SPEED;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED;
		end
	else
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_SUPER_TIME)then
			cHook.smokeTimer = SMOKE_SUPER_TIME;
		end
		hookSpeed = HOOK_SPEED_SUPER;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED_SUPER;
		end
	end
	
	if(cHook.ropeLength > distance)then
		cHook.ropeLength = distance;
	end
	
	local userVelocity = self.Owner:GetVelocity();
	local speed = userVelocity:Length();
	// Apply centripetal force.
	if(self.Owner:KeyDown(IN_DUCK))then
		
		// Get the tangential velocity
		local tangentialSpeed = (userVelocity.x * hookVec.x + userVelocity.y * hookVec.y + userVelocity.z * hookVec.z) / (distance + 100.0);

		tangentialSpeed = math.sqrt(speed^2 - tangentialSpeed^2);
		
		local centripetal = tangentialSpeed^2 / (distance + 100.0);
		if(centripetal > HOOK_CENTRIPETAL_MAX)then
			centripetal = HOOK_CENTRIPETAL_MAX;
		end
		hookSpeed = hookSpeed * 0.3;
		if(cHook.ropeLength > distance)then
			hookSpeed = hookspeed + 2.0*(cHook.ropeLength - distance);
		end
		hookSpeed = hookSpeed + centripetal;
	end
	
	hookSpeed = hookSpeed - (0.000005 * (hookSpeed + speed)^2);
	
	velocity = (hookDir * hookSpeed) * TIME_DELTA;
	return velocity;
end

////////////////////////////////////////////////////////////////////////////////
//   AIM ASSIST CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:ViewModelDrawn()
	self:DrawAims();
	self:DrawModel();
end

function SWEP:DrawWorldModel()
	self:DrawAims();
	self:DrawModel();
end

////////////////////////////////////////////////////////////////////////////////

function SWEP:AimHooks()
	self:AimHook("left");
	self:AimHook("right");
end

function SWEP:DrawAims()
	local drawmaxs = Vector(8,8,8);
	local drawmins = -drawmaxs;

	for k,v in pairs(self.aims) do
		if(v.aimPos != NULL)then
			// TODO: Better norm handling.
			if(v.norm == NULL)then
				render.DrawWireframeBox(v.aimPos, v.norm:Angle(), drawmaxs, drawmins, v.drawCol,true);
			else
				render.DrawWireframeBox(v.aimPos,self.Owner:GetAimVector():Angle() , drawmaxs, drawmins, v.drawCol,true);
			end
		end
	end
end

function SWEP:AimHook(key)
	local aimSet = self.aims[key];
	if(self.hooks[key].fired)then
		return;
	end
	
	local traceDist = HOOK_DISTANCE;
	
	local origin = self.Owner:EyePos();
	local aimVector = self.Owner:GetAimVector():GetNormalized();
	local aimPoint = origin + aimVector * traceDist;
	local filter = {self.Owner, self.Weapon};
		
	local values = {};
	local multiplier = aimSet.mult;
	local trace;
	
	local avr = -aimVector:Angle():Right();
	local avu = aimVector:Angle():Up();
	local offsets = {avr, (multiplier * avu + 0.2 * avr):GetNormalized()}
	
	local desiredIndex = -1;
	local desiredDistance = 1;
	local desiredOffsetIndex = -1;
	
	for oIndex=1,2 do
		local offsetVector = offsets[oIndex];
		local distances = {}
		
		// Perform the traces to solve for distance, first.
		for i=0,AIM_TRIG_DIVISIONS do
			trace = util.TraceLine({start = origin, endpos = aimPoint + offsetVector * AIM_SIN_TABLE[i*multiplier] * traceDist, filter = filter});
			if(!trace.Hit)then
				values[i] = traceDist; // Maybe apply an additional penalty?
				distances[i] = values[i];
			else
				values[i] = trace.HitPos:Distance(origin);
				distances[i] = values[i];
			end
			if(i != 0)then
				values[i-1] = values[i-1] - values[i];
			end
		end
		
		local mean = 0;
		local firstderivs = {};
		// Compute second derivatives.
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			firstderivs[i] = values[i];
			values[i] = values[i] - values[i+1];
			mean = mean + values[i];
		end
		
		mean = mean / (AIM_TRIG_DIVISIONS - 2);
		local stddev = 0;
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			stddev = stddev + (values[i] - mean)^2;
		end
		
		stddev = math.sqrt(stddev / (AIM_TRIG_DIVISIONS - 2));
		
		// TODO: Allow it to consider all candidates in a row, rather than just the first.
		local localdesire = 0;
		if(stddev > 50.0)then
			// Next we proceed directionally until we find a substantial change.
			for i=0,AIM_TRIG_DIVISIONS - 3 do
				// We consider it interesting if it's one standard deviation away.
				if((values[i] - mean) / stddev > 1.0 && firstderivs[i] > 0.0)then
					localdesire = i + 2;
					break;
				end
			end
		end
		
		if(localdesire > 0)then
			if(desiredIndex == -1 || localdesire*(distances[localdesire] / desiredDistance) < desiredIndex)then
				desiredIndex = localdesire;
				desiredDistance = distances[localdesire];
				desiredOffsetIndex = oIndex;
			end
		end
	end
	
	if(desiredIndex == -1)then
		desiredIndex = 0;
	end
	if(desiredOffsetIndex == -1)then
		desiredOffsetIndex = 1;
	end
	
	trace = util.TraceLine({start = origin, endpos = aimPoint + offsets[desiredOffsetIndex] * AIM_SIN_TABLE[desiredIndex*multiplier] * traceDist, filter = filter});
	if(trace.Hit)then
		aimSet.aimPos = trace.HitPos;
		aimSet.norm = trace.HitNorm;
	else
		aimSet.aimPos = NULL;
		aimSet.norm = NULL;
	end
end


function SWEP:DrawHUD()
	local acceptable = false;
	
	// Do a check on the current aim.
	local origin = self.Owner:GetShootPos();
	local hookTrace = RayTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector(), { self.Owner, self.Weapon });
	local distance = -1.0;
		
	if(hookTrace.Hit)then
		local hitPos = hookTrace.HitPos;
		distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance <= HOOK_DISTANCE)then
			acceptable = true;
		end
	end
	
	if(!SERVER)then
		local halfw = self.screenWidth / 2.0;
		local halfh = self.screenHeight / 2.0;
		if(acceptable)then
			surface.DrawCircle(halfw, halfh, 15.0 * (1.0 - distance / HOOK_DISTANCE), COLOUR_GREEN);
		else
			local radius = 5.0 + 20.0 * (distance / HOOK_DISTANCE - 1.0);
			if(radius > 25.0)then
				radius = 25.0;
			end
			if(distance == -1.0)then
				radius = 30.0;
			end
			surface.DrawCircle(halfw, halfh, radius, COLOUR_RED);
		end
	end
	
end



-- "addons\\anime\\lua\\weapons\\yetanother3dmg.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// 
// INFORMATION AVAILABLE FOR PUBLIC DISCLOSURE:
//  3D Maneuvering Gear/Omni-directional Maneuver Gear
//  Author: mmys
//  Version: 1.1 (2015-1-1)
// 
// Thank you to InsanityBringer for creating the 3DMG model.
// Thank you to everyone who made a 3DMG or grappling hook SWEP before.
//
// WHAT IS THIS?
//  This is a SWEP for the 3D Maneuver Gear from Attack on Titan/Shingeki no
//  Kyojin. It only replicates the actual maneuver gear--no box cutters at the
//  moment.
// 
// WHY MAKE THIS?
//  I felt the existing options weren't that great (no offense to their
//  creators)--in particular, none of them, from what I saw, allowed the use of
//  two separate hooks. The physics were also strange and slow.
// 
// SO IS IT OK IF I POKE AROUND HERE?
//  Given that I wrote a README section here, yeah, you can go ahead and poke
//  around. You can look through the code if you want--that's fine. If you do
//  use bits and pieces of it, then credit is very much appreciated (I'd also
//  love to see what you're making!)
// 

SWEP.PrintName = "Yet Another 3DMG"
SWEP.Author = "mmys"
SWEP.Purpose = "Swinging around, smacking into buildings, and breaking your legs."
SWEP.Instructions = "3D Maneuver Gear. LMB and RMB fire left and right hooks; hold to keep them. DUCK to try and maintain rope length, for swings. JUMP to speed up rope pulling."

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

// TODO: Implement a gas system.
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.ViewModel			= "models/weapons/v_3DMG.mdl"
SWEP.WorldModel			= "models/weapons/w_3DMG.mdl"

////////////////////////////////////////////////////////////////////////////////
// CONSTANTS
// Well, they're not really constant since you can modify them now, but hey.

// Engine consts
local TIME_DELTA = 0.05;
local ZERO_VECTOR_CONST = Vector(0,0,0);

// Hook related constants.
local MAX_HOOKS = 2;	// Note that simply increasing this won't work;
						//  there are a lot of other stray references you need to update.
local TRACING_DISTANCE = GetConVarNumber("sv_ya3dmg_tracing_distance"); // 20000.0;
local HOOK_DISTANCE = GetConVarNumber("sv_ya3dmg_hook_distance"); // 5000.0;
//local HOOK_AIM_DISTANCE = GetConVarNumber("sv_ya3dmg_hookaim_distance"); // 4300.0;

local HOOK_SPEED = GetConVarNumber("sv_ya3dmg_hookspeed"); //1500.0;
local HOOK_SHORTENED_SPEED = GetConVarNumber("sv_ya3dmg_hookspeedretract"); //2000.0;

local HOOK_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeed_super"); //3000.0;
local HOOK_SHORTENED_SPEED_SUPER = GetConVarNumber("sv_ya3dmg_hookspeedretract_super"); // 5000.0;

local HOOK_CENTRIPETAL_MAX = GetConVarNumber("sv_ya3dmg_maxcentripetal");//8300.0;

// Smoke related constants.
local SMOKE_TYPE = 1;	// Dummy value at the moment.
local SMOKE_ENABLED = GetConVarNumber("sv_ya3dmg_smoke_enabled");			// true
local SMOKE_NORMAL_TIME = GetConVarNumber("sv_ya3dmg_smoke_normal_time")	// 0.8
local SMOKE_SUPER_TIME = GetConVarNumber("sv_ya3dmg_smoke_super_time")	// 1.4

// Various other things.
local SHOOT_SOUND = Sound("Weapon_Crossbow.Single")
local BAD_SOUND = Sound("Weapon_SMG1.Empty")

// Aim assist stuff.
local AIM_TRIG_DIVISIONS = 15;
local AIM_ANGLE_BREADTH = 4.0; // One half of how far our aim assist goes, in degrees.

local COLOUR_RED = Color(255, 0, 0);
local COLOUR_GREEN = Color(0, 255, 0);

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//          DON'T EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING!          //
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

local AIM_SIN_TABLE = {}
for i=-AIM_TRIG_DIVISIONS,AIM_TRIG_DIVISIONS do
	AIM_SIN_TABLE[i] = math.sin((AIM_ANGLE_BREADTH / AIM_TRIG_DIVISIONS * i) * 0.01745329251994329576923690768489);
end


////////////////////////////////////////////////////////////////////////////////
//   HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// RayTracePoint(Vector, Vector, Table) -> TraceResult
// Traces a ray from 'origin' to 'dest', and returns the result of said ray.
local function RayTracePoint(origin, dest, filters)
	local trace = {};
	
	trace.start = origin;
	trace.endpos = dest;
	trace.filter = filters;
	
	return util.TraceLine(trace);
end

// RayTrace(Vector, Vector, Table) -> TraceResult
// 'direction' should be a unit vector for best results.
// Traces a ray from 'origin', in the direction of 'direction', and returns the result
//  of said ray.
local function RayTrace(origin, direction, filters)
	return RayTracePoint(origin, origin + direction * TRACING_DISTANCE, filters);
end

////////////////////////////////////////////////////////////////////////////////
//   CVAR MONITORING CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:AttachCallbackNum(varn, func)
	local scid = "cl";
	if(SERVER)then
		scid = "sv";
	end
	cvars.AddChangeCallback("sv_ya3dmg_" .. varn, function(n, ov, nv)
		func(tonumber(nv));
		self:SetNWBool("sv_vars_changed", true);
		
		self:CallOnClient("RefreshCVars");
		//net.Start(NET_UPDATE_STRING);
		//	net.WriteBit(true);
		//net.Send(self.Owner);
	end, "sv_ya3dmg_" .. varn .. scid);
	self.callbacks["sv_ya3dmg_" .. varn] = func;
end
function SWEP:PrepareCVarChanges()
	self.callbacks = {};
		
	self:AttachCallbackNum("hookspeed", 		function(v)	
		HOOK_SPEED = v;
	end)
	self:AttachCallbackNum("hookspeedretract", function(v)	HOOK_SHORTENED_SPEED = v; end)
	self:AttachCallbackNum("hookspeed_super", 			function(v)	HOOK_SPEED_SUPER = v; end)
	self:AttachCallbackNum("hookspeedretract_super", 	function(v)	HOOK_SHORTENED_SPEED_SUPER = v; end)
	self:AttachCallbackNum("maxcentripetal", 	function(v)	HOOK_CENTRIPETAL_MAX = v; end)
	self:AttachCallbackNum("hook_distance", 	function(v)	HOOK_DISTANCE = v; end)
	self:AttachCallbackNum("tracing_distance", 	function(v)	TRACING_DISTANCE = v; end)
	self:AttachCallbackNum("smoke_enabled", 	function(v)	
		SMOKE_ENABLED = v; 
	end)
	self:AttachCallbackNum("smoke_normal_time", 	function(v)	SMOKE_NORMAL_TIME = v; end)
	self:AttachCallbackNum("smoke_super_time", 	function(v)	SMOKE_SUPER_TIME = v; end)
end

function SWEP:RefreshCVars()
	for k, v in pairs(self.callbacks) do
		if(ConVarExists(k))then
			v(GetConVar(k):GetFloat());
		end
	end
end

function SWEP:UnregisterCVars()
	for k, _ in pairs(self.callbacks) do
		if(SERVER)then
			cvars.RemoveChangeCallback(k .. "sv");
		else
			cvars.RemoveChangeCallback(k .. "cl");
		end
	end
end

////////////////////////////////////////////////////////////////////////////////
//   CORE CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:Initialize()
	// This is super-ugly, I know, I know.
	self.leftHook = {i = 0, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.rightHook = {i = 1, entityHooked = false, entityOX = 0, entityOY = 0, entityOZ = 0, entityTarget = NULL, ropeLength = 0, hookPosition = Vector(1, 1, 1), rope = NULL, fired = false, smoke = NULL, smokeTimer = 0.0};
	self.leftHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = 1, drawCol = Color(255, 0, 0)};
	self.rightHookAiming = {aimPos = NULL, norm = NULL, lastPos = NULL, preserveFrames = 0, mult = -1, drawCol = Color(0, 255, 0)};
	
	self.hooks = {left = self.leftHook, right = self.rightHook};
	self.aims = {left = self.leftHookAiming, right = self.rightHookAiming};
	self.timeDetails = {["last"] = CurTime()};
	
	self:SetNWBool("sv_vars_changed", false);
	
	if(!SERVER)then
		self.screenWidth = surface.ScreenWidth();
		self.screenHeight = surface.ScreenHeight();
	end
	
	self:PrepareCVarChanges();
	self:RefreshCVars();
	
	// Prepare to receive the flag.
	//if(CLIENT)then
	//	net.Receive(NET_UPDATE_STRING, function (length, ply)
	//		self:RefreshCVars();
	//	end)
	//end
end

function SWEP:OnExit()
	self:ReleaseHook("left");
	self:ReleaseHook("right");
end

function SWEP:Think()
	if(!self.Owner || self.Owner == NULL)then 
		return 
	end
	
	if(self.Owner:KeyPressed(IN_ATTACK))then
		self:FireLeftHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK))then
		self:ReleaseLeftHook();
	end
	if(self.Owner:KeyPressed(IN_ATTACK2))then
		self:FireRightHook();
	elseif(self.Owner:KeyReleased(IN_ATTACK2))then
		self:ReleaseRightHook();
	end
	
	self:UpdatePhysics();
end

function SWEP:Deploy()
	self:RefreshCVars();
end
function SWEP:Holster()
	self:OnExit();
	return true;
end
function SWEP:OnRemove()
	self:OnExit();
	self:UnregisterCVars();
	return true;
end


////////////////////////////////////////////////////////////////////////////////
//   FIRING CODE
////////////////////////////////////////////////////////////////////////////////

// Extra redundancy, in case think isn't handled at the same time/in the same way.
function SWEP:PrimaryAttack()
	self:FireLeftHook();
end
function SWEP:SecondaryAttack()
	self:FireRightHook();
end

// You shouldn't do this, by the way.
function SWEP:FireLeftHook()
	self:FireHook("left");
end
function SWEP:ReleaseLeftHook()
	self:ReleaseHook("left");
end
function SWEP:FireRightHook()
	self:FireHook("right");
end
function SWEP:ReleaseRightHook()
	self:ReleaseHook("right");
end

function SWEP:FireHook(key)
	local currentHook = self.hooks[key];
	
	if(currentHook.fired)then
		return;
	end
	
	// Both hooks go to the same place right now.
	local currentAim = self.aims[key].aimPos;
	if(currentAim == NULL)then
		return;
	end
		
	// Fire the hooks!
	local origin = self.Owner:GetShootPos();
	
	local hookTrace = RayTracePoint(origin, origin + (currentAim - origin) * 1.1 , { self.Owner, self.Weapon });
	if(!hookTrace.Hit)then
		self:EmitSound(BAD_SOUND);
	else
		local hitPos = hookTrace.HitPos;
		local distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance > HOOK_DISTANCE)then
			self:EmitSound(BAD_SOUND);
			return;
		end
		
		self:EmitSound(SHOOT_SOUND);
		self:AimHook(key);
		
		if(currentHook.rope != NULL)then
			currentHook.rope:Remove();
		end
		
		// Sets up the rope, server-side.
		if(SERVER)then
			currentHook.rope = ents.Create("yetanother3dmgrope");
			currentHook.rope:SetDestination(hitPos);
			
			currentHook.rope:SetParent( self );
			currentHook.rope:SetOwner( self.Owner );
			currentHook.rope:SetPos(ZERO_VECTOR_CONST);
			currentHook.rope:Spawn();
		end
		
		// We add some special handling now if we hit an entity.
		if(IsValid(hookTrace.Entity) && hookTrace.Entity:IsValid())then
			local hooked = hookTrace.Entity;
			
			currentHook.entityHooked = true;
			currentHook.entityTarget = hooked;
			
			local hookedPos = hooked:GetPos();
			currentHook.entityOX = (hitPos - hookedPos):Dot(hooked:GetRight());
			currentHook.entityOY = (hitPos - hookedPos):Dot(hooked:GetUp());
			currentHook.entityOZ = (hitPos - hookedPos):Dot(hooked:GetForward());
		else
			currentHook.entityHooked = false;
			currentHook.entityTarget = NULL;
		end
		
		currentHook.fired = true;
		currentHook.hookPosition = hitPos;
		currentHook.ropeLength = distance;
	end
end

function SWEP:ReleaseHook(key)
	local currentHook = self.hooks[key];
	if(!currentHook.fired)then
		return;
	end	
	if(SERVER)then
		currentHook.rope:Remove();
	end
	currentHook.fired = false;
end

////////////////////////////////////////////////////////////////////////////////
//   PHYSICS CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:UpdatePhysics()
	local time = CurTime();
	
	self:AimHooks();
	if(time - TIME_DELTA >= self.timeDetails.last)then
		self.timeDetails.last = time;
		
		local velocity = Vector(0,0,0);		
		for k,v in pairs(self.hooks) do
			velocity = velocity + self:UpdateHookPhysics(v, k);
		end		
		if(velocity.x != 0 || velocity.y != 0 || velocity.z != 0)then
			self.Owner:SetVelocity(velocity);
		end
	end
end

// SWEP:UpdateHookPhysics(Hook Table) -> Vector
// Updates player physics according to the current hook.
function SWEP:UpdateHookPhysics(cHook, key)
	local origin = self.Owner:GetPos();
	
	if(SMOKE_ENABLED == 1)then
		if(cHook.smokeTimer > 0.0)then
			local apos;
			apos = self.Owner:GetActiveWeapon():GetAttachment(cHook.i + 3);
			
			cHook.smokeTimer = cHook.smokeTimer - TIME_DELTA;
			// TODO: Add extra smoke effects, and change them by intensity.
			ParticleEffect("generic_smoke",apos.Pos,Angle(0,0,0),self.Owner);
		end
	end
	
	if(!cHook.fired)then
		return ZERO_VECTOR_CONST;
	end
	
	if(SERVER)then
		local apos = self.Owner:GetViewModel():GetAttachment(cHook.i + 1);
		cHook.rope:SetPos(apos.Pos);
	end
	
	local velocity = Vector(0,0,0)
	
	if(cHook.entityHooked)then
		local hooked = cHook.entityTarget;
		if(!IsValid(hooked))then
			self:ReleaseHook(key);
			return ZERO_VECTOR_CONST;
		end
		local hookedPos = hooked:GetPos();
		
		local newPos = hookedPos + cHook.entityOX * hooked:GetRight()
								 + cHook.entityOY * hooked:GetUp()
								 + cHook.entityOZ * hooked:GetForward();
		velocity = velocity + (newPos - cHook.hookPosition) / TIME_DELTA;
		cHook.hookPosition = newPos;
		if SERVER then
			cHook.rope:SetDestination(newPos);
		end
	end
	
	local hookVec = (cHook.hookPosition - origin);
	local distance = hookVec:Length();
	local hookDir = hookVec:GetNormalized();
	local hookSpeed;
	
	if(!self.Owner:KeyDown(IN_JUMP) && !self.Owner:KeyDown(IN_SPEED))then
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_NORMAL_TIME)then
			cHook.smokeTimer = SMOKE_NORMAL_TIME;
		end
		hookSpeed = HOOK_SPEED;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED;
		end
	else
		if(SMOKE_ENABLED == 1 && cHook.smokeTimer < SMOKE_SUPER_TIME)then
			cHook.smokeTimer = SMOKE_SUPER_TIME;
		end
		hookSpeed = HOOK_SPEED_SUPER;
		
		// We want the 3DMG to try and restore its minimum length.
		if(cHook.ropeLength <= distance)then
			hookSpeed = HOOK_SHORTENED_SPEED_SUPER;
		end
	end
	
	if(cHook.ropeLength > distance)then
		cHook.ropeLength = distance;
	end
	
	local userVelocity = self.Owner:GetVelocity();
	local speed = userVelocity:Length();
	// Apply centripetal force.
	if(self.Owner:KeyDown(IN_DUCK))then
		
		// Get the tangential velocity
		local tangentialSpeed = (userVelocity.x * hookVec.x + userVelocity.y * hookVec.y + userVelocity.z * hookVec.z) / (distance + 100.0);

		tangentialSpeed = math.sqrt(speed^2 - tangentialSpeed^2);
		
		local centripetal = tangentialSpeed^2 / (distance + 100.0);
		if(centripetal > HOOK_CENTRIPETAL_MAX)then
			centripetal = HOOK_CENTRIPETAL_MAX;
		end
		hookSpeed = hookSpeed * 0.3;
		if(cHook.ropeLength > distance)then
			hookSpeed = hookspeed + 2.0*(cHook.ropeLength - distance);
		end
		hookSpeed = hookSpeed + centripetal;
	end
	
	hookSpeed = hookSpeed - (0.000005 * (hookSpeed + speed)^2);
	
	velocity = (hookDir * hookSpeed) * TIME_DELTA;
	return velocity;
end

////////////////////////////////////////////////////////////////////////////////
//   AIM ASSIST CODE
////////////////////////////////////////////////////////////////////////////////

function SWEP:ViewModelDrawn()
	self:DrawAims();
	self:DrawModel();
end

function SWEP:DrawWorldModel()
	self:DrawAims();
	self:DrawModel();
end

////////////////////////////////////////////////////////////////////////////////

function SWEP:AimHooks()
	self:AimHook("left");
	self:AimHook("right");
end

function SWEP:DrawAims()
	local drawmaxs = Vector(8,8,8);
	local drawmins = -drawmaxs;

	for k,v in pairs(self.aims) do
		if(v.aimPos != NULL)then
			// TODO: Better norm handling.
			if(v.norm == NULL)then
				render.DrawWireframeBox(v.aimPos, v.norm:Angle(), drawmaxs, drawmins, v.drawCol,true);
			else
				render.DrawWireframeBox(v.aimPos,self.Owner:GetAimVector():Angle() , drawmaxs, drawmins, v.drawCol,true);
			end
		end
	end
end

function SWEP:AimHook(key)
	local aimSet = self.aims[key];
	if(self.hooks[key].fired)then
		return;
	end
	
	local traceDist = HOOK_DISTANCE;
	
	local origin = self.Owner:EyePos();
	local aimVector = self.Owner:GetAimVector():GetNormalized();
	local aimPoint = origin + aimVector * traceDist;
	local filter = {self.Owner, self.Weapon};
		
	local values = {};
	local multiplier = aimSet.mult;
	local trace;
	
	local avr = -aimVector:Angle():Right();
	local avu = aimVector:Angle():Up();
	local offsets = {avr, (multiplier * avu + 0.2 * avr):GetNormalized()}
	
	local desiredIndex = -1;
	local desiredDistance = 1;
	local desiredOffsetIndex = -1;
	
	for oIndex=1,2 do
		local offsetVector = offsets[oIndex];
		local distances = {}
		
		// Perform the traces to solve for distance, first.
		for i=0,AIM_TRIG_DIVISIONS do
			trace = util.TraceLine({start = origin, endpos = aimPoint + offsetVector * AIM_SIN_TABLE[i*multiplier] * traceDist, filter = filter});
			if(!trace.Hit)then
				values[i] = traceDist; // Maybe apply an additional penalty?
				distances[i] = values[i];
			else
				values[i] = trace.HitPos:Distance(origin);
				distances[i] = values[i];
			end
			if(i != 0)then
				values[i-1] = values[i-1] - values[i];
			end
		end
		
		local mean = 0;
		local firstderivs = {};
		// Compute second derivatives.
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			firstderivs[i] = values[i];
			values[i] = values[i] - values[i+1];
			mean = mean + values[i];
		end
		
		mean = mean / (AIM_TRIG_DIVISIONS - 2);
		local stddev = 0;
		for i=0,AIM_TRIG_DIVISIONS - 2 do
			stddev = stddev + (values[i] - mean)^2;
		end
		
		stddev = math.sqrt(stddev / (AIM_TRIG_DIVISIONS - 2));
		
		// TODO: Allow it to consider all candidates in a row, rather than just the first.
		local localdesire = 0;
		if(stddev > 50.0)then
			// Next we proceed directionally until we find a substantial change.
			for i=0,AIM_TRIG_DIVISIONS - 3 do
				// We consider it interesting if it's one standard deviation away.
				if((values[i] - mean) / stddev > 1.0 && firstderivs[i] > 0.0)then
					localdesire = i + 2;
					break;
				end
			end
		end
		
		if(localdesire > 0)then
			if(desiredIndex == -1 || localdesire*(distances[localdesire] / desiredDistance) < desiredIndex)then
				desiredIndex = localdesire;
				desiredDistance = distances[localdesire];
				desiredOffsetIndex = oIndex;
			end
		end
	end
	
	if(desiredIndex == -1)then
		desiredIndex = 0;
	end
	if(desiredOffsetIndex == -1)then
		desiredOffsetIndex = 1;
	end
	
	trace = util.TraceLine({start = origin, endpos = aimPoint + offsets[desiredOffsetIndex] * AIM_SIN_TABLE[desiredIndex*multiplier] * traceDist, filter = filter});
	if(trace.Hit)then
		aimSet.aimPos = trace.HitPos;
		aimSet.norm = trace.HitNorm;
	else
		aimSet.aimPos = NULL;
		aimSet.norm = NULL;
	end
end


function SWEP:DrawHUD()
	local acceptable = false;
	
	// Do a check on the current aim.
	local origin = self.Owner:GetShootPos();
	local hookTrace = RayTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector(), { self.Owner, self.Weapon });
	local distance = -1.0;
		
	if(hookTrace.Hit)then
		local hitPos = hookTrace.HitPos;
		distance = math.sqrt((origin.x - hitPos.x)^2 + (origin.y - hitPos.y)^2 + (origin.z - hitPos.z)^2);
		
		if(distance <= HOOK_DISTANCE)then
			acceptable = true;
		end
	end
	
	if(!SERVER)then
		local halfw = self.screenWidth / 2.0;
		local halfh = self.screenHeight / 2.0;
		if(acceptable)then
			surface.DrawCircle(halfw, halfh, 15.0 * (1.0 - distance / HOOK_DISTANCE), COLOUR_GREEN);
		else
			local radius = 5.0 + 20.0 * (distance / HOOK_DISTANCE - 1.0);
			if(radius > 25.0)then
				radius = 25.0;
			end
			if(distance == -1.0)then
				radius = 30.0;
			end
			surface.DrawCircle(halfw, halfh, radius, COLOUR_RED);
		end
	end
	
end



