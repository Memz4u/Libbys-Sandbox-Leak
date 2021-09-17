-- "addons\\atags\\lua\\atags\\network\\cl_network.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _global = aTags
_global.network = _global.network or {}

local _this = _global.network

_this.listeners = _this.listeners or {}

-- Send stuff to the server, shouldn't be called.
function _this:send( netID, ... )

	if ( not netID or netID == "" ) then
		Error( "NetID " .. tostring( netID ) ..  " is not valid!" )
	end
	
	net.Start( "aTags_net" )

		net.WriteString( netID )
	
		-- Easiest way of doing this, right?
		net.WriteTable( { ... } )
	
	net.SendToServer()

end

-- Add a new network listener, will be called when the server sends stuff with that netID.
function _this:add( netID, callback, index )

	self.listeners[ netID ] = self.listeners[ netID ] or {}
	self.listeners[ netID ][ index or 1 ] = callback
	
end

-- Remove a network listener in a netID by index.
function _this:remove( netID, index )
	self.listeners[ netID ][ index ] = nil
end

-- Remove all listeners with the same netID.
function _this:removeAll( netID )
	self.listeners[ netID ] = nil
end

-- Receive stuff from the server, shouldn't be called.
function _this:receive()
	
	local netID = net.ReadString()
	local values = net.ReadTable()
	
	self:call( netID, unpack( values ) )
	
end

-- Call all listenders with the same netID, shouldn't be called.
function _this:call( netID, ... )
	
	local _listeners = self.listeners[ netID ] or {}
	for index, callback in pairs( _listeners ) do
		callback( ... )
	end
	
end

-- Receive stuff so we can call receive.
net.Receive( "aTags_net", function( len, ply )
	
	_this:receive()
	
end)

-- "addons\\atags\\lua\\atags\\network\\cl_network.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _global = aTags
_global.network = _global.network or {}

local _this = _global.network

_this.listeners = _this.listeners or {}

-- Send stuff to the server, shouldn't be called.
function _this:send( netID, ... )

	if ( not netID or netID == "" ) then
		Error( "NetID " .. tostring( netID ) ..  " is not valid!" )
	end
	
	net.Start( "aTags_net" )

		net.WriteString( netID )
	
		-- Easiest way of doing this, right?
		net.WriteTable( { ... } )
	
	net.SendToServer()

end

-- Add a new network listener, will be called when the server sends stuff with that netID.
function _this:add( netID, callback, index )

	self.listeners[ netID ] = self.listeners[ netID ] or {}
	self.listeners[ netID ][ index or 1 ] = callback
	
end

-- Remove a network listener in a netID by index.
function _this:remove( netID, index )
	self.listeners[ netID ][ index ] = nil
end

-- Remove all listeners with the same netID.
function _this:removeAll( netID )
	self.listeners[ netID ] = nil
end

-- Receive stuff from the server, shouldn't be called.
function _this:receive()
	
	local netID = net.ReadString()
	local values = net.ReadTable()
	
	self:call( netID, unpack( values ) )
	
end

-- Call all listenders with the same netID, shouldn't be called.
function _this:call( netID, ... )
	
	local _listeners = self.listeners[ netID ] or {}
	for index, callback in pairs( _listeners ) do
		callback( ... )
	end
	
end

-- Receive stuff so we can call receive.
net.Receive( "aTags_net", function( len, ply )
	
	_this:receive()
	
end)

-- "addons\\atags\\lua\\atags\\network\\cl_network.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _global = aTags
_global.network = _global.network or {}

local _this = _global.network

_this.listeners = _this.listeners or {}

-- Send stuff to the server, shouldn't be called.
function _this:send( netID, ... )

	if ( not netID or netID == "" ) then
		Error( "NetID " .. tostring( netID ) ..  " is not valid!" )
	end
	
	net.Start( "aTags_net" )

		net.WriteString( netID )
	
		-- Easiest way of doing this, right?
		net.WriteTable( { ... } )
	
	net.SendToServer()

end

-- Add a new network listener, will be called when the server sends stuff with that netID.
function _this:add( netID, callback, index )

	self.listeners[ netID ] = self.listeners[ netID ] or {}
	self.listeners[ netID ][ index or 1 ] = callback
	
end

-- Remove a network listener in a netID by index.
function _this:remove( netID, index )
	self.listeners[ netID ][ index ] = nil
end

-- Remove all listeners with the same netID.
function _this:removeAll( netID )
	self.listeners[ netID ] = nil
end

-- Receive stuff from the server, shouldn't be called.
function _this:receive()
	
	local netID = net.ReadString()
	local values = net.ReadTable()
	
	self:call( netID, unpack( values ) )
	
end

-- Call all listenders with the same netID, shouldn't be called.
function _this:call( netID, ... )
	
	local _listeners = self.listeners[ netID ] or {}
	for index, callback in pairs( _listeners ) do
		callback( ... )
	end
	
end

-- Receive stuff so we can call receive.
net.Receive( "aTags_net", function( len, ply )
	
	_this:receive()
	
end)

-- "addons\\atags\\lua\\atags\\network\\cl_network.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _global = aTags
_global.network = _global.network or {}

local _this = _global.network

_this.listeners = _this.listeners or {}

-- Send stuff to the server, shouldn't be called.
function _this:send( netID, ... )

	if ( not netID or netID == "" ) then
		Error( "NetID " .. tostring( netID ) ..  " is not valid!" )
	end
	
	net.Start( "aTags_net" )

		net.WriteString( netID )
	
		-- Easiest way of doing this, right?
		net.WriteTable( { ... } )
	
	net.SendToServer()

end

-- Add a new network listener, will be called when the server sends stuff with that netID.
function _this:add( netID, callback, index )

	self.listeners[ netID ] = self.listeners[ netID ] or {}
	self.listeners[ netID ][ index or 1 ] = callback
	
end

-- Remove a network listener in a netID by index.
function _this:remove( netID, index )
	self.listeners[ netID ][ index ] = nil
end

-- Remove all listeners with the same netID.
function _this:removeAll( netID )
	self.listeners[ netID ] = nil
end

-- Receive stuff from the server, shouldn't be called.
function _this:receive()
	
	local netID = net.ReadString()
	local values = net.ReadTable()
	
	self:call( netID, unpack( values ) )
	
end

-- Call all listenders with the same netID, shouldn't be called.
function _this:call( netID, ... )
	
	local _listeners = self.listeners[ netID ] or {}
	for index, callback in pairs( _listeners ) do
		callback( ... )
	end
	
end

-- Receive stuff so we can call receive.
net.Receive( "aTags_net", function( len, ply )
	
	_this:receive()
	
end)

-- "addons\\atags\\lua\\atags\\network\\cl_network.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _global = aTags
_global.network = _global.network or {}

local _this = _global.network

_this.listeners = _this.listeners or {}

-- Send stuff to the server, shouldn't be called.
function _this:send( netID, ... )

	if ( not netID or netID == "" ) then
		Error( "NetID " .. tostring( netID ) ..  " is not valid!" )
	end
	
	net.Start( "aTags_net" )

		net.WriteString( netID )
	
		-- Easiest way of doing this, right?
		net.WriteTable( { ... } )
	
	net.SendToServer()

end

-- Add a new network listener, will be called when the server sends stuff with that netID.
function _this:add( netID, callback, index )

	self.listeners[ netID ] = self.listeners[ netID ] or {}
	self.listeners[ netID ][ index or 1 ] = callback
	
end

-- Remove a network listener in a netID by index.
function _this:remove( netID, index )
	self.listeners[ netID ][ index ] = nil
end

-- Remove all listeners with the same netID.
function _this:removeAll( netID )
	self.listeners[ netID ] = nil
end

-- Receive stuff from the server, shouldn't be called.
function _this:receive()
	
	local netID = net.ReadString()
	local values = net.ReadTable()
	
	self:call( netID, unpack( values ) )
	
end

-- Call all listenders with the same netID, shouldn't be called.
function _this:call( netID, ... )
	
	local _listeners = self.listeners[ netID ] or {}
	for index, callback in pairs( _listeners ) do
		callback( ... )
	end
	
end

-- Receive stuff so we can call receive.
net.Receive( "aTags_net", function( len, ply )
	
	_this:receive()
	
end)

