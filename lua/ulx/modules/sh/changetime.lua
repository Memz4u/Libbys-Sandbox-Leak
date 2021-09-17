-- "lua\\ulx\\modules\\sh\\changetime.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local CATEGORY_NAME = "Apple's Creations"


function ulx.settime( calling_ply, target_ply, time )


local affected_plys = {}
function updatePlayer( ply )
sql.Query( "UPDATE utime SET totaltime = " .. math.floor( ply:GetUTimeTotalTime() ) .. " WHERE player = " .. ply:UniqueID() .. ";" )
end

function updateAll()
local players = player.GetAll()

for _, ply in ipairs( players ) do
if ply and ply:IsConnected() then
updatePlayer( ply )
end
end
end


local plyID = tostring(target_ply:UniqueID())
local ply = player.GetByUniqueID(plyID)
local ammount = tonumber(tostring(time))
ammount = ammount * 3600
ply:SetUTime( ammount )
ply:SetUTimeStart( CurTime() )

  //sql.Query( "UPDATE utime SET totaltime = " ..  math.floor(ammount)  .. " WHERE player = " .. plyID .. ";" )
  updateAll()
table.insert( affected_plys, target_ply )
ulx.fancyLogAdmin( calling_ply, "#A set #T's hours to #s", affected_plys, time )
end


local settime = ulx.command( CATEGORY_NAME, "ulx settime", ulx.settime, "!utime" )
settime:addParam{ type=ULib.cmds.PlayerArg }
settime:addParam{ type=ULib.cmds.NumArg, min=0, default=1, hint="Hours", ULib.cmds.round }
settime:defaultAccess( ULib.ACCESS_SUPERADMIN )
settime:help( "Change a player's hours - !utime" )

-- "lua\\ulx\\modules\\sh\\changetime.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local CATEGORY_NAME = "Apple's Creations"


function ulx.settime( calling_ply, target_ply, time )


local affected_plys = {}
function updatePlayer( ply )
sql.Query( "UPDATE utime SET totaltime = " .. math.floor( ply:GetUTimeTotalTime() ) .. " WHERE player = " .. ply:UniqueID() .. ";" )
end

function updateAll()
local players = player.GetAll()

for _, ply in ipairs( players ) do
if ply and ply:IsConnected() then
updatePlayer( ply )
end
end
end


local plyID = tostring(target_ply:UniqueID())
local ply = player.GetByUniqueID(plyID)
local ammount = tonumber(tostring(time))
ammount = ammount * 3600
ply:SetUTime( ammount )
ply:SetUTimeStart( CurTime() )

  //sql.Query( "UPDATE utime SET totaltime = " ..  math.floor(ammount)  .. " WHERE player = " .. plyID .. ";" )
  updateAll()
table.insert( affected_plys, target_ply )
ulx.fancyLogAdmin( calling_ply, "#A set #T's hours to #s", affected_plys, time )
end


local settime = ulx.command( CATEGORY_NAME, "ulx settime", ulx.settime, "!utime" )
settime:addParam{ type=ULib.cmds.PlayerArg }
settime:addParam{ type=ULib.cmds.NumArg, min=0, default=1, hint="Hours", ULib.cmds.round }
settime:defaultAccess( ULib.ACCESS_SUPERADMIN )
settime:help( "Change a player's hours - !utime" )

-- "lua\\ulx\\modules\\sh\\changetime.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local CATEGORY_NAME = "Apple's Creations"


function ulx.settime( calling_ply, target_ply, time )


local affected_plys = {}
function updatePlayer( ply )
sql.Query( "UPDATE utime SET totaltime = " .. math.floor( ply:GetUTimeTotalTime() ) .. " WHERE player = " .. ply:UniqueID() .. ";" )
end

function updateAll()
local players = player.GetAll()

for _, ply in ipairs( players ) do
if ply and ply:IsConnected() then
updatePlayer( ply )
end
end
end


local plyID = tostring(target_ply:UniqueID())
local ply = player.GetByUniqueID(plyID)
local ammount = tonumber(tostring(time))
ammount = ammount * 3600
ply:SetUTime( ammount )
ply:SetUTimeStart( CurTime() )

  //sql.Query( "UPDATE utime SET totaltime = " ..  math.floor(ammount)  .. " WHERE player = " .. plyID .. ";" )
  updateAll()
table.insert( affected_plys, target_ply )
ulx.fancyLogAdmin( calling_ply, "#A set #T's hours to #s", affected_plys, time )
end


local settime = ulx.command( CATEGORY_NAME, "ulx settime", ulx.settime, "!utime" )
settime:addParam{ type=ULib.cmds.PlayerArg }
settime:addParam{ type=ULib.cmds.NumArg, min=0, default=1, hint="Hours", ULib.cmds.round }
settime:defaultAccess( ULib.ACCESS_SUPERADMIN )
settime:help( "Change a player's hours - !utime" )

-- "lua\\ulx\\modules\\sh\\changetime.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local CATEGORY_NAME = "Apple's Creations"


function ulx.settime( calling_ply, target_ply, time )


local affected_plys = {}
function updatePlayer( ply )
sql.Query( "UPDATE utime SET totaltime = " .. math.floor( ply:GetUTimeTotalTime() ) .. " WHERE player = " .. ply:UniqueID() .. ";" )
end

function updateAll()
local players = player.GetAll()

for _, ply in ipairs( players ) do
if ply and ply:IsConnected() then
updatePlayer( ply )
end
end
end


local plyID = tostring(target_ply:UniqueID())
local ply = player.GetByUniqueID(plyID)
local ammount = tonumber(tostring(time))
ammount = ammount * 3600
ply:SetUTime( ammount )
ply:SetUTimeStart( CurTime() )

  //sql.Query( "UPDATE utime SET totaltime = " ..  math.floor(ammount)  .. " WHERE player = " .. plyID .. ";" )
  updateAll()
table.insert( affected_plys, target_ply )
ulx.fancyLogAdmin( calling_ply, "#A set #T's hours to #s", affected_plys, time )
end


local settime = ulx.command( CATEGORY_NAME, "ulx settime", ulx.settime, "!utime" )
settime:addParam{ type=ULib.cmds.PlayerArg }
settime:addParam{ type=ULib.cmds.NumArg, min=0, default=1, hint="Hours", ULib.cmds.round }
settime:defaultAccess( ULib.ACCESS_SUPERADMIN )
settime:help( "Change a player's hours - !utime" )

-- "lua\\ulx\\modules\\sh\\changetime.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local CATEGORY_NAME = "Apple's Creations"


function ulx.settime( calling_ply, target_ply, time )


local affected_plys = {}
function updatePlayer( ply )
sql.Query( "UPDATE utime SET totaltime = " .. math.floor( ply:GetUTimeTotalTime() ) .. " WHERE player = " .. ply:UniqueID() .. ";" )
end

function updateAll()
local players = player.GetAll()

for _, ply in ipairs( players ) do
if ply and ply:IsConnected() then
updatePlayer( ply )
end
end
end


local plyID = tostring(target_ply:UniqueID())
local ply = player.GetByUniqueID(plyID)
local ammount = tonumber(tostring(time))
ammount = ammount * 3600
ply:SetUTime( ammount )
ply:SetUTimeStart( CurTime() )

  //sql.Query( "UPDATE utime SET totaltime = " ..  math.floor(ammount)  .. " WHERE player = " .. plyID .. ";" )
  updateAll()
table.insert( affected_plys, target_ply )
ulx.fancyLogAdmin( calling_ply, "#A set #T's hours to #s", affected_plys, time )
end


local settime = ulx.command( CATEGORY_NAME, "ulx settime", ulx.settime, "!utime" )
settime:addParam{ type=ULib.cmds.PlayerArg }
settime:addParam{ type=ULib.cmds.NumArg, min=0, default=1, hint="Hours", ULib.cmds.round }
settime:defaultAccess( ULib.ACCESS_SUPERADMIN )
settime:help( "Change a player's hours - !utime" )

