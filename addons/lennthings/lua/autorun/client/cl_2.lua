-- "addons\\lennthings\\lua\\autorun\\client\\cl_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
------------Beginning of following------------
local function ClientFollowPlayer( ply, cmd, args )
	local nick = args[1]
	nick = string.lower( nick )

	for k, v in pairs(player.GetAll()) do
		if string.find( string.lower( v:Nick() ), nick ) then
			MsgN( "Following: " .. v:Name() )
			hook.Add("Think", "fsdgadsfea", function()
				local pos = v:GetPos()
				local lookAngle = ply:GetShootPos()
				if pos ~= lookAngle then
					ply:SetEyeAngles((pos - lookAngle + Vector(0, 0, 70)):Angle())
				end
			end)
			LocalPlayer():ConCommand("+speed")
			LocalPlayer():ConCommand("say", "FCK U nomsayin")
		end
	end

	MsgN( "Couldn't find player" )
end

local function AutoComplete( cmd, stringargs )
	print( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}


	for k, v in pairs( player.GetAll() ) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			nick = "\"" .. nick .. "\""
			nick = "FS_Followplayer " .. nick

			table.insert( tbl, nick )
		end
	end

	return tbl
end
concommand.Add("FS_Followplayer", ClientFollowPlayer, AutoComplete)

function StopFollowing()
	hook.Remove("Think", "fsdgadsfea")
	LocalPlayer():ConCommand("-forward")
	LocalPlayer():ConCommand('-speed')
	LocalPlayer():ConCommand('-right')
	LocalPlayer():ConCommand('-moveright')
end
concommand.Add("FS_Stopfollowing", StopFollowing)
-----------------End of Following-----------------

-- "addons\\lennthings\\lua\\autorun\\client\\cl_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
------------Beginning of following------------
local function ClientFollowPlayer( ply, cmd, args )
	local nick = args[1]
	nick = string.lower( nick )

	for k, v in pairs(player.GetAll()) do
		if string.find( string.lower( v:Nick() ), nick ) then
			MsgN( "Following: " .. v:Name() )
			hook.Add("Think", "fsdgadsfea", function()
				local pos = v:GetPos()
				local lookAngle = ply:GetShootPos()
				if pos ~= lookAngle then
					ply:SetEyeAngles((pos - lookAngle + Vector(0, 0, 70)):Angle())
				end
			end)
			LocalPlayer():ConCommand("+speed")
			LocalPlayer():ConCommand("say", "FCK U nomsayin")
		end
	end

	MsgN( "Couldn't find player" )
end

local function AutoComplete( cmd, stringargs )
	print( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}


	for k, v in pairs( player.GetAll() ) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			nick = "\"" .. nick .. "\""
			nick = "FS_Followplayer " .. nick

			table.insert( tbl, nick )
		end
	end

	return tbl
end
concommand.Add("FS_Followplayer", ClientFollowPlayer, AutoComplete)

function StopFollowing()
	hook.Remove("Think", "fsdgadsfea")
	LocalPlayer():ConCommand("-forward")
	LocalPlayer():ConCommand('-speed')
	LocalPlayer():ConCommand('-right')
	LocalPlayer():ConCommand('-moveright')
end
concommand.Add("FS_Stopfollowing", StopFollowing)
-----------------End of Following-----------------

-- "addons\\lennthings\\lua\\autorun\\client\\cl_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
------------Beginning of following------------
local function ClientFollowPlayer( ply, cmd, args )
	local nick = args[1]
	nick = string.lower( nick )

	for k, v in pairs(player.GetAll()) do
		if string.find( string.lower( v:Nick() ), nick ) then
			MsgN( "Following: " .. v:Name() )
			hook.Add("Think", "fsdgadsfea", function()
				local pos = v:GetPos()
				local lookAngle = ply:GetShootPos()
				if pos ~= lookAngle then
					ply:SetEyeAngles((pos - lookAngle + Vector(0, 0, 70)):Angle())
				end
			end)
			LocalPlayer():ConCommand("+speed")
			LocalPlayer():ConCommand("say", "FCK U nomsayin")
		end
	end

	MsgN( "Couldn't find player" )
end

local function AutoComplete( cmd, stringargs )
	print( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}


	for k, v in pairs( player.GetAll() ) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			nick = "\"" .. nick .. "\""
			nick = "FS_Followplayer " .. nick

			table.insert( tbl, nick )
		end
	end

	return tbl
end
concommand.Add("FS_Followplayer", ClientFollowPlayer, AutoComplete)

function StopFollowing()
	hook.Remove("Think", "fsdgadsfea")
	LocalPlayer():ConCommand("-forward")
	LocalPlayer():ConCommand('-speed')
	LocalPlayer():ConCommand('-right')
	LocalPlayer():ConCommand('-moveright')
end
concommand.Add("FS_Stopfollowing", StopFollowing)
-----------------End of Following-----------------

-- "addons\\lennthings\\lua\\autorun\\client\\cl_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
------------Beginning of following------------
local function ClientFollowPlayer( ply, cmd, args )
	local nick = args[1]
	nick = string.lower( nick )

	for k, v in pairs(player.GetAll()) do
		if string.find( string.lower( v:Nick() ), nick ) then
			MsgN( "Following: " .. v:Name() )
			hook.Add("Think", "fsdgadsfea", function()
				local pos = v:GetPos()
				local lookAngle = ply:GetShootPos()
				if pos ~= lookAngle then
					ply:SetEyeAngles((pos - lookAngle + Vector(0, 0, 70)):Angle())
				end
			end)
			LocalPlayer():ConCommand("+speed")
			LocalPlayer():ConCommand("say", "FCK U nomsayin")
		end
	end

	MsgN( "Couldn't find player" )
end

local function AutoComplete( cmd, stringargs )
	print( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}


	for k, v in pairs( player.GetAll() ) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			nick = "\"" .. nick .. "\""
			nick = "FS_Followplayer " .. nick

			table.insert( tbl, nick )
		end
	end

	return tbl
end
concommand.Add("FS_Followplayer", ClientFollowPlayer, AutoComplete)

function StopFollowing()
	hook.Remove("Think", "fsdgadsfea")
	LocalPlayer():ConCommand("-forward")
	LocalPlayer():ConCommand('-speed')
	LocalPlayer():ConCommand('-right')
	LocalPlayer():ConCommand('-moveright')
end
concommand.Add("FS_Stopfollowing", StopFollowing)
-----------------End of Following-----------------

-- "addons\\lennthings\\lua\\autorun\\client\\cl_2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
------------Beginning of following------------
local function ClientFollowPlayer( ply, cmd, args )
	local nick = args[1]
	nick = string.lower( nick )

	for k, v in pairs(player.GetAll()) do
		if string.find( string.lower( v:Nick() ), nick ) then
			MsgN( "Following: " .. v:Name() )
			hook.Add("Think", "fsdgadsfea", function()
				local pos = v:GetPos()
				local lookAngle = ply:GetShootPos()
				if pos ~= lookAngle then
					ply:SetEyeAngles((pos - lookAngle + Vector(0, 0, 70)):Angle())
				end
			end)
			LocalPlayer():ConCommand("+speed")
			LocalPlayer():ConCommand("say", "FCK U nomsayin")
		end
	end

	MsgN( "Couldn't find player" )
end

local function AutoComplete( cmd, stringargs )
	print( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}


	for k, v in pairs( player.GetAll() ) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			nick = "\"" .. nick .. "\""
			nick = "FS_Followplayer " .. nick

			table.insert( tbl, nick )
		end
	end

	return tbl
end
concommand.Add("FS_Followplayer", ClientFollowPlayer, AutoComplete)

function StopFollowing()
	hook.Remove("Think", "fsdgadsfea")
	LocalPlayer():ConCommand("-forward")
	LocalPlayer():ConCommand('-speed')
	LocalPlayer():ConCommand('-right')
	LocalPlayer():ConCommand('-moveright')
end
concommand.Add("FS_Stopfollowing", StopFollowing)
-----------------End of Following-----------------

