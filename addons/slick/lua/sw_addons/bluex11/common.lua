-- "addons\\slick\\lua\\sw_addons\\bluex11\\common.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/* 
Version 10.08.20

Last Change: 

Changed the functions:
SetEntAngPosViaAttachment()

Improved the function. No helper prop is needed anymore.

*/

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

function SW_ADDON:Add_Items( name, listname, model, class, skin )
	class = class or "prop_physics"
	skin = skin or 0
	
	local NormalOffset = nil
	local DropToFloor = nil
	
	if (class != "prop_ragdoll") then
		NormalOffset = 64
		DropToFloor = true
	end

	list.Set( "SpawnableEntities", name, { 
		PrintName = listname, 
		ClassName = class, 
		Category = "SligWolf's Props",
		
		NormalOffset = NormalOffset,
		DropToFloor = DropToFloor,

		KeyValues = {
			model = model,
			skin = skin,
			addonname = self.Addonname,
		}
	})
end

function SW_ADDON:AddPlayerModel(name, player_model, vhands_model, skin, bodygroup)
	player_model = player_model or ""
	vhands_model = vhands_model or ""
	name = name or player_model
	skin = skin or 0
	bodygroup = bodygroup or "00000000"

	if player_model == "" then return end
	
	player_manager.AddValidModel( name, player_model )

	if vhands_model == "" then return end
	player_manager.AddValidHands( name, vhands_model, skin, bodygroup )
end

local function NPC_Setup( ply, npc )
	if !IsValid(npc) then return end
	if npc.__IsSW_Duped then return end
	
	local kv = npc:GetKeyValues()
	local name = kv["classname"] or ""
	
	local tab = list.Get("NPC")
	local data = tab[name]
	if !data then return end
	if !data.IsSW then return end
	
	local data_custom = data.SW_Custom or {}
	
	if data_custom.Accuracy then
		npc:SetCurrentWeaponProficiency( data_custom.Accuracy )
	end
	
	if data_custom.Health then
		npc:SetHealth( data_custom.Health )
	end
	
	if data_custom.Blood then
		npc:SetBloodColor( data_custom.Blood )
	end
	
	if data_custom.Color then
		npc:SetColor( data_custom.Color )
	end
	
	if data_custom.Owner then
		npc.Owner = ply
	end
	
	local func = data_custom.OnSpawn
	if isfunction(func) then
		func(npc, data)
	end
	
	npc.__IsSW_Addon = true
	npc.__IsSW_Class = name
	
	local class = tostring(data.Class or "Corrupt Class!")
	npc:SetKeyValue( "classname", class )
	
	local dupedata = {}
	dupedata.customclass = name
	
	duplicator.StoreEntityModifier(npc, "SW_Common_NPC_Dupe", dupedata) 
end

local function NPC_Dupe(ply, npc, data)
	if !IsValid(npc) then return end
	if !data then return end
	if !data.customclass then return end

	npc:SetKeyValue( "classname", data.customclass )
	NPC_Setup(ply, npc)
	npc.__IsSW_Duped = true
end

function SW_ADDON:Add_NPC(name, npc)
	name = name or ""
	if name == "" then return end
	npc = npc or {}

	npc.Name = npc.Name or "SligWolf - Generic"
	npc.Class = npc.Class or "npc_citizen"
	npc.Category = npc.Category or "SligWolf's NPC's"
	npc.Skin = npc.Skin or 0
	npc.KeyValues = npc.KeyValues or {}
	npc.IsSW = true
	
	// Workaround to get back to custom NPC classname from the spawned NPC
	npc.KeyValues.classname = name

	npc.SW_Custom = npc.SW_Custom or {}
	list.Set( "NPC", name, npc )

	hook.Remove( "PlayerSpawnedNPC", "SW_Common_NPC_Setup")
	hook.Add( "PlayerSpawnedNPC", "SW_Common_NPC_Setup", NPC_Setup)
	duplicator.RegisterEntityModifier( "SW_Common_NPC_Dupe", NPC_Dupe)
	
	if CLIENT then
		language.Add(name, npc.Name)
	end
end

local function CantTouch( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Blockedprop then return false end
end
hook.Add( "PhysgunPickup", "SW_Common_CantTouch", CantTouch )

local function CantPickUp( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Cantpickup then return false end
end
hook.Add( "AllowPlayerPickup", "SW_Common_CantPickUp", CantPickUp )

local function CantUnfreeze( ply, ent )
    if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	if ent.__SW_NoUnfreeze then return false end
end
hook.Add( "CanPlayerUnfreeze", "SW_Common_CantUnfreeze", CantUnfreeze )

local function Tool( ply, tr, tool )
    if !IsValid(ply) then return end
	
	local ent = tr.Entity
	debugoverlay.Text( tr.HitPos, tostring(tool), 3, false ) 
	
	if ent.__SW_BlockAllTools then return false end
	
	local tb = ent.__SW_BlockTool
	
	if istable(tb) then
		if tb[tool] then
			return false
		end
	end
	
	if ent.__SW_AllowOnlyThisTool == tool then 
		return false
	end
end
hook.Add( "CanTool", "SW_Common_Tool", Tool )

local function ToolReload( ply, tr, tool )
    if !IsValid(ply) then return end

	local ent = tr.Entity
	local tb = ent.__SW_DenyToolReload
	
	if istable(tb) then
		if tb[tool] then
			if ply:KeyPressed(IN_RELOAD) then return false end
		end
	end
end
hook.Add( "CanTool", "SW_Common_ToolReload", ToolReload )

function SW_ADDON:MakeEnt(classname, ply, parent, name)
    local ent = ents.Create(classname)

    if !IsValid(ent) then return end
	ent.__SW_Vars = ent.__SW_Vars or {}
	self:SetName(ent, name)
	self:SetParent(ent, parent)
	
	if ent.__IsSW_Entity then
		ent:SetAddonID(self.Addonname)
	end

    if !ent.CPPISetOwner then return ent end
    if !IsValid(ply) then return ent end

    ent:CPPISetOwner(ply)
    return ent
end

function SW_ADDON:IsValidModel(ent)
	if !IsValid(ent) then return false end
	
	local model = tostring(ent:GetModel() or "")
	if model == "" then return false end
	
	model = Model(model)
	if !util.IsValidModel(model) then return false end
	
	return true
end

function SW_ADDON:AddToEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	
	if IsValid(ent) then
		self.ents[name][ent] = true
	else
		self.ents[name][ent] = nil
	end
end

function SW_ADDON:RemoveFromEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	self.ents[name][ent] = nil
end


function SW_ADDON:GetAllFromEntList(name)
	name = tostring(name or "")

	self.ents = self.ents or {}
	return self.ents[name] or {}
end

function SW_ADDON:ForEachInEntList(name, func)
	if !isfunction(func) then return end
	local entlist = self:GetAllFromEntList(name)
	
	local index = 1
	for k, v in pairs(entlist) do
		if !IsValid(k) then
			entlist[k] = nil
			continue
		end
		
		local bbreak = func(self, index, k)
		if bbreak == false then
			break
		end
		
		index = index + 1
	end
end

function SW_ADDON:SetupChildEntity(ent, parent, collision, attachmentid)
	if !IsValid(ent) then return end
	if !IsValid(parent) then return end
	
	collision = collision or COLLISION_GROUP_NONE
	attachmentid = attachmentid or 0
	
	ent:Spawn()
	ent:Activate()
	ent:SetParent(parent, attachmentid)
	ent:SetCollisionGroup( collision )
	ent:SetMoveType( MOVETYPE_NONE )
	ent.DoNotDuplicate = true
	parent:DeleteOnRemove( ent )
	
	self:SetParent(ent, parent)

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return ent end
	phys:Sleep()
	
	return ent
end

function SW_ADDON:GetName(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return "" end
	
	return self:ValidateName(ent.__SW_Vars.Name)
end

function SW_ADDON:SetName(ent, name)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars
	
	name = self:ValidateName(name)
	if name == "" then
		name = tostring(util.CRC(tostring(ent)))
	end
	
	local oldname = self:GetName(ent)
	vars.Name = name
	
	local parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[oldname] = nil
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars

    if !IsValid(vars.ParentENT) then return end
	if vars.ParentENT == ent then return end

	return vars.ParentENT
end

function SW_ADDON:SetParent(ent, parent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	if parent == ent then
		parent = nil
	end
	
	local vars = ent.__SW_Vars

	vars.ParentENT = parent
	vars.SuperParentENT = self:GetSuperParent(ent)

	parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	local name = self:GetName(ent)
	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetSuperParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	local vars = ent.__SW_Vars
	
	if IsValid(vars.SuperParentENT) and (vars.SuperParentENT != ent) then
		return vars.SuperParentENT
	end
	
	if !IsValid(vars.ParentENT) then
		return ent
	end
	
	vars.SuperParentENT = self:GetSuperParent(vars.ParentENT)
	if vars.SuperParentENT == ent then return end
    if !IsValid(vars.SuperParentENT) then return end
	
	return vars.SuperParentENT
end

function SW_ADDON:GetEntityPath(ent)
	if !IsValid(ent) then return end
	
	local name = self:GetName(ent)
	local parent = self:GetParent(ent)
	
	if !IsValid(parent) then
		return name
	end
	
	local parent_name = self:GetName(parent)
	name = parent_name .. "/" .. name
	
	return name
end

function SW_ADDON:GetChildren(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	return ent.__SW_Vars.ChildrenENTs or {}
end

function SW_ADDON:GetChild(ent, name)
	local children = self:GetChildren(ent)
	if !children then return end
	
	local child = children[name]
	if !IsValid(child) then return end
	
	if self:GetParent(child) != ent then
		children[name] = nil
		return
	end

	return child
end

function SW_ADDON:GetChildFromPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	
	local curchild = ent
	for k, v in pairs(hirachy) do
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return end
	end
	
	return curchild
end

function SW_ADDON:FindChildAtPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	local lastindex = #hirachy
	
	local curchild = ent
	for k, v in ipairs(hirachy) do
		if(k >= lastindex) then
			return self:FindChildren(curchild, v)
		end
		
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return {} end
	end
	
	return {}
end

function SW_ADDON:ForEachFilteredChild(ent, name, func)
	if !IsValid(ent) then return end
	if !isfunction(func) then return end
	
	local found = self:FindChildAtPath(ent, name)
	local index = 0
	
	for k, v in pairs(found) do
		index = index + 1
		local bbreak = func(ent, index, k, v)
		if bbreak then break end
	end
end

function SW_ADDON:FindChildren(ent, name)
	local children = self:GetChildren(ent)
	if !children then return {} end
	
	name = tostring(name or "")
	
	local found = {}
	for k, v in pairs(children) do
		if !IsValid(v) then continue end
		if !string.find(k, name) then continue end
		found[k] = v
	end
	
	return found
end

function SW_ADDON:ChangePoseParameter( ent, val, name, divide )
	if !IsValid(ent) then return end
	val = val or 0
	name = name or ""
	divide = divide or 1
	
	ent:SetPoseParameter( name, val/divide ) 
end

function SW_ADDON:Exit_Seat( ent, ply, pvf, pvr, pvu, evf, evr, evu )

	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end

	local Filter = function( addon, veh, f_ent )
		if !IsValid(f_ent) then return false end
		if !IsValid(ply) then return false end
		if f_ent == veh then return false end
		if f_ent == ply then return false end
		if f_ent:GetModel() == "models/sligwolf/unique_props/seat.mdl" then return false end

		return true
	end	

	local lpos = ent:GetPos()
	local lang = ent:GetAngles()
	local fwd = lang:Forward()
	local rgt = lang:Right()
	local up = lang:Up()
	local pos = lpos - fwd*pvf - rgt*pvr - up*pvu
	
	pvf = pvf or 0
	pvr = pvr or 0
	pvu = pvu or 0
	evf = evf or 0
	evr = evr or 0
	evu = evu or 0

	local tb = {
		V1 = { VecA = Vector(0,0,0), VecB = Vector(0,0,70) },
		V2 = { VecA = Vector(15,0,0), VecB = Vector(15,0,70) },
		V3 = { VecA = Vector(0,15,0), VecB = Vector(0,15,70) },
		V4 = { VecA = Vector(-15,0,0), VecB = Vector(-15,0,70) },
		V5 = { VecA = Vector(0,-15,0), VecB = Vector(0,-15,70) },
		V6 = { VecA = Vector(15,15,0), VecB = Vector(15,15,70) },
		V7 = { VecA = Vector(-15,15,0), VecB = Vector(-15,15,70) },
		V8 = { VecA = Vector(-15,-15,0), VecB = Vector(-15,-15,70) },
		V9 = { VecA = Vector(15,-15,0), VecB = Vector(15,-15,70) },
	}
	
	for k,v in pairs(tb) do
		local tr = self:Tracer( ent, pos+v.VecA, pos+v.VecB, Filter )
		if tr.Hit then return true end
	end
	
	ply:SetPos(pos)
	ply:SetEyeAngles((lpos-(lpos - fwd*evf - rgt*evr + up*evu)):Angle())
	return false
end

function SW_ADDON:Indicator_Sound(ent, bool_R, bool_L, pitchon, pitchoff, vol, sound)
	if !IsValid(ent) then return end
	
	local Check = bool_R or bool_L or nil
	if !Check then return end
	vol = vol or 50
	pitchon = pitchon or 100
	pitchoff = pitchoff or 75
	sound = sound or "vehicles/sligwolf/generic/indicator_on.wav"
	
	if !ent.__SW_Indicator_OnOff then
		ent:EmitSound(sound, vol, pitchon)
		ent.__SW_Indicator_OnOff = true
		return
	else
		ent:EmitSound(sound, vol, pitchoff)
		ent.__SW_Indicator_OnOff = false
		return
	end
end

function SW_ADDON:VehicleOrderThink()
	if CLIENT then
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		local vehicle = ply:GetVehicle()
		if !IsValid(vehicle) then return end
		
		if gui.IsGameUIVisible() then return end
		if gui.IsConsoleVisible() then return end
		if IsValid(vgui.GetKeyboardFocus()) then return end
		if ply:IsTyping() then return end
		
		for k,v in pairs(self.KeySettings or {}) do
			if (!v.cv) then continue end
			
			local isdown = input.IsKeyDown( v.cv:GetInt() )
			self:SendVehicleOrder(vehicle, k, isdown)
		end
		
		return
	end

	for vehicle, players in pairs(self.PressedKeyMap or {}) do
		if !IsValid(vehicle) then continue end
		
		for ply, keys in pairs(players or {}) do
			if !IsValid(ply) then continue end
			
			for name, callback_data in pairs(keys or {}) do
				if !callback_data.state then continue end
				
				local callback_hold = callback_data.callback_hold
				callback_hold(self, ply, vehicle, true)
			end
		end
	end
end

function SW_ADDON:VehicleOrderLeave(ply, vehicle)
	if CLIENT then return end
	
	local holdedkeys = self.PressedKeyMap or {}
	holdedkeys = holdedkeys[vehicle] or {}
	holdedkeys = holdedkeys[ply] or {}

	for name, callback_data in pairs(holdedkeys) do
		if !callback_data.state then continue end
	
		local callback_hold = callback_data.callback_hold
		local callback_up = callback_data.callback_up
		
		callback_hold(self, ply, vehicle, false)
		callback_up(self, ply, vehicle, false)
		
		callback_data.state = false
	end
end

function SW_ADDON:RegisterVehicleOrder(name, callback_hold, callback_down, callback_up)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	if CLIENT then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end

	name = name or ""
	if name == "" then return end

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	
	local valid = false
	if !isfunction(callback_hold) then
		callback_hold = (function() end)
	else
		valid = true
	end
		
	if !isfunction(callback_down) then
		callback_down = (function() end)
	else
		valid = true
	end
	
	if !isfunction(callback_up) then
		callback_up = (function() end)
	else
		valid = true
	end	
	
	if !valid then
		error("no callback functions given!")
		return
	end	
	
	util.AddNetworkString( netname )
	net.Receive( netname, function( len, ply )
		local ent = net.ReadEntity()
		local down = net.ReadBool() or false
		
		if !IsValid(ent) then return end
		if !IsValid(ply) then return end
		if !ply:InVehicle() then return end

		local veh = ply:GetVehicle()
		if(ent != veh) then return end
		
		local setting = self.KeySettings[name]
		if !setting then return end
		
		self.KeyBuffer = self.KeyBuffer or {}
		self.KeyBuffer[veh] = self.KeyBuffer[veh] or {}
	
		local changedbuffer = self.KeyBuffer[veh][name] or {}
		local times  = changedbuffer.times or {}
		
		local mintime = setting.time or 0
		if mintime > 0 then
			local lasttime = times[down] or 0
			local deltatime = CurTime() - lasttime
		
			if deltatime <= mintime then return end
		end
		
		if changedbuffer.state == down then return end
		
		times[down] = CurTime()	
		changedbuffer.times = times
		changedbuffer.state = down
		
		self.KeyBuffer[veh][name] = changedbuffer
		
		self.PressedKeyMap = self.PressedKeyMap or {}
		self.PressedKeyMap[veh] = self.PressedKeyMap[veh] or {}
		self.PressedKeyMap[veh][ply] = self.PressedKeyMap[veh][ply] or {}
		self.PressedKeyMap[veh][ply][name] = {
			callback_hold = callback_hold,
			callback_up = callback_up,
			callback_down = callback_down,
			state = down,
		}

		if down then
			callback_down(self, ply, veh, down)
			return
		end
		
		callback_up(self, ply, veh, down)
	end)
end

function SW_ADDON:RegisterKeySettings(name, default, time, description, extra_text)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	name = name or ""
	description = description or ""
	help = help or ""
	default = default or 0
	time = time or 0.1
	
	if (name == "") then return end
	if (description == "") then return end
	if (default == 0) then return end

	local setting = {}
	setting.description = description
	setting.cvcmd = "cl_"..self.NetworkaddonID.."_key_"..name
	setting.default = default
	setting.time = time

	if (extra_text != "") then
		setting.extra_text = extra_text
	end

	if CLIENT then
		setting.cv = CreateClientConVar( setting.cvcmd, tostring( default ), true, false )
	end

	self.KeySettings = self.KeySettings or {}
	self.KeySettings[name] = setting
end

if CLIENT then

function SW_ADDON:SendVehicleOrder(vehicle, name, down)
	if !IsValid(vehicle) then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end
	
	name = name or ""
	down = down or false

	if name == "" then return end
	
	self.KeyBuffer = self.KeyBuffer or {}
	self.KeyBuffer[vehicle] = self.KeyBuffer[vehicle] or {}
	
	local changedbuffer = self.KeyBuffer[vehicle][name] or {}

	if changedbuffer.state == down then return end
	changedbuffer.state = down
	
	self.KeyBuffer[vehicle][name] = changedbuffer

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	net.Start(netname) 
		net.WriteEntity(vehicle)
		net.WriteBool(down)
	net.SendToServer()
end


local function AddGap(panel)
	local pnl = panel:AddControl("Label", {
		Text = ""
	})
	
	return pnl
end

function SW_ADDON:VehicleOrderMenu()
	spawnmenu.AddToolMenuOption(
		"Utilities", "SW Vehicle KEY's",
		self.NetworkaddonID.."_Key_Settings",
		self.NiceName, "", "",
		function(panel, ...)
			for k,v in pairs(self.KeySettings or {}) do
				if (!v.cv) then continue end

				panel:AddControl( "Numpad", { 
					Label = v.description, 
					Command = v.cvcmd
				})
				
				if (v.extra_text) then
					panel:AddControl("Label", {
						Text = v.extra_text
					})
				end
				
				AddGap(panel)
			end
		end
	)
end

end

function SW_ADDON:SoundEdit(sound, state, pitch, pitchtime, volume, volumetime)

	sound = sound or nil
	if !sound then return end
	
	state = state or 0
	pitch = pitch or 100
	pitchtime = pitchtime or 0
	volume = volume or 1
	volumetime = volumetime or 0
	
	if state == 0 then
		sound:Stop()
	end
	if state == 1 then
		sound:Play()
	end
	if state == 2 then
		sound:ChangePitch(pitch, pitchtime)
	end
	if state == 3 then
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 4 then
		sound:Play()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 5 then
		sound:Stop()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
end

function SW_ADDON:GetBoneArray( ent )
	if !IsValid(ent) then return end
	
	local EntArray = {}
	local BoneArray = {}
	local BoneAngArray = {}
	local BonePosArray = {}
	
	for i = 1, 128 do		
		local Bone = ent:GetBoneName( i )
		if !Bone or Bone == "" or Bone == "__INVALIDBONE__" then continue end
		
		BoneArray[i] = Bone
		BoneAngArray[i] = ent:GetManipulateBoneAngles( i )
		BonePosArray[i] = ent:GetManipulateBonePosition( i )
	end
	
	EntArray = {
		Bones = BoneArray,
		Angles = BoneAngArray,
		Positions = BonePosArray,
	}
	
	ent.__SW_EntArray_Bone_Ang_Pos = EntArray
	
end

function SW_ADDON:CheckBoneArray( ent )
	if !IsValid(ent) then return false end
	
	local tb0 = ent.__SW_EntArray_Bone_Ang_Pos
	if !istable(tb0) then return false end
	
	local Check = table.GetKeys(tb0)
	local Num0 = table.Count(tb0)
	if !istable( Check ) then return false end
	if !Num0 == 3 then return false end
	
	local tb1 = tb0.Bones
	local tb2 = tb0.Angles
	local tb3 = tb0.Positions
	
	if !istable(tb1) or !istable(tb2) or !istable(tb3) then return false end
	
	local Num1 = table.Count( tb1 )
	local Num2 = table.Count( tb2 )
	local Num3 = table.Count( tb3 )
	
	if Num1 != Num2 then return false end
	if Num2 != Num3 then return false end
	if Num3 != Num1 then return false end
	
	return true
	
end

function SW_ADDON:BoneEdit( ent, name, ang, vec )
	if !IsValid(ent) then return end
	
	local Check = self:CheckBoneArray(ent)
	if !Check then return end
	
	local TB = ent.__SW_EntArray_Bone_Ang_Pos
	
	name = name or nil
	local Bone = ent:LookupBone(name)
	if !Bone then return end
	vec = vec or TB.Positions[Bone] or Vector()
	ang = ang or TB.Angles[Bone] or Angle()
	
	ent:ManipulateBonePosition( Bone, vec ) 
	ent:ManipulateBoneAngles( Bone, ang )

end

function SW_ADDON:CamControl(ply, ent)

	if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	
	if ply:GetViewEntity() == ent then
		ply:SetViewEntity(ply)
		ply.__SW_Cam_Mode = false
		return
	end
	ply:SetViewEntity(ent)
	ply.__SW_Cam_Mode = true
end

function SW_ADDON:ViewEnt( ply )
	if !IsValid(ply) then return end
	
	local Old_Cam = ply:GetViewEntity()
	ply.__SW_Old_Cam = Old_Cam
	local Cam = ply.__SW_Old_Cam
	
	if !IsValid(Cam) then return end
	if !ply.__SW_Cam_Mode then return end
	
	ply:SetViewEntity(ply)
	ply.__SW_Cam_Mode = false
end

function SW_ADDON:ChangeMat( ent, num, mat )
	if !IsValid(ent) then return end
	num = num or 0
	mat = mat or ""
	
	ent:SetSubMaterial( num, mat )
end

function SW_ADDON:RemoveUTimerOnEnt(ent, name)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end

	name = tostring(name or "")
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	timer.Remove(uname)
end

function SW_ADDON:CreateUTimerOnEnt(ent, name, time, func, repeats)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end
	
	name = tostring(name or "")
	time = time or 0
	repeats = repeats or 0
	
	if repeats <= 0 then
		repeats = 1
	end
	
	if time < 0 then
		time = 0
	end
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	
	timer.Remove(uname)
	timer.Create(uname, time, repeats, function()
	
		if !IsValid(ent) then
			timer.Remove( uname )
			return
		end
	
		func(ent)
	end)
end

local function GetCameraEnt( ply )
	if !IsValid(ply) and CLIENT then
		ply = LocalPlayer()
	end

	if !IsValid(ply) then return nil end
	local camera = ply:GetViewEntity()
	if !IsValid(camera) then return ply end

	return camera
end

function SW_ADDON:DoTrace( ply, maxdist, filter )
	local camera = GetCameraEnt(ply)
	local start_pos, end_pos
	if !IsValid(ply) then return nil end
	if !IsValid(camera) then return nil end
	
	maxdist = maxdist or 500

	if camera:IsPlayer() then
		start_pos = camera:EyePos()
		end_pos = start_pos + camera:GetAimVector() * maxdist
	else
		start_pos = camera:GetPos()
		end_pos = start_pos + ply:GetAimVector() * maxdist
	end
	
	local trace = {}
	trace.start = start_pos
	trace.endpos = end_pos

	trace.filter = function( ent, ... )
		if !IsValid(ent) then return false end
		if !IsValid(ply) then return false end
		if !IsValid(camera) then return false end
		if ent == ply then return false end
		if ent == camera then return false end
		
		if ply.GetVehicle and ent == ply:GetVehicle() then return false end
		if camera.GetVehicle and ent == camera:GetVehicle() then return false end

		if filter then
			if isfunction(filter) then
				if !filter(ent, ply, camera, ...) then
					return false
				end
			end
			
			if istable(filter) then
				if filter[ent] then
					return false
				end
			end
			
			if filter == ent then
				return false
			end
		end
		
		return true
	end
	return util.TraceLine(trace)
end

function SW_ADDON:PressButton( ply, playervehicle )
	if !IsValid(ply) then return end

	local tr = self:DoTrace(ply, 100)
	if !tr then return end
	
	local Button = tr.Entity
	if !IsValid(Button) then return end
		
	local superparent = self:GetSuperParent(Button)

	if !IsValid(superparent) then
		superparent = Button
		playervehicle = nil
	else
		if Button.__SW_Invehicle and !IsValid(playervehicle) then return end
	end

	if IsValid(playervehicle) and superparent != playervehicle then return end

	if !Button.__SW_Buttonfunc then return end

	if !superparent.__SW_AddonID or ( superparent.__SW_AddonID == "" ) then
		error("superparent.__SW_AddonID missing!")
		return
	end
	
	if superparent.__SW_AddonID != self.NetworkaddonID then return end

	local allowuse = true
	
	if superparent.CPPICanUse then
		allowuse = superparent:CPPICanUse(ply) or false
	end
	
	if !allowuse then return end
	
	return Button.__SW_Buttonfunc(Button, superparent, ply)
end

local matcache = {}
function SW_ADDON:SW_HUD_Texture(PNGname, RGB, TexX, TexY, W, H)
	local texturedata = matcache[PNGname]

	if texturedata then
		texturedata.color = RGB
		texturedata.x = TexX
		texturedata.y = TexY
		texturedata.w = W
		texturedata.h = H
   
		return texturedata
	end

	matcache[PNGname] = { Textur = Material(PNGname), color=RGB, x=TexX, y=TexY, w=W, h=H }
	return matcache[PNGname]
end

function SW_ADDON:DrawMaterial(texturedata)
	surface.SetMaterial(texturedata.Textur)
	surface.DrawTexturedRect(texturedata.x, texturedata.y, texturedata.w, texturedata.h)
end

function SW_ADDON:GetConnectedVehicles(vehicle)
	vehicle = self:GetSuperParent(vehicle)
	if !IsValid(vehicle) then return end

	vehicle.__SW_Connected = vehicle.__SW_Connected or {}
	return vehicle.__SW_Connected
end

function SW_ADDON:GetTrailerVehicles(vehicle)
	if !IsValid(vehicle) then return end

	local unique = {}
	local connected = {}

	local function recusive_func(f_ent)
		local vehicles = self:GetConnectedVehicles(f_ent)
		if !vehicles then return end

		for k, v in pairs(vehicles) do
			if !IsValid(v) then continue end
			if unique[v] then continue end
			
			unique[v] = true
			connected[#connected + 1] = v
			recusive_func(v)
		end
		
		if unique[f_ent] then return end
		
		unique[f_ent] = true
		connected[#connected + 1] = f_ent
	end
	
	recusive_func(vehicle)
	
	return connected
end

function SW_ADDON:ForEachTrailerVehicles(vehicle, func)
	if !IsValid(vehicle) then return end
	if !isfunction(func) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	for k, v in ipairs(vehicles) do
		if !IsValid(vehicle) then continue end
		if func(k, v) == false then break end
	end
end

function SW_ADDON:GetTrailerMainVehicles(vehicle)
	if !IsValid(vehicle) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	local mainvehicles = {}
	for k, v in pairs(vehicles) do
		if !IsValid(v) then continue end
		if !v.__IsSW_TrailerMain then continue end
		mainvehicles[#mainvehicles + 1] = v
	end
	
	return mainvehicles
end

function SW_ADDON:TrailerHasMainVehicles(vehicle)
	local mainvehicles = self:GetTrailerMainVehicles(vehicle)
	
	if !mainvehicles then return false end
	if !IsValid(mainvehicles[1]) then return false end
	
	return true
end

function SW_ADDON:ValidateName(name)
	name = tostring(name or "")
	name = string.gsub(name, "^!", "", 1)
	name = string.gsub(name, "[\\/]", "")
	return name
end

function SW_ADDON:GetVal(ent, name, default)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name

	local data = vars.Data or {}
	local value = data[name]
	
	if value == nil then
		value = default 
	end
	
	return value
end

function SW_ADDON:SetVal(ent, name, value)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name
	
	vars.Data = vars.Data or {}
	vars.Data[name] = value
end

function SW_ADDON:SetupDupeModifier(ent, name, precopycallback, postcopycallback)
    if !IsValid(ent) then return end

	name = self:ValidateName(name)
    if name == "" then return end

	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
    if vars.duperegistered then return end
	
    if !isfunction(precopycallback) then
		precopycallback = (function() end)
	end
	
	if !isfunction(postcopycallback) then
		postcopycallback = (function() end)
	end
	
	local oldprecopy = superparent.PreEntityCopy or (function() end)
	local dupename = "SW_Common_MakeEnt_Dupe_" .. self.NetworkaddonID  .. "_" .. name
	vars.dupename = dupename
	
	superparent.PreEntityCopy = function(...)
		if IsValid(superparent) then
			precopycallback(superparent)
		end
		
		vars.Data = vars.Data or {}
		duplicator.StoreEntityModifier(superparent, dupename, vars.Data)
		
		return oldprecopy(...)
	end
	vars.duperegistered = true

	self.duperegistered = self.duperegistered or {}
    if self.duperegistered[dupename] then return end
	
	duplicator.RegisterEntityModifier(dupename, function(ply, ent, data)
		if !IsValid(ent) then return end

		local superparent = self:GetSuperParent(ent) or ent
		if !IsValid(superparent) then return end

		superparent.__SW_Vars = superparent.__SW_Vars or {}
		local vars = superparent.__SW_Vars
		
		vars.Data = data or {}
		
		if IsValid(superparent) then
			postcopycallback(superparent)
		end
	end)
	
	self.duperegistered[dupename] = true
end

function SW_ADDON:AddFont(name, data)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end

	name = self.NetworkaddonID .. "_" .. name
	
	self.cachedfonts = self.cachedfonts or {}
	if self.cachedfonts[name] then return name end
	
	self.cachedfonts[name] = true

	surface.CreateFont(name, data)
	return name
end

function SW_ADDON:GetFont(name)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end
	
	name = self.NetworkaddonID .. "_" .. name
	if !self.cachedfonts[name] then return nil end
	
	return name
end

function SW_ADDON:CheckAllowUse(ent, ply)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	local allowuse = true
	
    if ent.CPPICanUse then
		allowuse = ent:CPPICanUse(ply) or false
	end
	
    return allowuse
end

function SW_ADDON:VectorToLocalToWorld( ent, vec )
	if !IsValid(ent) then return nil end
	
	vec = vec or Vector()
	vec = ent:LocalToWorld(vec)
	
	return vec
end

function SW_ADDON:DirToLocalToWorld( ent, ang, dir )
	if !IsValid(ent) then return nil end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	ang = ang or Angle()
	ang = ent:LocalToWorldAngles(ang)
		
		
	local func = ang[dir]
	if !isfunction(func) then return end

	return func(ang)
end

function SW_ADDON:GetAttachmentPosAng(ent, attachment)
	if !self:IsValidModel(ent) then return nil end
	attachment = tostring(attachment or "")

	if attachment == "" then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Num = ent:LookupAttachment(attachment) or 0
	if Num <= 0 then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Att = ent:GetAttachment(Num)
	if not Att then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local pos = Att.Pos
	local ang = Att.Ang

	return pos, ang, true
end

function SW_ADDON:SetEntAngPosViaAttachment(entA, entB, attA, attB)
	if !self:IsValidModel(entA) then return false end
	if !self:IsValidModel(entB) then return false end

	attA = tostring(attA or "")
	attB = tostring(attB or "")
	
	local PosA, AngA, HasAttA = self:GetAttachmentPosAng(entA, attA)
	local PosB, AngB, HasAttB = self:GetAttachmentPosAng(entB, attB)

	if not HasAttA and not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	if not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	local localPosA = entA:WorldToLocal(PosA)
	local localAngA = entA:WorldToLocalAngles(AngA)

	local localPosB = entB:WorldToLocal(PosB)
	local localAngB = entB:WorldToLocalAngles(AngB)

	local M = Matrix()

	M:SetAngles(localAngA)
	M:SetTranslation(localPosA)

	local M2 = Matrix()
	M2:SetAngles(localAngB)
	M2:SetTranslation(localPosB)

	M = M * M2:GetInverseTR()

	local ang = M:GetAngles()
	local pos = M:GetTranslation()

	pos = entA:LocalToWorld(pos)
	ang = entA:LocalToWorldAngles(ang)

	entB:SetAngles(ang)
	entB:SetPos(pos)

	return true
end

function SW_ADDON:RemoveEntites(tb)
	tb = tb or {}
	if !istable(tb) then return end
	
	for k,v in pairs(tb) do
		if !IsValid(v) then continue end
		v:Remove()
	end
end

function SW_ADDON:FindPropInSphere(ent, radius, attachment, filterA, filterB)
	if !IsValid(ent) then return nil end
	radius = radius or 10
	filterA = filterA or "none"
	filterB = filterB or "none"
	
	local new_ent = nil

	local pos = self:GetAttachmentPosAng(ent, attachment)
	local objs = ents.FindInSphere( pos, radius ) or {}
	
	for k,v in pairs(objs) do
		if !IsValid(v) then continue end
		local mdl = v:GetModel()
		if mdl == filterA or mdl == filterB then
			new_ent = v
			return new_ent
		end
	end
	
	return nil
end

local Color_trGreen = Color( 50, 255, 50 )
local Color_trBlue = Color( 50, 50, 255 )
local Color_trTextHit = Color( 100, 255, 100 )

function SW_ADDON:Tracer( ent, vec1, vec2, filterfunc )
	if !IsValid(ent) then return nil end
	
	vec1 = vec1 or Vector()
	vec2 = vec2 or Vector()

	if !isfunction(filterfunc) then
		filterfunc = (function()
			return true
		end)
	end
	
	local tr = util.TraceLine( {
		start = vec1,
		endpos = vec2,
		filter = function(trent, ...)
			if !IsValid(ent) then return false end
			if !IsValid(trent) then return false end
			if trent == ent then return false end
			
			local sp = self:GetSuperParent(ent)
			if !IsValid(sp) then return false end
			if trent == sp then return false end

			if self:GetSuperParent(trent) == sp then return false end
			return filterfunc(self, sp, trent, ...)
		end
	} )
	
	if !tr then return nil end
	
	vec1 = tr.StartPos
	
	debugoverlay.Cross( vec1, 1, 0.1, color_white, true ) 
	debugoverlay.Cross( vec2, 1, 0.1, color_white, true ) 
	debugoverlay.Line( vec1, tr.HitPos, 0.1, Color_trGreen, true )
	debugoverlay.Line( tr.HitPos, vec2, 0.1, Color_trBlue, true )
	debugoverlay.EntityTextAtPosition(vec1, 0, "Start", 0.1, color_white)
	
	if tr.Hit then
		debugoverlay.EntityTextAtPosition(tr.HitPos, 0, "Hit", 0.1, Color_trTextHit)
	end
	
	debugoverlay.EntityTextAtPosition(vec2, 0, "End", 0.1, color_white)
	
	return tr
end

function SW_ADDON:TracerAttachment( ent, attachment, len, dir, filterfunc )
	len = len or 0
	
	if len == 0 then
		len = 1
	end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	local pos, ang = self:GetAttachmentPosAng(ent, attachment)
	if !pos then return end
		
	local func = ang[dir]
	if !isfunction(func) then return end

	local endpos = pos + func(ang) * len

	return self:Tracer(ent, pos, endpos, filterfunc)
end

function SW_ADDON:TracerAttachmentToAttachment( ent, attachmentA, attachmentB, filterfunc )
	local posA = self:GetAttachmentPosAng(ent, attachmentA)
	if !posA then return end

	local posB = self:GetAttachmentPosAng(ent, attachmentB)
	if !posB then return end

	return self:Tracer(ent, posA, posB, filterfunc)
end

function SW_ADDON:CheckGround(ent, vec1, vec2)
	if !IsValid(ent) then return false end

	vec2 = vec2 or vec1
	vec1 = vec1 or vec2

	if !vec1 then return false end
	if !vec2 then return false end

	local vec1A = ent:LocalToWorld(Vector(vec1.x, vec1.y, vec1.z)) 
	local vec2A = ent:LocalToWorld(Vector(vec2.x, -vec2.y, vec2.z)) 

	local vec1B = ent:LocalToWorld(Vector(-vec1.x, vec1.y, vec1.z)) 
	local vec2B = ent:LocalToWorld(Vector(-vec2.x, -vec2.y, vec2.z)) 

	local tr1 = self:Tracer(ent, vec1A, vec2A)
	local tr2 = self:Tracer(ent, vec1B, vec2B)
	
	if tr1 and tr1.Hit then return true end
	if tr2 and tr2.Hit then return true end
	
	return false
end

function SW_ADDON:GetRelativeVelocity(ent)
	if !IsValid(ent) then return end

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local v = phys:GetVelocity()
	return phys:WorldToLocalVector(v)
end

function SW_ADDON:GetForwardVelocity(ent)
	local v = self:GetRelativeVelocity(ent)
	if !v then return 0 end
	
	return v.y or 0
end

function SW_ADDON:GetKPHSpeed(v)
	local UnitKmh = math.Round((v * 0.75) * 3600 * 0.0000254)
	return UnitKmh
end

function SW_ADDON:ConstraintIsAllowed(ent, ply, mode)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	mode = tostring(mode or "")
	mode = string.lower(mode)
	
	if mode == "" then
		mode = "weld"
	end
	
	local allowtool = true
	
	if ent.CPPICanTool then
		allowtool = ent:CPPICanTool(ply, mode) or false
	end
	
	if !allowtool then return false end
	return true
end

-- "addons\\slick\\lua\\sw_addons\\bluex11\\common.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/* 
Version 10.08.20

Last Change: 

Changed the functions:
SetEntAngPosViaAttachment()

Improved the function. No helper prop is needed anymore.

*/

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

function SW_ADDON:Add_Items( name, listname, model, class, skin )
	class = class or "prop_physics"
	skin = skin or 0
	
	local NormalOffset = nil
	local DropToFloor = nil
	
	if (class != "prop_ragdoll") then
		NormalOffset = 64
		DropToFloor = true
	end

	list.Set( "SpawnableEntities", name, { 
		PrintName = listname, 
		ClassName = class, 
		Category = "SligWolf's Props",
		
		NormalOffset = NormalOffset,
		DropToFloor = DropToFloor,

		KeyValues = {
			model = model,
			skin = skin,
			addonname = self.Addonname,
		}
	})
end

function SW_ADDON:AddPlayerModel(name, player_model, vhands_model, skin, bodygroup)
	player_model = player_model or ""
	vhands_model = vhands_model or ""
	name = name or player_model
	skin = skin or 0
	bodygroup = bodygroup or "00000000"

	if player_model == "" then return end
	
	player_manager.AddValidModel( name, player_model )

	if vhands_model == "" then return end
	player_manager.AddValidHands( name, vhands_model, skin, bodygroup )
end

local function NPC_Setup( ply, npc )
	if !IsValid(npc) then return end
	if npc.__IsSW_Duped then return end
	
	local kv = npc:GetKeyValues()
	local name = kv["classname"] or ""
	
	local tab = list.Get("NPC")
	local data = tab[name]
	if !data then return end
	if !data.IsSW then return end
	
	local data_custom = data.SW_Custom or {}
	
	if data_custom.Accuracy then
		npc:SetCurrentWeaponProficiency( data_custom.Accuracy )
	end
	
	if data_custom.Health then
		npc:SetHealth( data_custom.Health )
	end
	
	if data_custom.Blood then
		npc:SetBloodColor( data_custom.Blood )
	end
	
	if data_custom.Color then
		npc:SetColor( data_custom.Color )
	end
	
	if data_custom.Owner then
		npc.Owner = ply
	end
	
	local func = data_custom.OnSpawn
	if isfunction(func) then
		func(npc, data)
	end
	
	npc.__IsSW_Addon = true
	npc.__IsSW_Class = name
	
	local class = tostring(data.Class or "Corrupt Class!")
	npc:SetKeyValue( "classname", class )
	
	local dupedata = {}
	dupedata.customclass = name
	
	duplicator.StoreEntityModifier(npc, "SW_Common_NPC_Dupe", dupedata) 
end

local function NPC_Dupe(ply, npc, data)
	if !IsValid(npc) then return end
	if !data then return end
	if !data.customclass then return end

	npc:SetKeyValue( "classname", data.customclass )
	NPC_Setup(ply, npc)
	npc.__IsSW_Duped = true
end

function SW_ADDON:Add_NPC(name, npc)
	name = name or ""
	if name == "" then return end
	npc = npc or {}

	npc.Name = npc.Name or "SligWolf - Generic"
	npc.Class = npc.Class or "npc_citizen"
	npc.Category = npc.Category or "SligWolf's NPC's"
	npc.Skin = npc.Skin or 0
	npc.KeyValues = npc.KeyValues or {}
	npc.IsSW = true
	
	// Workaround to get back to custom NPC classname from the spawned NPC
	npc.KeyValues.classname = name

	npc.SW_Custom = npc.SW_Custom or {}
	list.Set( "NPC", name, npc )

	hook.Remove( "PlayerSpawnedNPC", "SW_Common_NPC_Setup")
	hook.Add( "PlayerSpawnedNPC", "SW_Common_NPC_Setup", NPC_Setup)
	duplicator.RegisterEntityModifier( "SW_Common_NPC_Dupe", NPC_Dupe)
	
	if CLIENT then
		language.Add(name, npc.Name)
	end
end

local function CantTouch( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Blockedprop then return false end
end
hook.Add( "PhysgunPickup", "SW_Common_CantTouch", CantTouch )

local function CantPickUp( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Cantpickup then return false end
end
hook.Add( "AllowPlayerPickup", "SW_Common_CantPickUp", CantPickUp )

local function CantUnfreeze( ply, ent )
    if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	if ent.__SW_NoUnfreeze then return false end
end
hook.Add( "CanPlayerUnfreeze", "SW_Common_CantUnfreeze", CantUnfreeze )

local function Tool( ply, tr, tool )
    if !IsValid(ply) then return end
	
	local ent = tr.Entity
	debugoverlay.Text( tr.HitPos, tostring(tool), 3, false ) 
	
	if ent.__SW_BlockAllTools then return false end
	
	local tb = ent.__SW_BlockTool
	
	if istable(tb) then
		if tb[tool] then
			return false
		end
	end
	
	if ent.__SW_AllowOnlyThisTool == tool then 
		return false
	end
end
hook.Add( "CanTool", "SW_Common_Tool", Tool )

local function ToolReload( ply, tr, tool )
    if !IsValid(ply) then return end

	local ent = tr.Entity
	local tb = ent.__SW_DenyToolReload
	
	if istable(tb) then
		if tb[tool] then
			if ply:KeyPressed(IN_RELOAD) then return false end
		end
	end
end
hook.Add( "CanTool", "SW_Common_ToolReload", ToolReload )

function SW_ADDON:MakeEnt(classname, ply, parent, name)
    local ent = ents.Create(classname)

    if !IsValid(ent) then return end
	ent.__SW_Vars = ent.__SW_Vars or {}
	self:SetName(ent, name)
	self:SetParent(ent, parent)
	
	if ent.__IsSW_Entity then
		ent:SetAddonID(self.Addonname)
	end

    if !ent.CPPISetOwner then return ent end
    if !IsValid(ply) then return ent end

    ent:CPPISetOwner(ply)
    return ent
end

function SW_ADDON:IsValidModel(ent)
	if !IsValid(ent) then return false end
	
	local model = tostring(ent:GetModel() or "")
	if model == "" then return false end
	
	model = Model(model)
	if !util.IsValidModel(model) then return false end
	
	return true
end

function SW_ADDON:AddToEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	
	if IsValid(ent) then
		self.ents[name][ent] = true
	else
		self.ents[name][ent] = nil
	end
end

function SW_ADDON:RemoveFromEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	self.ents[name][ent] = nil
end


function SW_ADDON:GetAllFromEntList(name)
	name = tostring(name or "")

	self.ents = self.ents or {}
	return self.ents[name] or {}
end

function SW_ADDON:ForEachInEntList(name, func)
	if !isfunction(func) then return end
	local entlist = self:GetAllFromEntList(name)
	
	local index = 1
	for k, v in pairs(entlist) do
		if !IsValid(k) then
			entlist[k] = nil
			continue
		end
		
		local bbreak = func(self, index, k)
		if bbreak == false then
			break
		end
		
		index = index + 1
	end
end

function SW_ADDON:SetupChildEntity(ent, parent, collision, attachmentid)
	if !IsValid(ent) then return end
	if !IsValid(parent) then return end
	
	collision = collision or COLLISION_GROUP_NONE
	attachmentid = attachmentid or 0
	
	ent:Spawn()
	ent:Activate()
	ent:SetParent(parent, attachmentid)
	ent:SetCollisionGroup( collision )
	ent:SetMoveType( MOVETYPE_NONE )
	ent.DoNotDuplicate = true
	parent:DeleteOnRemove( ent )
	
	self:SetParent(ent, parent)

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return ent end
	phys:Sleep()
	
	return ent
end

function SW_ADDON:GetName(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return "" end
	
	return self:ValidateName(ent.__SW_Vars.Name)
end

function SW_ADDON:SetName(ent, name)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars
	
	name = self:ValidateName(name)
	if name == "" then
		name = tostring(util.CRC(tostring(ent)))
	end
	
	local oldname = self:GetName(ent)
	vars.Name = name
	
	local parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[oldname] = nil
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars

    if !IsValid(vars.ParentENT) then return end
	if vars.ParentENT == ent then return end

	return vars.ParentENT
end

function SW_ADDON:SetParent(ent, parent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	if parent == ent then
		parent = nil
	end
	
	local vars = ent.__SW_Vars

	vars.ParentENT = parent
	vars.SuperParentENT = self:GetSuperParent(ent)

	parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	local name = self:GetName(ent)
	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetSuperParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	local vars = ent.__SW_Vars
	
	if IsValid(vars.SuperParentENT) and (vars.SuperParentENT != ent) then
		return vars.SuperParentENT
	end
	
	if !IsValid(vars.ParentENT) then
		return ent
	end
	
	vars.SuperParentENT = self:GetSuperParent(vars.ParentENT)
	if vars.SuperParentENT == ent then return end
    if !IsValid(vars.SuperParentENT) then return end
	
	return vars.SuperParentENT
end

function SW_ADDON:GetEntityPath(ent)
	if !IsValid(ent) then return end
	
	local name = self:GetName(ent)
	local parent = self:GetParent(ent)
	
	if !IsValid(parent) then
		return name
	end
	
	local parent_name = self:GetName(parent)
	name = parent_name .. "/" .. name
	
	return name
end

function SW_ADDON:GetChildren(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	return ent.__SW_Vars.ChildrenENTs or {}
end

function SW_ADDON:GetChild(ent, name)
	local children = self:GetChildren(ent)
	if !children then return end
	
	local child = children[name]
	if !IsValid(child) then return end
	
	if self:GetParent(child) != ent then
		children[name] = nil
		return
	end

	return child
end

function SW_ADDON:GetChildFromPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	
	local curchild = ent
	for k, v in pairs(hirachy) do
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return end
	end
	
	return curchild
end

function SW_ADDON:FindChildAtPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	local lastindex = #hirachy
	
	local curchild = ent
	for k, v in ipairs(hirachy) do
		if(k >= lastindex) then
			return self:FindChildren(curchild, v)
		end
		
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return {} end
	end
	
	return {}
end

function SW_ADDON:ForEachFilteredChild(ent, name, func)
	if !IsValid(ent) then return end
	if !isfunction(func) then return end
	
	local found = self:FindChildAtPath(ent, name)
	local index = 0
	
	for k, v in pairs(found) do
		index = index + 1
		local bbreak = func(ent, index, k, v)
		if bbreak then break end
	end
end

function SW_ADDON:FindChildren(ent, name)
	local children = self:GetChildren(ent)
	if !children then return {} end
	
	name = tostring(name or "")
	
	local found = {}
	for k, v in pairs(children) do
		if !IsValid(v) then continue end
		if !string.find(k, name) then continue end
		found[k] = v
	end
	
	return found
end

function SW_ADDON:ChangePoseParameter( ent, val, name, divide )
	if !IsValid(ent) then return end
	val = val or 0
	name = name or ""
	divide = divide or 1
	
	ent:SetPoseParameter( name, val/divide ) 
end

function SW_ADDON:Exit_Seat( ent, ply, pvf, pvr, pvu, evf, evr, evu )

	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end

	local Filter = function( addon, veh, f_ent )
		if !IsValid(f_ent) then return false end
		if !IsValid(ply) then return false end
		if f_ent == veh then return false end
		if f_ent == ply then return false end
		if f_ent:GetModel() == "models/sligwolf/unique_props/seat.mdl" then return false end

		return true
	end	

	local lpos = ent:GetPos()
	local lang = ent:GetAngles()
	local fwd = lang:Forward()
	local rgt = lang:Right()
	local up = lang:Up()
	local pos = lpos - fwd*pvf - rgt*pvr - up*pvu
	
	pvf = pvf or 0
	pvr = pvr or 0
	pvu = pvu or 0
	evf = evf or 0
	evr = evr or 0
	evu = evu or 0

	local tb = {
		V1 = { VecA = Vector(0,0,0), VecB = Vector(0,0,70) },
		V2 = { VecA = Vector(15,0,0), VecB = Vector(15,0,70) },
		V3 = { VecA = Vector(0,15,0), VecB = Vector(0,15,70) },
		V4 = { VecA = Vector(-15,0,0), VecB = Vector(-15,0,70) },
		V5 = { VecA = Vector(0,-15,0), VecB = Vector(0,-15,70) },
		V6 = { VecA = Vector(15,15,0), VecB = Vector(15,15,70) },
		V7 = { VecA = Vector(-15,15,0), VecB = Vector(-15,15,70) },
		V8 = { VecA = Vector(-15,-15,0), VecB = Vector(-15,-15,70) },
		V9 = { VecA = Vector(15,-15,0), VecB = Vector(15,-15,70) },
	}
	
	for k,v in pairs(tb) do
		local tr = self:Tracer( ent, pos+v.VecA, pos+v.VecB, Filter )
		if tr.Hit then return true end
	end
	
	ply:SetPos(pos)
	ply:SetEyeAngles((lpos-(lpos - fwd*evf - rgt*evr + up*evu)):Angle())
	return false
end

function SW_ADDON:Indicator_Sound(ent, bool_R, bool_L, pitchon, pitchoff, vol, sound)
	if !IsValid(ent) then return end
	
	local Check = bool_R or bool_L or nil
	if !Check then return end
	vol = vol or 50
	pitchon = pitchon or 100
	pitchoff = pitchoff or 75
	sound = sound or "vehicles/sligwolf/generic/indicator_on.wav"
	
	if !ent.__SW_Indicator_OnOff then
		ent:EmitSound(sound, vol, pitchon)
		ent.__SW_Indicator_OnOff = true
		return
	else
		ent:EmitSound(sound, vol, pitchoff)
		ent.__SW_Indicator_OnOff = false
		return
	end
end

function SW_ADDON:VehicleOrderThink()
	if CLIENT then
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		local vehicle = ply:GetVehicle()
		if !IsValid(vehicle) then return end
		
		if gui.IsGameUIVisible() then return end
		if gui.IsConsoleVisible() then return end
		if IsValid(vgui.GetKeyboardFocus()) then return end
		if ply:IsTyping() then return end
		
		for k,v in pairs(self.KeySettings or {}) do
			if (!v.cv) then continue end
			
			local isdown = input.IsKeyDown( v.cv:GetInt() )
			self:SendVehicleOrder(vehicle, k, isdown)
		end
		
		return
	end

	for vehicle, players in pairs(self.PressedKeyMap or {}) do
		if !IsValid(vehicle) then continue end
		
		for ply, keys in pairs(players or {}) do
			if !IsValid(ply) then continue end
			
			for name, callback_data in pairs(keys or {}) do
				if !callback_data.state then continue end
				
				local callback_hold = callback_data.callback_hold
				callback_hold(self, ply, vehicle, true)
			end
		end
	end
end

function SW_ADDON:VehicleOrderLeave(ply, vehicle)
	if CLIENT then return end
	
	local holdedkeys = self.PressedKeyMap or {}
	holdedkeys = holdedkeys[vehicle] or {}
	holdedkeys = holdedkeys[ply] or {}

	for name, callback_data in pairs(holdedkeys) do
		if !callback_data.state then continue end
	
		local callback_hold = callback_data.callback_hold
		local callback_up = callback_data.callback_up
		
		callback_hold(self, ply, vehicle, false)
		callback_up(self, ply, vehicle, false)
		
		callback_data.state = false
	end
end

function SW_ADDON:RegisterVehicleOrder(name, callback_hold, callback_down, callback_up)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	if CLIENT then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end

	name = name or ""
	if name == "" then return end

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	
	local valid = false
	if !isfunction(callback_hold) then
		callback_hold = (function() end)
	else
		valid = true
	end
		
	if !isfunction(callback_down) then
		callback_down = (function() end)
	else
		valid = true
	end
	
	if !isfunction(callback_up) then
		callback_up = (function() end)
	else
		valid = true
	end	
	
	if !valid then
		error("no callback functions given!")
		return
	end	
	
	util.AddNetworkString( netname )
	net.Receive( netname, function( len, ply )
		local ent = net.ReadEntity()
		local down = net.ReadBool() or false
		
		if !IsValid(ent) then return end
		if !IsValid(ply) then return end
		if !ply:InVehicle() then return end

		local veh = ply:GetVehicle()
		if(ent != veh) then return end
		
		local setting = self.KeySettings[name]
		if !setting then return end
		
		self.KeyBuffer = self.KeyBuffer or {}
		self.KeyBuffer[veh] = self.KeyBuffer[veh] or {}
	
		local changedbuffer = self.KeyBuffer[veh][name] or {}
		local times  = changedbuffer.times or {}
		
		local mintime = setting.time or 0
		if mintime > 0 then
			local lasttime = times[down] or 0
			local deltatime = CurTime() - lasttime
		
			if deltatime <= mintime then return end
		end
		
		if changedbuffer.state == down then return end
		
		times[down] = CurTime()	
		changedbuffer.times = times
		changedbuffer.state = down
		
		self.KeyBuffer[veh][name] = changedbuffer
		
		self.PressedKeyMap = self.PressedKeyMap or {}
		self.PressedKeyMap[veh] = self.PressedKeyMap[veh] or {}
		self.PressedKeyMap[veh][ply] = self.PressedKeyMap[veh][ply] or {}
		self.PressedKeyMap[veh][ply][name] = {
			callback_hold = callback_hold,
			callback_up = callback_up,
			callback_down = callback_down,
			state = down,
		}

		if down then
			callback_down(self, ply, veh, down)
			return
		end
		
		callback_up(self, ply, veh, down)
	end)
end

function SW_ADDON:RegisterKeySettings(name, default, time, description, extra_text)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	name = name or ""
	description = description or ""
	help = help or ""
	default = default or 0
	time = time or 0.1
	
	if (name == "") then return end
	if (description == "") then return end
	if (default == 0) then return end

	local setting = {}
	setting.description = description
	setting.cvcmd = "cl_"..self.NetworkaddonID.."_key_"..name
	setting.default = default
	setting.time = time

	if (extra_text != "") then
		setting.extra_text = extra_text
	end

	if CLIENT then
		setting.cv = CreateClientConVar( setting.cvcmd, tostring( default ), true, false )
	end

	self.KeySettings = self.KeySettings or {}
	self.KeySettings[name] = setting
end

if CLIENT then

function SW_ADDON:SendVehicleOrder(vehicle, name, down)
	if !IsValid(vehicle) then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end
	
	name = name or ""
	down = down or false

	if name == "" then return end
	
	self.KeyBuffer = self.KeyBuffer or {}
	self.KeyBuffer[vehicle] = self.KeyBuffer[vehicle] or {}
	
	local changedbuffer = self.KeyBuffer[vehicle][name] or {}

	if changedbuffer.state == down then return end
	changedbuffer.state = down
	
	self.KeyBuffer[vehicle][name] = changedbuffer

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	net.Start(netname) 
		net.WriteEntity(vehicle)
		net.WriteBool(down)
	net.SendToServer()
end


local function AddGap(panel)
	local pnl = panel:AddControl("Label", {
		Text = ""
	})
	
	return pnl
end

function SW_ADDON:VehicleOrderMenu()
	spawnmenu.AddToolMenuOption(
		"Utilities", "SW Vehicle KEY's",
		self.NetworkaddonID.."_Key_Settings",
		self.NiceName, "", "",
		function(panel, ...)
			for k,v in pairs(self.KeySettings or {}) do
				if (!v.cv) then continue end

				panel:AddControl( "Numpad", { 
					Label = v.description, 
					Command = v.cvcmd
				})
				
				if (v.extra_text) then
					panel:AddControl("Label", {
						Text = v.extra_text
					})
				end
				
				AddGap(panel)
			end
		end
	)
end

end

function SW_ADDON:SoundEdit(sound, state, pitch, pitchtime, volume, volumetime)

	sound = sound or nil
	if !sound then return end
	
	state = state or 0
	pitch = pitch or 100
	pitchtime = pitchtime or 0
	volume = volume or 1
	volumetime = volumetime or 0
	
	if state == 0 then
		sound:Stop()
	end
	if state == 1 then
		sound:Play()
	end
	if state == 2 then
		sound:ChangePitch(pitch, pitchtime)
	end
	if state == 3 then
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 4 then
		sound:Play()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 5 then
		sound:Stop()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
end

function SW_ADDON:GetBoneArray( ent )
	if !IsValid(ent) then return end
	
	local EntArray = {}
	local BoneArray = {}
	local BoneAngArray = {}
	local BonePosArray = {}
	
	for i = 1, 128 do		
		local Bone = ent:GetBoneName( i )
		if !Bone or Bone == "" or Bone == "__INVALIDBONE__" then continue end
		
		BoneArray[i] = Bone
		BoneAngArray[i] = ent:GetManipulateBoneAngles( i )
		BonePosArray[i] = ent:GetManipulateBonePosition( i )
	end
	
	EntArray = {
		Bones = BoneArray,
		Angles = BoneAngArray,
		Positions = BonePosArray,
	}
	
	ent.__SW_EntArray_Bone_Ang_Pos = EntArray
	
end

function SW_ADDON:CheckBoneArray( ent )
	if !IsValid(ent) then return false end
	
	local tb0 = ent.__SW_EntArray_Bone_Ang_Pos
	if !istable(tb0) then return false end
	
	local Check = table.GetKeys(tb0)
	local Num0 = table.Count(tb0)
	if !istable( Check ) then return false end
	if !Num0 == 3 then return false end
	
	local tb1 = tb0.Bones
	local tb2 = tb0.Angles
	local tb3 = tb0.Positions
	
	if !istable(tb1) or !istable(tb2) or !istable(tb3) then return false end
	
	local Num1 = table.Count( tb1 )
	local Num2 = table.Count( tb2 )
	local Num3 = table.Count( tb3 )
	
	if Num1 != Num2 then return false end
	if Num2 != Num3 then return false end
	if Num3 != Num1 then return false end
	
	return true
	
end

function SW_ADDON:BoneEdit( ent, name, ang, vec )
	if !IsValid(ent) then return end
	
	local Check = self:CheckBoneArray(ent)
	if !Check then return end
	
	local TB = ent.__SW_EntArray_Bone_Ang_Pos
	
	name = name or nil
	local Bone = ent:LookupBone(name)
	if !Bone then return end
	vec = vec or TB.Positions[Bone] or Vector()
	ang = ang or TB.Angles[Bone] or Angle()
	
	ent:ManipulateBonePosition( Bone, vec ) 
	ent:ManipulateBoneAngles( Bone, ang )

end

function SW_ADDON:CamControl(ply, ent)

	if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	
	if ply:GetViewEntity() == ent then
		ply:SetViewEntity(ply)
		ply.__SW_Cam_Mode = false
		return
	end
	ply:SetViewEntity(ent)
	ply.__SW_Cam_Mode = true
end

function SW_ADDON:ViewEnt( ply )
	if !IsValid(ply) then return end
	
	local Old_Cam = ply:GetViewEntity()
	ply.__SW_Old_Cam = Old_Cam
	local Cam = ply.__SW_Old_Cam
	
	if !IsValid(Cam) then return end
	if !ply.__SW_Cam_Mode then return end
	
	ply:SetViewEntity(ply)
	ply.__SW_Cam_Mode = false
end

function SW_ADDON:ChangeMat( ent, num, mat )
	if !IsValid(ent) then return end
	num = num or 0
	mat = mat or ""
	
	ent:SetSubMaterial( num, mat )
end

function SW_ADDON:RemoveUTimerOnEnt(ent, name)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end

	name = tostring(name or "")
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	timer.Remove(uname)
end

function SW_ADDON:CreateUTimerOnEnt(ent, name, time, func, repeats)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end
	
	name = tostring(name or "")
	time = time or 0
	repeats = repeats or 0
	
	if repeats <= 0 then
		repeats = 1
	end
	
	if time < 0 then
		time = 0
	end
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	
	timer.Remove(uname)
	timer.Create(uname, time, repeats, function()
	
		if !IsValid(ent) then
			timer.Remove( uname )
			return
		end
	
		func(ent)
	end)
end

local function GetCameraEnt( ply )
	if !IsValid(ply) and CLIENT then
		ply = LocalPlayer()
	end

	if !IsValid(ply) then return nil end
	local camera = ply:GetViewEntity()
	if !IsValid(camera) then return ply end

	return camera
end

function SW_ADDON:DoTrace( ply, maxdist, filter )
	local camera = GetCameraEnt(ply)
	local start_pos, end_pos
	if !IsValid(ply) then return nil end
	if !IsValid(camera) then return nil end
	
	maxdist = maxdist or 500

	if camera:IsPlayer() then
		start_pos = camera:EyePos()
		end_pos = start_pos + camera:GetAimVector() * maxdist
	else
		start_pos = camera:GetPos()
		end_pos = start_pos + ply:GetAimVector() * maxdist
	end
	
	local trace = {}
	trace.start = start_pos
	trace.endpos = end_pos

	trace.filter = function( ent, ... )
		if !IsValid(ent) then return false end
		if !IsValid(ply) then return false end
		if !IsValid(camera) then return false end
		if ent == ply then return false end
		if ent == camera then return false end
		
		if ply.GetVehicle and ent == ply:GetVehicle() then return false end
		if camera.GetVehicle and ent == camera:GetVehicle() then return false end

		if filter then
			if isfunction(filter) then
				if !filter(ent, ply, camera, ...) then
					return false
				end
			end
			
			if istable(filter) then
				if filter[ent] then
					return false
				end
			end
			
			if filter == ent then
				return false
			end
		end
		
		return true
	end
	return util.TraceLine(trace)
end

function SW_ADDON:PressButton( ply, playervehicle )
	if !IsValid(ply) then return end

	local tr = self:DoTrace(ply, 100)
	if !tr then return end
	
	local Button = tr.Entity
	if !IsValid(Button) then return end
		
	local superparent = self:GetSuperParent(Button)

	if !IsValid(superparent) then
		superparent = Button
		playervehicle = nil
	else
		if Button.__SW_Invehicle and !IsValid(playervehicle) then return end
	end

	if IsValid(playervehicle) and superparent != playervehicle then return end

	if !Button.__SW_Buttonfunc then return end

	if !superparent.__SW_AddonID or ( superparent.__SW_AddonID == "" ) then
		error("superparent.__SW_AddonID missing!")
		return
	end
	
	if superparent.__SW_AddonID != self.NetworkaddonID then return end

	local allowuse = true
	
	if superparent.CPPICanUse then
		allowuse = superparent:CPPICanUse(ply) or false
	end
	
	if !allowuse then return end
	
	return Button.__SW_Buttonfunc(Button, superparent, ply)
end

local matcache = {}
function SW_ADDON:SW_HUD_Texture(PNGname, RGB, TexX, TexY, W, H)
	local texturedata = matcache[PNGname]

	if texturedata then
		texturedata.color = RGB
		texturedata.x = TexX
		texturedata.y = TexY
		texturedata.w = W
		texturedata.h = H
   
		return texturedata
	end

	matcache[PNGname] = { Textur = Material(PNGname), color=RGB, x=TexX, y=TexY, w=W, h=H }
	return matcache[PNGname]
end

function SW_ADDON:DrawMaterial(texturedata)
	surface.SetMaterial(texturedata.Textur)
	surface.DrawTexturedRect(texturedata.x, texturedata.y, texturedata.w, texturedata.h)
end

function SW_ADDON:GetConnectedVehicles(vehicle)
	vehicle = self:GetSuperParent(vehicle)
	if !IsValid(vehicle) then return end

	vehicle.__SW_Connected = vehicle.__SW_Connected or {}
	return vehicle.__SW_Connected
end

function SW_ADDON:GetTrailerVehicles(vehicle)
	if !IsValid(vehicle) then return end

	local unique = {}
	local connected = {}

	local function recusive_func(f_ent)
		local vehicles = self:GetConnectedVehicles(f_ent)
		if !vehicles then return end

		for k, v in pairs(vehicles) do
			if !IsValid(v) then continue end
			if unique[v] then continue end
			
			unique[v] = true
			connected[#connected + 1] = v
			recusive_func(v)
		end
		
		if unique[f_ent] then return end
		
		unique[f_ent] = true
		connected[#connected + 1] = f_ent
	end
	
	recusive_func(vehicle)
	
	return connected
end

function SW_ADDON:ForEachTrailerVehicles(vehicle, func)
	if !IsValid(vehicle) then return end
	if !isfunction(func) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	for k, v in ipairs(vehicles) do
		if !IsValid(vehicle) then continue end
		if func(k, v) == false then break end
	end
end

function SW_ADDON:GetTrailerMainVehicles(vehicle)
	if !IsValid(vehicle) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	local mainvehicles = {}
	for k, v in pairs(vehicles) do
		if !IsValid(v) then continue end
		if !v.__IsSW_TrailerMain then continue end
		mainvehicles[#mainvehicles + 1] = v
	end
	
	return mainvehicles
end

function SW_ADDON:TrailerHasMainVehicles(vehicle)
	local mainvehicles = self:GetTrailerMainVehicles(vehicle)
	
	if !mainvehicles then return false end
	if !IsValid(mainvehicles[1]) then return false end
	
	return true
end

function SW_ADDON:ValidateName(name)
	name = tostring(name or "")
	name = string.gsub(name, "^!", "", 1)
	name = string.gsub(name, "[\\/]", "")
	return name
end

function SW_ADDON:GetVal(ent, name, default)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name

	local data = vars.Data or {}
	local value = data[name]
	
	if value == nil then
		value = default 
	end
	
	return value
end

function SW_ADDON:SetVal(ent, name, value)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name
	
	vars.Data = vars.Data or {}
	vars.Data[name] = value
end

function SW_ADDON:SetupDupeModifier(ent, name, precopycallback, postcopycallback)
    if !IsValid(ent) then return end

	name = self:ValidateName(name)
    if name == "" then return end

	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
    if vars.duperegistered then return end
	
    if !isfunction(precopycallback) then
		precopycallback = (function() end)
	end
	
	if !isfunction(postcopycallback) then
		postcopycallback = (function() end)
	end
	
	local oldprecopy = superparent.PreEntityCopy or (function() end)
	local dupename = "SW_Common_MakeEnt_Dupe_" .. self.NetworkaddonID  .. "_" .. name
	vars.dupename = dupename
	
	superparent.PreEntityCopy = function(...)
		if IsValid(superparent) then
			precopycallback(superparent)
		end
		
		vars.Data = vars.Data or {}
		duplicator.StoreEntityModifier(superparent, dupename, vars.Data)
		
		return oldprecopy(...)
	end
	vars.duperegistered = true

	self.duperegistered = self.duperegistered or {}
    if self.duperegistered[dupename] then return end
	
	duplicator.RegisterEntityModifier(dupename, function(ply, ent, data)
		if !IsValid(ent) then return end

		local superparent = self:GetSuperParent(ent) or ent
		if !IsValid(superparent) then return end

		superparent.__SW_Vars = superparent.__SW_Vars or {}
		local vars = superparent.__SW_Vars
		
		vars.Data = data or {}
		
		if IsValid(superparent) then
			postcopycallback(superparent)
		end
	end)
	
	self.duperegistered[dupename] = true
end

function SW_ADDON:AddFont(name, data)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end

	name = self.NetworkaddonID .. "_" .. name
	
	self.cachedfonts = self.cachedfonts or {}
	if self.cachedfonts[name] then return name end
	
	self.cachedfonts[name] = true

	surface.CreateFont(name, data)
	return name
end

function SW_ADDON:GetFont(name)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end
	
	name = self.NetworkaddonID .. "_" .. name
	if !self.cachedfonts[name] then return nil end
	
	return name
end

function SW_ADDON:CheckAllowUse(ent, ply)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	local allowuse = true
	
    if ent.CPPICanUse then
		allowuse = ent:CPPICanUse(ply) or false
	end
	
    return allowuse
end

function SW_ADDON:VectorToLocalToWorld( ent, vec )
	if !IsValid(ent) then return nil end
	
	vec = vec or Vector()
	vec = ent:LocalToWorld(vec)
	
	return vec
end

function SW_ADDON:DirToLocalToWorld( ent, ang, dir )
	if !IsValid(ent) then return nil end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	ang = ang or Angle()
	ang = ent:LocalToWorldAngles(ang)
		
		
	local func = ang[dir]
	if !isfunction(func) then return end

	return func(ang)
end

function SW_ADDON:GetAttachmentPosAng(ent, attachment)
	if !self:IsValidModel(ent) then return nil end
	attachment = tostring(attachment or "")

	if attachment == "" then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Num = ent:LookupAttachment(attachment) or 0
	if Num <= 0 then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Att = ent:GetAttachment(Num)
	if not Att then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local pos = Att.Pos
	local ang = Att.Ang

	return pos, ang, true
end

function SW_ADDON:SetEntAngPosViaAttachment(entA, entB, attA, attB)
	if !self:IsValidModel(entA) then return false end
	if !self:IsValidModel(entB) then return false end

	attA = tostring(attA or "")
	attB = tostring(attB or "")
	
	local PosA, AngA, HasAttA = self:GetAttachmentPosAng(entA, attA)
	local PosB, AngB, HasAttB = self:GetAttachmentPosAng(entB, attB)

	if not HasAttA and not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	if not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	local localPosA = entA:WorldToLocal(PosA)
	local localAngA = entA:WorldToLocalAngles(AngA)

	local localPosB = entB:WorldToLocal(PosB)
	local localAngB = entB:WorldToLocalAngles(AngB)

	local M = Matrix()

	M:SetAngles(localAngA)
	M:SetTranslation(localPosA)

	local M2 = Matrix()
	M2:SetAngles(localAngB)
	M2:SetTranslation(localPosB)

	M = M * M2:GetInverseTR()

	local ang = M:GetAngles()
	local pos = M:GetTranslation()

	pos = entA:LocalToWorld(pos)
	ang = entA:LocalToWorldAngles(ang)

	entB:SetAngles(ang)
	entB:SetPos(pos)

	return true
end

function SW_ADDON:RemoveEntites(tb)
	tb = tb or {}
	if !istable(tb) then return end
	
	for k,v in pairs(tb) do
		if !IsValid(v) then continue end
		v:Remove()
	end
end

function SW_ADDON:FindPropInSphere(ent, radius, attachment, filterA, filterB)
	if !IsValid(ent) then return nil end
	radius = radius or 10
	filterA = filterA or "none"
	filterB = filterB or "none"
	
	local new_ent = nil

	local pos = self:GetAttachmentPosAng(ent, attachment)
	local objs = ents.FindInSphere( pos, radius ) or {}
	
	for k,v in pairs(objs) do
		if !IsValid(v) then continue end
		local mdl = v:GetModel()
		if mdl == filterA or mdl == filterB then
			new_ent = v
			return new_ent
		end
	end
	
	return nil
end

local Color_trGreen = Color( 50, 255, 50 )
local Color_trBlue = Color( 50, 50, 255 )
local Color_trTextHit = Color( 100, 255, 100 )

function SW_ADDON:Tracer( ent, vec1, vec2, filterfunc )
	if !IsValid(ent) then return nil end
	
	vec1 = vec1 or Vector()
	vec2 = vec2 or Vector()

	if !isfunction(filterfunc) then
		filterfunc = (function()
			return true
		end)
	end
	
	local tr = util.TraceLine( {
		start = vec1,
		endpos = vec2,
		filter = function(trent, ...)
			if !IsValid(ent) then return false end
			if !IsValid(trent) then return false end
			if trent == ent then return false end
			
			local sp = self:GetSuperParent(ent)
			if !IsValid(sp) then return false end
			if trent == sp then return false end

			if self:GetSuperParent(trent) == sp then return false end
			return filterfunc(self, sp, trent, ...)
		end
	} )
	
	if !tr then return nil end
	
	vec1 = tr.StartPos
	
	debugoverlay.Cross( vec1, 1, 0.1, color_white, true ) 
	debugoverlay.Cross( vec2, 1, 0.1, color_white, true ) 
	debugoverlay.Line( vec1, tr.HitPos, 0.1, Color_trGreen, true )
	debugoverlay.Line( tr.HitPos, vec2, 0.1, Color_trBlue, true )
	debugoverlay.EntityTextAtPosition(vec1, 0, "Start", 0.1, color_white)
	
	if tr.Hit then
		debugoverlay.EntityTextAtPosition(tr.HitPos, 0, "Hit", 0.1, Color_trTextHit)
	end
	
	debugoverlay.EntityTextAtPosition(vec2, 0, "End", 0.1, color_white)
	
	return tr
end

function SW_ADDON:TracerAttachment( ent, attachment, len, dir, filterfunc )
	len = len or 0
	
	if len == 0 then
		len = 1
	end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	local pos, ang = self:GetAttachmentPosAng(ent, attachment)
	if !pos then return end
		
	local func = ang[dir]
	if !isfunction(func) then return end

	local endpos = pos + func(ang) * len

	return self:Tracer(ent, pos, endpos, filterfunc)
end

function SW_ADDON:TracerAttachmentToAttachment( ent, attachmentA, attachmentB, filterfunc )
	local posA = self:GetAttachmentPosAng(ent, attachmentA)
	if !posA then return end

	local posB = self:GetAttachmentPosAng(ent, attachmentB)
	if !posB then return end

	return self:Tracer(ent, posA, posB, filterfunc)
end

function SW_ADDON:CheckGround(ent, vec1, vec2)
	if !IsValid(ent) then return false end

	vec2 = vec2 or vec1
	vec1 = vec1 or vec2

	if !vec1 then return false end
	if !vec2 then return false end

	local vec1A = ent:LocalToWorld(Vector(vec1.x, vec1.y, vec1.z)) 
	local vec2A = ent:LocalToWorld(Vector(vec2.x, -vec2.y, vec2.z)) 

	local vec1B = ent:LocalToWorld(Vector(-vec1.x, vec1.y, vec1.z)) 
	local vec2B = ent:LocalToWorld(Vector(-vec2.x, -vec2.y, vec2.z)) 

	local tr1 = self:Tracer(ent, vec1A, vec2A)
	local tr2 = self:Tracer(ent, vec1B, vec2B)
	
	if tr1 and tr1.Hit then return true end
	if tr2 and tr2.Hit then return true end
	
	return false
end

function SW_ADDON:GetRelativeVelocity(ent)
	if !IsValid(ent) then return end

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local v = phys:GetVelocity()
	return phys:WorldToLocalVector(v)
end

function SW_ADDON:GetForwardVelocity(ent)
	local v = self:GetRelativeVelocity(ent)
	if !v then return 0 end
	
	return v.y or 0
end

function SW_ADDON:GetKPHSpeed(v)
	local UnitKmh = math.Round((v * 0.75) * 3600 * 0.0000254)
	return UnitKmh
end

function SW_ADDON:ConstraintIsAllowed(ent, ply, mode)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	mode = tostring(mode or "")
	mode = string.lower(mode)
	
	if mode == "" then
		mode = "weld"
	end
	
	local allowtool = true
	
	if ent.CPPICanTool then
		allowtool = ent:CPPICanTool(ply, mode) or false
	end
	
	if !allowtool then return false end
	return true
end

-- "addons\\slick\\lua\\sw_addons\\bluex11\\common.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/* 
Version 10.08.20

Last Change: 

Changed the functions:
SetEntAngPosViaAttachment()

Improved the function. No helper prop is needed anymore.

*/

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

function SW_ADDON:Add_Items( name, listname, model, class, skin )
	class = class or "prop_physics"
	skin = skin or 0
	
	local NormalOffset = nil
	local DropToFloor = nil
	
	if (class != "prop_ragdoll") then
		NormalOffset = 64
		DropToFloor = true
	end

	list.Set( "SpawnableEntities", name, { 
		PrintName = listname, 
		ClassName = class, 
		Category = "SligWolf's Props",
		
		NormalOffset = NormalOffset,
		DropToFloor = DropToFloor,

		KeyValues = {
			model = model,
			skin = skin,
			addonname = self.Addonname,
		}
	})
end

function SW_ADDON:AddPlayerModel(name, player_model, vhands_model, skin, bodygroup)
	player_model = player_model or ""
	vhands_model = vhands_model or ""
	name = name or player_model
	skin = skin or 0
	bodygroup = bodygroup or "00000000"

	if player_model == "" then return end
	
	player_manager.AddValidModel( name, player_model )

	if vhands_model == "" then return end
	player_manager.AddValidHands( name, vhands_model, skin, bodygroup )
end

local function NPC_Setup( ply, npc )
	if !IsValid(npc) then return end
	if npc.__IsSW_Duped then return end
	
	local kv = npc:GetKeyValues()
	local name = kv["classname"] or ""
	
	local tab = list.Get("NPC")
	local data = tab[name]
	if !data then return end
	if !data.IsSW then return end
	
	local data_custom = data.SW_Custom or {}
	
	if data_custom.Accuracy then
		npc:SetCurrentWeaponProficiency( data_custom.Accuracy )
	end
	
	if data_custom.Health then
		npc:SetHealth( data_custom.Health )
	end
	
	if data_custom.Blood then
		npc:SetBloodColor( data_custom.Blood )
	end
	
	if data_custom.Color then
		npc:SetColor( data_custom.Color )
	end
	
	if data_custom.Owner then
		npc.Owner = ply
	end
	
	local func = data_custom.OnSpawn
	if isfunction(func) then
		func(npc, data)
	end
	
	npc.__IsSW_Addon = true
	npc.__IsSW_Class = name
	
	local class = tostring(data.Class or "Corrupt Class!")
	npc:SetKeyValue( "classname", class )
	
	local dupedata = {}
	dupedata.customclass = name
	
	duplicator.StoreEntityModifier(npc, "SW_Common_NPC_Dupe", dupedata) 
end

local function NPC_Dupe(ply, npc, data)
	if !IsValid(npc) then return end
	if !data then return end
	if !data.customclass then return end

	npc:SetKeyValue( "classname", data.customclass )
	NPC_Setup(ply, npc)
	npc.__IsSW_Duped = true
end

function SW_ADDON:Add_NPC(name, npc)
	name = name or ""
	if name == "" then return end
	npc = npc or {}

	npc.Name = npc.Name or "SligWolf - Generic"
	npc.Class = npc.Class or "npc_citizen"
	npc.Category = npc.Category or "SligWolf's NPC's"
	npc.Skin = npc.Skin or 0
	npc.KeyValues = npc.KeyValues or {}
	npc.IsSW = true
	
	// Workaround to get back to custom NPC classname from the spawned NPC
	npc.KeyValues.classname = name

	npc.SW_Custom = npc.SW_Custom or {}
	list.Set( "NPC", name, npc )

	hook.Remove( "PlayerSpawnedNPC", "SW_Common_NPC_Setup")
	hook.Add( "PlayerSpawnedNPC", "SW_Common_NPC_Setup", NPC_Setup)
	duplicator.RegisterEntityModifier( "SW_Common_NPC_Dupe", NPC_Dupe)
	
	if CLIENT then
		language.Add(name, npc.Name)
	end
end

local function CantTouch( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Blockedprop then return false end
end
hook.Add( "PhysgunPickup", "SW_Common_CantTouch", CantTouch )

local function CantPickUp( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Cantpickup then return false end
end
hook.Add( "AllowPlayerPickup", "SW_Common_CantPickUp", CantPickUp )

local function CantUnfreeze( ply, ent )
    if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	if ent.__SW_NoUnfreeze then return false end
end
hook.Add( "CanPlayerUnfreeze", "SW_Common_CantUnfreeze", CantUnfreeze )

local function Tool( ply, tr, tool )
    if !IsValid(ply) then return end
	
	local ent = tr.Entity
	debugoverlay.Text( tr.HitPos, tostring(tool), 3, false ) 
	
	if ent.__SW_BlockAllTools then return false end
	
	local tb = ent.__SW_BlockTool
	
	if istable(tb) then
		if tb[tool] then
			return false
		end
	end
	
	if ent.__SW_AllowOnlyThisTool == tool then 
		return false
	end
end
hook.Add( "CanTool", "SW_Common_Tool", Tool )

local function ToolReload( ply, tr, tool )
    if !IsValid(ply) then return end

	local ent = tr.Entity
	local tb = ent.__SW_DenyToolReload
	
	if istable(tb) then
		if tb[tool] then
			if ply:KeyPressed(IN_RELOAD) then return false end
		end
	end
end
hook.Add( "CanTool", "SW_Common_ToolReload", ToolReload )

function SW_ADDON:MakeEnt(classname, ply, parent, name)
    local ent = ents.Create(classname)

    if !IsValid(ent) then return end
	ent.__SW_Vars = ent.__SW_Vars or {}
	self:SetName(ent, name)
	self:SetParent(ent, parent)
	
	if ent.__IsSW_Entity then
		ent:SetAddonID(self.Addonname)
	end

    if !ent.CPPISetOwner then return ent end
    if !IsValid(ply) then return ent end

    ent:CPPISetOwner(ply)
    return ent
end

function SW_ADDON:IsValidModel(ent)
	if !IsValid(ent) then return false end
	
	local model = tostring(ent:GetModel() or "")
	if model == "" then return false end
	
	model = Model(model)
	if !util.IsValidModel(model) then return false end
	
	return true
end

function SW_ADDON:AddToEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	
	if IsValid(ent) then
		self.ents[name][ent] = true
	else
		self.ents[name][ent] = nil
	end
end

function SW_ADDON:RemoveFromEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	self.ents[name][ent] = nil
end


function SW_ADDON:GetAllFromEntList(name)
	name = tostring(name or "")

	self.ents = self.ents or {}
	return self.ents[name] or {}
end

function SW_ADDON:ForEachInEntList(name, func)
	if !isfunction(func) then return end
	local entlist = self:GetAllFromEntList(name)
	
	local index = 1
	for k, v in pairs(entlist) do
		if !IsValid(k) then
			entlist[k] = nil
			continue
		end
		
		local bbreak = func(self, index, k)
		if bbreak == false then
			break
		end
		
		index = index + 1
	end
end

function SW_ADDON:SetupChildEntity(ent, parent, collision, attachmentid)
	if !IsValid(ent) then return end
	if !IsValid(parent) then return end
	
	collision = collision or COLLISION_GROUP_NONE
	attachmentid = attachmentid or 0
	
	ent:Spawn()
	ent:Activate()
	ent:SetParent(parent, attachmentid)
	ent:SetCollisionGroup( collision )
	ent:SetMoveType( MOVETYPE_NONE )
	ent.DoNotDuplicate = true
	parent:DeleteOnRemove( ent )
	
	self:SetParent(ent, parent)

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return ent end
	phys:Sleep()
	
	return ent
end

function SW_ADDON:GetName(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return "" end
	
	return self:ValidateName(ent.__SW_Vars.Name)
end

function SW_ADDON:SetName(ent, name)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars
	
	name = self:ValidateName(name)
	if name == "" then
		name = tostring(util.CRC(tostring(ent)))
	end
	
	local oldname = self:GetName(ent)
	vars.Name = name
	
	local parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[oldname] = nil
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars

    if !IsValid(vars.ParentENT) then return end
	if vars.ParentENT == ent then return end

	return vars.ParentENT
end

function SW_ADDON:SetParent(ent, parent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	if parent == ent then
		parent = nil
	end
	
	local vars = ent.__SW_Vars

	vars.ParentENT = parent
	vars.SuperParentENT = self:GetSuperParent(ent)

	parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	local name = self:GetName(ent)
	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetSuperParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	local vars = ent.__SW_Vars
	
	if IsValid(vars.SuperParentENT) and (vars.SuperParentENT != ent) then
		return vars.SuperParentENT
	end
	
	if !IsValid(vars.ParentENT) then
		return ent
	end
	
	vars.SuperParentENT = self:GetSuperParent(vars.ParentENT)
	if vars.SuperParentENT == ent then return end
    if !IsValid(vars.SuperParentENT) then return end
	
	return vars.SuperParentENT
end

function SW_ADDON:GetEntityPath(ent)
	if !IsValid(ent) then return end
	
	local name = self:GetName(ent)
	local parent = self:GetParent(ent)
	
	if !IsValid(parent) then
		return name
	end
	
	local parent_name = self:GetName(parent)
	name = parent_name .. "/" .. name
	
	return name
end

function SW_ADDON:GetChildren(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	return ent.__SW_Vars.ChildrenENTs or {}
end

function SW_ADDON:GetChild(ent, name)
	local children = self:GetChildren(ent)
	if !children then return end
	
	local child = children[name]
	if !IsValid(child) then return end
	
	if self:GetParent(child) != ent then
		children[name] = nil
		return
	end

	return child
end

function SW_ADDON:GetChildFromPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	
	local curchild = ent
	for k, v in pairs(hirachy) do
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return end
	end
	
	return curchild
end

function SW_ADDON:FindChildAtPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	local lastindex = #hirachy
	
	local curchild = ent
	for k, v in ipairs(hirachy) do
		if(k >= lastindex) then
			return self:FindChildren(curchild, v)
		end
		
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return {} end
	end
	
	return {}
end

function SW_ADDON:ForEachFilteredChild(ent, name, func)
	if !IsValid(ent) then return end
	if !isfunction(func) then return end
	
	local found = self:FindChildAtPath(ent, name)
	local index = 0
	
	for k, v in pairs(found) do
		index = index + 1
		local bbreak = func(ent, index, k, v)
		if bbreak then break end
	end
end

function SW_ADDON:FindChildren(ent, name)
	local children = self:GetChildren(ent)
	if !children then return {} end
	
	name = tostring(name or "")
	
	local found = {}
	for k, v in pairs(children) do
		if !IsValid(v) then continue end
		if !string.find(k, name) then continue end
		found[k] = v
	end
	
	return found
end

function SW_ADDON:ChangePoseParameter( ent, val, name, divide )
	if !IsValid(ent) then return end
	val = val or 0
	name = name or ""
	divide = divide or 1
	
	ent:SetPoseParameter( name, val/divide ) 
end

function SW_ADDON:Exit_Seat( ent, ply, pvf, pvr, pvu, evf, evr, evu )

	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end

	local Filter = function( addon, veh, f_ent )
		if !IsValid(f_ent) then return false end
		if !IsValid(ply) then return false end
		if f_ent == veh then return false end
		if f_ent == ply then return false end
		if f_ent:GetModel() == "models/sligwolf/unique_props/seat.mdl" then return false end

		return true
	end	

	local lpos = ent:GetPos()
	local lang = ent:GetAngles()
	local fwd = lang:Forward()
	local rgt = lang:Right()
	local up = lang:Up()
	local pos = lpos - fwd*pvf - rgt*pvr - up*pvu
	
	pvf = pvf or 0
	pvr = pvr or 0
	pvu = pvu or 0
	evf = evf or 0
	evr = evr or 0
	evu = evu or 0

	local tb = {
		V1 = { VecA = Vector(0,0,0), VecB = Vector(0,0,70) },
		V2 = { VecA = Vector(15,0,0), VecB = Vector(15,0,70) },
		V3 = { VecA = Vector(0,15,0), VecB = Vector(0,15,70) },
		V4 = { VecA = Vector(-15,0,0), VecB = Vector(-15,0,70) },
		V5 = { VecA = Vector(0,-15,0), VecB = Vector(0,-15,70) },
		V6 = { VecA = Vector(15,15,0), VecB = Vector(15,15,70) },
		V7 = { VecA = Vector(-15,15,0), VecB = Vector(-15,15,70) },
		V8 = { VecA = Vector(-15,-15,0), VecB = Vector(-15,-15,70) },
		V9 = { VecA = Vector(15,-15,0), VecB = Vector(15,-15,70) },
	}
	
	for k,v in pairs(tb) do
		local tr = self:Tracer( ent, pos+v.VecA, pos+v.VecB, Filter )
		if tr.Hit then return true end
	end
	
	ply:SetPos(pos)
	ply:SetEyeAngles((lpos-(lpos - fwd*evf - rgt*evr + up*evu)):Angle())
	return false
end

function SW_ADDON:Indicator_Sound(ent, bool_R, bool_L, pitchon, pitchoff, vol, sound)
	if !IsValid(ent) then return end
	
	local Check = bool_R or bool_L or nil
	if !Check then return end
	vol = vol or 50
	pitchon = pitchon or 100
	pitchoff = pitchoff or 75
	sound = sound or "vehicles/sligwolf/generic/indicator_on.wav"
	
	if !ent.__SW_Indicator_OnOff then
		ent:EmitSound(sound, vol, pitchon)
		ent.__SW_Indicator_OnOff = true
		return
	else
		ent:EmitSound(sound, vol, pitchoff)
		ent.__SW_Indicator_OnOff = false
		return
	end
end

function SW_ADDON:VehicleOrderThink()
	if CLIENT then
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		local vehicle = ply:GetVehicle()
		if !IsValid(vehicle) then return end
		
		if gui.IsGameUIVisible() then return end
		if gui.IsConsoleVisible() then return end
		if IsValid(vgui.GetKeyboardFocus()) then return end
		if ply:IsTyping() then return end
		
		for k,v in pairs(self.KeySettings or {}) do
			if (!v.cv) then continue end
			
			local isdown = input.IsKeyDown( v.cv:GetInt() )
			self:SendVehicleOrder(vehicle, k, isdown)
		end
		
		return
	end

	for vehicle, players in pairs(self.PressedKeyMap or {}) do
		if !IsValid(vehicle) then continue end
		
		for ply, keys in pairs(players or {}) do
			if !IsValid(ply) then continue end
			
			for name, callback_data in pairs(keys or {}) do
				if !callback_data.state then continue end
				
				local callback_hold = callback_data.callback_hold
				callback_hold(self, ply, vehicle, true)
			end
		end
	end
end

function SW_ADDON:VehicleOrderLeave(ply, vehicle)
	if CLIENT then return end
	
	local holdedkeys = self.PressedKeyMap or {}
	holdedkeys = holdedkeys[vehicle] or {}
	holdedkeys = holdedkeys[ply] or {}

	for name, callback_data in pairs(holdedkeys) do
		if !callback_data.state then continue end
	
		local callback_hold = callback_data.callback_hold
		local callback_up = callback_data.callback_up
		
		callback_hold(self, ply, vehicle, false)
		callback_up(self, ply, vehicle, false)
		
		callback_data.state = false
	end
end

function SW_ADDON:RegisterVehicleOrder(name, callback_hold, callback_down, callback_up)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	if CLIENT then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end

	name = name or ""
	if name == "" then return end

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	
	local valid = false
	if !isfunction(callback_hold) then
		callback_hold = (function() end)
	else
		valid = true
	end
		
	if !isfunction(callback_down) then
		callback_down = (function() end)
	else
		valid = true
	end
	
	if !isfunction(callback_up) then
		callback_up = (function() end)
	else
		valid = true
	end	
	
	if !valid then
		error("no callback functions given!")
		return
	end	
	
	util.AddNetworkString( netname )
	net.Receive( netname, function( len, ply )
		local ent = net.ReadEntity()
		local down = net.ReadBool() or false
		
		if !IsValid(ent) then return end
		if !IsValid(ply) then return end
		if !ply:InVehicle() then return end

		local veh = ply:GetVehicle()
		if(ent != veh) then return end
		
		local setting = self.KeySettings[name]
		if !setting then return end
		
		self.KeyBuffer = self.KeyBuffer or {}
		self.KeyBuffer[veh] = self.KeyBuffer[veh] or {}
	
		local changedbuffer = self.KeyBuffer[veh][name] or {}
		local times  = changedbuffer.times or {}
		
		local mintime = setting.time or 0
		if mintime > 0 then
			local lasttime = times[down] or 0
			local deltatime = CurTime() - lasttime
		
			if deltatime <= mintime then return end
		end
		
		if changedbuffer.state == down then return end
		
		times[down] = CurTime()	
		changedbuffer.times = times
		changedbuffer.state = down
		
		self.KeyBuffer[veh][name] = changedbuffer
		
		self.PressedKeyMap = self.PressedKeyMap or {}
		self.PressedKeyMap[veh] = self.PressedKeyMap[veh] or {}
		self.PressedKeyMap[veh][ply] = self.PressedKeyMap[veh][ply] or {}
		self.PressedKeyMap[veh][ply][name] = {
			callback_hold = callback_hold,
			callback_up = callback_up,
			callback_down = callback_down,
			state = down,
		}

		if down then
			callback_down(self, ply, veh, down)
			return
		end
		
		callback_up(self, ply, veh, down)
	end)
end

function SW_ADDON:RegisterKeySettings(name, default, time, description, extra_text)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	name = name or ""
	description = description or ""
	help = help or ""
	default = default or 0
	time = time or 0.1
	
	if (name == "") then return end
	if (description == "") then return end
	if (default == 0) then return end

	local setting = {}
	setting.description = description
	setting.cvcmd = "cl_"..self.NetworkaddonID.."_key_"..name
	setting.default = default
	setting.time = time

	if (extra_text != "") then
		setting.extra_text = extra_text
	end

	if CLIENT then
		setting.cv = CreateClientConVar( setting.cvcmd, tostring( default ), true, false )
	end

	self.KeySettings = self.KeySettings or {}
	self.KeySettings[name] = setting
end

if CLIENT then

function SW_ADDON:SendVehicleOrder(vehicle, name, down)
	if !IsValid(vehicle) then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end
	
	name = name or ""
	down = down or false

	if name == "" then return end
	
	self.KeyBuffer = self.KeyBuffer or {}
	self.KeyBuffer[vehicle] = self.KeyBuffer[vehicle] or {}
	
	local changedbuffer = self.KeyBuffer[vehicle][name] or {}

	if changedbuffer.state == down then return end
	changedbuffer.state = down
	
	self.KeyBuffer[vehicle][name] = changedbuffer

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	net.Start(netname) 
		net.WriteEntity(vehicle)
		net.WriteBool(down)
	net.SendToServer()
end


local function AddGap(panel)
	local pnl = panel:AddControl("Label", {
		Text = ""
	})
	
	return pnl
end

function SW_ADDON:VehicleOrderMenu()
	spawnmenu.AddToolMenuOption(
		"Utilities", "SW Vehicle KEY's",
		self.NetworkaddonID.."_Key_Settings",
		self.NiceName, "", "",
		function(panel, ...)
			for k,v in pairs(self.KeySettings or {}) do
				if (!v.cv) then continue end

				panel:AddControl( "Numpad", { 
					Label = v.description, 
					Command = v.cvcmd
				})
				
				if (v.extra_text) then
					panel:AddControl("Label", {
						Text = v.extra_text
					})
				end
				
				AddGap(panel)
			end
		end
	)
end

end

function SW_ADDON:SoundEdit(sound, state, pitch, pitchtime, volume, volumetime)

	sound = sound or nil
	if !sound then return end
	
	state = state or 0
	pitch = pitch or 100
	pitchtime = pitchtime or 0
	volume = volume or 1
	volumetime = volumetime or 0
	
	if state == 0 then
		sound:Stop()
	end
	if state == 1 then
		sound:Play()
	end
	if state == 2 then
		sound:ChangePitch(pitch, pitchtime)
	end
	if state == 3 then
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 4 then
		sound:Play()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 5 then
		sound:Stop()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
end

function SW_ADDON:GetBoneArray( ent )
	if !IsValid(ent) then return end
	
	local EntArray = {}
	local BoneArray = {}
	local BoneAngArray = {}
	local BonePosArray = {}
	
	for i = 1, 128 do		
		local Bone = ent:GetBoneName( i )
		if !Bone or Bone == "" or Bone == "__INVALIDBONE__" then continue end
		
		BoneArray[i] = Bone
		BoneAngArray[i] = ent:GetManipulateBoneAngles( i )
		BonePosArray[i] = ent:GetManipulateBonePosition( i )
	end
	
	EntArray = {
		Bones = BoneArray,
		Angles = BoneAngArray,
		Positions = BonePosArray,
	}
	
	ent.__SW_EntArray_Bone_Ang_Pos = EntArray
	
end

function SW_ADDON:CheckBoneArray( ent )
	if !IsValid(ent) then return false end
	
	local tb0 = ent.__SW_EntArray_Bone_Ang_Pos
	if !istable(tb0) then return false end
	
	local Check = table.GetKeys(tb0)
	local Num0 = table.Count(tb0)
	if !istable( Check ) then return false end
	if !Num0 == 3 then return false end
	
	local tb1 = tb0.Bones
	local tb2 = tb0.Angles
	local tb3 = tb0.Positions
	
	if !istable(tb1) or !istable(tb2) or !istable(tb3) then return false end
	
	local Num1 = table.Count( tb1 )
	local Num2 = table.Count( tb2 )
	local Num3 = table.Count( tb3 )
	
	if Num1 != Num2 then return false end
	if Num2 != Num3 then return false end
	if Num3 != Num1 then return false end
	
	return true
	
end

function SW_ADDON:BoneEdit( ent, name, ang, vec )
	if !IsValid(ent) then return end
	
	local Check = self:CheckBoneArray(ent)
	if !Check then return end
	
	local TB = ent.__SW_EntArray_Bone_Ang_Pos
	
	name = name or nil
	local Bone = ent:LookupBone(name)
	if !Bone then return end
	vec = vec or TB.Positions[Bone] or Vector()
	ang = ang or TB.Angles[Bone] or Angle()
	
	ent:ManipulateBonePosition( Bone, vec ) 
	ent:ManipulateBoneAngles( Bone, ang )

end

function SW_ADDON:CamControl(ply, ent)

	if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	
	if ply:GetViewEntity() == ent then
		ply:SetViewEntity(ply)
		ply.__SW_Cam_Mode = false
		return
	end
	ply:SetViewEntity(ent)
	ply.__SW_Cam_Mode = true
end

function SW_ADDON:ViewEnt( ply )
	if !IsValid(ply) then return end
	
	local Old_Cam = ply:GetViewEntity()
	ply.__SW_Old_Cam = Old_Cam
	local Cam = ply.__SW_Old_Cam
	
	if !IsValid(Cam) then return end
	if !ply.__SW_Cam_Mode then return end
	
	ply:SetViewEntity(ply)
	ply.__SW_Cam_Mode = false
end

function SW_ADDON:ChangeMat( ent, num, mat )
	if !IsValid(ent) then return end
	num = num or 0
	mat = mat or ""
	
	ent:SetSubMaterial( num, mat )
end

function SW_ADDON:RemoveUTimerOnEnt(ent, name)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end

	name = tostring(name or "")
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	timer.Remove(uname)
end

function SW_ADDON:CreateUTimerOnEnt(ent, name, time, func, repeats)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end
	
	name = tostring(name or "")
	time = time or 0
	repeats = repeats or 0
	
	if repeats <= 0 then
		repeats = 1
	end
	
	if time < 0 then
		time = 0
	end
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	
	timer.Remove(uname)
	timer.Create(uname, time, repeats, function()
	
		if !IsValid(ent) then
			timer.Remove( uname )
			return
		end
	
		func(ent)
	end)
end

local function GetCameraEnt( ply )
	if !IsValid(ply) and CLIENT then
		ply = LocalPlayer()
	end

	if !IsValid(ply) then return nil end
	local camera = ply:GetViewEntity()
	if !IsValid(camera) then return ply end

	return camera
end

function SW_ADDON:DoTrace( ply, maxdist, filter )
	local camera = GetCameraEnt(ply)
	local start_pos, end_pos
	if !IsValid(ply) then return nil end
	if !IsValid(camera) then return nil end
	
	maxdist = maxdist or 500

	if camera:IsPlayer() then
		start_pos = camera:EyePos()
		end_pos = start_pos + camera:GetAimVector() * maxdist
	else
		start_pos = camera:GetPos()
		end_pos = start_pos + ply:GetAimVector() * maxdist
	end
	
	local trace = {}
	trace.start = start_pos
	trace.endpos = end_pos

	trace.filter = function( ent, ... )
		if !IsValid(ent) then return false end
		if !IsValid(ply) then return false end
		if !IsValid(camera) then return false end
		if ent == ply then return false end
		if ent == camera then return false end
		
		if ply.GetVehicle and ent == ply:GetVehicle() then return false end
		if camera.GetVehicle and ent == camera:GetVehicle() then return false end

		if filter then
			if isfunction(filter) then
				if !filter(ent, ply, camera, ...) then
					return false
				end
			end
			
			if istable(filter) then
				if filter[ent] then
					return false
				end
			end
			
			if filter == ent then
				return false
			end
		end
		
		return true
	end
	return util.TraceLine(trace)
end

function SW_ADDON:PressButton( ply, playervehicle )
	if !IsValid(ply) then return end

	local tr = self:DoTrace(ply, 100)
	if !tr then return end
	
	local Button = tr.Entity
	if !IsValid(Button) then return end
		
	local superparent = self:GetSuperParent(Button)

	if !IsValid(superparent) then
		superparent = Button
		playervehicle = nil
	else
		if Button.__SW_Invehicle and !IsValid(playervehicle) then return end
	end

	if IsValid(playervehicle) and superparent != playervehicle then return end

	if !Button.__SW_Buttonfunc then return end

	if !superparent.__SW_AddonID or ( superparent.__SW_AddonID == "" ) then
		error("superparent.__SW_AddonID missing!")
		return
	end
	
	if superparent.__SW_AddonID != self.NetworkaddonID then return end

	local allowuse = true
	
	if superparent.CPPICanUse then
		allowuse = superparent:CPPICanUse(ply) or false
	end
	
	if !allowuse then return end
	
	return Button.__SW_Buttonfunc(Button, superparent, ply)
end

local matcache = {}
function SW_ADDON:SW_HUD_Texture(PNGname, RGB, TexX, TexY, W, H)
	local texturedata = matcache[PNGname]

	if texturedata then
		texturedata.color = RGB
		texturedata.x = TexX
		texturedata.y = TexY
		texturedata.w = W
		texturedata.h = H
   
		return texturedata
	end

	matcache[PNGname] = { Textur = Material(PNGname), color=RGB, x=TexX, y=TexY, w=W, h=H }
	return matcache[PNGname]
end

function SW_ADDON:DrawMaterial(texturedata)
	surface.SetMaterial(texturedata.Textur)
	surface.DrawTexturedRect(texturedata.x, texturedata.y, texturedata.w, texturedata.h)
end

function SW_ADDON:GetConnectedVehicles(vehicle)
	vehicle = self:GetSuperParent(vehicle)
	if !IsValid(vehicle) then return end

	vehicle.__SW_Connected = vehicle.__SW_Connected or {}
	return vehicle.__SW_Connected
end

function SW_ADDON:GetTrailerVehicles(vehicle)
	if !IsValid(vehicle) then return end

	local unique = {}
	local connected = {}

	local function recusive_func(f_ent)
		local vehicles = self:GetConnectedVehicles(f_ent)
		if !vehicles then return end

		for k, v in pairs(vehicles) do
			if !IsValid(v) then continue end
			if unique[v] then continue end
			
			unique[v] = true
			connected[#connected + 1] = v
			recusive_func(v)
		end
		
		if unique[f_ent] then return end
		
		unique[f_ent] = true
		connected[#connected + 1] = f_ent
	end
	
	recusive_func(vehicle)
	
	return connected
end

function SW_ADDON:ForEachTrailerVehicles(vehicle, func)
	if !IsValid(vehicle) then return end
	if !isfunction(func) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	for k, v in ipairs(vehicles) do
		if !IsValid(vehicle) then continue end
		if func(k, v) == false then break end
	end
end

function SW_ADDON:GetTrailerMainVehicles(vehicle)
	if !IsValid(vehicle) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	local mainvehicles = {}
	for k, v in pairs(vehicles) do
		if !IsValid(v) then continue end
		if !v.__IsSW_TrailerMain then continue end
		mainvehicles[#mainvehicles + 1] = v
	end
	
	return mainvehicles
end

function SW_ADDON:TrailerHasMainVehicles(vehicle)
	local mainvehicles = self:GetTrailerMainVehicles(vehicle)
	
	if !mainvehicles then return false end
	if !IsValid(mainvehicles[1]) then return false end
	
	return true
end

function SW_ADDON:ValidateName(name)
	name = tostring(name or "")
	name = string.gsub(name, "^!", "", 1)
	name = string.gsub(name, "[\\/]", "")
	return name
end

function SW_ADDON:GetVal(ent, name, default)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name

	local data = vars.Data or {}
	local value = data[name]
	
	if value == nil then
		value = default 
	end
	
	return value
end

function SW_ADDON:SetVal(ent, name, value)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name
	
	vars.Data = vars.Data or {}
	vars.Data[name] = value
end

function SW_ADDON:SetupDupeModifier(ent, name, precopycallback, postcopycallback)
    if !IsValid(ent) then return end

	name = self:ValidateName(name)
    if name == "" then return end

	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
    if vars.duperegistered then return end
	
    if !isfunction(precopycallback) then
		precopycallback = (function() end)
	end
	
	if !isfunction(postcopycallback) then
		postcopycallback = (function() end)
	end
	
	local oldprecopy = superparent.PreEntityCopy or (function() end)
	local dupename = "SW_Common_MakeEnt_Dupe_" .. self.NetworkaddonID  .. "_" .. name
	vars.dupename = dupename
	
	superparent.PreEntityCopy = function(...)
		if IsValid(superparent) then
			precopycallback(superparent)
		end
		
		vars.Data = vars.Data or {}
		duplicator.StoreEntityModifier(superparent, dupename, vars.Data)
		
		return oldprecopy(...)
	end
	vars.duperegistered = true

	self.duperegistered = self.duperegistered or {}
    if self.duperegistered[dupename] then return end
	
	duplicator.RegisterEntityModifier(dupename, function(ply, ent, data)
		if !IsValid(ent) then return end

		local superparent = self:GetSuperParent(ent) or ent
		if !IsValid(superparent) then return end

		superparent.__SW_Vars = superparent.__SW_Vars or {}
		local vars = superparent.__SW_Vars
		
		vars.Data = data or {}
		
		if IsValid(superparent) then
			postcopycallback(superparent)
		end
	end)
	
	self.duperegistered[dupename] = true
end

function SW_ADDON:AddFont(name, data)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end

	name = self.NetworkaddonID .. "_" .. name
	
	self.cachedfonts = self.cachedfonts or {}
	if self.cachedfonts[name] then return name end
	
	self.cachedfonts[name] = true

	surface.CreateFont(name, data)
	return name
end

function SW_ADDON:GetFont(name)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end
	
	name = self.NetworkaddonID .. "_" .. name
	if !self.cachedfonts[name] then return nil end
	
	return name
end

function SW_ADDON:CheckAllowUse(ent, ply)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	local allowuse = true
	
    if ent.CPPICanUse then
		allowuse = ent:CPPICanUse(ply) or false
	end
	
    return allowuse
end

function SW_ADDON:VectorToLocalToWorld( ent, vec )
	if !IsValid(ent) then return nil end
	
	vec = vec or Vector()
	vec = ent:LocalToWorld(vec)
	
	return vec
end

function SW_ADDON:DirToLocalToWorld( ent, ang, dir )
	if !IsValid(ent) then return nil end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	ang = ang or Angle()
	ang = ent:LocalToWorldAngles(ang)
		
		
	local func = ang[dir]
	if !isfunction(func) then return end

	return func(ang)
end

function SW_ADDON:GetAttachmentPosAng(ent, attachment)
	if !self:IsValidModel(ent) then return nil end
	attachment = tostring(attachment or "")

	if attachment == "" then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Num = ent:LookupAttachment(attachment) or 0
	if Num <= 0 then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Att = ent:GetAttachment(Num)
	if not Att then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local pos = Att.Pos
	local ang = Att.Ang

	return pos, ang, true
end

function SW_ADDON:SetEntAngPosViaAttachment(entA, entB, attA, attB)
	if !self:IsValidModel(entA) then return false end
	if !self:IsValidModel(entB) then return false end

	attA = tostring(attA or "")
	attB = tostring(attB or "")
	
	local PosA, AngA, HasAttA = self:GetAttachmentPosAng(entA, attA)
	local PosB, AngB, HasAttB = self:GetAttachmentPosAng(entB, attB)

	if not HasAttA and not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	if not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	local localPosA = entA:WorldToLocal(PosA)
	local localAngA = entA:WorldToLocalAngles(AngA)

	local localPosB = entB:WorldToLocal(PosB)
	local localAngB = entB:WorldToLocalAngles(AngB)

	local M = Matrix()

	M:SetAngles(localAngA)
	M:SetTranslation(localPosA)

	local M2 = Matrix()
	M2:SetAngles(localAngB)
	M2:SetTranslation(localPosB)

	M = M * M2:GetInverseTR()

	local ang = M:GetAngles()
	local pos = M:GetTranslation()

	pos = entA:LocalToWorld(pos)
	ang = entA:LocalToWorldAngles(ang)

	entB:SetAngles(ang)
	entB:SetPos(pos)

	return true
end

function SW_ADDON:RemoveEntites(tb)
	tb = tb or {}
	if !istable(tb) then return end
	
	for k,v in pairs(tb) do
		if !IsValid(v) then continue end
		v:Remove()
	end
end

function SW_ADDON:FindPropInSphere(ent, radius, attachment, filterA, filterB)
	if !IsValid(ent) then return nil end
	radius = radius or 10
	filterA = filterA or "none"
	filterB = filterB or "none"
	
	local new_ent = nil

	local pos = self:GetAttachmentPosAng(ent, attachment)
	local objs = ents.FindInSphere( pos, radius ) or {}
	
	for k,v in pairs(objs) do
		if !IsValid(v) then continue end
		local mdl = v:GetModel()
		if mdl == filterA or mdl == filterB then
			new_ent = v
			return new_ent
		end
	end
	
	return nil
end

local Color_trGreen = Color( 50, 255, 50 )
local Color_trBlue = Color( 50, 50, 255 )
local Color_trTextHit = Color( 100, 255, 100 )

function SW_ADDON:Tracer( ent, vec1, vec2, filterfunc )
	if !IsValid(ent) then return nil end
	
	vec1 = vec1 or Vector()
	vec2 = vec2 or Vector()

	if !isfunction(filterfunc) then
		filterfunc = (function()
			return true
		end)
	end
	
	local tr = util.TraceLine( {
		start = vec1,
		endpos = vec2,
		filter = function(trent, ...)
			if !IsValid(ent) then return false end
			if !IsValid(trent) then return false end
			if trent == ent then return false end
			
			local sp = self:GetSuperParent(ent)
			if !IsValid(sp) then return false end
			if trent == sp then return false end

			if self:GetSuperParent(trent) == sp then return false end
			return filterfunc(self, sp, trent, ...)
		end
	} )
	
	if !tr then return nil end
	
	vec1 = tr.StartPos
	
	debugoverlay.Cross( vec1, 1, 0.1, color_white, true ) 
	debugoverlay.Cross( vec2, 1, 0.1, color_white, true ) 
	debugoverlay.Line( vec1, tr.HitPos, 0.1, Color_trGreen, true )
	debugoverlay.Line( tr.HitPos, vec2, 0.1, Color_trBlue, true )
	debugoverlay.EntityTextAtPosition(vec1, 0, "Start", 0.1, color_white)
	
	if tr.Hit then
		debugoverlay.EntityTextAtPosition(tr.HitPos, 0, "Hit", 0.1, Color_trTextHit)
	end
	
	debugoverlay.EntityTextAtPosition(vec2, 0, "End", 0.1, color_white)
	
	return tr
end

function SW_ADDON:TracerAttachment( ent, attachment, len, dir, filterfunc )
	len = len or 0
	
	if len == 0 then
		len = 1
	end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	local pos, ang = self:GetAttachmentPosAng(ent, attachment)
	if !pos then return end
		
	local func = ang[dir]
	if !isfunction(func) then return end

	local endpos = pos + func(ang) * len

	return self:Tracer(ent, pos, endpos, filterfunc)
end

function SW_ADDON:TracerAttachmentToAttachment( ent, attachmentA, attachmentB, filterfunc )
	local posA = self:GetAttachmentPosAng(ent, attachmentA)
	if !posA then return end

	local posB = self:GetAttachmentPosAng(ent, attachmentB)
	if !posB then return end

	return self:Tracer(ent, posA, posB, filterfunc)
end

function SW_ADDON:CheckGround(ent, vec1, vec2)
	if !IsValid(ent) then return false end

	vec2 = vec2 or vec1
	vec1 = vec1 or vec2

	if !vec1 then return false end
	if !vec2 then return false end

	local vec1A = ent:LocalToWorld(Vector(vec1.x, vec1.y, vec1.z)) 
	local vec2A = ent:LocalToWorld(Vector(vec2.x, -vec2.y, vec2.z)) 

	local vec1B = ent:LocalToWorld(Vector(-vec1.x, vec1.y, vec1.z)) 
	local vec2B = ent:LocalToWorld(Vector(-vec2.x, -vec2.y, vec2.z)) 

	local tr1 = self:Tracer(ent, vec1A, vec2A)
	local tr2 = self:Tracer(ent, vec1B, vec2B)
	
	if tr1 and tr1.Hit then return true end
	if tr2 and tr2.Hit then return true end
	
	return false
end

function SW_ADDON:GetRelativeVelocity(ent)
	if !IsValid(ent) then return end

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local v = phys:GetVelocity()
	return phys:WorldToLocalVector(v)
end

function SW_ADDON:GetForwardVelocity(ent)
	local v = self:GetRelativeVelocity(ent)
	if !v then return 0 end
	
	return v.y or 0
end

function SW_ADDON:GetKPHSpeed(v)
	local UnitKmh = math.Round((v * 0.75) * 3600 * 0.0000254)
	return UnitKmh
end

function SW_ADDON:ConstraintIsAllowed(ent, ply, mode)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	mode = tostring(mode or "")
	mode = string.lower(mode)
	
	if mode == "" then
		mode = "weld"
	end
	
	local allowtool = true
	
	if ent.CPPICanTool then
		allowtool = ent:CPPICanTool(ply, mode) or false
	end
	
	if !allowtool then return false end
	return true
end

-- "addons\\slick\\lua\\sw_addons\\bluex11\\common.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/* 
Version 10.08.20

Last Change: 

Changed the functions:
SetEntAngPosViaAttachment()

Improved the function. No helper prop is needed anymore.

*/

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

function SW_ADDON:Add_Items( name, listname, model, class, skin )
	class = class or "prop_physics"
	skin = skin or 0
	
	local NormalOffset = nil
	local DropToFloor = nil
	
	if (class != "prop_ragdoll") then
		NormalOffset = 64
		DropToFloor = true
	end

	list.Set( "SpawnableEntities", name, { 
		PrintName = listname, 
		ClassName = class, 
		Category = "SligWolf's Props",
		
		NormalOffset = NormalOffset,
		DropToFloor = DropToFloor,

		KeyValues = {
			model = model,
			skin = skin,
			addonname = self.Addonname,
		}
	})
end

function SW_ADDON:AddPlayerModel(name, player_model, vhands_model, skin, bodygroup)
	player_model = player_model or ""
	vhands_model = vhands_model or ""
	name = name or player_model
	skin = skin or 0
	bodygroup = bodygroup or "00000000"

	if player_model == "" then return end
	
	player_manager.AddValidModel( name, player_model )

	if vhands_model == "" then return end
	player_manager.AddValidHands( name, vhands_model, skin, bodygroup )
end

local function NPC_Setup( ply, npc )
	if !IsValid(npc) then return end
	if npc.__IsSW_Duped then return end
	
	local kv = npc:GetKeyValues()
	local name = kv["classname"] or ""
	
	local tab = list.Get("NPC")
	local data = tab[name]
	if !data then return end
	if !data.IsSW then return end
	
	local data_custom = data.SW_Custom or {}
	
	if data_custom.Accuracy then
		npc:SetCurrentWeaponProficiency( data_custom.Accuracy )
	end
	
	if data_custom.Health then
		npc:SetHealth( data_custom.Health )
	end
	
	if data_custom.Blood then
		npc:SetBloodColor( data_custom.Blood )
	end
	
	if data_custom.Color then
		npc:SetColor( data_custom.Color )
	end
	
	if data_custom.Owner then
		npc.Owner = ply
	end
	
	local func = data_custom.OnSpawn
	if isfunction(func) then
		func(npc, data)
	end
	
	npc.__IsSW_Addon = true
	npc.__IsSW_Class = name
	
	local class = tostring(data.Class or "Corrupt Class!")
	npc:SetKeyValue( "classname", class )
	
	local dupedata = {}
	dupedata.customclass = name
	
	duplicator.StoreEntityModifier(npc, "SW_Common_NPC_Dupe", dupedata) 
end

local function NPC_Dupe(ply, npc, data)
	if !IsValid(npc) then return end
	if !data then return end
	if !data.customclass then return end

	npc:SetKeyValue( "classname", data.customclass )
	NPC_Setup(ply, npc)
	npc.__IsSW_Duped = true
end

function SW_ADDON:Add_NPC(name, npc)
	name = name or ""
	if name == "" then return end
	npc = npc or {}

	npc.Name = npc.Name or "SligWolf - Generic"
	npc.Class = npc.Class or "npc_citizen"
	npc.Category = npc.Category or "SligWolf's NPC's"
	npc.Skin = npc.Skin or 0
	npc.KeyValues = npc.KeyValues or {}
	npc.IsSW = true
	
	// Workaround to get back to custom NPC classname from the spawned NPC
	npc.KeyValues.classname = name

	npc.SW_Custom = npc.SW_Custom or {}
	list.Set( "NPC", name, npc )

	hook.Remove( "PlayerSpawnedNPC", "SW_Common_NPC_Setup")
	hook.Add( "PlayerSpawnedNPC", "SW_Common_NPC_Setup", NPC_Setup)
	duplicator.RegisterEntityModifier( "SW_Common_NPC_Dupe", NPC_Dupe)
	
	if CLIENT then
		language.Add(name, npc.Name)
	end
end

local function CantTouch( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Blockedprop then return false end
end
hook.Add( "PhysgunPickup", "SW_Common_CantTouch", CantTouch )

local function CantPickUp( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Cantpickup then return false end
end
hook.Add( "AllowPlayerPickup", "SW_Common_CantPickUp", CantPickUp )

local function CantUnfreeze( ply, ent )
    if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	if ent.__SW_NoUnfreeze then return false end
end
hook.Add( "CanPlayerUnfreeze", "SW_Common_CantUnfreeze", CantUnfreeze )

local function Tool( ply, tr, tool )
    if !IsValid(ply) then return end
	
	local ent = tr.Entity
	debugoverlay.Text( tr.HitPos, tostring(tool), 3, false ) 
	
	if ent.__SW_BlockAllTools then return false end
	
	local tb = ent.__SW_BlockTool
	
	if istable(tb) then
		if tb[tool] then
			return false
		end
	end
	
	if ent.__SW_AllowOnlyThisTool == tool then 
		return false
	end
end
hook.Add( "CanTool", "SW_Common_Tool", Tool )

local function ToolReload( ply, tr, tool )
    if !IsValid(ply) then return end

	local ent = tr.Entity
	local tb = ent.__SW_DenyToolReload
	
	if istable(tb) then
		if tb[tool] then
			if ply:KeyPressed(IN_RELOAD) then return false end
		end
	end
end
hook.Add( "CanTool", "SW_Common_ToolReload", ToolReload )

function SW_ADDON:MakeEnt(classname, ply, parent, name)
    local ent = ents.Create(classname)

    if !IsValid(ent) then return end
	ent.__SW_Vars = ent.__SW_Vars or {}
	self:SetName(ent, name)
	self:SetParent(ent, parent)
	
	if ent.__IsSW_Entity then
		ent:SetAddonID(self.Addonname)
	end

    if !ent.CPPISetOwner then return ent end
    if !IsValid(ply) then return ent end

    ent:CPPISetOwner(ply)
    return ent
end

function SW_ADDON:IsValidModel(ent)
	if !IsValid(ent) then return false end
	
	local model = tostring(ent:GetModel() or "")
	if model == "" then return false end
	
	model = Model(model)
	if !util.IsValidModel(model) then return false end
	
	return true
end

function SW_ADDON:AddToEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	
	if IsValid(ent) then
		self.ents[name][ent] = true
	else
		self.ents[name][ent] = nil
	end
end

function SW_ADDON:RemoveFromEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	self.ents[name][ent] = nil
end


function SW_ADDON:GetAllFromEntList(name)
	name = tostring(name or "")

	self.ents = self.ents or {}
	return self.ents[name] or {}
end

function SW_ADDON:ForEachInEntList(name, func)
	if !isfunction(func) then return end
	local entlist = self:GetAllFromEntList(name)
	
	local index = 1
	for k, v in pairs(entlist) do
		if !IsValid(k) then
			entlist[k] = nil
			continue
		end
		
		local bbreak = func(self, index, k)
		if bbreak == false then
			break
		end
		
		index = index + 1
	end
end

function SW_ADDON:SetupChildEntity(ent, parent, collision, attachmentid)
	if !IsValid(ent) then return end
	if !IsValid(parent) then return end
	
	collision = collision or COLLISION_GROUP_NONE
	attachmentid = attachmentid or 0
	
	ent:Spawn()
	ent:Activate()
	ent:SetParent(parent, attachmentid)
	ent:SetCollisionGroup( collision )
	ent:SetMoveType( MOVETYPE_NONE )
	ent.DoNotDuplicate = true
	parent:DeleteOnRemove( ent )
	
	self:SetParent(ent, parent)

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return ent end
	phys:Sleep()
	
	return ent
end

function SW_ADDON:GetName(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return "" end
	
	return self:ValidateName(ent.__SW_Vars.Name)
end

function SW_ADDON:SetName(ent, name)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars
	
	name = self:ValidateName(name)
	if name == "" then
		name = tostring(util.CRC(tostring(ent)))
	end
	
	local oldname = self:GetName(ent)
	vars.Name = name
	
	local parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[oldname] = nil
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars

    if !IsValid(vars.ParentENT) then return end
	if vars.ParentENT == ent then return end

	return vars.ParentENT
end

function SW_ADDON:SetParent(ent, parent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	if parent == ent then
		parent = nil
	end
	
	local vars = ent.__SW_Vars

	vars.ParentENT = parent
	vars.SuperParentENT = self:GetSuperParent(ent)

	parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	local name = self:GetName(ent)
	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetSuperParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	local vars = ent.__SW_Vars
	
	if IsValid(vars.SuperParentENT) and (vars.SuperParentENT != ent) then
		return vars.SuperParentENT
	end
	
	if !IsValid(vars.ParentENT) then
		return ent
	end
	
	vars.SuperParentENT = self:GetSuperParent(vars.ParentENT)
	if vars.SuperParentENT == ent then return end
    if !IsValid(vars.SuperParentENT) then return end
	
	return vars.SuperParentENT
end

function SW_ADDON:GetEntityPath(ent)
	if !IsValid(ent) then return end
	
	local name = self:GetName(ent)
	local parent = self:GetParent(ent)
	
	if !IsValid(parent) then
		return name
	end
	
	local parent_name = self:GetName(parent)
	name = parent_name .. "/" .. name
	
	return name
end

function SW_ADDON:GetChildren(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	return ent.__SW_Vars.ChildrenENTs or {}
end

function SW_ADDON:GetChild(ent, name)
	local children = self:GetChildren(ent)
	if !children then return end
	
	local child = children[name]
	if !IsValid(child) then return end
	
	if self:GetParent(child) != ent then
		children[name] = nil
		return
	end

	return child
end

function SW_ADDON:GetChildFromPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	
	local curchild = ent
	for k, v in pairs(hirachy) do
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return end
	end
	
	return curchild
end

function SW_ADDON:FindChildAtPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	local lastindex = #hirachy
	
	local curchild = ent
	for k, v in ipairs(hirachy) do
		if(k >= lastindex) then
			return self:FindChildren(curchild, v)
		end
		
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return {} end
	end
	
	return {}
end

function SW_ADDON:ForEachFilteredChild(ent, name, func)
	if !IsValid(ent) then return end
	if !isfunction(func) then return end
	
	local found = self:FindChildAtPath(ent, name)
	local index = 0
	
	for k, v in pairs(found) do
		index = index + 1
		local bbreak = func(ent, index, k, v)
		if bbreak then break end
	end
end

function SW_ADDON:FindChildren(ent, name)
	local children = self:GetChildren(ent)
	if !children then return {} end
	
	name = tostring(name or "")
	
	local found = {}
	for k, v in pairs(children) do
		if !IsValid(v) then continue end
		if !string.find(k, name) then continue end
		found[k] = v
	end
	
	return found
end

function SW_ADDON:ChangePoseParameter( ent, val, name, divide )
	if !IsValid(ent) then return end
	val = val or 0
	name = name or ""
	divide = divide or 1
	
	ent:SetPoseParameter( name, val/divide ) 
end

function SW_ADDON:Exit_Seat( ent, ply, pvf, pvr, pvu, evf, evr, evu )

	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end

	local Filter = function( addon, veh, f_ent )
		if !IsValid(f_ent) then return false end
		if !IsValid(ply) then return false end
		if f_ent == veh then return false end
		if f_ent == ply then return false end
		if f_ent:GetModel() == "models/sligwolf/unique_props/seat.mdl" then return false end

		return true
	end	

	local lpos = ent:GetPos()
	local lang = ent:GetAngles()
	local fwd = lang:Forward()
	local rgt = lang:Right()
	local up = lang:Up()
	local pos = lpos - fwd*pvf - rgt*pvr - up*pvu
	
	pvf = pvf or 0
	pvr = pvr or 0
	pvu = pvu or 0
	evf = evf or 0
	evr = evr or 0
	evu = evu or 0

	local tb = {
		V1 = { VecA = Vector(0,0,0), VecB = Vector(0,0,70) },
		V2 = { VecA = Vector(15,0,0), VecB = Vector(15,0,70) },
		V3 = { VecA = Vector(0,15,0), VecB = Vector(0,15,70) },
		V4 = { VecA = Vector(-15,0,0), VecB = Vector(-15,0,70) },
		V5 = { VecA = Vector(0,-15,0), VecB = Vector(0,-15,70) },
		V6 = { VecA = Vector(15,15,0), VecB = Vector(15,15,70) },
		V7 = { VecA = Vector(-15,15,0), VecB = Vector(-15,15,70) },
		V8 = { VecA = Vector(-15,-15,0), VecB = Vector(-15,-15,70) },
		V9 = { VecA = Vector(15,-15,0), VecB = Vector(15,-15,70) },
	}
	
	for k,v in pairs(tb) do
		local tr = self:Tracer( ent, pos+v.VecA, pos+v.VecB, Filter )
		if tr.Hit then return true end
	end
	
	ply:SetPos(pos)
	ply:SetEyeAngles((lpos-(lpos - fwd*evf - rgt*evr + up*evu)):Angle())
	return false
end

function SW_ADDON:Indicator_Sound(ent, bool_R, bool_L, pitchon, pitchoff, vol, sound)
	if !IsValid(ent) then return end
	
	local Check = bool_R or bool_L or nil
	if !Check then return end
	vol = vol or 50
	pitchon = pitchon or 100
	pitchoff = pitchoff or 75
	sound = sound or "vehicles/sligwolf/generic/indicator_on.wav"
	
	if !ent.__SW_Indicator_OnOff then
		ent:EmitSound(sound, vol, pitchon)
		ent.__SW_Indicator_OnOff = true
		return
	else
		ent:EmitSound(sound, vol, pitchoff)
		ent.__SW_Indicator_OnOff = false
		return
	end
end

function SW_ADDON:VehicleOrderThink()
	if CLIENT then
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		local vehicle = ply:GetVehicle()
		if !IsValid(vehicle) then return end
		
		if gui.IsGameUIVisible() then return end
		if gui.IsConsoleVisible() then return end
		if IsValid(vgui.GetKeyboardFocus()) then return end
		if ply:IsTyping() then return end
		
		for k,v in pairs(self.KeySettings or {}) do
			if (!v.cv) then continue end
			
			local isdown = input.IsKeyDown( v.cv:GetInt() )
			self:SendVehicleOrder(vehicle, k, isdown)
		end
		
		return
	end

	for vehicle, players in pairs(self.PressedKeyMap or {}) do
		if !IsValid(vehicle) then continue end
		
		for ply, keys in pairs(players or {}) do
			if !IsValid(ply) then continue end
			
			for name, callback_data in pairs(keys or {}) do
				if !callback_data.state then continue end
				
				local callback_hold = callback_data.callback_hold
				callback_hold(self, ply, vehicle, true)
			end
		end
	end
end

function SW_ADDON:VehicleOrderLeave(ply, vehicle)
	if CLIENT then return end
	
	local holdedkeys = self.PressedKeyMap or {}
	holdedkeys = holdedkeys[vehicle] or {}
	holdedkeys = holdedkeys[ply] or {}

	for name, callback_data in pairs(holdedkeys) do
		if !callback_data.state then continue end
	
		local callback_hold = callback_data.callback_hold
		local callback_up = callback_data.callback_up
		
		callback_hold(self, ply, vehicle, false)
		callback_up(self, ply, vehicle, false)
		
		callback_data.state = false
	end
end

function SW_ADDON:RegisterVehicleOrder(name, callback_hold, callback_down, callback_up)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	if CLIENT then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end

	name = name or ""
	if name == "" then return end

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	
	local valid = false
	if !isfunction(callback_hold) then
		callback_hold = (function() end)
	else
		valid = true
	end
		
	if !isfunction(callback_down) then
		callback_down = (function() end)
	else
		valid = true
	end
	
	if !isfunction(callback_up) then
		callback_up = (function() end)
	else
		valid = true
	end	
	
	if !valid then
		error("no callback functions given!")
		return
	end	
	
	util.AddNetworkString( netname )
	net.Receive( netname, function( len, ply )
		local ent = net.ReadEntity()
		local down = net.ReadBool() or false
		
		if !IsValid(ent) then return end
		if !IsValid(ply) then return end
		if !ply:InVehicle() then return end

		local veh = ply:GetVehicle()
		if(ent != veh) then return end
		
		local setting = self.KeySettings[name]
		if !setting then return end
		
		self.KeyBuffer = self.KeyBuffer or {}
		self.KeyBuffer[veh] = self.KeyBuffer[veh] or {}
	
		local changedbuffer = self.KeyBuffer[veh][name] or {}
		local times  = changedbuffer.times or {}
		
		local mintime = setting.time or 0
		if mintime > 0 then
			local lasttime = times[down] or 0
			local deltatime = CurTime() - lasttime
		
			if deltatime <= mintime then return end
		end
		
		if changedbuffer.state == down then return end
		
		times[down] = CurTime()	
		changedbuffer.times = times
		changedbuffer.state = down
		
		self.KeyBuffer[veh][name] = changedbuffer
		
		self.PressedKeyMap = self.PressedKeyMap or {}
		self.PressedKeyMap[veh] = self.PressedKeyMap[veh] or {}
		self.PressedKeyMap[veh][ply] = self.PressedKeyMap[veh][ply] or {}
		self.PressedKeyMap[veh][ply][name] = {
			callback_hold = callback_hold,
			callback_up = callback_up,
			callback_down = callback_down,
			state = down,
		}

		if down then
			callback_down(self, ply, veh, down)
			return
		end
		
		callback_up(self, ply, veh, down)
	end)
end

function SW_ADDON:RegisterKeySettings(name, default, time, description, extra_text)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	name = name or ""
	description = description or ""
	help = help or ""
	default = default or 0
	time = time or 0.1
	
	if (name == "") then return end
	if (description == "") then return end
	if (default == 0) then return end

	local setting = {}
	setting.description = description
	setting.cvcmd = "cl_"..self.NetworkaddonID.."_key_"..name
	setting.default = default
	setting.time = time

	if (extra_text != "") then
		setting.extra_text = extra_text
	end

	if CLIENT then
		setting.cv = CreateClientConVar( setting.cvcmd, tostring( default ), true, false )
	end

	self.KeySettings = self.KeySettings or {}
	self.KeySettings[name] = setting
end

if CLIENT then

function SW_ADDON:SendVehicleOrder(vehicle, name, down)
	if !IsValid(vehicle) then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end
	
	name = name or ""
	down = down or false

	if name == "" then return end
	
	self.KeyBuffer = self.KeyBuffer or {}
	self.KeyBuffer[vehicle] = self.KeyBuffer[vehicle] or {}
	
	local changedbuffer = self.KeyBuffer[vehicle][name] or {}

	if changedbuffer.state == down then return end
	changedbuffer.state = down
	
	self.KeyBuffer[vehicle][name] = changedbuffer

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	net.Start(netname) 
		net.WriteEntity(vehicle)
		net.WriteBool(down)
	net.SendToServer()
end


local function AddGap(panel)
	local pnl = panel:AddControl("Label", {
		Text = ""
	})
	
	return pnl
end

function SW_ADDON:VehicleOrderMenu()
	spawnmenu.AddToolMenuOption(
		"Utilities", "SW Vehicle KEY's",
		self.NetworkaddonID.."_Key_Settings",
		self.NiceName, "", "",
		function(panel, ...)
			for k,v in pairs(self.KeySettings or {}) do
				if (!v.cv) then continue end

				panel:AddControl( "Numpad", { 
					Label = v.description, 
					Command = v.cvcmd
				})
				
				if (v.extra_text) then
					panel:AddControl("Label", {
						Text = v.extra_text
					})
				end
				
				AddGap(panel)
			end
		end
	)
end

end

function SW_ADDON:SoundEdit(sound, state, pitch, pitchtime, volume, volumetime)

	sound = sound or nil
	if !sound then return end
	
	state = state or 0
	pitch = pitch or 100
	pitchtime = pitchtime or 0
	volume = volume or 1
	volumetime = volumetime or 0
	
	if state == 0 then
		sound:Stop()
	end
	if state == 1 then
		sound:Play()
	end
	if state == 2 then
		sound:ChangePitch(pitch, pitchtime)
	end
	if state == 3 then
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 4 then
		sound:Play()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 5 then
		sound:Stop()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
end

function SW_ADDON:GetBoneArray( ent )
	if !IsValid(ent) then return end
	
	local EntArray = {}
	local BoneArray = {}
	local BoneAngArray = {}
	local BonePosArray = {}
	
	for i = 1, 128 do		
		local Bone = ent:GetBoneName( i )
		if !Bone or Bone == "" or Bone == "__INVALIDBONE__" then continue end
		
		BoneArray[i] = Bone
		BoneAngArray[i] = ent:GetManipulateBoneAngles( i )
		BonePosArray[i] = ent:GetManipulateBonePosition( i )
	end
	
	EntArray = {
		Bones = BoneArray,
		Angles = BoneAngArray,
		Positions = BonePosArray,
	}
	
	ent.__SW_EntArray_Bone_Ang_Pos = EntArray
	
end

function SW_ADDON:CheckBoneArray( ent )
	if !IsValid(ent) then return false end
	
	local tb0 = ent.__SW_EntArray_Bone_Ang_Pos
	if !istable(tb0) then return false end
	
	local Check = table.GetKeys(tb0)
	local Num0 = table.Count(tb0)
	if !istable( Check ) then return false end
	if !Num0 == 3 then return false end
	
	local tb1 = tb0.Bones
	local tb2 = tb0.Angles
	local tb3 = tb0.Positions
	
	if !istable(tb1) or !istable(tb2) or !istable(tb3) then return false end
	
	local Num1 = table.Count( tb1 )
	local Num2 = table.Count( tb2 )
	local Num3 = table.Count( tb3 )
	
	if Num1 != Num2 then return false end
	if Num2 != Num3 then return false end
	if Num3 != Num1 then return false end
	
	return true
	
end

function SW_ADDON:BoneEdit( ent, name, ang, vec )
	if !IsValid(ent) then return end
	
	local Check = self:CheckBoneArray(ent)
	if !Check then return end
	
	local TB = ent.__SW_EntArray_Bone_Ang_Pos
	
	name = name or nil
	local Bone = ent:LookupBone(name)
	if !Bone then return end
	vec = vec or TB.Positions[Bone] or Vector()
	ang = ang or TB.Angles[Bone] or Angle()
	
	ent:ManipulateBonePosition( Bone, vec ) 
	ent:ManipulateBoneAngles( Bone, ang )

end

function SW_ADDON:CamControl(ply, ent)

	if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	
	if ply:GetViewEntity() == ent then
		ply:SetViewEntity(ply)
		ply.__SW_Cam_Mode = false
		return
	end
	ply:SetViewEntity(ent)
	ply.__SW_Cam_Mode = true
end

function SW_ADDON:ViewEnt( ply )
	if !IsValid(ply) then return end
	
	local Old_Cam = ply:GetViewEntity()
	ply.__SW_Old_Cam = Old_Cam
	local Cam = ply.__SW_Old_Cam
	
	if !IsValid(Cam) then return end
	if !ply.__SW_Cam_Mode then return end
	
	ply:SetViewEntity(ply)
	ply.__SW_Cam_Mode = false
end

function SW_ADDON:ChangeMat( ent, num, mat )
	if !IsValid(ent) then return end
	num = num or 0
	mat = mat or ""
	
	ent:SetSubMaterial( num, mat )
end

function SW_ADDON:RemoveUTimerOnEnt(ent, name)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end

	name = tostring(name or "")
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	timer.Remove(uname)
end

function SW_ADDON:CreateUTimerOnEnt(ent, name, time, func, repeats)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end
	
	name = tostring(name or "")
	time = time or 0
	repeats = repeats or 0
	
	if repeats <= 0 then
		repeats = 1
	end
	
	if time < 0 then
		time = 0
	end
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	
	timer.Remove(uname)
	timer.Create(uname, time, repeats, function()
	
		if !IsValid(ent) then
			timer.Remove( uname )
			return
		end
	
		func(ent)
	end)
end

local function GetCameraEnt( ply )
	if !IsValid(ply) and CLIENT then
		ply = LocalPlayer()
	end

	if !IsValid(ply) then return nil end
	local camera = ply:GetViewEntity()
	if !IsValid(camera) then return ply end

	return camera
end

function SW_ADDON:DoTrace( ply, maxdist, filter )
	local camera = GetCameraEnt(ply)
	local start_pos, end_pos
	if !IsValid(ply) then return nil end
	if !IsValid(camera) then return nil end
	
	maxdist = maxdist or 500

	if camera:IsPlayer() then
		start_pos = camera:EyePos()
		end_pos = start_pos + camera:GetAimVector() * maxdist
	else
		start_pos = camera:GetPos()
		end_pos = start_pos + ply:GetAimVector() * maxdist
	end
	
	local trace = {}
	trace.start = start_pos
	trace.endpos = end_pos

	trace.filter = function( ent, ... )
		if !IsValid(ent) then return false end
		if !IsValid(ply) then return false end
		if !IsValid(camera) then return false end
		if ent == ply then return false end
		if ent == camera then return false end
		
		if ply.GetVehicle and ent == ply:GetVehicle() then return false end
		if camera.GetVehicle and ent == camera:GetVehicle() then return false end

		if filter then
			if isfunction(filter) then
				if !filter(ent, ply, camera, ...) then
					return false
				end
			end
			
			if istable(filter) then
				if filter[ent] then
					return false
				end
			end
			
			if filter == ent then
				return false
			end
		end
		
		return true
	end
	return util.TraceLine(trace)
end

function SW_ADDON:PressButton( ply, playervehicle )
	if !IsValid(ply) then return end

	local tr = self:DoTrace(ply, 100)
	if !tr then return end
	
	local Button = tr.Entity
	if !IsValid(Button) then return end
		
	local superparent = self:GetSuperParent(Button)

	if !IsValid(superparent) then
		superparent = Button
		playervehicle = nil
	else
		if Button.__SW_Invehicle and !IsValid(playervehicle) then return end
	end

	if IsValid(playervehicle) and superparent != playervehicle then return end

	if !Button.__SW_Buttonfunc then return end

	if !superparent.__SW_AddonID or ( superparent.__SW_AddonID == "" ) then
		error("superparent.__SW_AddonID missing!")
		return
	end
	
	if superparent.__SW_AddonID != self.NetworkaddonID then return end

	local allowuse = true
	
	if superparent.CPPICanUse then
		allowuse = superparent:CPPICanUse(ply) or false
	end
	
	if !allowuse then return end
	
	return Button.__SW_Buttonfunc(Button, superparent, ply)
end

local matcache = {}
function SW_ADDON:SW_HUD_Texture(PNGname, RGB, TexX, TexY, W, H)
	local texturedata = matcache[PNGname]

	if texturedata then
		texturedata.color = RGB
		texturedata.x = TexX
		texturedata.y = TexY
		texturedata.w = W
		texturedata.h = H
   
		return texturedata
	end

	matcache[PNGname] = { Textur = Material(PNGname), color=RGB, x=TexX, y=TexY, w=W, h=H }
	return matcache[PNGname]
end

function SW_ADDON:DrawMaterial(texturedata)
	surface.SetMaterial(texturedata.Textur)
	surface.DrawTexturedRect(texturedata.x, texturedata.y, texturedata.w, texturedata.h)
end

function SW_ADDON:GetConnectedVehicles(vehicle)
	vehicle = self:GetSuperParent(vehicle)
	if !IsValid(vehicle) then return end

	vehicle.__SW_Connected = vehicle.__SW_Connected or {}
	return vehicle.__SW_Connected
end

function SW_ADDON:GetTrailerVehicles(vehicle)
	if !IsValid(vehicle) then return end

	local unique = {}
	local connected = {}

	local function recusive_func(f_ent)
		local vehicles = self:GetConnectedVehicles(f_ent)
		if !vehicles then return end

		for k, v in pairs(vehicles) do
			if !IsValid(v) then continue end
			if unique[v] then continue end
			
			unique[v] = true
			connected[#connected + 1] = v
			recusive_func(v)
		end
		
		if unique[f_ent] then return end
		
		unique[f_ent] = true
		connected[#connected + 1] = f_ent
	end
	
	recusive_func(vehicle)
	
	return connected
end

function SW_ADDON:ForEachTrailerVehicles(vehicle, func)
	if !IsValid(vehicle) then return end
	if !isfunction(func) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	for k, v in ipairs(vehicles) do
		if !IsValid(vehicle) then continue end
		if func(k, v) == false then break end
	end
end

function SW_ADDON:GetTrailerMainVehicles(vehicle)
	if !IsValid(vehicle) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	local mainvehicles = {}
	for k, v in pairs(vehicles) do
		if !IsValid(v) then continue end
		if !v.__IsSW_TrailerMain then continue end
		mainvehicles[#mainvehicles + 1] = v
	end
	
	return mainvehicles
end

function SW_ADDON:TrailerHasMainVehicles(vehicle)
	local mainvehicles = self:GetTrailerMainVehicles(vehicle)
	
	if !mainvehicles then return false end
	if !IsValid(mainvehicles[1]) then return false end
	
	return true
end

function SW_ADDON:ValidateName(name)
	name = tostring(name or "")
	name = string.gsub(name, "^!", "", 1)
	name = string.gsub(name, "[\\/]", "")
	return name
end

function SW_ADDON:GetVal(ent, name, default)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name

	local data = vars.Data or {}
	local value = data[name]
	
	if value == nil then
		value = default 
	end
	
	return value
end

function SW_ADDON:SetVal(ent, name, value)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name
	
	vars.Data = vars.Data or {}
	vars.Data[name] = value
end

function SW_ADDON:SetupDupeModifier(ent, name, precopycallback, postcopycallback)
    if !IsValid(ent) then return end

	name = self:ValidateName(name)
    if name == "" then return end

	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
    if vars.duperegistered then return end
	
    if !isfunction(precopycallback) then
		precopycallback = (function() end)
	end
	
	if !isfunction(postcopycallback) then
		postcopycallback = (function() end)
	end
	
	local oldprecopy = superparent.PreEntityCopy or (function() end)
	local dupename = "SW_Common_MakeEnt_Dupe_" .. self.NetworkaddonID  .. "_" .. name
	vars.dupename = dupename
	
	superparent.PreEntityCopy = function(...)
		if IsValid(superparent) then
			precopycallback(superparent)
		end
		
		vars.Data = vars.Data or {}
		duplicator.StoreEntityModifier(superparent, dupename, vars.Data)
		
		return oldprecopy(...)
	end
	vars.duperegistered = true

	self.duperegistered = self.duperegistered or {}
    if self.duperegistered[dupename] then return end
	
	duplicator.RegisterEntityModifier(dupename, function(ply, ent, data)
		if !IsValid(ent) then return end

		local superparent = self:GetSuperParent(ent) or ent
		if !IsValid(superparent) then return end

		superparent.__SW_Vars = superparent.__SW_Vars or {}
		local vars = superparent.__SW_Vars
		
		vars.Data = data or {}
		
		if IsValid(superparent) then
			postcopycallback(superparent)
		end
	end)
	
	self.duperegistered[dupename] = true
end

function SW_ADDON:AddFont(name, data)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end

	name = self.NetworkaddonID .. "_" .. name
	
	self.cachedfonts = self.cachedfonts or {}
	if self.cachedfonts[name] then return name end
	
	self.cachedfonts[name] = true

	surface.CreateFont(name, data)
	return name
end

function SW_ADDON:GetFont(name)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end
	
	name = self.NetworkaddonID .. "_" .. name
	if !self.cachedfonts[name] then return nil end
	
	return name
end

function SW_ADDON:CheckAllowUse(ent, ply)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	local allowuse = true
	
    if ent.CPPICanUse then
		allowuse = ent:CPPICanUse(ply) or false
	end
	
    return allowuse
end

function SW_ADDON:VectorToLocalToWorld( ent, vec )
	if !IsValid(ent) then return nil end
	
	vec = vec or Vector()
	vec = ent:LocalToWorld(vec)
	
	return vec
end

function SW_ADDON:DirToLocalToWorld( ent, ang, dir )
	if !IsValid(ent) then return nil end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	ang = ang or Angle()
	ang = ent:LocalToWorldAngles(ang)
		
		
	local func = ang[dir]
	if !isfunction(func) then return end

	return func(ang)
end

function SW_ADDON:GetAttachmentPosAng(ent, attachment)
	if !self:IsValidModel(ent) then return nil end
	attachment = tostring(attachment or "")

	if attachment == "" then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Num = ent:LookupAttachment(attachment) or 0
	if Num <= 0 then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Att = ent:GetAttachment(Num)
	if not Att then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local pos = Att.Pos
	local ang = Att.Ang

	return pos, ang, true
end

function SW_ADDON:SetEntAngPosViaAttachment(entA, entB, attA, attB)
	if !self:IsValidModel(entA) then return false end
	if !self:IsValidModel(entB) then return false end

	attA = tostring(attA or "")
	attB = tostring(attB or "")
	
	local PosA, AngA, HasAttA = self:GetAttachmentPosAng(entA, attA)
	local PosB, AngB, HasAttB = self:GetAttachmentPosAng(entB, attB)

	if not HasAttA and not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	if not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	local localPosA = entA:WorldToLocal(PosA)
	local localAngA = entA:WorldToLocalAngles(AngA)

	local localPosB = entB:WorldToLocal(PosB)
	local localAngB = entB:WorldToLocalAngles(AngB)

	local M = Matrix()

	M:SetAngles(localAngA)
	M:SetTranslation(localPosA)

	local M2 = Matrix()
	M2:SetAngles(localAngB)
	M2:SetTranslation(localPosB)

	M = M * M2:GetInverseTR()

	local ang = M:GetAngles()
	local pos = M:GetTranslation()

	pos = entA:LocalToWorld(pos)
	ang = entA:LocalToWorldAngles(ang)

	entB:SetAngles(ang)
	entB:SetPos(pos)

	return true
end

function SW_ADDON:RemoveEntites(tb)
	tb = tb or {}
	if !istable(tb) then return end
	
	for k,v in pairs(tb) do
		if !IsValid(v) then continue end
		v:Remove()
	end
end

function SW_ADDON:FindPropInSphere(ent, radius, attachment, filterA, filterB)
	if !IsValid(ent) then return nil end
	radius = radius or 10
	filterA = filterA or "none"
	filterB = filterB or "none"
	
	local new_ent = nil

	local pos = self:GetAttachmentPosAng(ent, attachment)
	local objs = ents.FindInSphere( pos, radius ) or {}
	
	for k,v in pairs(objs) do
		if !IsValid(v) then continue end
		local mdl = v:GetModel()
		if mdl == filterA or mdl == filterB then
			new_ent = v
			return new_ent
		end
	end
	
	return nil
end

local Color_trGreen = Color( 50, 255, 50 )
local Color_trBlue = Color( 50, 50, 255 )
local Color_trTextHit = Color( 100, 255, 100 )

function SW_ADDON:Tracer( ent, vec1, vec2, filterfunc )
	if !IsValid(ent) then return nil end
	
	vec1 = vec1 or Vector()
	vec2 = vec2 or Vector()

	if !isfunction(filterfunc) then
		filterfunc = (function()
			return true
		end)
	end
	
	local tr = util.TraceLine( {
		start = vec1,
		endpos = vec2,
		filter = function(trent, ...)
			if !IsValid(ent) then return false end
			if !IsValid(trent) then return false end
			if trent == ent then return false end
			
			local sp = self:GetSuperParent(ent)
			if !IsValid(sp) then return false end
			if trent == sp then return false end

			if self:GetSuperParent(trent) == sp then return false end
			return filterfunc(self, sp, trent, ...)
		end
	} )
	
	if !tr then return nil end
	
	vec1 = tr.StartPos
	
	debugoverlay.Cross( vec1, 1, 0.1, color_white, true ) 
	debugoverlay.Cross( vec2, 1, 0.1, color_white, true ) 
	debugoverlay.Line( vec1, tr.HitPos, 0.1, Color_trGreen, true )
	debugoverlay.Line( tr.HitPos, vec2, 0.1, Color_trBlue, true )
	debugoverlay.EntityTextAtPosition(vec1, 0, "Start", 0.1, color_white)
	
	if tr.Hit then
		debugoverlay.EntityTextAtPosition(tr.HitPos, 0, "Hit", 0.1, Color_trTextHit)
	end
	
	debugoverlay.EntityTextAtPosition(vec2, 0, "End", 0.1, color_white)
	
	return tr
end

function SW_ADDON:TracerAttachment( ent, attachment, len, dir, filterfunc )
	len = len or 0
	
	if len == 0 then
		len = 1
	end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	local pos, ang = self:GetAttachmentPosAng(ent, attachment)
	if !pos then return end
		
	local func = ang[dir]
	if !isfunction(func) then return end

	local endpos = pos + func(ang) * len

	return self:Tracer(ent, pos, endpos, filterfunc)
end

function SW_ADDON:TracerAttachmentToAttachment( ent, attachmentA, attachmentB, filterfunc )
	local posA = self:GetAttachmentPosAng(ent, attachmentA)
	if !posA then return end

	local posB = self:GetAttachmentPosAng(ent, attachmentB)
	if !posB then return end

	return self:Tracer(ent, posA, posB, filterfunc)
end

function SW_ADDON:CheckGround(ent, vec1, vec2)
	if !IsValid(ent) then return false end

	vec2 = vec2 or vec1
	vec1 = vec1 or vec2

	if !vec1 then return false end
	if !vec2 then return false end

	local vec1A = ent:LocalToWorld(Vector(vec1.x, vec1.y, vec1.z)) 
	local vec2A = ent:LocalToWorld(Vector(vec2.x, -vec2.y, vec2.z)) 

	local vec1B = ent:LocalToWorld(Vector(-vec1.x, vec1.y, vec1.z)) 
	local vec2B = ent:LocalToWorld(Vector(-vec2.x, -vec2.y, vec2.z)) 

	local tr1 = self:Tracer(ent, vec1A, vec2A)
	local tr2 = self:Tracer(ent, vec1B, vec2B)
	
	if tr1 and tr1.Hit then return true end
	if tr2 and tr2.Hit then return true end
	
	return false
end

function SW_ADDON:GetRelativeVelocity(ent)
	if !IsValid(ent) then return end

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local v = phys:GetVelocity()
	return phys:WorldToLocalVector(v)
end

function SW_ADDON:GetForwardVelocity(ent)
	local v = self:GetRelativeVelocity(ent)
	if !v then return 0 end
	
	return v.y or 0
end

function SW_ADDON:GetKPHSpeed(v)
	local UnitKmh = math.Round((v * 0.75) * 3600 * 0.0000254)
	return UnitKmh
end

function SW_ADDON:ConstraintIsAllowed(ent, ply, mode)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	mode = tostring(mode or "")
	mode = string.lower(mode)
	
	if mode == "" then
		mode = "weld"
	end
	
	local allowtool = true
	
	if ent.CPPICanTool then
		allowtool = ent:CPPICanTool(ply, mode) or false
	end
	
	if !allowtool then return false end
	return true
end

-- "addons\\slick\\lua\\sw_addons\\bluex11\\common.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/* 
Version 10.08.20

Last Change: 

Changed the functions:
SetEntAngPosViaAttachment()

Improved the function. No helper prop is needed anymore.

*/

if !SW_ADDON then
	SW_Addons.AutoReloadAddon(function() end)
	return
end

function SW_ADDON:Add_Items( name, listname, model, class, skin )
	class = class or "prop_physics"
	skin = skin or 0
	
	local NormalOffset = nil
	local DropToFloor = nil
	
	if (class != "prop_ragdoll") then
		NormalOffset = 64
		DropToFloor = true
	end

	list.Set( "SpawnableEntities", name, { 
		PrintName = listname, 
		ClassName = class, 
		Category = "SligWolf's Props",
		
		NormalOffset = NormalOffset,
		DropToFloor = DropToFloor,

		KeyValues = {
			model = model,
			skin = skin,
			addonname = self.Addonname,
		}
	})
end

function SW_ADDON:AddPlayerModel(name, player_model, vhands_model, skin, bodygroup)
	player_model = player_model or ""
	vhands_model = vhands_model or ""
	name = name or player_model
	skin = skin or 0
	bodygroup = bodygroup or "00000000"

	if player_model == "" then return end
	
	player_manager.AddValidModel( name, player_model )

	if vhands_model == "" then return end
	player_manager.AddValidHands( name, vhands_model, skin, bodygroup )
end

local function NPC_Setup( ply, npc )
	if !IsValid(npc) then return end
	if npc.__IsSW_Duped then return end
	
	local kv = npc:GetKeyValues()
	local name = kv["classname"] or ""
	
	local tab = list.Get("NPC")
	local data = tab[name]
	if !data then return end
	if !data.IsSW then return end
	
	local data_custom = data.SW_Custom or {}
	
	if data_custom.Accuracy then
		npc:SetCurrentWeaponProficiency( data_custom.Accuracy )
	end
	
	if data_custom.Health then
		npc:SetHealth( data_custom.Health )
	end
	
	if data_custom.Blood then
		npc:SetBloodColor( data_custom.Blood )
	end
	
	if data_custom.Color then
		npc:SetColor( data_custom.Color )
	end
	
	if data_custom.Owner then
		npc.Owner = ply
	end
	
	local func = data_custom.OnSpawn
	if isfunction(func) then
		func(npc, data)
	end
	
	npc.__IsSW_Addon = true
	npc.__IsSW_Class = name
	
	local class = tostring(data.Class or "Corrupt Class!")
	npc:SetKeyValue( "classname", class )
	
	local dupedata = {}
	dupedata.customclass = name
	
	duplicator.StoreEntityModifier(npc, "SW_Common_NPC_Dupe", dupedata) 
end

local function NPC_Dupe(ply, npc, data)
	if !IsValid(npc) then return end
	if !data then return end
	if !data.customclass then return end

	npc:SetKeyValue( "classname", data.customclass )
	NPC_Setup(ply, npc)
	npc.__IsSW_Duped = true
end

function SW_ADDON:Add_NPC(name, npc)
	name = name or ""
	if name == "" then return end
	npc = npc or {}

	npc.Name = npc.Name or "SligWolf - Generic"
	npc.Class = npc.Class or "npc_citizen"
	npc.Category = npc.Category or "SligWolf's NPC's"
	npc.Skin = npc.Skin or 0
	npc.KeyValues = npc.KeyValues or {}
	npc.IsSW = true
	
	// Workaround to get back to custom NPC classname from the spawned NPC
	npc.KeyValues.classname = name

	npc.SW_Custom = npc.SW_Custom or {}
	list.Set( "NPC", name, npc )

	hook.Remove( "PlayerSpawnedNPC", "SW_Common_NPC_Setup")
	hook.Add( "PlayerSpawnedNPC", "SW_Common_NPC_Setup", NPC_Setup)
	duplicator.RegisterEntityModifier( "SW_Common_NPC_Dupe", NPC_Dupe)
	
	if CLIENT then
		language.Add(name, npc.Name)
	end
end

local function CantTouch( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Blockedprop then return false end
end
hook.Add( "PhysgunPickup", "SW_Common_CantTouch", CantTouch )

local function CantPickUp( ply, ent )
    if !IsValid(ply) then return end
    if !IsValid(ent) then return end
    if ent.__SW_Cantpickup then return false end
end
hook.Add( "AllowPlayerPickup", "SW_Common_CantPickUp", CantPickUp )

local function CantUnfreeze( ply, ent )
    if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	if ent.__SW_NoUnfreeze then return false end
end
hook.Add( "CanPlayerUnfreeze", "SW_Common_CantUnfreeze", CantUnfreeze )

local function Tool( ply, tr, tool )
    if !IsValid(ply) then return end
	
	local ent = tr.Entity
	debugoverlay.Text( tr.HitPos, tostring(tool), 3, false ) 
	
	if ent.__SW_BlockAllTools then return false end
	
	local tb = ent.__SW_BlockTool
	
	if istable(tb) then
		if tb[tool] then
			return false
		end
	end
	
	if ent.__SW_AllowOnlyThisTool == tool then 
		return false
	end
end
hook.Add( "CanTool", "SW_Common_Tool", Tool )

local function ToolReload( ply, tr, tool )
    if !IsValid(ply) then return end

	local ent = tr.Entity
	local tb = ent.__SW_DenyToolReload
	
	if istable(tb) then
		if tb[tool] then
			if ply:KeyPressed(IN_RELOAD) then return false end
		end
	end
end
hook.Add( "CanTool", "SW_Common_ToolReload", ToolReload )

function SW_ADDON:MakeEnt(classname, ply, parent, name)
    local ent = ents.Create(classname)

    if !IsValid(ent) then return end
	ent.__SW_Vars = ent.__SW_Vars or {}
	self:SetName(ent, name)
	self:SetParent(ent, parent)
	
	if ent.__IsSW_Entity then
		ent:SetAddonID(self.Addonname)
	end

    if !ent.CPPISetOwner then return ent end
    if !IsValid(ply) then return ent end

    ent:CPPISetOwner(ply)
    return ent
end

function SW_ADDON:IsValidModel(ent)
	if !IsValid(ent) then return false end
	
	local model = tostring(ent:GetModel() or "")
	if model == "" then return false end
	
	model = Model(model)
	if !util.IsValidModel(model) then return false end
	
	return true
end

function SW_ADDON:AddToEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	
	if IsValid(ent) then
		self.ents[name][ent] = true
	else
		self.ents[name][ent] = nil
	end
end

function SW_ADDON:RemoveFromEntList(name, ent)
	name = tostring(name or "")

	self.ents = self.ents or {}
	self.ents[name] = self.ents[name] or {}
	self.ents[name][ent] = nil
end


function SW_ADDON:GetAllFromEntList(name)
	name = tostring(name or "")

	self.ents = self.ents or {}
	return self.ents[name] or {}
end

function SW_ADDON:ForEachInEntList(name, func)
	if !isfunction(func) then return end
	local entlist = self:GetAllFromEntList(name)
	
	local index = 1
	for k, v in pairs(entlist) do
		if !IsValid(k) then
			entlist[k] = nil
			continue
		end
		
		local bbreak = func(self, index, k)
		if bbreak == false then
			break
		end
		
		index = index + 1
	end
end

function SW_ADDON:SetupChildEntity(ent, parent, collision, attachmentid)
	if !IsValid(ent) then return end
	if !IsValid(parent) then return end
	
	collision = collision or COLLISION_GROUP_NONE
	attachmentid = attachmentid or 0
	
	ent:Spawn()
	ent:Activate()
	ent:SetParent(parent, attachmentid)
	ent:SetCollisionGroup( collision )
	ent:SetMoveType( MOVETYPE_NONE )
	ent.DoNotDuplicate = true
	parent:DeleteOnRemove( ent )
	
	self:SetParent(ent, parent)

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return ent end
	phys:Sleep()
	
	return ent
end

function SW_ADDON:GetName(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return "" end
	
	return self:ValidateName(ent.__SW_Vars.Name)
end

function SW_ADDON:SetName(ent, name)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars
	
	name = self:ValidateName(name)
	if name == "" then
		name = tostring(util.CRC(tostring(ent)))
	end
	
	local oldname = self:GetName(ent)
	vars.Name = name
	
	local parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[oldname] = nil
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end
	local vars = ent.__SW_Vars

    if !IsValid(vars.ParentENT) then return end
	if vars.ParentENT == ent then return end

	return vars.ParentENT
end

function SW_ADDON:SetParent(ent, parent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	if parent == ent then
		parent = nil
	end
	
	local vars = ent.__SW_Vars

	vars.ParentENT = parent
	vars.SuperParentENT = self:GetSuperParent(ent)

	parent = self:GetParent(ent)
	if !IsValid(parent) then return end
	
	parent.__SW_Vars = parent.__SW_Vars or {}
	local vars_parent = parent.__SW_Vars

	local name = self:GetName(ent)
	vars_parent.ChildrenENTs = vars_parent.ChildrenENTs or {}
	vars_parent.ChildrenENTs[name] = ent
end

function SW_ADDON:GetSuperParent(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	local vars = ent.__SW_Vars
	
	if IsValid(vars.SuperParentENT) and (vars.SuperParentENT != ent) then
		return vars.SuperParentENT
	end
	
	if !IsValid(vars.ParentENT) then
		return ent
	end
	
	vars.SuperParentENT = self:GetSuperParent(vars.ParentENT)
	if vars.SuperParentENT == ent then return end
    if !IsValid(vars.SuperParentENT) then return end
	
	return vars.SuperParentENT
end

function SW_ADDON:GetEntityPath(ent)
	if !IsValid(ent) then return end
	
	local name = self:GetName(ent)
	local parent = self:GetParent(ent)
	
	if !IsValid(parent) then
		return name
	end
	
	local parent_name = self:GetName(parent)
	name = parent_name .. "/" .. name
	
	return name
end

function SW_ADDON:GetChildren(ent)
	if !IsValid(ent) then return end
	if !ent.__SW_Vars then return end

	return ent.__SW_Vars.ChildrenENTs or {}
end

function SW_ADDON:GetChild(ent, name)
	local children = self:GetChildren(ent)
	if !children then return end
	
	local child = children[name]
	if !IsValid(child) then return end
	
	if self:GetParent(child) != ent then
		children[name] = nil
		return
	end

	return child
end

function SW_ADDON:GetChildFromPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	
	local curchild = ent
	for k, v in pairs(hirachy) do
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return end
	end
	
	return curchild
end

function SW_ADDON:FindChildAtPath(ent, path)
	path = tostring(path or "")
	local hirachy = string.Explode("/", path, false) or {}
	local lastindex = #hirachy
	
	local curchild = ent
	for k, v in ipairs(hirachy) do
		if(k >= lastindex) then
			return self:FindChildren(curchild, v)
		end
		
		curchild = self:GetChild(curchild, v)
		if !IsValid(curchild) then return {} end
	end
	
	return {}
end

function SW_ADDON:ForEachFilteredChild(ent, name, func)
	if !IsValid(ent) then return end
	if !isfunction(func) then return end
	
	local found = self:FindChildAtPath(ent, name)
	local index = 0
	
	for k, v in pairs(found) do
		index = index + 1
		local bbreak = func(ent, index, k, v)
		if bbreak then break end
	end
end

function SW_ADDON:FindChildren(ent, name)
	local children = self:GetChildren(ent)
	if !children then return {} end
	
	name = tostring(name or "")
	
	local found = {}
	for k, v in pairs(children) do
		if !IsValid(v) then continue end
		if !string.find(k, name) then continue end
		found[k] = v
	end
	
	return found
end

function SW_ADDON:ChangePoseParameter( ent, val, name, divide )
	if !IsValid(ent) then return end
	val = val or 0
	name = name or ""
	divide = divide or 1
	
	ent:SetPoseParameter( name, val/divide ) 
end

function SW_ADDON:Exit_Seat( ent, ply, pvf, pvr, pvu, evf, evr, evu )

	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end

	local Filter = function( addon, veh, f_ent )
		if !IsValid(f_ent) then return false end
		if !IsValid(ply) then return false end
		if f_ent == veh then return false end
		if f_ent == ply then return false end
		if f_ent:GetModel() == "models/sligwolf/unique_props/seat.mdl" then return false end

		return true
	end	

	local lpos = ent:GetPos()
	local lang = ent:GetAngles()
	local fwd = lang:Forward()
	local rgt = lang:Right()
	local up = lang:Up()
	local pos = lpos - fwd*pvf - rgt*pvr - up*pvu
	
	pvf = pvf or 0
	pvr = pvr or 0
	pvu = pvu or 0
	evf = evf or 0
	evr = evr or 0
	evu = evu or 0

	local tb = {
		V1 = { VecA = Vector(0,0,0), VecB = Vector(0,0,70) },
		V2 = { VecA = Vector(15,0,0), VecB = Vector(15,0,70) },
		V3 = { VecA = Vector(0,15,0), VecB = Vector(0,15,70) },
		V4 = { VecA = Vector(-15,0,0), VecB = Vector(-15,0,70) },
		V5 = { VecA = Vector(0,-15,0), VecB = Vector(0,-15,70) },
		V6 = { VecA = Vector(15,15,0), VecB = Vector(15,15,70) },
		V7 = { VecA = Vector(-15,15,0), VecB = Vector(-15,15,70) },
		V8 = { VecA = Vector(-15,-15,0), VecB = Vector(-15,-15,70) },
		V9 = { VecA = Vector(15,-15,0), VecB = Vector(15,-15,70) },
	}
	
	for k,v in pairs(tb) do
		local tr = self:Tracer( ent, pos+v.VecA, pos+v.VecB, Filter )
		if tr.Hit then return true end
	end
	
	ply:SetPos(pos)
	ply:SetEyeAngles((lpos-(lpos - fwd*evf - rgt*evr + up*evu)):Angle())
	return false
end

function SW_ADDON:Indicator_Sound(ent, bool_R, bool_L, pitchon, pitchoff, vol, sound)
	if !IsValid(ent) then return end
	
	local Check = bool_R or bool_L or nil
	if !Check then return end
	vol = vol or 50
	pitchon = pitchon or 100
	pitchoff = pitchoff or 75
	sound = sound or "vehicles/sligwolf/generic/indicator_on.wav"
	
	if !ent.__SW_Indicator_OnOff then
		ent:EmitSound(sound, vol, pitchon)
		ent.__SW_Indicator_OnOff = true
		return
	else
		ent:EmitSound(sound, vol, pitchoff)
		ent.__SW_Indicator_OnOff = false
		return
	end
end

function SW_ADDON:VehicleOrderThink()
	if CLIENT then
		local ply = LocalPlayer()
		if !IsValid(ply) then return end
		local vehicle = ply:GetVehicle()
		if !IsValid(vehicle) then return end
		
		if gui.IsGameUIVisible() then return end
		if gui.IsConsoleVisible() then return end
		if IsValid(vgui.GetKeyboardFocus()) then return end
		if ply:IsTyping() then return end
		
		for k,v in pairs(self.KeySettings or {}) do
			if (!v.cv) then continue end
			
			local isdown = input.IsKeyDown( v.cv:GetInt() )
			self:SendVehicleOrder(vehicle, k, isdown)
		end
		
		return
	end

	for vehicle, players in pairs(self.PressedKeyMap or {}) do
		if !IsValid(vehicle) then continue end
		
		for ply, keys in pairs(players or {}) do
			if !IsValid(ply) then continue end
			
			for name, callback_data in pairs(keys or {}) do
				if !callback_data.state then continue end
				
				local callback_hold = callback_data.callback_hold
				callback_hold(self, ply, vehicle, true)
			end
		end
	end
end

function SW_ADDON:VehicleOrderLeave(ply, vehicle)
	if CLIENT then return end
	
	local holdedkeys = self.PressedKeyMap or {}
	holdedkeys = holdedkeys[vehicle] or {}
	holdedkeys = holdedkeys[ply] or {}

	for name, callback_data in pairs(holdedkeys) do
		if !callback_data.state then continue end
	
		local callback_hold = callback_data.callback_hold
		local callback_up = callback_data.callback_up
		
		callback_hold(self, ply, vehicle, false)
		callback_up(self, ply, vehicle, false)
		
		callback_data.state = false
	end
end

function SW_ADDON:RegisterVehicleOrder(name, callback_hold, callback_down, callback_up)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	if CLIENT then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end

	name = name or ""
	if name == "" then return end

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	
	local valid = false
	if !isfunction(callback_hold) then
		callback_hold = (function() end)
	else
		valid = true
	end
		
	if !isfunction(callback_down) then
		callback_down = (function() end)
	else
		valid = true
	end
	
	if !isfunction(callback_up) then
		callback_up = (function() end)
	else
		valid = true
	end	
	
	if !valid then
		error("no callback functions given!")
		return
	end	
	
	util.AddNetworkString( netname )
	net.Receive( netname, function( len, ply )
		local ent = net.ReadEntity()
		local down = net.ReadBool() or false
		
		if !IsValid(ent) then return end
		if !IsValid(ply) then return end
		if !ply:InVehicle() then return end

		local veh = ply:GetVehicle()
		if(ent != veh) then return end
		
		local setting = self.KeySettings[name]
		if !setting then return end
		
		self.KeyBuffer = self.KeyBuffer or {}
		self.KeyBuffer[veh] = self.KeyBuffer[veh] or {}
	
		local changedbuffer = self.KeyBuffer[veh][name] or {}
		local times  = changedbuffer.times or {}
		
		local mintime = setting.time or 0
		if mintime > 0 then
			local lasttime = times[down] or 0
			local deltatime = CurTime() - lasttime
		
			if deltatime <= mintime then return end
		end
		
		if changedbuffer.state == down then return end
		
		times[down] = CurTime()	
		changedbuffer.times = times
		changedbuffer.state = down
		
		self.KeyBuffer[veh][name] = changedbuffer
		
		self.PressedKeyMap = self.PressedKeyMap or {}
		self.PressedKeyMap[veh] = self.PressedKeyMap[veh] or {}
		self.PressedKeyMap[veh][ply] = self.PressedKeyMap[veh][ply] or {}
		self.PressedKeyMap[veh][ply][name] = {
			callback_hold = callback_hold,
			callback_up = callback_up,
			callback_down = callback_down,
			state = down,
		}

		if down then
			callback_down(self, ply, veh, down)
			return
		end
		
		callback_up(self, ply, veh, down)
	end)
end

function SW_ADDON:RegisterKeySettings(name, default, time, description, extra_text)
	self.hooks = self.hooks or {}
	self.hooks.VehicleOrderThink = "Think"
	self.hooks.VehicleOrderMenu = "PopulateToolMenu"
	self.hooks.VehicleOrderLeave = "PlayerLeaveVehicle"

	name = name or ""
	description = description or ""
	help = help or ""
	default = default or 0
	time = time or 0.1
	
	if (name == "") then return end
	if (description == "") then return end
	if (default == 0) then return end

	local setting = {}
	setting.description = description
	setting.cvcmd = "cl_"..self.NetworkaddonID.."_key_"..name
	setting.default = default
	setting.time = time

	if (extra_text != "") then
		setting.extra_text = extra_text
	end

	if CLIENT then
		setting.cv = CreateClientConVar( setting.cvcmd, tostring( default ), true, false )
	end

	self.KeySettings = self.KeySettings or {}
	self.KeySettings[name] = setting
end

if CLIENT then

function SW_ADDON:SendVehicleOrder(vehicle, name, down)
	if !IsValid(vehicle) then return end

	local ID = self.NetworkaddonID or ""
	if ID == "" then
		error("Invalid NetworkaddonID!")
		return
	end
	
	name = name or ""
	down = down or false

	if name == "" then return end
	
	self.KeyBuffer = self.KeyBuffer or {}
	self.KeyBuffer[vehicle] = self.KeyBuffer[vehicle] or {}
	
	local changedbuffer = self.KeyBuffer[vehicle][name] or {}

	if changedbuffer.state == down then return end
	changedbuffer.state = down
	
	self.KeyBuffer[vehicle][name] = changedbuffer

	local netname = "SligWolf_VehicleOrder_"..ID.."_"..name
	net.Start(netname) 
		net.WriteEntity(vehicle)
		net.WriteBool(down)
	net.SendToServer()
end


local function AddGap(panel)
	local pnl = panel:AddControl("Label", {
		Text = ""
	})
	
	return pnl
end

function SW_ADDON:VehicleOrderMenu()
	spawnmenu.AddToolMenuOption(
		"Utilities", "SW Vehicle KEY's",
		self.NetworkaddonID.."_Key_Settings",
		self.NiceName, "", "",
		function(panel, ...)
			for k,v in pairs(self.KeySettings or {}) do
				if (!v.cv) then continue end

				panel:AddControl( "Numpad", { 
					Label = v.description, 
					Command = v.cvcmd
				})
				
				if (v.extra_text) then
					panel:AddControl("Label", {
						Text = v.extra_text
					})
				end
				
				AddGap(panel)
			end
		end
	)
end

end

function SW_ADDON:SoundEdit(sound, state, pitch, pitchtime, volume, volumetime)

	sound = sound or nil
	if !sound then return end
	
	state = state or 0
	pitch = pitch or 100
	pitchtime = pitchtime or 0
	volume = volume or 1
	volumetime = volumetime or 0
	
	if state == 0 then
		sound:Stop()
	end
	if state == 1 then
		sound:Play()
	end
	if state == 2 then
		sound:ChangePitch(pitch, pitchtime)
	end
	if state == 3 then
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 4 then
		sound:Play()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
	if state == 5 then
		sound:Stop()
		sound:ChangePitch(pitch, pitchtime)
		sound:ChangeVolume(volume, volumetime)
	end
end

function SW_ADDON:GetBoneArray( ent )
	if !IsValid(ent) then return end
	
	local EntArray = {}
	local BoneArray = {}
	local BoneAngArray = {}
	local BonePosArray = {}
	
	for i = 1, 128 do		
		local Bone = ent:GetBoneName( i )
		if !Bone or Bone == "" or Bone == "__INVALIDBONE__" then continue end
		
		BoneArray[i] = Bone
		BoneAngArray[i] = ent:GetManipulateBoneAngles( i )
		BonePosArray[i] = ent:GetManipulateBonePosition( i )
	end
	
	EntArray = {
		Bones = BoneArray,
		Angles = BoneAngArray,
		Positions = BonePosArray,
	}
	
	ent.__SW_EntArray_Bone_Ang_Pos = EntArray
	
end

function SW_ADDON:CheckBoneArray( ent )
	if !IsValid(ent) then return false end
	
	local tb0 = ent.__SW_EntArray_Bone_Ang_Pos
	if !istable(tb0) then return false end
	
	local Check = table.GetKeys(tb0)
	local Num0 = table.Count(tb0)
	if !istable( Check ) then return false end
	if !Num0 == 3 then return false end
	
	local tb1 = tb0.Bones
	local tb2 = tb0.Angles
	local tb3 = tb0.Positions
	
	if !istable(tb1) or !istable(tb2) or !istable(tb3) then return false end
	
	local Num1 = table.Count( tb1 )
	local Num2 = table.Count( tb2 )
	local Num3 = table.Count( tb3 )
	
	if Num1 != Num2 then return false end
	if Num2 != Num3 then return false end
	if Num3 != Num1 then return false end
	
	return true
	
end

function SW_ADDON:BoneEdit( ent, name, ang, vec )
	if !IsValid(ent) then return end
	
	local Check = self:CheckBoneArray(ent)
	if !Check then return end
	
	local TB = ent.__SW_EntArray_Bone_Ang_Pos
	
	name = name or nil
	local Bone = ent:LookupBone(name)
	if !Bone then return end
	vec = vec or TB.Positions[Bone] or Vector()
	ang = ang or TB.Angles[Bone] or Angle()
	
	ent:ManipulateBonePosition( Bone, vec ) 
	ent:ManipulateBoneAngles( Bone, ang )

end

function SW_ADDON:CamControl(ply, ent)

	if !IsValid(ply) then return end
	if !IsValid(ent) then return end
	
	if ply:GetViewEntity() == ent then
		ply:SetViewEntity(ply)
		ply.__SW_Cam_Mode = false
		return
	end
	ply:SetViewEntity(ent)
	ply.__SW_Cam_Mode = true
end

function SW_ADDON:ViewEnt( ply )
	if !IsValid(ply) then return end
	
	local Old_Cam = ply:GetViewEntity()
	ply.__SW_Old_Cam = Old_Cam
	local Cam = ply.__SW_Old_Cam
	
	if !IsValid(Cam) then return end
	if !ply.__SW_Cam_Mode then return end
	
	ply:SetViewEntity(ply)
	ply.__SW_Cam_Mode = false
end

function SW_ADDON:ChangeMat( ent, num, mat )
	if !IsValid(ent) then return end
	num = num or 0
	mat = mat or ""
	
	ent:SetSubMaterial( num, mat )
end

function SW_ADDON:RemoveUTimerOnEnt(ent, name)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end

	name = tostring(name or "")
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	timer.Remove(uname)
end

function SW_ADDON:CreateUTimerOnEnt(ent, name, time, func, repeats)

	if !IsValid(ent) then return end
	if !ent.GetCreationID then return end
	
	name = tostring(name or "")
	time = time or 0
	repeats = repeats or 0
	
	if repeats <= 0 then
		repeats = 1
	end
	
	if time < 0 then
		time = 0
	end
	
	local uname = self.NetworkaddonID.."_"..ent:GetCreationID().."_"..name
	
	timer.Remove(uname)
	timer.Create(uname, time, repeats, function()
	
		if !IsValid(ent) then
			timer.Remove( uname )
			return
		end
	
		func(ent)
	end)
end

local function GetCameraEnt( ply )
	if !IsValid(ply) and CLIENT then
		ply = LocalPlayer()
	end

	if !IsValid(ply) then return nil end
	local camera = ply:GetViewEntity()
	if !IsValid(camera) then return ply end

	return camera
end

function SW_ADDON:DoTrace( ply, maxdist, filter )
	local camera = GetCameraEnt(ply)
	local start_pos, end_pos
	if !IsValid(ply) then return nil end
	if !IsValid(camera) then return nil end
	
	maxdist = maxdist or 500

	if camera:IsPlayer() then
		start_pos = camera:EyePos()
		end_pos = start_pos + camera:GetAimVector() * maxdist
	else
		start_pos = camera:GetPos()
		end_pos = start_pos + ply:GetAimVector() * maxdist
	end
	
	local trace = {}
	trace.start = start_pos
	trace.endpos = end_pos

	trace.filter = function( ent, ... )
		if !IsValid(ent) then return false end
		if !IsValid(ply) then return false end
		if !IsValid(camera) then return false end
		if ent == ply then return false end
		if ent == camera then return false end
		
		if ply.GetVehicle and ent == ply:GetVehicle() then return false end
		if camera.GetVehicle and ent == camera:GetVehicle() then return false end

		if filter then
			if isfunction(filter) then
				if !filter(ent, ply, camera, ...) then
					return false
				end
			end
			
			if istable(filter) then
				if filter[ent] then
					return false
				end
			end
			
			if filter == ent then
				return false
			end
		end
		
		return true
	end
	return util.TraceLine(trace)
end

function SW_ADDON:PressButton( ply, playervehicle )
	if !IsValid(ply) then return end

	local tr = self:DoTrace(ply, 100)
	if !tr then return end
	
	local Button = tr.Entity
	if !IsValid(Button) then return end
		
	local superparent = self:GetSuperParent(Button)

	if !IsValid(superparent) then
		superparent = Button
		playervehicle = nil
	else
		if Button.__SW_Invehicle and !IsValid(playervehicle) then return end
	end

	if IsValid(playervehicle) and superparent != playervehicle then return end

	if !Button.__SW_Buttonfunc then return end

	if !superparent.__SW_AddonID or ( superparent.__SW_AddonID == "" ) then
		error("superparent.__SW_AddonID missing!")
		return
	end
	
	if superparent.__SW_AddonID != self.NetworkaddonID then return end

	local allowuse = true
	
	if superparent.CPPICanUse then
		allowuse = superparent:CPPICanUse(ply) or false
	end
	
	if !allowuse then return end
	
	return Button.__SW_Buttonfunc(Button, superparent, ply)
end

local matcache = {}
function SW_ADDON:SW_HUD_Texture(PNGname, RGB, TexX, TexY, W, H)
	local texturedata = matcache[PNGname]

	if texturedata then
		texturedata.color = RGB
		texturedata.x = TexX
		texturedata.y = TexY
		texturedata.w = W
		texturedata.h = H
   
		return texturedata
	end

	matcache[PNGname] = { Textur = Material(PNGname), color=RGB, x=TexX, y=TexY, w=W, h=H }
	return matcache[PNGname]
end

function SW_ADDON:DrawMaterial(texturedata)
	surface.SetMaterial(texturedata.Textur)
	surface.DrawTexturedRect(texturedata.x, texturedata.y, texturedata.w, texturedata.h)
end

function SW_ADDON:GetConnectedVehicles(vehicle)
	vehicle = self:GetSuperParent(vehicle)
	if !IsValid(vehicle) then return end

	vehicle.__SW_Connected = vehicle.__SW_Connected or {}
	return vehicle.__SW_Connected
end

function SW_ADDON:GetTrailerVehicles(vehicle)
	if !IsValid(vehicle) then return end

	local unique = {}
	local connected = {}

	local function recusive_func(f_ent)
		local vehicles = self:GetConnectedVehicles(f_ent)
		if !vehicles then return end

		for k, v in pairs(vehicles) do
			if !IsValid(v) then continue end
			if unique[v] then continue end
			
			unique[v] = true
			connected[#connected + 1] = v
			recusive_func(v)
		end
		
		if unique[f_ent] then return end
		
		unique[f_ent] = true
		connected[#connected + 1] = f_ent
	end
	
	recusive_func(vehicle)
	
	return connected
end

function SW_ADDON:ForEachTrailerVehicles(vehicle, func)
	if !IsValid(vehicle) then return end
	if !isfunction(func) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	for k, v in ipairs(vehicles) do
		if !IsValid(vehicle) then continue end
		if func(k, v) == false then break end
	end
end

function SW_ADDON:GetTrailerMainVehicles(vehicle)
	if !IsValid(vehicle) then return end
	
	local vehicles = self:GetTrailerVehicles(vehicle)
	if !vehicles then return end

	local mainvehicles = {}
	for k, v in pairs(vehicles) do
		if !IsValid(v) then continue end
		if !v.__IsSW_TrailerMain then continue end
		mainvehicles[#mainvehicles + 1] = v
	end
	
	return mainvehicles
end

function SW_ADDON:TrailerHasMainVehicles(vehicle)
	local mainvehicles = self:GetTrailerMainVehicles(vehicle)
	
	if !mainvehicles then return false end
	if !IsValid(mainvehicles[1]) then return false end
	
	return true
end

function SW_ADDON:ValidateName(name)
	name = tostring(name or "")
	name = string.gsub(name, "^!", "", 1)
	name = string.gsub(name, "[\\/]", "")
	return name
end

function SW_ADDON:GetVal(ent, name, default)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name

	local data = vars.Data or {}
	local value = data[name]
	
	if value == nil then
		value = default 
	end
	
	return value
end

function SW_ADDON:SetVal(ent, name, value)
    if !IsValid(ent) then return end
	
	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	local path = self:GetEntityPath(ent)
	
	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
	name = self:ValidateName(name)
	name = self.NetworkaddonID .. "/" .. path .. "/!" .. name
	
	vars.Data = vars.Data or {}
	vars.Data[name] = value
end

function SW_ADDON:SetupDupeModifier(ent, name, precopycallback, postcopycallback)
    if !IsValid(ent) then return end

	name = self:ValidateName(name)
    if name == "" then return end

	local superparent = self:GetSuperParent(ent) or ent
    if !IsValid(superparent) then return end

	superparent.__SW_Vars = superparent.__SW_Vars or {}
	local vars = superparent.__SW_Vars
	
    if vars.duperegistered then return end
	
    if !isfunction(precopycallback) then
		precopycallback = (function() end)
	end
	
	if !isfunction(postcopycallback) then
		postcopycallback = (function() end)
	end
	
	local oldprecopy = superparent.PreEntityCopy or (function() end)
	local dupename = "SW_Common_MakeEnt_Dupe_" .. self.NetworkaddonID  .. "_" .. name
	vars.dupename = dupename
	
	superparent.PreEntityCopy = function(...)
		if IsValid(superparent) then
			precopycallback(superparent)
		end
		
		vars.Data = vars.Data or {}
		duplicator.StoreEntityModifier(superparent, dupename, vars.Data)
		
		return oldprecopy(...)
	end
	vars.duperegistered = true

	self.duperegistered = self.duperegistered or {}
    if self.duperegistered[dupename] then return end
	
	duplicator.RegisterEntityModifier(dupename, function(ply, ent, data)
		if !IsValid(ent) then return end

		local superparent = self:GetSuperParent(ent) or ent
		if !IsValid(superparent) then return end

		superparent.__SW_Vars = superparent.__SW_Vars or {}
		local vars = superparent.__SW_Vars
		
		vars.Data = data or {}
		
		if IsValid(superparent) then
			postcopycallback(superparent)
		end
	end)
	
	self.duperegistered[dupename] = true
end

function SW_ADDON:AddFont(name, data)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end

	name = self.NetworkaddonID .. "_" .. name
	
	self.cachedfonts = self.cachedfonts or {}
	if self.cachedfonts[name] then return name end
	
	self.cachedfonts[name] = true

	surface.CreateFont(name, data)
	return name
end

function SW_ADDON:GetFont(name)
	if !CLIENT then return nil end
	
	name = tostring(name or "")
	if name == "" then return nil end
	
	name = self.NetworkaddonID .. "_" .. name
	if !self.cachedfonts[name] then return nil end
	
	return name
end

function SW_ADDON:CheckAllowUse(ent, ply)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	local allowuse = true
	
    if ent.CPPICanUse then
		allowuse = ent:CPPICanUse(ply) or false
	end
	
    return allowuse
end

function SW_ADDON:VectorToLocalToWorld( ent, vec )
	if !IsValid(ent) then return nil end
	
	vec = vec or Vector()
	vec = ent:LocalToWorld(vec)
	
	return vec
end

function SW_ADDON:DirToLocalToWorld( ent, ang, dir )
	if !IsValid(ent) then return nil end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	ang = ang or Angle()
	ang = ent:LocalToWorldAngles(ang)
		
		
	local func = ang[dir]
	if !isfunction(func) then return end

	return func(ang)
end

function SW_ADDON:GetAttachmentPosAng(ent, attachment)
	if !self:IsValidModel(ent) then return nil end
	attachment = tostring(attachment or "")

	if attachment == "" then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Num = ent:LookupAttachment(attachment) or 0
	if Num <= 0 then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local Att = ent:GetAttachment(Num)
	if not Att then
		local pos = ent:GetPos()
		local ang = ent:GetAngles()

		return pos, ang, false
	end

	local pos = Att.Pos
	local ang = Att.Ang

	return pos, ang, true
end

function SW_ADDON:SetEntAngPosViaAttachment(entA, entB, attA, attB)
	if !self:IsValidModel(entA) then return false end
	if !self:IsValidModel(entB) then return false end

	attA = tostring(attA or "")
	attB = tostring(attB or "")
	
	local PosA, AngA, HasAttA = self:GetAttachmentPosAng(entA, attA)
	local PosB, AngB, HasAttB = self:GetAttachmentPosAng(entB, attB)

	if not HasAttA and not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	if not HasAttB then
		entB:SetPos(PosA)
		entB:SetAngles(AngA)

		return true
	end

	local localPosA = entA:WorldToLocal(PosA)
	local localAngA = entA:WorldToLocalAngles(AngA)

	local localPosB = entB:WorldToLocal(PosB)
	local localAngB = entB:WorldToLocalAngles(AngB)

	local M = Matrix()

	M:SetAngles(localAngA)
	M:SetTranslation(localPosA)

	local M2 = Matrix()
	M2:SetAngles(localAngB)
	M2:SetTranslation(localPosB)

	M = M * M2:GetInverseTR()

	local ang = M:GetAngles()
	local pos = M:GetTranslation()

	pos = entA:LocalToWorld(pos)
	ang = entA:LocalToWorldAngles(ang)

	entB:SetAngles(ang)
	entB:SetPos(pos)

	return true
end

function SW_ADDON:RemoveEntites(tb)
	tb = tb or {}
	if !istable(tb) then return end
	
	for k,v in pairs(tb) do
		if !IsValid(v) then continue end
		v:Remove()
	end
end

function SW_ADDON:FindPropInSphere(ent, radius, attachment, filterA, filterB)
	if !IsValid(ent) then return nil end
	radius = radius or 10
	filterA = filterA or "none"
	filterB = filterB or "none"
	
	local new_ent = nil

	local pos = self:GetAttachmentPosAng(ent, attachment)
	local objs = ents.FindInSphere( pos, radius ) or {}
	
	for k,v in pairs(objs) do
		if !IsValid(v) then continue end
		local mdl = v:GetModel()
		if mdl == filterA or mdl == filterB then
			new_ent = v
			return new_ent
		end
	end
	
	return nil
end

local Color_trGreen = Color( 50, 255, 50 )
local Color_trBlue = Color( 50, 50, 255 )
local Color_trTextHit = Color( 100, 255, 100 )

function SW_ADDON:Tracer( ent, vec1, vec2, filterfunc )
	if !IsValid(ent) then return nil end
	
	vec1 = vec1 or Vector()
	vec2 = vec2 or Vector()

	if !isfunction(filterfunc) then
		filterfunc = (function()
			return true
		end)
	end
	
	local tr = util.TraceLine( {
		start = vec1,
		endpos = vec2,
		filter = function(trent, ...)
			if !IsValid(ent) then return false end
			if !IsValid(trent) then return false end
			if trent == ent then return false end
			
			local sp = self:GetSuperParent(ent)
			if !IsValid(sp) then return false end
			if trent == sp then return false end

			if self:GetSuperParent(trent) == sp then return false end
			return filterfunc(self, sp, trent, ...)
		end
	} )
	
	if !tr then return nil end
	
	vec1 = tr.StartPos
	
	debugoverlay.Cross( vec1, 1, 0.1, color_white, true ) 
	debugoverlay.Cross( vec2, 1, 0.1, color_white, true ) 
	debugoverlay.Line( vec1, tr.HitPos, 0.1, Color_trGreen, true )
	debugoverlay.Line( tr.HitPos, vec2, 0.1, Color_trBlue, true )
	debugoverlay.EntityTextAtPosition(vec1, 0, "Start", 0.1, color_white)
	
	if tr.Hit then
		debugoverlay.EntityTextAtPosition(tr.HitPos, 0, "Hit", 0.1, Color_trTextHit)
	end
	
	debugoverlay.EntityTextAtPosition(vec2, 0, "End", 0.1, color_white)
	
	return tr
end

function SW_ADDON:TracerAttachment( ent, attachment, len, dir, filterfunc )
	len = len or 0
	
	if len == 0 then
		len = 1
	end
	
	dir = dir or ""
	
	if dir == "" then
		dir = "Forward"
	end
	
	local pos, ang = self:GetAttachmentPosAng(ent, attachment)
	if !pos then return end
		
	local func = ang[dir]
	if !isfunction(func) then return end

	local endpos = pos + func(ang) * len

	return self:Tracer(ent, pos, endpos, filterfunc)
end

function SW_ADDON:TracerAttachmentToAttachment( ent, attachmentA, attachmentB, filterfunc )
	local posA = self:GetAttachmentPosAng(ent, attachmentA)
	if !posA then return end

	local posB = self:GetAttachmentPosAng(ent, attachmentB)
	if !posB then return end

	return self:Tracer(ent, posA, posB, filterfunc)
end

function SW_ADDON:CheckGround(ent, vec1, vec2)
	if !IsValid(ent) then return false end

	vec2 = vec2 or vec1
	vec1 = vec1 or vec2

	if !vec1 then return false end
	if !vec2 then return false end

	local vec1A = ent:LocalToWorld(Vector(vec1.x, vec1.y, vec1.z)) 
	local vec2A = ent:LocalToWorld(Vector(vec2.x, -vec2.y, vec2.z)) 

	local vec1B = ent:LocalToWorld(Vector(-vec1.x, vec1.y, vec1.z)) 
	local vec2B = ent:LocalToWorld(Vector(-vec2.x, -vec2.y, vec2.z)) 

	local tr1 = self:Tracer(ent, vec1A, vec2A)
	local tr2 = self:Tracer(ent, vec1B, vec2B)
	
	if tr1 and tr1.Hit then return true end
	if tr2 and tr2.Hit then return true end
	
	return false
end

function SW_ADDON:GetRelativeVelocity(ent)
	if !IsValid(ent) then return end

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then return end
	
	local v = phys:GetVelocity()
	return phys:WorldToLocalVector(v)
end

function SW_ADDON:GetForwardVelocity(ent)
	local v = self:GetRelativeVelocity(ent)
	if !v then return 0 end
	
	return v.y or 0
end

function SW_ADDON:GetKPHSpeed(v)
	local UnitKmh = math.Round((v * 0.75) * 3600 * 0.0000254)
	return UnitKmh
end

function SW_ADDON:ConstraintIsAllowed(ent, ply, mode)
	if !IsValid(ent) then return false end
	if !IsValid(ply) then return false end
	
	mode = tostring(mode or "")
	mode = string.lower(mode)
	
	if mode == "" then
		mode = "weld"
	end
	
	local allowtool = true
	
	if ent.CPPICanTool then
		allowtool = ent:CPPICanTool(ply, mode) or false
	end
	
	if !allowtool then return false end
	return true
end

