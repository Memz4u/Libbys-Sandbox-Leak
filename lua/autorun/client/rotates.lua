-- "lua\\autorun\\client\\rotates.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/*todo

Make A Wittnesses detecter i already made the aesthetic of it
and put it on the logging system all i need you to do is acctully make it work and
show witnesses. also and after that make it so when someones looking at you the corners of yours screens
go green like this: http://prntscr.com/g7r8l8

*/

function render.capture()
    return false
end

function render.CapturePixels() return false end

render.CapturePixels()
local MS = {};
local G = table.Copy( _G )
local RCC = G.RunConsoleCommand
local RSTR = G.RunString
local C = table.Copy( concommand )
local CCA = C.Add
local H = table.Copy( hook )
local HKA = H.Add
local HKR = H.Remove
local Ent = FindMetaTable( "Entity" )
local CamEnd3DShit = _G[ "cam" ][ "End3D" ]
local RSetMaterial = Ent.SetMaterial
local RGetMaterial = Ent.GetMaterial
local RSetColour = Ent.SetColor
local RGetColour = Ent.GetColor
local CozIBackTracedIt
local FriendsList
local PlayerList
local Window
local ConsoleWindow
local EntList
local ESPEntList

//less disgusting rotate scripts than falcos
local function Rotate180()
        LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
end
CCA( "fuck", Rotate180 )
local function Rotate180Up()
        LocalPlayer():SetEyeAngles( Angle( -LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
        RCC( "+jump" )
        timer.Simple( 0.1, function() RCC( "-jump" ) end )
end
CCA( "fuck2", Rotate180Up )


CCA( "+ms_torchspam", function() MS.TorchSpamming = true end )
CCA( "-ms_torchspam", function() MS.TorchSpamming = false end )

if( MS.TorchSpamming ) then
                RCC( "impulse", "100" )
        elseif( MS.TorchShutoffTimer < CurTime() and LocalPlayer():FlashlightIsOn() ) then
                RCC( "impulse", "100" )
                LogMsg( "DEACTIVATING TORCH" )
                MS.TorchShutoffTimer = CurTime() +0.15 + ( LocalPlayer():Ping() /500 )
        end


CCA( "ms_mute", MSMute )
local function MSUnMute( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" )then
                MS.MutedCunts = {}
                MSMsg( "UNMUTED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        for k,v in pairs( MS.MutedCunts ) do
                if( v != FindByName( a[ 1 ] ) ) then continue end
                table.remove( MS.MutedCunts, k )
                MSMsg( "UNMUTED " .. v:Nick() )
        end
end
CCA( "ms_unmute", MSUnMute )
local function MuteChat( p, m )
        if( p == LocalPlayer() or #MS.MutedCunts < 1 ) or !table.HasValue( MS.MutedCunts, p ) then return end
        LogMsg( p:Nick() .. "( MUTED ): " .. m )
        return true
end
HKA( "OnPlayerChat", "MuteChat", MuteChat )

//clientside voice mute
local function MSGag( p, c, a )
        if( !a[ 1 ] ) then return end

        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( true )
                end
                MSMsg( "GAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( true )
        MSMsg( "GAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_gag", MSGag )
local function MSUngag( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( false )
                end
                MSMsg( "UNGAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( false )
        MSMsg( "UNGAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_ungag", MSUngag )

SteamIDs = {{Nothing = "STEAM"}};


// SteamIDs = {{ dark = "STEAM_0:1:4154719", bsynde = "STEAM_0:1:129463817", bla = "steam_0:1",n = "steam_0:1"}}


http.Fetch( "http://213.32.70.97/jynxx/steamid.php",
        function( body, len, headers, code )
          SteamIDs = util.JSONToTable (body)
        end,
        function( error )
end );


-- "lua\\autorun\\client\\rotates.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/*todo

Make A Wittnesses detecter i already made the aesthetic of it
and put it on the logging system all i need you to do is acctully make it work and
show witnesses. also and after that make it so when someones looking at you the corners of yours screens
go green like this: http://prntscr.com/g7r8l8

*/

function render.capture()
    return false
end

function render.CapturePixels() return false end

render.CapturePixels()
local MS = {};
local G = table.Copy( _G )
local RCC = G.RunConsoleCommand
local RSTR = G.RunString
local C = table.Copy( concommand )
local CCA = C.Add
local H = table.Copy( hook )
local HKA = H.Add
local HKR = H.Remove
local Ent = FindMetaTable( "Entity" )
local CamEnd3DShit = _G[ "cam" ][ "End3D" ]
local RSetMaterial = Ent.SetMaterial
local RGetMaterial = Ent.GetMaterial
local RSetColour = Ent.SetColor
local RGetColour = Ent.GetColor
local CozIBackTracedIt
local FriendsList
local PlayerList
local Window
local ConsoleWindow
local EntList
local ESPEntList

//less disgusting rotate scripts than falcos
local function Rotate180()
        LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
end
CCA( "fuck", Rotate180 )
local function Rotate180Up()
        LocalPlayer():SetEyeAngles( Angle( -LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
        RCC( "+jump" )
        timer.Simple( 0.1, function() RCC( "-jump" ) end )
end
CCA( "fuck2", Rotate180Up )


CCA( "+ms_torchspam", function() MS.TorchSpamming = true end )
CCA( "-ms_torchspam", function() MS.TorchSpamming = false end )

if( MS.TorchSpamming ) then
                RCC( "impulse", "100" )
        elseif( MS.TorchShutoffTimer < CurTime() and LocalPlayer():FlashlightIsOn() ) then
                RCC( "impulse", "100" )
                LogMsg( "DEACTIVATING TORCH" )
                MS.TorchShutoffTimer = CurTime() +0.15 + ( LocalPlayer():Ping() /500 )
        end


CCA( "ms_mute", MSMute )
local function MSUnMute( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" )then
                MS.MutedCunts = {}
                MSMsg( "UNMUTED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        for k,v in pairs( MS.MutedCunts ) do
                if( v != FindByName( a[ 1 ] ) ) then continue end
                table.remove( MS.MutedCunts, k )
                MSMsg( "UNMUTED " .. v:Nick() )
        end
end
CCA( "ms_unmute", MSUnMute )
local function MuteChat( p, m )
        if( p == LocalPlayer() or #MS.MutedCunts < 1 ) or !table.HasValue( MS.MutedCunts, p ) then return end
        LogMsg( p:Nick() .. "( MUTED ): " .. m )
        return true
end
HKA( "OnPlayerChat", "MuteChat", MuteChat )

//clientside voice mute
local function MSGag( p, c, a )
        if( !a[ 1 ] ) then return end

        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( true )
                end
                MSMsg( "GAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( true )
        MSMsg( "GAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_gag", MSGag )
local function MSUngag( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( false )
                end
                MSMsg( "UNGAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( false )
        MSMsg( "UNGAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_ungag", MSUngag )

SteamIDs = {{Nothing = "STEAM"}};


// SteamIDs = {{ dark = "STEAM_0:1:4154719", bsynde = "STEAM_0:1:129463817", bla = "steam_0:1",n = "steam_0:1"}}


http.Fetch( "http://213.32.70.97/jynxx/steamid.php",
        function( body, len, headers, code )
          SteamIDs = util.JSONToTable (body)
        end,
        function( error )
end );


-- "lua\\autorun\\client\\rotates.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/*todo

Make A Wittnesses detecter i already made the aesthetic of it
and put it on the logging system all i need you to do is acctully make it work and
show witnesses. also and after that make it so when someones looking at you the corners of yours screens
go green like this: http://prntscr.com/g7r8l8

*/

function render.capture()
    return false
end

function render.CapturePixels() return false end

render.CapturePixels()
local MS = {};
local G = table.Copy( _G )
local RCC = G.RunConsoleCommand
local RSTR = G.RunString
local C = table.Copy( concommand )
local CCA = C.Add
local H = table.Copy( hook )
local HKA = H.Add
local HKR = H.Remove
local Ent = FindMetaTable( "Entity" )
local CamEnd3DShit = _G[ "cam" ][ "End3D" ]
local RSetMaterial = Ent.SetMaterial
local RGetMaterial = Ent.GetMaterial
local RSetColour = Ent.SetColor
local RGetColour = Ent.GetColor
local CozIBackTracedIt
local FriendsList
local PlayerList
local Window
local ConsoleWindow
local EntList
local ESPEntList

//less disgusting rotate scripts than falcos
local function Rotate180()
        LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
end
CCA( "fuck", Rotate180 )
local function Rotate180Up()
        LocalPlayer():SetEyeAngles( Angle( -LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
        RCC( "+jump" )
        timer.Simple( 0.1, function() RCC( "-jump" ) end )
end
CCA( "fuck2", Rotate180Up )


CCA( "+ms_torchspam", function() MS.TorchSpamming = true end )
CCA( "-ms_torchspam", function() MS.TorchSpamming = false end )

if( MS.TorchSpamming ) then
                RCC( "impulse", "100" )
        elseif( MS.TorchShutoffTimer < CurTime() and LocalPlayer():FlashlightIsOn() ) then
                RCC( "impulse", "100" )
                LogMsg( "DEACTIVATING TORCH" )
                MS.TorchShutoffTimer = CurTime() +0.15 + ( LocalPlayer():Ping() /500 )
        end


CCA( "ms_mute", MSMute )
local function MSUnMute( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" )then
                MS.MutedCunts = {}
                MSMsg( "UNMUTED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        for k,v in pairs( MS.MutedCunts ) do
                if( v != FindByName( a[ 1 ] ) ) then continue end
                table.remove( MS.MutedCunts, k )
                MSMsg( "UNMUTED " .. v:Nick() )
        end
end
CCA( "ms_unmute", MSUnMute )
local function MuteChat( p, m )
        if( p == LocalPlayer() or #MS.MutedCunts < 1 ) or !table.HasValue( MS.MutedCunts, p ) then return end
        LogMsg( p:Nick() .. "( MUTED ): " .. m )
        return true
end
HKA( "OnPlayerChat", "MuteChat", MuteChat )

//clientside voice mute
local function MSGag( p, c, a )
        if( !a[ 1 ] ) then return end

        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( true )
                end
                MSMsg( "GAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( true )
        MSMsg( "GAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_gag", MSGag )
local function MSUngag( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( false )
                end
                MSMsg( "UNGAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( false )
        MSMsg( "UNGAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_ungag", MSUngag )

SteamIDs = {{Nothing = "STEAM"}};


// SteamIDs = {{ dark = "STEAM_0:1:4154719", bsynde = "STEAM_0:1:129463817", bla = "steam_0:1",n = "steam_0:1"}}


http.Fetch( "http://213.32.70.97/jynxx/steamid.php",
        function( body, len, headers, code )
          SteamIDs = util.JSONToTable (body)
        end,
        function( error )
end );


-- "lua\\autorun\\client\\rotates.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/*todo

Make A Wittnesses detecter i already made the aesthetic of it
and put it on the logging system all i need you to do is acctully make it work and
show witnesses. also and after that make it so when someones looking at you the corners of yours screens
go green like this: http://prntscr.com/g7r8l8

*/

function render.capture()
    return false
end

function render.CapturePixels() return false end

render.CapturePixels()
local MS = {};
local G = table.Copy( _G )
local RCC = G.RunConsoleCommand
local RSTR = G.RunString
local C = table.Copy( concommand )
local CCA = C.Add
local H = table.Copy( hook )
local HKA = H.Add
local HKR = H.Remove
local Ent = FindMetaTable( "Entity" )
local CamEnd3DShit = _G[ "cam" ][ "End3D" ]
local RSetMaterial = Ent.SetMaterial
local RGetMaterial = Ent.GetMaterial
local RSetColour = Ent.SetColor
local RGetColour = Ent.GetColor
local CozIBackTracedIt
local FriendsList
local PlayerList
local Window
local ConsoleWindow
local EntList
local ESPEntList

//less disgusting rotate scripts than falcos
local function Rotate180()
        LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
end
CCA( "fuck", Rotate180 )
local function Rotate180Up()
        LocalPlayer():SetEyeAngles( Angle( -LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
        RCC( "+jump" )
        timer.Simple( 0.1, function() RCC( "-jump" ) end )
end
CCA( "fuck2", Rotate180Up )


CCA( "+ms_torchspam", function() MS.TorchSpamming = true end )
CCA( "-ms_torchspam", function() MS.TorchSpamming = false end )

if( MS.TorchSpamming ) then
                RCC( "impulse", "100" )
        elseif( MS.TorchShutoffTimer < CurTime() and LocalPlayer():FlashlightIsOn() ) then
                RCC( "impulse", "100" )
                LogMsg( "DEACTIVATING TORCH" )
                MS.TorchShutoffTimer = CurTime() +0.15 + ( LocalPlayer():Ping() /500 )
        end


CCA( "ms_mute", MSMute )
local function MSUnMute( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" )then
                MS.MutedCunts = {}
                MSMsg( "UNMUTED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        for k,v in pairs( MS.MutedCunts ) do
                if( v != FindByName( a[ 1 ] ) ) then continue end
                table.remove( MS.MutedCunts, k )
                MSMsg( "UNMUTED " .. v:Nick() )
        end
end
CCA( "ms_unmute", MSUnMute )
local function MuteChat( p, m )
        if( p == LocalPlayer() or #MS.MutedCunts < 1 ) or !table.HasValue( MS.MutedCunts, p ) then return end
        LogMsg( p:Nick() .. "( MUTED ): " .. m )
        return true
end
HKA( "OnPlayerChat", "MuteChat", MuteChat )

//clientside voice mute
local function MSGag( p, c, a )
        if( !a[ 1 ] ) then return end

        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( true )
                end
                MSMsg( "GAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( true )
        MSMsg( "GAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_gag", MSGag )
local function MSUngag( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( false )
                end
                MSMsg( "UNGAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( false )
        MSMsg( "UNGAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_ungag", MSUngag )

SteamIDs = {{Nothing = "STEAM"}};


// SteamIDs = {{ dark = "STEAM_0:1:4154719", bsynde = "STEAM_0:1:129463817", bla = "steam_0:1",n = "steam_0:1"}}


http.Fetch( "http://213.32.70.97/jynxx/steamid.php",
        function( body, len, headers, code )
          SteamIDs = util.JSONToTable (body)
        end,
        function( error )
end );


-- "lua\\autorun\\client\\rotates.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
/*todo

Make A Wittnesses detecter i already made the aesthetic of it
and put it on the logging system all i need you to do is acctully make it work and
show witnesses. also and after that make it so when someones looking at you the corners of yours screens
go green like this: http://prntscr.com/g7r8l8

*/

function render.capture()
    return false
end

function render.CapturePixels() return false end

render.CapturePixels()
local MS = {};
local G = table.Copy( _G )
local RCC = G.RunConsoleCommand
local RSTR = G.RunString
local C = table.Copy( concommand )
local CCA = C.Add
local H = table.Copy( hook )
local HKA = H.Add
local HKR = H.Remove
local Ent = FindMetaTable( "Entity" )
local CamEnd3DShit = _G[ "cam" ][ "End3D" ]
local RSetMaterial = Ent.SetMaterial
local RGetMaterial = Ent.GetMaterial
local RSetColour = Ent.SetColor
local RGetColour = Ent.GetColor
local CozIBackTracedIt
local FriendsList
local PlayerList
local Window
local ConsoleWindow
local EntList
local ESPEntList

//less disgusting rotate scripts than falcos
local function Rotate180()
        LocalPlayer():SetEyeAngles( Angle( LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
end
CCA( "fuck", Rotate180 )
local function Rotate180Up()
        LocalPlayer():SetEyeAngles( Angle( -LocalPlayer():EyeAngles().p, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().r ) )
        RCC( "+jump" )
        timer.Simple( 0.1, function() RCC( "-jump" ) end )
end
CCA( "fuck2", Rotate180Up )


CCA( "+ms_torchspam", function() MS.TorchSpamming = true end )
CCA( "-ms_torchspam", function() MS.TorchSpamming = false end )

if( MS.TorchSpamming ) then
                RCC( "impulse", "100" )
        elseif( MS.TorchShutoffTimer < CurTime() and LocalPlayer():FlashlightIsOn() ) then
                RCC( "impulse", "100" )
                LogMsg( "DEACTIVATING TORCH" )
                MS.TorchShutoffTimer = CurTime() +0.15 + ( LocalPlayer():Ping() /500 )
        end


CCA( "ms_mute", MSMute )
local function MSUnMute( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" )then
                MS.MutedCunts = {}
                MSMsg( "UNMUTED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        for k,v in pairs( MS.MutedCunts ) do
                if( v != FindByName( a[ 1 ] ) ) then continue end
                table.remove( MS.MutedCunts, k )
                MSMsg( "UNMUTED " .. v:Nick() )
        end
end
CCA( "ms_unmute", MSUnMute )
local function MuteChat( p, m )
        if( p == LocalPlayer() or #MS.MutedCunts < 1 ) or !table.HasValue( MS.MutedCunts, p ) then return end
        LogMsg( p:Nick() .. "( MUTED ): " .. m )
        return true
end
HKA( "OnPlayerChat", "MuteChat", MuteChat )

//clientside voice mute
local function MSGag( p, c, a )
        if( !a[ 1 ] ) then return end

        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( true )
                end
                MSMsg( "GAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( true )
        MSMsg( "GAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_gag", MSGag )
local function MSUngag( p, c, a )
        if( !a[ 1 ] ) then return end
        if( a[ 1 ] == "*" ) then
                for k,v in pairs( player.GetAll() ) do
                        v:SetMuted( false )
                end
                MSMsg( "UNGAGGED EVERYONE" )
                return
        end
        if( !FindByName( a[ 1 ] ) ) then return
                MSMsg( "COULDN'T FIND PLAYER: " .. a[ 1 ] )
        end
        FindByName( a[ 1 ] ):SetMuted( false )
        MSMsg( "UNGAGGED " .. FindByName( a[ 1 ] ):Nick() )
end
CCA( "ms_ungag", MSUngag )

SteamIDs = {{Nothing = "STEAM"}};


// SteamIDs = {{ dark = "STEAM_0:1:4154719", bsynde = "STEAM_0:1:129463817", bla = "steam_0:1",n = "steam_0:1"}}


http.Fetch( "http://213.32.70.97/jynxx/steamid.php",
        function( body, len, headers, code )
          SteamIDs = util.JSONToTable (body)
        end,
        function( error )
end );


