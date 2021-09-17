-- "addons\\atags\\lua\\atags\\sh_permissions.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function ATAG:HasPermissions( ply )

	if not IsValid( ply ) then return false end
	
	if not evolve and table.HasValue( ATAG.adminPanel_Access, ply:GetUserGroup() ) then
		return true
	end

	if ULib then
		
		if ply:query( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if evolve then
	
		if table.HasValue( ATAG.adminPanel_Access, ply:EV_GetRank() ) then
			return true
		end
		
		if ply:EV_HasPrivilege( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if serverguard then

		if serverguard.player and serverguard.player:HasPermission( ply, "aTags Admin Panel" ) then
			return true
		end
		
	end
	
	return false
end

hook.Add( "Initialize", "aTags - Permissions - Initialize", function()
	if serverguard and serverguard.permission then
		serverguard.permission:Add( "aTags Admin Panel" )
	end
end)

-- "addons\\atags\\lua\\atags\\sh_permissions.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function ATAG:HasPermissions( ply )

	if not IsValid( ply ) then return false end
	
	if not evolve and table.HasValue( ATAG.adminPanel_Access, ply:GetUserGroup() ) then
		return true
	end

	if ULib then
		
		if ply:query( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if evolve then
	
		if table.HasValue( ATAG.adminPanel_Access, ply:EV_GetRank() ) then
			return true
		end
		
		if ply:EV_HasPrivilege( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if serverguard then

		if serverguard.player and serverguard.player:HasPermission( ply, "aTags Admin Panel" ) then
			return true
		end
		
	end
	
	return false
end

hook.Add( "Initialize", "aTags - Permissions - Initialize", function()
	if serverguard and serverguard.permission then
		serverguard.permission:Add( "aTags Admin Panel" )
	end
end)

-- "addons\\atags\\lua\\atags\\sh_permissions.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function ATAG:HasPermissions( ply )

	if not IsValid( ply ) then return false end
	
	if not evolve and table.HasValue( ATAG.adminPanel_Access, ply:GetUserGroup() ) then
		return true
	end

	if ULib then
		
		if ply:query( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if evolve then
	
		if table.HasValue( ATAG.adminPanel_Access, ply:EV_GetRank() ) then
			return true
		end
		
		if ply:EV_HasPrivilege( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if serverguard then

		if serverguard.player and serverguard.player:HasPermission( ply, "aTags Admin Panel" ) then
			return true
		end
		
	end
	
	return false
end

hook.Add( "Initialize", "aTags - Permissions - Initialize", function()
	if serverguard and serverguard.permission then
		serverguard.permission:Add( "aTags Admin Panel" )
	end
end)

-- "addons\\atags\\lua\\atags\\sh_permissions.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function ATAG:HasPermissions( ply )

	if not IsValid( ply ) then return false end
	
	if not evolve and table.HasValue( ATAG.adminPanel_Access, ply:GetUserGroup() ) then
		return true
	end

	if ULib then
		
		if ply:query( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if evolve then
	
		if table.HasValue( ATAG.adminPanel_Access, ply:EV_GetRank() ) then
			return true
		end
		
		if ply:EV_HasPrivilege( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if serverguard then

		if serverguard.player and serverguard.player:HasPermission( ply, "aTags Admin Panel" ) then
			return true
		end
		
	end
	
	return false
end

hook.Add( "Initialize", "aTags - Permissions - Initialize", function()
	if serverguard and serverguard.permission then
		serverguard.permission:Add( "aTags Admin Panel" )
	end
end)

-- "addons\\atags\\lua\\atags\\sh_permissions.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function ATAG:HasPermissions( ply )

	if not IsValid( ply ) then return false end
	
	if not evolve and table.HasValue( ATAG.adminPanel_Access, ply:GetUserGroup() ) then
		return true
	end

	if ULib then
		
		if ply:query( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if evolve then
	
		if table.HasValue( ATAG.adminPanel_Access, ply:EV_GetRank() ) then
			return true
		end
		
		if ply:EV_HasPrivilege( "atags adminpanel" ) then
			return true
		end
		
	end
	
	if serverguard then

		if serverguard.player and serverguard.player:HasPermission( ply, "aTags Admin Panel" ) then
			return true
		end
		
	end
	
	return false
end

hook.Add( "Initialize", "aTags - Permissions - Initialize", function()
	if serverguard and serverguard.permission then
		serverguard.permission:Add( "aTags Admin Panel" )
	end
end)

