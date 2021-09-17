-- "addons\\deathzone\\lua\\cl_data.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
net.Receive( "PK_PlayerData", function()
	local tbl = net.ReadTable()
	if( table.Count( tbl ) == 0 ) then return end

	for k,v in pairs( tbl ) do
		k.pkdata = v
	end
end )

hook.Add( "InitPostEntity", "PK_RequestData", function()
	net.Start( "PK_RequestData" )
	net.SendToServer()
end )

-- "addons\\deathzone\\lua\\cl_data.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
net.Receive( "PK_PlayerData", function()
	local tbl = net.ReadTable()
	if( table.Count( tbl ) == 0 ) then return end

	for k,v in pairs( tbl ) do
		k.pkdata = v
	end
end )

hook.Add( "InitPostEntity", "PK_RequestData", function()
	net.Start( "PK_RequestData" )
	net.SendToServer()
end )

-- "addons\\deathzone\\lua\\cl_data.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
net.Receive( "PK_PlayerData", function()
	local tbl = net.ReadTable()
	if( table.Count( tbl ) == 0 ) then return end

	for k,v in pairs( tbl ) do
		k.pkdata = v
	end
end )

hook.Add( "InitPostEntity", "PK_RequestData", function()
	net.Start( "PK_RequestData" )
	net.SendToServer()
end )

-- "addons\\deathzone\\lua\\cl_data.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
net.Receive( "PK_PlayerData", function()
	local tbl = net.ReadTable()
	if( table.Count( tbl ) == 0 ) then return end

	for k,v in pairs( tbl ) do
		k.pkdata = v
	end
end )

hook.Add( "InitPostEntity", "PK_RequestData", function()
	net.Start( "PK_RequestData" )
	net.SendToServer()
end )

-- "addons\\deathzone\\lua\\cl_data.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
net.Receive( "PK_PlayerData", function()
	local tbl = net.ReadTable()
	if( table.Count( tbl ) == 0 ) then return end

	for k,v in pairs( tbl ) do
		k.pkdata = v
	end
end )

hook.Add( "InitPostEntity", "PK_RequestData", function()
	net.Start( "PK_RequestData" )
	net.SendToServer()
end )

