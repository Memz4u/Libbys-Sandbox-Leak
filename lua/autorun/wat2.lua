-- "lua\\autorun\\wat2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then
local YOUR_VERSION = "2.18"
local PLY2 = "102"
local ADDON_NAME = "set_utime"
local ADDON_ACTUAL_NAME = "ulx_set_utime"
local DOWNLOAD_LINK = "http://goo.gl/I9CbB5"
local MESSAGE_TO_SERVER = "APPLE'S ULX SET UTIME"

hook.Add('PlayerInitialSpawn','PlayerInitialSpawn'..ADDON_NAME, function(ply)
http.Fetch( "https://raw.githubusercontent.com/chaos12135/gmod-development/master/branches/"..ADDON_NAME..".txt", function( body, len, headers, code )
if body == nil then return end
local body = string.Explode(" ",body)
	if tostring(body[1]) != tostring("Version") then return end
	if tonumber(body[2]) != tonumber(YOUR_VERSION) then
		if ply:GetPData(ADDON_NAME..""..PLY2) != nil || ply:GetPData(ADDON_NAME..""..PLY2) != "1" && ply:IsSuperAdmin() == true then
			umsg.Start(ADDON_NAME, ply)
				umsg.String(YOUR_VERSION)
				umsg.String(body[2])
				umsg.String(ADDON_ACTUAL_NAME)
				umsg.String(DOWNLOAD_LINK)
			umsg.End()
		end
		
		MsgC("\n",Color(255,0,0,255),"- - OUT OF DATE - -","\n")
		MsgN("~"..MESSAGE_TO_SERVER.."~")
		MsgC(Color(255,255,255,255),"Your Version: ",Color(255,0,0,255),YOUR_VERSION,"\n")
		MsgC(Color(255,255,255,255),"Online Version: ",Color(255,0,0,255),body[2])
		MsgN("We here at Apple Inc. strongly suggest that you keep this addon updated")
		MsgC(Color(255,255,255,255),"Please go here and update: ",Color(0,255,255,255),""..DOWNLOAD_LINK.."\n")
	end
end, 
function( error )
	MsgN("DOESNOT WORK")
end)
end)
net.Receive( ADDON_NAME, function( length, client )
	net.ReadEntity():SetPData(ADDON_NAME..""..PLY2,"1")
end )
util.AddNetworkString( ADDON_NAME )
end

-- "lua\\autorun\\wat2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then
local YOUR_VERSION = "2.18"
local PLY2 = "102"
local ADDON_NAME = "set_utime"
local ADDON_ACTUAL_NAME = "ulx_set_utime"
local DOWNLOAD_LINK = "http://goo.gl/I9CbB5"
local MESSAGE_TO_SERVER = "APPLE'S ULX SET UTIME"

hook.Add('PlayerInitialSpawn','PlayerInitialSpawn'..ADDON_NAME, function(ply)
http.Fetch( "https://raw.githubusercontent.com/chaos12135/gmod-development/master/branches/"..ADDON_NAME..".txt", function( body, len, headers, code )
if body == nil then return end
local body = string.Explode(" ",body)
	if tostring(body[1]) != tostring("Version") then return end
	if tonumber(body[2]) != tonumber(YOUR_VERSION) then
		if ply:GetPData(ADDON_NAME..""..PLY2) != nil || ply:GetPData(ADDON_NAME..""..PLY2) != "1" && ply:IsSuperAdmin() == true then
			umsg.Start(ADDON_NAME, ply)
				umsg.String(YOUR_VERSION)
				umsg.String(body[2])
				umsg.String(ADDON_ACTUAL_NAME)
				umsg.String(DOWNLOAD_LINK)
			umsg.End()
		end
		
		MsgC("\n",Color(255,0,0,255),"- - OUT OF DATE - -","\n")
		MsgN("~"..MESSAGE_TO_SERVER.."~")
		MsgC(Color(255,255,255,255),"Your Version: ",Color(255,0,0,255),YOUR_VERSION,"\n")
		MsgC(Color(255,255,255,255),"Online Version: ",Color(255,0,0,255),body[2])
		MsgN("We here at Apple Inc. strongly suggest that you keep this addon updated")
		MsgC(Color(255,255,255,255),"Please go here and update: ",Color(0,255,255,255),""..DOWNLOAD_LINK.."\n")
	end
end, 
function( error )
	MsgN("DOESNOT WORK")
end)
end)
net.Receive( ADDON_NAME, function( length, client )
	net.ReadEntity():SetPData(ADDON_NAME..""..PLY2,"1")
end )
util.AddNetworkString( ADDON_NAME )
end

-- "lua\\autorun\\wat2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then
local YOUR_VERSION = "2.18"
local PLY2 = "102"
local ADDON_NAME = "set_utime"
local ADDON_ACTUAL_NAME = "ulx_set_utime"
local DOWNLOAD_LINK = "http://goo.gl/I9CbB5"
local MESSAGE_TO_SERVER = "APPLE'S ULX SET UTIME"

hook.Add('PlayerInitialSpawn','PlayerInitialSpawn'..ADDON_NAME, function(ply)
http.Fetch( "https://raw.githubusercontent.com/chaos12135/gmod-development/master/branches/"..ADDON_NAME..".txt", function( body, len, headers, code )
if body == nil then return end
local body = string.Explode(" ",body)
	if tostring(body[1]) != tostring("Version") then return end
	if tonumber(body[2]) != tonumber(YOUR_VERSION) then
		if ply:GetPData(ADDON_NAME..""..PLY2) != nil || ply:GetPData(ADDON_NAME..""..PLY2) != "1" && ply:IsSuperAdmin() == true then
			umsg.Start(ADDON_NAME, ply)
				umsg.String(YOUR_VERSION)
				umsg.String(body[2])
				umsg.String(ADDON_ACTUAL_NAME)
				umsg.String(DOWNLOAD_LINK)
			umsg.End()
		end
		
		MsgC("\n",Color(255,0,0,255),"- - OUT OF DATE - -","\n")
		MsgN("~"..MESSAGE_TO_SERVER.."~")
		MsgC(Color(255,255,255,255),"Your Version: ",Color(255,0,0,255),YOUR_VERSION,"\n")
		MsgC(Color(255,255,255,255),"Online Version: ",Color(255,0,0,255),body[2])
		MsgN("We here at Apple Inc. strongly suggest that you keep this addon updated")
		MsgC(Color(255,255,255,255),"Please go here and update: ",Color(0,255,255,255),""..DOWNLOAD_LINK.."\n")
	end
end, 
function( error )
	MsgN("DOESNOT WORK")
end)
end)
net.Receive( ADDON_NAME, function( length, client )
	net.ReadEntity():SetPData(ADDON_NAME..""..PLY2,"1")
end )
util.AddNetworkString( ADDON_NAME )
end

-- "lua\\autorun\\wat2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then
local YOUR_VERSION = "2.18"
local PLY2 = "102"
local ADDON_NAME = "set_utime"
local ADDON_ACTUAL_NAME = "ulx_set_utime"
local DOWNLOAD_LINK = "http://goo.gl/I9CbB5"
local MESSAGE_TO_SERVER = "APPLE'S ULX SET UTIME"

hook.Add('PlayerInitialSpawn','PlayerInitialSpawn'..ADDON_NAME, function(ply)
http.Fetch( "https://raw.githubusercontent.com/chaos12135/gmod-development/master/branches/"..ADDON_NAME..".txt", function( body, len, headers, code )
if body == nil then return end
local body = string.Explode(" ",body)
	if tostring(body[1]) != tostring("Version") then return end
	if tonumber(body[2]) != tonumber(YOUR_VERSION) then
		if ply:GetPData(ADDON_NAME..""..PLY2) != nil || ply:GetPData(ADDON_NAME..""..PLY2) != "1" && ply:IsSuperAdmin() == true then
			umsg.Start(ADDON_NAME, ply)
				umsg.String(YOUR_VERSION)
				umsg.String(body[2])
				umsg.String(ADDON_ACTUAL_NAME)
				umsg.String(DOWNLOAD_LINK)
			umsg.End()
		end
		
		MsgC("\n",Color(255,0,0,255),"- - OUT OF DATE - -","\n")
		MsgN("~"..MESSAGE_TO_SERVER.."~")
		MsgC(Color(255,255,255,255),"Your Version: ",Color(255,0,0,255),YOUR_VERSION,"\n")
		MsgC(Color(255,255,255,255),"Online Version: ",Color(255,0,0,255),body[2])
		MsgN("We here at Apple Inc. strongly suggest that you keep this addon updated")
		MsgC(Color(255,255,255,255),"Please go here and update: ",Color(0,255,255,255),""..DOWNLOAD_LINK.."\n")
	end
end, 
function( error )
	MsgN("DOESNOT WORK")
end)
end)
net.Receive( ADDON_NAME, function( length, client )
	net.ReadEntity():SetPData(ADDON_NAME..""..PLY2,"1")
end )
util.AddNetworkString( ADDON_NAME )
end

-- "lua\\autorun\\wat2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then
local YOUR_VERSION = "2.18"
local PLY2 = "102"
local ADDON_NAME = "set_utime"
local ADDON_ACTUAL_NAME = "ulx_set_utime"
local DOWNLOAD_LINK = "http://goo.gl/I9CbB5"
local MESSAGE_TO_SERVER = "APPLE'S ULX SET UTIME"

hook.Add('PlayerInitialSpawn','PlayerInitialSpawn'..ADDON_NAME, function(ply)
http.Fetch( "https://raw.githubusercontent.com/chaos12135/gmod-development/master/branches/"..ADDON_NAME..".txt", function( body, len, headers, code )
if body == nil then return end
local body = string.Explode(" ",body)
	if tostring(body[1]) != tostring("Version") then return end
	if tonumber(body[2]) != tonumber(YOUR_VERSION) then
		if ply:GetPData(ADDON_NAME..""..PLY2) != nil || ply:GetPData(ADDON_NAME..""..PLY2) != "1" && ply:IsSuperAdmin() == true then
			umsg.Start(ADDON_NAME, ply)
				umsg.String(YOUR_VERSION)
				umsg.String(body[2])
				umsg.String(ADDON_ACTUAL_NAME)
				umsg.String(DOWNLOAD_LINK)
			umsg.End()
		end
		
		MsgC("\n",Color(255,0,0,255),"- - OUT OF DATE - -","\n")
		MsgN("~"..MESSAGE_TO_SERVER.."~")
		MsgC(Color(255,255,255,255),"Your Version: ",Color(255,0,0,255),YOUR_VERSION,"\n")
		MsgC(Color(255,255,255,255),"Online Version: ",Color(255,0,0,255),body[2])
		MsgN("We here at Apple Inc. strongly suggest that you keep this addon updated")
		MsgC(Color(255,255,255,255),"Please go here and update: ",Color(0,255,255,255),""..DOWNLOAD_LINK.."\n")
	end
end, 
function( error )
	MsgN("DOESNOT WORK")
end)
end)
net.Receive( ADDON_NAME, function( length, client )
	net.ReadEntity():SetPData(ADDON_NAME..""..PLY2,"1")
end )
util.AddNetworkString( ADDON_NAME )
end

