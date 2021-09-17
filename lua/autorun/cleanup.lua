-- "lua\\autorun\\cleanup.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
   --------------------------------------------------------
-- Created By Luke( http://steamcommunity.com/id/pssLuke/ ) --
   --------------------------------------------------------
local CATEGORY_NAME = "Players"

function ulx.cleanup( calling_ply, target_ply )

	target_ply:SendLua([[ LocalPlayer():ConCommand("gmod_cleanup") ]])
	ulx.fancyLogAdmin( calling_ply, "#A removed all props belonging to #T.", target_ply )
	
end
local cleanup = ulx.command( CATEGORY_NAME, "ulx cleanup", ulx.cleanup, "!cleanup" )
cleanup:addParam{ type=ULib.cmds.PlayerArg }
cleanup:defaultAccess( ULib.ACCESS_ADMIN )
cleanup:help( "Remove all props belonging to a specified user." )

function ulx.cleanupall( calling_ply )

	for k, v in pairs(player.GetAll()) do
		v:SendLua([[ LocalPlayer():ConCommand("gmod_cleanup") ]])
	end
	ulx.fancyLogAdmin( calling_ply, "#A removed all props." )
	
end
local cleanupall = ulx.command( CATEGORY_NAME, "ulx cleanupall", ulx.cleanupall, "!cleanupall" )
cleanupall:defaultAccess( ULib.ACCESS_ADMIN )
cleanupall:help( "Remove all props." )

-- "lua\\autorun\\cleanup.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
   --------------------------------------------------------
-- Created By Luke( http://steamcommunity.com/id/pssLuke/ ) --
   --------------------------------------------------------
local CATEGORY_NAME = "Players"

function ulx.cleanup( calling_ply, target_ply )

	target_ply:SendLua([[ LocalPlayer():ConCommand("gmod_cleanup") ]])
	ulx.fancyLogAdmin( calling_ply, "#A removed all props belonging to #T.", target_ply )
	
end
local cleanup = ulx.command( CATEGORY_NAME, "ulx cleanup", ulx.cleanup, "!cleanup" )
cleanup:addParam{ type=ULib.cmds.PlayerArg }
cleanup:defaultAccess( ULib.ACCESS_ADMIN )
cleanup:help( "Remove all props belonging to a specified user." )

function ulx.cleanupall( calling_ply )

	for k, v in pairs(player.GetAll()) do
		v:SendLua([[ LocalPlayer():ConCommand("gmod_cleanup") ]])
	end
	ulx.fancyLogAdmin( calling_ply, "#A removed all props." )
	
end
local cleanupall = ulx.command( CATEGORY_NAME, "ulx cleanupall", ulx.cleanupall, "!cleanupall" )
cleanupall:defaultAccess( ULib.ACCESS_ADMIN )
cleanupall:help( "Remove all props." )

