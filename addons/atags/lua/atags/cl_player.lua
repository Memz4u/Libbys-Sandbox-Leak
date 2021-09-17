-- "addons\\atags\\lua\\atags\\cl_player.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _this = aTags
local meta = FindMetaTable( "Player" )

-- If player is not initialized in Lua yet, we put the tag in this table.
local waitingChat = {}
local waitingScoreboard = {}

_this.network:add( "chat_tag", function( plyID, tag )
	
	local _table = { pieces = {} }
	for k, v in pairs( tag.tags or {} ) do
		
		if ( v[ 1 ] == "\\MESSAGE" ) then
			_table.messageColor = v[ 2 ]
		elseif ( v[ 1 ] == "\\NAMECOL" ) then
			_table.nameColor = v[ 2 ]
		else
			table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
		end
		
	end
	
	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingChat[ plyID ] = _table
		return
	end
	
	ply.aTags_ch = _table
	
end)

_this.network:add( "chat_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
	
		local ply = player.GetByUniqueID( plyID )
		
		local _table = { pieces = {} }
		for k, v in pairs( tag.tags or {} ) do
			
			if ( v[ 1 ] == "\\MESSAGE" ) then
				_table.messageColor = v[ 2 ]
			elseif ( v[ 1 ] == "\\NAMECOL" ) then
				_table.nameColor = v[ 2 ]
			else
				table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
			end
			
		end
		
		if not IsValid( ply ) then
			waitingChat[ plyID ] = _table
			continue
		end
		
		ply.aTags_ch = _table
		
	end
	
end)

_this.network:add( "scoreboard_tag", function( plyID, tag )

	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingScoreboard[ plyID ] = tag
		return
	end
	
	ply.aTags_sb = tag
	
end)

_this.network:add( "scoreboard_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
		
		local ply = player.GetByUniqueID( plyID )
		if not IsValid( ply ) then
			waitingScoreboard[ plyID ] = tag
			continue
		end
		
		ply.aTags_sb = tag
		
	end
	
end)

function meta:getChatTag()
	local tag = self.aTags_ch or {}
	return tag.pieces, tag.messageColor, tag.nameColor
end

function meta:getScoreboardTag()
	local tag = self.aTags_sb or {}
	return tag.name, tag.color
end

hook.Add( "OnEntityCreated", "aTags", function( ent )
	
	if ( IsValid( ent ) and ent:IsPlayer() ) then
		
		local chatTag = waitingChat[ ent:UniqueID() ]
		local scoreboardTag = waitingScoreboard[ ent:UniqueID() ]
		
		if chatTag then
			ent.aTags_ch = chatTag
		end
		if scoreboardTag then
			ent.aTags_sb = scoreboardTag
		end
		
	end
	
end)

-- "addons\\atags\\lua\\atags\\cl_player.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _this = aTags
local meta = FindMetaTable( "Player" )

-- If player is not initialized in Lua yet, we put the tag in this table.
local waitingChat = {}
local waitingScoreboard = {}

_this.network:add( "chat_tag", function( plyID, tag )
	
	local _table = { pieces = {} }
	for k, v in pairs( tag.tags or {} ) do
		
		if ( v[ 1 ] == "\\MESSAGE" ) then
			_table.messageColor = v[ 2 ]
		elseif ( v[ 1 ] == "\\NAMECOL" ) then
			_table.nameColor = v[ 2 ]
		else
			table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
		end
		
	end
	
	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingChat[ plyID ] = _table
		return
	end
	
	ply.aTags_ch = _table
	
end)

_this.network:add( "chat_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
	
		local ply = player.GetByUniqueID( plyID )
		
		local _table = { pieces = {} }
		for k, v in pairs( tag.tags or {} ) do
			
			if ( v[ 1 ] == "\\MESSAGE" ) then
				_table.messageColor = v[ 2 ]
			elseif ( v[ 1 ] == "\\NAMECOL" ) then
				_table.nameColor = v[ 2 ]
			else
				table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
			end
			
		end
		
		if not IsValid( ply ) then
			waitingChat[ plyID ] = _table
			continue
		end
		
		ply.aTags_ch = _table
		
	end
	
end)

_this.network:add( "scoreboard_tag", function( plyID, tag )

	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingScoreboard[ plyID ] = tag
		return
	end
	
	ply.aTags_sb = tag
	
end)

_this.network:add( "scoreboard_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
		
		local ply = player.GetByUniqueID( plyID )
		if not IsValid( ply ) then
			waitingScoreboard[ plyID ] = tag
			continue
		end
		
		ply.aTags_sb = tag
		
	end
	
end)

function meta:getChatTag()
	local tag = self.aTags_ch or {}
	return tag.pieces, tag.messageColor, tag.nameColor
end

function meta:getScoreboardTag()
	local tag = self.aTags_sb or {}
	return tag.name, tag.color
end

hook.Add( "OnEntityCreated", "aTags", function( ent )
	
	if ( IsValid( ent ) and ent:IsPlayer() ) then
		
		local chatTag = waitingChat[ ent:UniqueID() ]
		local scoreboardTag = waitingScoreboard[ ent:UniqueID() ]
		
		if chatTag then
			ent.aTags_ch = chatTag
		end
		if scoreboardTag then
			ent.aTags_sb = scoreboardTag
		end
		
	end
	
end)

-- "addons\\atags\\lua\\atags\\cl_player.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _this = aTags
local meta = FindMetaTable( "Player" )

-- If player is not initialized in Lua yet, we put the tag in this table.
local waitingChat = {}
local waitingScoreboard = {}

_this.network:add( "chat_tag", function( plyID, tag )
	
	local _table = { pieces = {} }
	for k, v in pairs( tag.tags or {} ) do
		
		if ( v[ 1 ] == "\\MESSAGE" ) then
			_table.messageColor = v[ 2 ]
		elseif ( v[ 1 ] == "\\NAMECOL" ) then
			_table.nameColor = v[ 2 ]
		else
			table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
		end
		
	end
	
	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingChat[ plyID ] = _table
		return
	end
	
	ply.aTags_ch = _table
	
end)

_this.network:add( "chat_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
	
		local ply = player.GetByUniqueID( plyID )
		
		local _table = { pieces = {} }
		for k, v in pairs( tag.tags or {} ) do
			
			if ( v[ 1 ] == "\\MESSAGE" ) then
				_table.messageColor = v[ 2 ]
			elseif ( v[ 1 ] == "\\NAMECOL" ) then
				_table.nameColor = v[ 2 ]
			else
				table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
			end
			
		end
		
		if not IsValid( ply ) then
			waitingChat[ plyID ] = _table
			continue
		end
		
		ply.aTags_ch = _table
		
	end
	
end)

_this.network:add( "scoreboard_tag", function( plyID, tag )

	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingScoreboard[ plyID ] = tag
		return
	end
	
	ply.aTags_sb = tag
	
end)

_this.network:add( "scoreboard_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
		
		local ply = player.GetByUniqueID( plyID )
		if not IsValid( ply ) then
			waitingScoreboard[ plyID ] = tag
			continue
		end
		
		ply.aTags_sb = tag
		
	end
	
end)

function meta:getChatTag()
	local tag = self.aTags_ch or {}
	return tag.pieces, tag.messageColor, tag.nameColor
end

function meta:getScoreboardTag()
	local tag = self.aTags_sb or {}
	return tag.name, tag.color
end

hook.Add( "OnEntityCreated", "aTags", function( ent )
	
	if ( IsValid( ent ) and ent:IsPlayer() ) then
		
		local chatTag = waitingChat[ ent:UniqueID() ]
		local scoreboardTag = waitingScoreboard[ ent:UniqueID() ]
		
		if chatTag then
			ent.aTags_ch = chatTag
		end
		if scoreboardTag then
			ent.aTags_sb = scoreboardTag
		end
		
	end
	
end)

-- "addons\\atags\\lua\\atags\\cl_player.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _this = aTags
local meta = FindMetaTable( "Player" )

-- If player is not initialized in Lua yet, we put the tag in this table.
local waitingChat = {}
local waitingScoreboard = {}

_this.network:add( "chat_tag", function( plyID, tag )
	
	local _table = { pieces = {} }
	for k, v in pairs( tag.tags or {} ) do
		
		if ( v[ 1 ] == "\\MESSAGE" ) then
			_table.messageColor = v[ 2 ]
		elseif ( v[ 1 ] == "\\NAMECOL" ) then
			_table.nameColor = v[ 2 ]
		else
			table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
		end
		
	end
	
	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingChat[ plyID ] = _table
		return
	end
	
	ply.aTags_ch = _table
	
end)

_this.network:add( "chat_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
	
		local ply = player.GetByUniqueID( plyID )
		
		local _table = { pieces = {} }
		for k, v in pairs( tag.tags or {} ) do
			
			if ( v[ 1 ] == "\\MESSAGE" ) then
				_table.messageColor = v[ 2 ]
			elseif ( v[ 1 ] == "\\NAMECOL" ) then
				_table.nameColor = v[ 2 ]
			else
				table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
			end
			
		end
		
		if not IsValid( ply ) then
			waitingChat[ plyID ] = _table
			continue
		end
		
		ply.aTags_ch = _table
		
	end
	
end)

_this.network:add( "scoreboard_tag", function( plyID, tag )

	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingScoreboard[ plyID ] = tag
		return
	end
	
	ply.aTags_sb = tag
	
end)

_this.network:add( "scoreboard_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
		
		local ply = player.GetByUniqueID( plyID )
		if not IsValid( ply ) then
			waitingScoreboard[ plyID ] = tag
			continue
		end
		
		ply.aTags_sb = tag
		
	end
	
end)

function meta:getChatTag()
	local tag = self.aTags_ch or {}
	return tag.pieces, tag.messageColor, tag.nameColor
end

function meta:getScoreboardTag()
	local tag = self.aTags_sb or {}
	return tag.name, tag.color
end

hook.Add( "OnEntityCreated", "aTags", function( ent )
	
	if ( IsValid( ent ) and ent:IsPlayer() ) then
		
		local chatTag = waitingChat[ ent:UniqueID() ]
		local scoreboardTag = waitingScoreboard[ ent:UniqueID() ]
		
		if chatTag then
			ent.aTags_ch = chatTag
		end
		if scoreboardTag then
			ent.aTags_sb = scoreboardTag
		end
		
	end
	
end)

-- "addons\\atags\\lua\\atags\\cl_player.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local _this = aTags
local meta = FindMetaTable( "Player" )

-- If player is not initialized in Lua yet, we put the tag in this table.
local waitingChat = {}
local waitingScoreboard = {}

_this.network:add( "chat_tag", function( plyID, tag )
	
	local _table = { pieces = {} }
	for k, v in pairs( tag.tags or {} ) do
		
		if ( v[ 1 ] == "\\MESSAGE" ) then
			_table.messageColor = v[ 2 ]
		elseif ( v[ 1 ] == "\\NAMECOL" ) then
			_table.nameColor = v[ 2 ]
		else
			table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
		end
		
	end
	
	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingChat[ plyID ] = _table
		return
	end
	
	ply.aTags_ch = _table
	
end)

_this.network:add( "chat_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
	
		local ply = player.GetByUniqueID( plyID )
		
		local _table = { pieces = {} }
		for k, v in pairs( tag.tags or {} ) do
			
			if ( v[ 1 ] == "\\MESSAGE" ) then
				_table.messageColor = v[ 2 ]
			elseif ( v[ 1 ] == "\\NAMECOL" ) then
				_table.nameColor = v[ 2 ]
			else
				table.insert( _table.pieces, { name = v[ 1 ], color = v[ 2 ] } )
			end
			
		end
		
		if not IsValid( ply ) then
			waitingChat[ plyID ] = _table
			continue
		end
		
		ply.aTags_ch = _table
		
	end
	
end)

_this.network:add( "scoreboard_tag", function( plyID, tag )

	local ply = player.GetByUniqueID( plyID )
	if not IsValid( ply ) then
		waitingScoreboard[ plyID ] = tag
		return
	end
	
	ply.aTags_sb = tag
	
end)

_this.network:add( "scoreboard_tags", function( tags )
	
	for plyID, tag in pairs( tags ) do
		
		local ply = player.GetByUniqueID( plyID )
		if not IsValid( ply ) then
			waitingScoreboard[ plyID ] = tag
			continue
		end
		
		ply.aTags_sb = tag
		
	end
	
end)

function meta:getChatTag()
	local tag = self.aTags_ch or {}
	return tag.pieces, tag.messageColor, tag.nameColor
end

function meta:getScoreboardTag()
	local tag = self.aTags_sb or {}
	return tag.name, tag.color
end

hook.Add( "OnEntityCreated", "aTags", function( ent )
	
	if ( IsValid( ent ) and ent:IsPlayer() ) then
		
		local chatTag = waitingChat[ ent:UniqueID() ]
		local scoreboardTag = waitingScoreboard[ ent:UniqueID() ]
		
		if chatTag then
			ent.aTags_ch = chatTag
		end
		if scoreboardTag then
			ent.aTags_sb = scoreboardTag
		end
		
	end
	
end)

