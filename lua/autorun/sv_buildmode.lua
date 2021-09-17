-- "lua\\autorun\\sv_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
----[[-----------------------
--        Custom Build Mode
--			Recoded by Rainbow
--				Version 1.0
--
--
--    Feel free to use or edit this script.
-----------]]-----------------
if not SERVER then return end
AddCSLuaFile( "autorun/cl_buildmode.lua" )
util.AddNetworkString("PlayerJoin")
util.AddNetworkString("RightBackAtYou")
util.AddNetworkString("InitBuild")
util.AddNetworkString("InitPVP")
net.Receive("PlayerJoin", function(len,ply)
	net.Start("RightBackAtYou")
	net.Send(ply)
end)


local function bm_build(ply)
	if ply:GetNWBool("BuildMode",nil) == true then
		ply:ChatPrint( "You are already in build mode! Type !pvp to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == false then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",true)
		ply:ChatPrint( "Build mode enabled! Type !pvp to leave." )
		
	end
end

local function bm_pvp(ply)
	if ply:GetNWBool("BuildMode",nil) == false then
		ply:ChatPrint( "You are already in PVP mode! Type !build to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == true then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",false)
		ply:ChatPrint( "PVP mode enabled! Type !build to leave." )

	end
end
net.Receive("InitPVP", function(len,ply)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (PVP MODE) has started playing!")
	end
	bm_pvp(ply)
end)
net.Receive("InitBuild", function(len,ply)		
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (BUILD MODE) has started playing!")
	end
	bm_build(ply)
end)

------
hook.Add( "PlayerSay", "sbox_buildmode_chat", function( ply, text )
	if string.lower(text) == "!build" then
		bm_build(ply)
		return ""
	elseif string.lower(text) == "!pvp" then
		bm_pvp(ply)
		return ""
	end
end )

hook.Add("PlayerShouldTakeDamage", "sbox_buildmode_dmg", function ( ply, attacker )
	if ply:GetNWBool("BuildMode",nil) then
		return false
	elseif attacker:GetNWBool("BuildMode",nil) then
		return false
	else
		return true
	end
end)
hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
	if ( desiredState == false ) then
		return true 
	elseif (ply:GetNWBool("BuildMode",nil)) then
		return true
	else
		ply:ChatPrint("You are in PVP mode, you cannot noclip! Type !build to switch to build mode.")
		return false
	end
end )

-- "lua\\autorun\\sv_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
----[[-----------------------
--        Custom Build Mode
--			Recoded by Rainbow
--				Version 1.0
--
--
--    Feel free to use or edit this script.
-----------]]-----------------
if not SERVER then return end
AddCSLuaFile( "autorun/cl_buildmode.lua" )
util.AddNetworkString("PlayerJoin")
util.AddNetworkString("RightBackAtYou")
util.AddNetworkString("InitBuild")
util.AddNetworkString("InitPVP")
net.Receive("PlayerJoin", function(len,ply)
	net.Start("RightBackAtYou")
	net.Send(ply)
end)


local function bm_build(ply)
	if ply:GetNWBool("BuildMode",nil) == true then
		ply:ChatPrint( "You are already in build mode! Type !pvp to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == false then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",true)
		ply:ChatPrint( "Build mode enabled! Type !pvp to leave." )
		
	end
end

local function bm_pvp(ply)
	if ply:GetNWBool("BuildMode",nil) == false then
		ply:ChatPrint( "You are already in PVP mode! Type !build to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == true then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",false)
		ply:ChatPrint( "PVP mode enabled! Type !build to leave." )

	end
end
net.Receive("InitPVP", function(len,ply)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (PVP MODE) has started playing!")
	end
	bm_pvp(ply)
end)
net.Receive("InitBuild", function(len,ply)		
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (BUILD MODE) has started playing!")
	end
	bm_build(ply)
end)

------
hook.Add( "PlayerSay", "sbox_buildmode_chat", function( ply, text )
	if string.lower(text) == "!build" then
		bm_build(ply)
		return ""
	elseif string.lower(text) == "!pvp" then
		bm_pvp(ply)
		return ""
	end
end )

hook.Add("PlayerShouldTakeDamage", "sbox_buildmode_dmg", function ( ply, attacker )
	if ply:GetNWBool("BuildMode",nil) then
		return false
	elseif attacker:GetNWBool("BuildMode",nil) then
		return false
	else
		return true
	end
end)
hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
	if ( desiredState == false ) then
		return true 
	elseif (ply:GetNWBool("BuildMode",nil)) then
		return true
	else
		ply:ChatPrint("You are in PVP mode, you cannot noclip! Type !build to switch to build mode.")
		return false
	end
end )

-- "lua\\autorun\\sv_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
----[[-----------------------
--        Custom Build Mode
--			Recoded by Rainbow
--				Version 1.0
--
--
--    Feel free to use or edit this script.
-----------]]-----------------
if not SERVER then return end
AddCSLuaFile( "autorun/cl_buildmode.lua" )
util.AddNetworkString("PlayerJoin")
util.AddNetworkString("RightBackAtYou")
util.AddNetworkString("InitBuild")
util.AddNetworkString("InitPVP")
net.Receive("PlayerJoin", function(len,ply)
	net.Start("RightBackAtYou")
	net.Send(ply)
end)


local function bm_build(ply)
	if ply:GetNWBool("BuildMode",nil) == true then
		ply:ChatPrint( "You are already in build mode! Type !pvp to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == false then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",true)
		ply:ChatPrint( "Build mode enabled! Type !pvp to leave." )
		
	end
end

local function bm_pvp(ply)
	if ply:GetNWBool("BuildMode",nil) == false then
		ply:ChatPrint( "You are already in PVP mode! Type !build to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == true then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",false)
		ply:ChatPrint( "PVP mode enabled! Type !build to leave." )

	end
end
net.Receive("InitPVP", function(len,ply)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (PVP MODE) has started playing!")
	end
	bm_pvp(ply)
end)
net.Receive("InitBuild", function(len,ply)		
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (BUILD MODE) has started playing!")
	end
	bm_build(ply)
end)

------
hook.Add( "PlayerSay", "sbox_buildmode_chat", function( ply, text )
	if string.lower(text) == "!build" then
		bm_build(ply)
		return ""
	elseif string.lower(text) == "!pvp" then
		bm_pvp(ply)
		return ""
	end
end )

hook.Add("PlayerShouldTakeDamage", "sbox_buildmode_dmg", function ( ply, attacker )
	if ply:GetNWBool("BuildMode",nil) then
		return false
	elseif attacker:GetNWBool("BuildMode",nil) then
		return false
	else
		return true
	end
end)
hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
	if ( desiredState == false ) then
		return true 
	elseif (ply:GetNWBool("BuildMode",nil)) then
		return true
	else
		ply:ChatPrint("You are in PVP mode, you cannot noclip! Type !build to switch to build mode.")
		return false
	end
end )

-- "lua\\autorun\\sv_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
----[[-----------------------
--        Custom Build Mode
--			Recoded by Rainbow
--				Version 1.0
--
--
--    Feel free to use or edit this script.
-----------]]-----------------
if not SERVER then return end
AddCSLuaFile( "autorun/cl_buildmode.lua" )
util.AddNetworkString("PlayerJoin")
util.AddNetworkString("RightBackAtYou")
util.AddNetworkString("InitBuild")
util.AddNetworkString("InitPVP")
net.Receive("PlayerJoin", function(len,ply)
	net.Start("RightBackAtYou")
	net.Send(ply)
end)


local function bm_build(ply)
	if ply:GetNWBool("BuildMode",nil) == true then
		ply:ChatPrint( "You are already in build mode! Type !pvp to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == false then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",true)
		ply:ChatPrint( "Build mode enabled! Type !pvp to leave." )
		
	end
end

local function bm_pvp(ply)
	if ply:GetNWBool("BuildMode",nil) == false then
		ply:ChatPrint( "You are already in PVP mode! Type !build to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == true then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",false)
		ply:ChatPrint( "PVP mode enabled! Type !build to leave." )

	end
end
net.Receive("InitPVP", function(len,ply)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (PVP MODE) has started playing!")
	end
	bm_pvp(ply)
end)
net.Receive("InitBuild", function(len,ply)		
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (BUILD MODE) has started playing!")
	end
	bm_build(ply)
end)

------
hook.Add( "PlayerSay", "sbox_buildmode_chat", function( ply, text )
	if string.lower(text) == "!build" then
		bm_build(ply)
		return ""
	elseif string.lower(text) == "!pvp" then
		bm_pvp(ply)
		return ""
	end
end )

hook.Add("PlayerShouldTakeDamage", "sbox_buildmode_dmg", function ( ply, attacker )
	if ply:GetNWBool("BuildMode",nil) then
		return false
	elseif attacker:GetNWBool("BuildMode",nil) then
		return false
	else
		return true
	end
end)
hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
	if ( desiredState == false ) then
		return true 
	elseif (ply:GetNWBool("BuildMode",nil)) then
		return true
	else
		ply:ChatPrint("You are in PVP mode, you cannot noclip! Type !build to switch to build mode.")
		return false
	end
end )

-- "lua\\autorun\\sv_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
----[[-----------------------
--        Custom Build Mode
--			Recoded by Rainbow
--				Version 1.0
--
--
--    Feel free to use or edit this script.
-----------]]-----------------
if not SERVER then return end
AddCSLuaFile( "autorun/cl_buildmode.lua" )
util.AddNetworkString("PlayerJoin")
util.AddNetworkString("RightBackAtYou")
util.AddNetworkString("InitBuild")
util.AddNetworkString("InitPVP")
net.Receive("PlayerJoin", function(len,ply)
	net.Start("RightBackAtYou")
	net.Send(ply)
end)


local function bm_build(ply)
	if ply:GetNWBool("BuildMode",nil) == true then
		ply:ChatPrint( "You are already in build mode! Type !pvp to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == false then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",true)
		ply:ChatPrint( "Build mode enabled! Type !pvp to leave." )
		
	end
end

local function bm_pvp(ply)
	if ply:GetNWBool("BuildMode",nil) == false then
		ply:ChatPrint( "You are already in PVP mode! Type !build to leave." )
	else
		if ply:GetNWBool("BuildMode",nil) == true then
			ply:Kill()
		end
		ply:SetNWBool("BuildMode",false)
		ply:ChatPrint( "PVP mode enabled! Type !build to leave." )

	end
end
net.Receive("InitPVP", function(len,ply)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (PVP MODE) has started playing!")
	end
	bm_pvp(ply)
end)
net.Receive("InitBuild", function(len,ply)		
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint( ply:Name() .. " (BUILD MODE) has started playing!")
	end
	bm_build(ply)
end)

------
hook.Add( "PlayerSay", "sbox_buildmode_chat", function( ply, text )
	if string.lower(text) == "!build" then
		bm_build(ply)
		return ""
	elseif string.lower(text) == "!pvp" then
		bm_pvp(ply)
		return ""
	end
end )

hook.Add("PlayerShouldTakeDamage", "sbox_buildmode_dmg", function ( ply, attacker )
	if ply:GetNWBool("BuildMode",nil) then
		return false
	elseif attacker:GetNWBool("BuildMode",nil) then
		return false
	else
		return true
	end
end)
hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
	if ( desiredState == false ) then
		return true 
	elseif (ply:GetNWBool("BuildMode",nil)) then
		return true
	else
		ply:ChatPrint("You are in PVP mode, you cannot noclip! Type !build to switch to build mode.")
		return false
	end
end )

