-- "addons\\slick\\lua\\sw_addons\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SW_Addons = SW_Addons or {}
SW_Addons.Addondata = SW_Addons.Addondata or {}

local defaulthook = {
	Think = "Think",
	Tick = "Tick",
	PlyInit = "PlayerInitialSpawn",
	EntInit = "InitPostEntity",
	KeyPress = "KeyPress",
	KeyRelease = "KeyRelease",
	HUDPaint = "HUDPaint",
	ToolMenu = "PopulateToolMenu",
	Spawn = "PlayerSpawnedVehicle",
	Leave = "PlayerLeaveVehicle",
	Enter = "PlayerEnteredVehicle",
}

local function AddHooks(SW_ADDON)
	local addedhooks = SW_ADDON.hooks or {}
	local hooks = table.Copy(defaulthook)

	for k,v in pairs(addedhooks) do
		k = tostring(k)
		v = tostring(v)
		
		if k == "" then continue end 
		if v == "" then continue end 

		hooks[k] = v
	end
	
	for k,v in pairs(hooks) do
		local func = SW_ADDON[k]
		if !isfunction(func) then 
			continue 
		end

		local hookname = "sw_"..SW_ADDON.Addonname.."_"..v.."_"..k
		
		hook.Remove(v, hookname)
		hook.Add(v, hookname, function(...)
			return func(SW_ADDON, ...)
		end)
	end
end

function SW_Addons.LoadAddon(name, withcommon, withsound)
	name = name or ""
	if name == "" then return false end
	
	local colrealm = SERVER and Color(137,222,255) or Color(255,222,102)
	local realm = SERVER and "server" or "client"
	local prefixcol = Color(128,255,128)
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local check = file.Exists( "sw_addons/"..name.."/init.lua", "LUA" )
	if !check then 
		MsgC(prefixcol, "[SW-ADDONS] ", Color( 255, 90, 90 ), "Unknown addon '"..name.."' at "..realm.."!\n")
		return 
	end
	
	withcommon = withcommon or false
	withsound = withsound or false
	
	if SW_Addons.Addondata[name] then return true end
	local path = ""
	
	SW_ADDON = {}
	SW_ADDON.Addonname = name 
	SW_ADDON.Common = false
	SW_ADDON.Sound = false
	

	if withcommon then
		path = "sw_addons/"..name.."/common.lua"
		SW_ADDON.Common = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	if withsound then
		path = "sw_addons/"..name.."/sound.lua"
		SW_ADDON.Sound = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	path = "sw_addons/"..name.."/init.lua"

	include(path)
	AddCSLuaFile(path)
	
	local func = SW_ADDON.Afterload
	if isfunction(func) then
		func(SW_ADDON)
	end

	AddHooks(SW_ADDON)
	
	SW_Addons.Addondata[name] = SW_ADDON
	SW_ADDON = nil
	
	MsgC(prefixcol, "[SW-ADDONS] ", colrealm, "Addon '"..name.."' loaded at "..realm.."!\n")
	
	return true
end

function SW_Addons.ReloadAddon(name)
	name = name or ""
	if name == "" then return false end
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local addon = SW_Addons.Addondata[name] or {}
	
	local withcommon = addon.Common or false
	local withsound = addon.Sound or false
	
	SW_Addons.Addondata[name] = nil
	return SW_Addons.LoadAddon(name, withcommon, withsound)
end

function SW_Addons.ReloadAllAddons()
	for k,v in pairs(SW_Addons.Addondata) do
		SW_Addons.ReloadAddon(k)
	end
end

function SW_Addons.AutoReloadAddon(funcobj)
	if !isfunction(funcobj) then return false end

	local info = debug.getinfo(funcobj) or {}
	local path = info.short_src or info.source or ""
	
	local folders = string.Explode("/", path, false)
	local count = #folders
	
	local name = folders[count-1]
	return SW_Addons.ReloadAddon(name)
end	

if SERVER then
	util.AddNetworkString( "sw_reload_addon" )
	util.AddNetworkString( "sw_reload_alladdons" )
	
	concommand.Add( "sv_sw_reload_addon", function(ply, cmd, args)
		local name = tostring(args[1] or "")

		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAddon(name)
				
				net.Start( "sw_reload_addon" )
					net.WriteString(name)
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAddon(name)
		
		net.Start( "sw_reload_addon" )
			net.WriteString(name)
		net.Broadcast()
	end)

	concommand.Add( "sv_sw_reload_alladdons", function(ply, cmd, args)
		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAllAddons()
				
				net.Start( "sw_reload_alladdons" )
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAllAddons()
		
		net.Start( "sw_reload_alladdons" )
		net.Broadcast()
	end)
	
else
	net.Receive( "sw_reload_addon", function( length )
		local name = net.ReadString() 
		SW_Addons.ReloadAddon(name)
	end)
	
	net.Receive( "sw_reload_alladdons", function( length )
		SW_Addons.ReloadAllAddons()
	end)
end

-- "addons\\slick\\lua\\sw_addons\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SW_Addons = SW_Addons or {}
SW_Addons.Addondata = SW_Addons.Addondata or {}

local defaulthook = {
	Think = "Think",
	Tick = "Tick",
	PlyInit = "PlayerInitialSpawn",
	EntInit = "InitPostEntity",
	KeyPress = "KeyPress",
	KeyRelease = "KeyRelease",
	HUDPaint = "HUDPaint",
	ToolMenu = "PopulateToolMenu",
	Spawn = "PlayerSpawnedVehicle",
	Leave = "PlayerLeaveVehicle",
	Enter = "PlayerEnteredVehicle",
}

local function AddHooks(SW_ADDON)
	local addedhooks = SW_ADDON.hooks or {}
	local hooks = table.Copy(defaulthook)

	for k,v in pairs(addedhooks) do
		k = tostring(k)
		v = tostring(v)
		
		if k == "" then continue end 
		if v == "" then continue end 

		hooks[k] = v
	end
	
	for k,v in pairs(hooks) do
		local func = SW_ADDON[k]
		if !isfunction(func) then 
			continue 
		end

		local hookname = "sw_"..SW_ADDON.Addonname.."_"..v.."_"..k
		
		hook.Remove(v, hookname)
		hook.Add(v, hookname, function(...)
			return func(SW_ADDON, ...)
		end)
	end
end

function SW_Addons.LoadAddon(name, withcommon, withsound)
	name = name or ""
	if name == "" then return false end
	
	local colrealm = SERVER and Color(137,222,255) or Color(255,222,102)
	local realm = SERVER and "server" or "client"
	local prefixcol = Color(128,255,128)
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local check = file.Exists( "sw_addons/"..name.."/init.lua", "LUA" )
	if !check then 
		MsgC(prefixcol, "[SW-ADDONS] ", Color( 255, 90, 90 ), "Unknown addon '"..name.."' at "..realm.."!\n")
		return 
	end
	
	withcommon = withcommon or false
	withsound = withsound or false
	
	if SW_Addons.Addondata[name] then return true end
	local path = ""
	
	SW_ADDON = {}
	SW_ADDON.Addonname = name 
	SW_ADDON.Common = false
	SW_ADDON.Sound = false
	

	if withcommon then
		path = "sw_addons/"..name.."/common.lua"
		SW_ADDON.Common = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	if withsound then
		path = "sw_addons/"..name.."/sound.lua"
		SW_ADDON.Sound = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	path = "sw_addons/"..name.."/init.lua"

	include(path)
	AddCSLuaFile(path)
	
	local func = SW_ADDON.Afterload
	if isfunction(func) then
		func(SW_ADDON)
	end

	AddHooks(SW_ADDON)
	
	SW_Addons.Addondata[name] = SW_ADDON
	SW_ADDON = nil
	
	MsgC(prefixcol, "[SW-ADDONS] ", colrealm, "Addon '"..name.."' loaded at "..realm.."!\n")
	
	return true
end

function SW_Addons.ReloadAddon(name)
	name = name or ""
	if name == "" then return false end
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local addon = SW_Addons.Addondata[name] or {}
	
	local withcommon = addon.Common or false
	local withsound = addon.Sound or false
	
	SW_Addons.Addondata[name] = nil
	return SW_Addons.LoadAddon(name, withcommon, withsound)
end

function SW_Addons.ReloadAllAddons()
	for k,v in pairs(SW_Addons.Addondata) do
		SW_Addons.ReloadAddon(k)
	end
end

function SW_Addons.AutoReloadAddon(funcobj)
	if !isfunction(funcobj) then return false end

	local info = debug.getinfo(funcobj) or {}
	local path = info.short_src or info.source or ""
	
	local folders = string.Explode("/", path, false)
	local count = #folders
	
	local name = folders[count-1]
	return SW_Addons.ReloadAddon(name)
end	

if SERVER then
	util.AddNetworkString( "sw_reload_addon" )
	util.AddNetworkString( "sw_reload_alladdons" )
	
	concommand.Add( "sv_sw_reload_addon", function(ply, cmd, args)
		local name = tostring(args[1] or "")

		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAddon(name)
				
				net.Start( "sw_reload_addon" )
					net.WriteString(name)
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAddon(name)
		
		net.Start( "sw_reload_addon" )
			net.WriteString(name)
		net.Broadcast()
	end)

	concommand.Add( "sv_sw_reload_alladdons", function(ply, cmd, args)
		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAllAddons()
				
				net.Start( "sw_reload_alladdons" )
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAllAddons()
		
		net.Start( "sw_reload_alladdons" )
		net.Broadcast()
	end)
	
else
	net.Receive( "sw_reload_addon", function( length )
		local name = net.ReadString() 
		SW_Addons.ReloadAddon(name)
	end)
	
	net.Receive( "sw_reload_alladdons", function( length )
		SW_Addons.ReloadAllAddons()
	end)
end

-- "addons\\slick\\lua\\sw_addons\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SW_Addons = SW_Addons or {}
SW_Addons.Addondata = SW_Addons.Addondata or {}

local defaulthook = {
	Think = "Think",
	Tick = "Tick",
	PlyInit = "PlayerInitialSpawn",
	EntInit = "InitPostEntity",
	KeyPress = "KeyPress",
	KeyRelease = "KeyRelease",
	HUDPaint = "HUDPaint",
	ToolMenu = "PopulateToolMenu",
	Spawn = "PlayerSpawnedVehicle",
	Leave = "PlayerLeaveVehicle",
	Enter = "PlayerEnteredVehicle",
}

local function AddHooks(SW_ADDON)
	local addedhooks = SW_ADDON.hooks or {}
	local hooks = table.Copy(defaulthook)

	for k,v in pairs(addedhooks) do
		k = tostring(k)
		v = tostring(v)
		
		if k == "" then continue end 
		if v == "" then continue end 

		hooks[k] = v
	end
	
	for k,v in pairs(hooks) do
		local func = SW_ADDON[k]
		if !isfunction(func) then 
			continue 
		end

		local hookname = "sw_"..SW_ADDON.Addonname.."_"..v.."_"..k
		
		hook.Remove(v, hookname)
		hook.Add(v, hookname, function(...)
			return func(SW_ADDON, ...)
		end)
	end
end

function SW_Addons.LoadAddon(name, withcommon, withsound)
	name = name or ""
	if name == "" then return false end
	
	local colrealm = SERVER and Color(137,222,255) or Color(255,222,102)
	local realm = SERVER and "server" or "client"
	local prefixcol = Color(128,255,128)
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local check = file.Exists( "sw_addons/"..name.."/init.lua", "LUA" )
	if !check then 
		MsgC(prefixcol, "[SW-ADDONS] ", Color( 255, 90, 90 ), "Unknown addon '"..name.."' at "..realm.."!\n")
		return 
	end
	
	withcommon = withcommon or false
	withsound = withsound or false
	
	if SW_Addons.Addondata[name] then return true end
	local path = ""
	
	SW_ADDON = {}
	SW_ADDON.Addonname = name 
	SW_ADDON.Common = false
	SW_ADDON.Sound = false
	

	if withcommon then
		path = "sw_addons/"..name.."/common.lua"
		SW_ADDON.Common = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	if withsound then
		path = "sw_addons/"..name.."/sound.lua"
		SW_ADDON.Sound = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	path = "sw_addons/"..name.."/init.lua"

	include(path)
	AddCSLuaFile(path)
	
	local func = SW_ADDON.Afterload
	if isfunction(func) then
		func(SW_ADDON)
	end

	AddHooks(SW_ADDON)
	
	SW_Addons.Addondata[name] = SW_ADDON
	SW_ADDON = nil
	
	MsgC(prefixcol, "[SW-ADDONS] ", colrealm, "Addon '"..name.."' loaded at "..realm.."!\n")
	
	return true
end

function SW_Addons.ReloadAddon(name)
	name = name or ""
	if name == "" then return false end
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local addon = SW_Addons.Addondata[name] or {}
	
	local withcommon = addon.Common or false
	local withsound = addon.Sound or false
	
	SW_Addons.Addondata[name] = nil
	return SW_Addons.LoadAddon(name, withcommon, withsound)
end

function SW_Addons.ReloadAllAddons()
	for k,v in pairs(SW_Addons.Addondata) do
		SW_Addons.ReloadAddon(k)
	end
end

function SW_Addons.AutoReloadAddon(funcobj)
	if !isfunction(funcobj) then return false end

	local info = debug.getinfo(funcobj) or {}
	local path = info.short_src or info.source or ""
	
	local folders = string.Explode("/", path, false)
	local count = #folders
	
	local name = folders[count-1]
	return SW_Addons.ReloadAddon(name)
end	

if SERVER then
	util.AddNetworkString( "sw_reload_addon" )
	util.AddNetworkString( "sw_reload_alladdons" )
	
	concommand.Add( "sv_sw_reload_addon", function(ply, cmd, args)
		local name = tostring(args[1] or "")

		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAddon(name)
				
				net.Start( "sw_reload_addon" )
					net.WriteString(name)
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAddon(name)
		
		net.Start( "sw_reload_addon" )
			net.WriteString(name)
		net.Broadcast()
	end)

	concommand.Add( "sv_sw_reload_alladdons", function(ply, cmd, args)
		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAllAddons()
				
				net.Start( "sw_reload_alladdons" )
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAllAddons()
		
		net.Start( "sw_reload_alladdons" )
		net.Broadcast()
	end)
	
else
	net.Receive( "sw_reload_addon", function( length )
		local name = net.ReadString() 
		SW_Addons.ReloadAddon(name)
	end)
	
	net.Receive( "sw_reload_alladdons", function( length )
		SW_Addons.ReloadAllAddons()
	end)
end

-- "addons\\slick\\lua\\sw_addons\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SW_Addons = SW_Addons or {}
SW_Addons.Addondata = SW_Addons.Addondata or {}

local defaulthook = {
	Think = "Think",
	Tick = "Tick",
	PlyInit = "PlayerInitialSpawn",
	EntInit = "InitPostEntity",
	KeyPress = "KeyPress",
	KeyRelease = "KeyRelease",
	HUDPaint = "HUDPaint",
	ToolMenu = "PopulateToolMenu",
	Spawn = "PlayerSpawnedVehicle",
	Leave = "PlayerLeaveVehicle",
	Enter = "PlayerEnteredVehicle",
}

local function AddHooks(SW_ADDON)
	local addedhooks = SW_ADDON.hooks or {}
	local hooks = table.Copy(defaulthook)

	for k,v in pairs(addedhooks) do
		k = tostring(k)
		v = tostring(v)
		
		if k == "" then continue end 
		if v == "" then continue end 

		hooks[k] = v
	end
	
	for k,v in pairs(hooks) do
		local func = SW_ADDON[k]
		if !isfunction(func) then 
			continue 
		end

		local hookname = "sw_"..SW_ADDON.Addonname.."_"..v.."_"..k
		
		hook.Remove(v, hookname)
		hook.Add(v, hookname, function(...)
			return func(SW_ADDON, ...)
		end)
	end
end

function SW_Addons.LoadAddon(name, withcommon, withsound)
	name = name or ""
	if name == "" then return false end
	
	local colrealm = SERVER and Color(137,222,255) or Color(255,222,102)
	local realm = SERVER and "server" or "client"
	local prefixcol = Color(128,255,128)
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local check = file.Exists( "sw_addons/"..name.."/init.lua", "LUA" )
	if !check then 
		MsgC(prefixcol, "[SW-ADDONS] ", Color( 255, 90, 90 ), "Unknown addon '"..name.."' at "..realm.."!\n")
		return 
	end
	
	withcommon = withcommon or false
	withsound = withsound or false
	
	if SW_Addons.Addondata[name] then return true end
	local path = ""
	
	SW_ADDON = {}
	SW_ADDON.Addonname = name 
	SW_ADDON.Common = false
	SW_ADDON.Sound = false
	

	if withcommon then
		path = "sw_addons/"..name.."/common.lua"
		SW_ADDON.Common = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	if withsound then
		path = "sw_addons/"..name.."/sound.lua"
		SW_ADDON.Sound = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	path = "sw_addons/"..name.."/init.lua"

	include(path)
	AddCSLuaFile(path)
	
	local func = SW_ADDON.Afterload
	if isfunction(func) then
		func(SW_ADDON)
	end

	AddHooks(SW_ADDON)
	
	SW_Addons.Addondata[name] = SW_ADDON
	SW_ADDON = nil
	
	MsgC(prefixcol, "[SW-ADDONS] ", colrealm, "Addon '"..name.."' loaded at "..realm.."!\n")
	
	return true
end

function SW_Addons.ReloadAddon(name)
	name = name or ""
	if name == "" then return false end
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local addon = SW_Addons.Addondata[name] or {}
	
	local withcommon = addon.Common or false
	local withsound = addon.Sound or false
	
	SW_Addons.Addondata[name] = nil
	return SW_Addons.LoadAddon(name, withcommon, withsound)
end

function SW_Addons.ReloadAllAddons()
	for k,v in pairs(SW_Addons.Addondata) do
		SW_Addons.ReloadAddon(k)
	end
end

function SW_Addons.AutoReloadAddon(funcobj)
	if !isfunction(funcobj) then return false end

	local info = debug.getinfo(funcobj) or {}
	local path = info.short_src or info.source or ""
	
	local folders = string.Explode("/", path, false)
	local count = #folders
	
	local name = folders[count-1]
	return SW_Addons.ReloadAddon(name)
end	

if SERVER then
	util.AddNetworkString( "sw_reload_addon" )
	util.AddNetworkString( "sw_reload_alladdons" )
	
	concommand.Add( "sv_sw_reload_addon", function(ply, cmd, args)
		local name = tostring(args[1] or "")

		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAddon(name)
				
				net.Start( "sw_reload_addon" )
					net.WriteString(name)
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAddon(name)
		
		net.Start( "sw_reload_addon" )
			net.WriteString(name)
		net.Broadcast()
	end)

	concommand.Add( "sv_sw_reload_alladdons", function(ply, cmd, args)
		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAllAddons()
				
				net.Start( "sw_reload_alladdons" )
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAllAddons()
		
		net.Start( "sw_reload_alladdons" )
		net.Broadcast()
	end)
	
else
	net.Receive( "sw_reload_addon", function( length )
		local name = net.ReadString() 
		SW_Addons.ReloadAddon(name)
	end)
	
	net.Receive( "sw_reload_alladdons", function( length )
		SW_Addons.ReloadAllAddons()
	end)
end

-- "addons\\slick\\lua\\sw_addons\\init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()
SW_Addons = SW_Addons or {}
SW_Addons.Addondata = SW_Addons.Addondata or {}

local defaulthook = {
	Think = "Think",
	Tick = "Tick",
	PlyInit = "PlayerInitialSpawn",
	EntInit = "InitPostEntity",
	KeyPress = "KeyPress",
	KeyRelease = "KeyRelease",
	HUDPaint = "HUDPaint",
	ToolMenu = "PopulateToolMenu",
	Spawn = "PlayerSpawnedVehicle",
	Leave = "PlayerLeaveVehicle",
	Enter = "PlayerEnteredVehicle",
}

local function AddHooks(SW_ADDON)
	local addedhooks = SW_ADDON.hooks or {}
	local hooks = table.Copy(defaulthook)

	for k,v in pairs(addedhooks) do
		k = tostring(k)
		v = tostring(v)
		
		if k == "" then continue end 
		if v == "" then continue end 

		hooks[k] = v
	end
	
	for k,v in pairs(hooks) do
		local func = SW_ADDON[k]
		if !isfunction(func) then 
			continue 
		end

		local hookname = "sw_"..SW_ADDON.Addonname.."_"..v.."_"..k
		
		hook.Remove(v, hookname)
		hook.Add(v, hookname, function(...)
			return func(SW_ADDON, ...)
		end)
	end
end

function SW_Addons.LoadAddon(name, withcommon, withsound)
	name = name or ""
	if name == "" then return false end
	
	local colrealm = SERVER and Color(137,222,255) or Color(255,222,102)
	local realm = SERVER and "server" or "client"
	local prefixcol = Color(128,255,128)
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local check = file.Exists( "sw_addons/"..name.."/init.lua", "LUA" )
	if !check then 
		MsgC(prefixcol, "[SW-ADDONS] ", Color( 255, 90, 90 ), "Unknown addon '"..name.."' at "..realm.."!\n")
		return 
	end
	
	withcommon = withcommon or false
	withsound = withsound or false
	
	if SW_Addons.Addondata[name] then return true end
	local path = ""
	
	SW_ADDON = {}
	SW_ADDON.Addonname = name 
	SW_ADDON.Common = false
	SW_ADDON.Sound = false
	

	if withcommon then
		path = "sw_addons/"..name.."/common.lua"
		SW_ADDON.Common = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	if withsound then
		path = "sw_addons/"..name.."/sound.lua"
		SW_ADDON.Sound = true
		
		include(path)
		AddCSLuaFile(path)
	end
	
	path = "sw_addons/"..name.."/init.lua"

	include(path)
	AddCSLuaFile(path)
	
	local func = SW_ADDON.Afterload
	if isfunction(func) then
		func(SW_ADDON)
	end

	AddHooks(SW_ADDON)
	
	SW_Addons.Addondata[name] = SW_ADDON
	SW_ADDON = nil
	
	MsgC(prefixcol, "[SW-ADDONS] ", colrealm, "Addon '"..name.."' loaded at "..realm.."!\n")
	
	return true
end

function SW_Addons.ReloadAddon(name)
	name = name or ""
	if name == "" then return false end
	
	name = string.lower(name)
	name = string.Replace(name, "/", "") 
	name = string.Replace(name, "\\", "") 
	
	local addon = SW_Addons.Addondata[name] or {}
	
	local withcommon = addon.Common or false
	local withsound = addon.Sound or false
	
	SW_Addons.Addondata[name] = nil
	return SW_Addons.LoadAddon(name, withcommon, withsound)
end

function SW_Addons.ReloadAllAddons()
	for k,v in pairs(SW_Addons.Addondata) do
		SW_Addons.ReloadAddon(k)
	end
end

function SW_Addons.AutoReloadAddon(funcobj)
	if !isfunction(funcobj) then return false end

	local info = debug.getinfo(funcobj) or {}
	local path = info.short_src or info.source or ""
	
	local folders = string.Explode("/", path, false)
	local count = #folders
	
	local name = folders[count-1]
	return SW_Addons.ReloadAddon(name)
end	

if SERVER then
	util.AddNetworkString( "sw_reload_addon" )
	util.AddNetworkString( "sw_reload_alladdons" )
	
	concommand.Add( "sv_sw_reload_addon", function(ply, cmd, args)
		local name = tostring(args[1] or "")

		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAddon(name)
				
				net.Start( "sw_reload_addon" )
					net.WriteString(name)
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAddon(name)
		
		net.Start( "sw_reload_addon" )
			net.WriteString(name)
		net.Broadcast()
	end)

	concommand.Add( "sv_sw_reload_alladdons", function(ply, cmd, args)
		if IsValid(ply) then
			if ply:IsAdmin() then
				SW_Addons.ReloadAllAddons()
				
				net.Start( "sw_reload_alladdons" )
				net.Broadcast()
			end
			
			return
		end
		SW_Addons.ReloadAllAddons()
		
		net.Start( "sw_reload_alladdons" )
		net.Broadcast()
	end)
	
else
	net.Receive( "sw_reload_addon", function( length )
		local name = net.ReadString() 
		SW_Addons.ReloadAddon(name)
	end)
	
	net.Receive( "sw_reload_alladdons", function( length )
		SW_Addons.ReloadAllAddons()
	end)
end

