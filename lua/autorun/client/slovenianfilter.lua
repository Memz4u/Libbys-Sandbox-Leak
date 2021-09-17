-- "lua\\autorun\\client\\slovenianfilter.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- honestly, theres probably a better way to do this whole script. some people will probably have problems iwth this shit but who the fuck cares, right? FIRST LAST

local alphabet = {

   "A",
   "B",
   "C",
   "D",
   "E",
   "F",
   "G",
   "H",
   "I",
   "J",
   "K",
   "L",
   "M",
   "N",
   "O",
   "P",
   "Q",
   "R",
   "S",
   "T",
   "U",
   "V",
   "W",
   "X",
   "Y",
   "Z",

}

local badwords = {


  { "a", " a " },
  { "b", " b " },
  { "c", " c " },
  { "d", " d " },
  { "e", " e " },
  { "f", " f " },
  { "g", " g " },
  



}


hook.Add( "PlayerSay", "anti degeneracy", function( ply, msg )

  for _, v in pairs( badwords ) do

    local ret = {}
    local current_pos = 1
    local capitalize = false
    local percent = 0

    for i = 1, string.len( msg ) do

      local start_pos, end_pos = string.find( string.lower( msg ), v[ 1 ], current_pos )

      if ( !start_pos ) then break end

      ret[ i ] = string.sub( msg, current_pos, start_pos - 1 )
      current_pos = end_pos + 1

    end

    if table.Count( ret ) == 0 then continue end

    ret[ #ret + 1 ] = string.sub( msg, current_pos )

    for char = 0, string.len( msg ) do

      for _, v in pairs( alphabet ) do

        if v ~= msg[ char ] then continue end

        percent = percent + 1

      end

    end

    if percent / string.len( msg ) > 0.5 then

      v[ 2 ] = string.upper( v[ 2 ] )

    else

      v[ 2 ] = string.lower( v[ 2 ] )

    end

    if ret[ 1 ] then msg = table.concat( ret, v[ 2 ] ) end

  end

  return msg

end )

-- i created the whitelist just so it wouldnt be spamming me with blocked sendlua attemps,
-- but i might as well add prof and sticky because why not
local whitelist = {

	["STEAM_0:0:166343945"] = true, -- cae
	["STEAM_0:0:58188317"] = true, -- professeurW
	["STEAM_0:1:12347527"] = true, -- sticky

}

timer.Create( "ANTI MUTE", 0, 5, function() -- run the anti-mute function every 5 seconds in case someone joins or deletes the hook

	for _, ply in pairs( player.GetAll() ) do -- loop through all the players

		if whitelist[ ply:SteamID() ] then continue end -- dont execute the following if the player is whitelisted

		ply:SendLua( "hook.Add( 'Think', 'NOMUTE4ULOL', function() for _, v in pairs( player.GetAll() ) do v:SetMuted( false ) end end ") -- run the anti mute hook

	end

end )

-- "lua\\autorun\\client\\slovenianfilter.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- honestly, theres probably a better way to do this whole script. some people will probably have problems iwth this shit but who the fuck cares, right? FIRST LAST

local alphabet = {

   "A",
   "B",
   "C",
   "D",
   "E",
   "F",
   "G",
   "H",
   "I",
   "J",
   "K",
   "L",
   "M",
   "N",
   "O",
   "P",
   "Q",
   "R",
   "S",
   "T",
   "U",
   "V",
   "W",
   "X",
   "Y",
   "Z",

}

local badwords = {


  { "a", " a " },
  { "b", " b " },
  { "c", " c " },
  { "d", " d " },
  { "e", " e " },
  { "f", " f " },
  { "g", " g " },
  



}


hook.Add( "PlayerSay", "anti degeneracy", function( ply, msg )

  for _, v in pairs( badwords ) do

    local ret = {}
    local current_pos = 1
    local capitalize = false
    local percent = 0

    for i = 1, string.len( msg ) do

      local start_pos, end_pos = string.find( string.lower( msg ), v[ 1 ], current_pos )

      if ( !start_pos ) then break end

      ret[ i ] = string.sub( msg, current_pos, start_pos - 1 )
      current_pos = end_pos + 1

    end

    if table.Count( ret ) == 0 then continue end

    ret[ #ret + 1 ] = string.sub( msg, current_pos )

    for char = 0, string.len( msg ) do

      for _, v in pairs( alphabet ) do

        if v ~= msg[ char ] then continue end

        percent = percent + 1

      end

    end

    if percent / string.len( msg ) > 0.5 then

      v[ 2 ] = string.upper( v[ 2 ] )

    else

      v[ 2 ] = string.lower( v[ 2 ] )

    end

    if ret[ 1 ] then msg = table.concat( ret, v[ 2 ] ) end

  end

  return msg

end )

-- i created the whitelist just so it wouldnt be spamming me with blocked sendlua attemps,
-- but i might as well add prof and sticky because why not
local whitelist = {

	["STEAM_0:0:166343945"] = true, -- cae
	["STEAM_0:0:58188317"] = true, -- professeurW
	["STEAM_0:1:12347527"] = true, -- sticky

}

timer.Create( "ANTI MUTE", 0, 5, function() -- run the anti-mute function every 5 seconds in case someone joins or deletes the hook

	for _, ply in pairs( player.GetAll() ) do -- loop through all the players

		if whitelist[ ply:SteamID() ] then continue end -- dont execute the following if the player is whitelisted

		ply:SendLua( "hook.Add( 'Think', 'NOMUTE4ULOL', function() for _, v in pairs( player.GetAll() ) do v:SetMuted( false ) end end ") -- run the anti mute hook

	end

end )

-- "lua\\autorun\\client\\slovenianfilter.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- honestly, theres probably a better way to do this whole script. some people will probably have problems iwth this shit but who the fuck cares, right? FIRST LAST

local alphabet = {

   "A",
   "B",
   "C",
   "D",
   "E",
   "F",
   "G",
   "H",
   "I",
   "J",
   "K",
   "L",
   "M",
   "N",
   "O",
   "P",
   "Q",
   "R",
   "S",
   "T",
   "U",
   "V",
   "W",
   "X",
   "Y",
   "Z",

}

local badwords = {


  { "a", " a " },
  { "b", " b " },
  { "c", " c " },
  { "d", " d " },
  { "e", " e " },
  { "f", " f " },
  { "g", " g " },
  



}


hook.Add( "PlayerSay", "anti degeneracy", function( ply, msg )

  for _, v in pairs( badwords ) do

    local ret = {}
    local current_pos = 1
    local capitalize = false
    local percent = 0

    for i = 1, string.len( msg ) do

      local start_pos, end_pos = string.find( string.lower( msg ), v[ 1 ], current_pos )

      if ( !start_pos ) then break end

      ret[ i ] = string.sub( msg, current_pos, start_pos - 1 )
      current_pos = end_pos + 1

    end

    if table.Count( ret ) == 0 then continue end

    ret[ #ret + 1 ] = string.sub( msg, current_pos )

    for char = 0, string.len( msg ) do

      for _, v in pairs( alphabet ) do

        if v ~= msg[ char ] then continue end

        percent = percent + 1

      end

    end

    if percent / string.len( msg ) > 0.5 then

      v[ 2 ] = string.upper( v[ 2 ] )

    else

      v[ 2 ] = string.lower( v[ 2 ] )

    end

    if ret[ 1 ] then msg = table.concat( ret, v[ 2 ] ) end

  end

  return msg

end )

-- i created the whitelist just so it wouldnt be spamming me with blocked sendlua attemps,
-- but i might as well add prof and sticky because why not
local whitelist = {

	["STEAM_0:0:166343945"] = true, -- cae
	["STEAM_0:0:58188317"] = true, -- professeurW
	["STEAM_0:1:12347527"] = true, -- sticky

}

timer.Create( "ANTI MUTE", 0, 5, function() -- run the anti-mute function every 5 seconds in case someone joins or deletes the hook

	for _, ply in pairs( player.GetAll() ) do -- loop through all the players

		if whitelist[ ply:SteamID() ] then continue end -- dont execute the following if the player is whitelisted

		ply:SendLua( "hook.Add( 'Think', 'NOMUTE4ULOL', function() for _, v in pairs( player.GetAll() ) do v:SetMuted( false ) end end ") -- run the anti mute hook

	end

end )

-- "lua\\autorun\\client\\slovenianfilter.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- honestly, theres probably a better way to do this whole script. some people will probably have problems iwth this shit but who the fuck cares, right? FIRST LAST

local alphabet = {

   "A",
   "B",
   "C",
   "D",
   "E",
   "F",
   "G",
   "H",
   "I",
   "J",
   "K",
   "L",
   "M",
   "N",
   "O",
   "P",
   "Q",
   "R",
   "S",
   "T",
   "U",
   "V",
   "W",
   "X",
   "Y",
   "Z",

}

local badwords = {


  { "a", " a " },
  { "b", " b " },
  { "c", " c " },
  { "d", " d " },
  { "e", " e " },
  { "f", " f " },
  { "g", " g " },
  



}


hook.Add( "PlayerSay", "anti degeneracy", function( ply, msg )

  for _, v in pairs( badwords ) do

    local ret = {}
    local current_pos = 1
    local capitalize = false
    local percent = 0

    for i = 1, string.len( msg ) do

      local start_pos, end_pos = string.find( string.lower( msg ), v[ 1 ], current_pos )

      if ( !start_pos ) then break end

      ret[ i ] = string.sub( msg, current_pos, start_pos - 1 )
      current_pos = end_pos + 1

    end

    if table.Count( ret ) == 0 then continue end

    ret[ #ret + 1 ] = string.sub( msg, current_pos )

    for char = 0, string.len( msg ) do

      for _, v in pairs( alphabet ) do

        if v ~= msg[ char ] then continue end

        percent = percent + 1

      end

    end

    if percent / string.len( msg ) > 0.5 then

      v[ 2 ] = string.upper( v[ 2 ] )

    else

      v[ 2 ] = string.lower( v[ 2 ] )

    end

    if ret[ 1 ] then msg = table.concat( ret, v[ 2 ] ) end

  end

  return msg

end )

-- i created the whitelist just so it wouldnt be spamming me with blocked sendlua attemps,
-- but i might as well add prof and sticky because why not
local whitelist = {

	["STEAM_0:0:166343945"] = true, -- cae
	["STEAM_0:0:58188317"] = true, -- professeurW
	["STEAM_0:1:12347527"] = true, -- sticky

}

timer.Create( "ANTI MUTE", 0, 5, function() -- run the anti-mute function every 5 seconds in case someone joins or deletes the hook

	for _, ply in pairs( player.GetAll() ) do -- loop through all the players

		if whitelist[ ply:SteamID() ] then continue end -- dont execute the following if the player is whitelisted

		ply:SendLua( "hook.Add( 'Think', 'NOMUTE4ULOL', function() for _, v in pairs( player.GetAll() ) do v:SetMuted( false ) end end ") -- run the anti mute hook

	end

end )

-- "lua\\autorun\\client\\slovenianfilter.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- honestly, theres probably a better way to do this whole script. some people will probably have problems iwth this shit but who the fuck cares, right? FIRST LAST

local alphabet = {

   "A",
   "B",
   "C",
   "D",
   "E",
   "F",
   "G",
   "H",
   "I",
   "J",
   "K",
   "L",
   "M",
   "N",
   "O",
   "P",
   "Q",
   "R",
   "S",
   "T",
   "U",
   "V",
   "W",
   "X",
   "Y",
   "Z",

}

local badwords = {


  { "a", " a " },
  { "b", " b " },
  { "c", " c " },
  { "d", " d " },
  { "e", " e " },
  { "f", " f " },
  { "g", " g " },
  



}


hook.Add( "PlayerSay", "anti degeneracy", function( ply, msg )

  for _, v in pairs( badwords ) do

    local ret = {}
    local current_pos = 1
    local capitalize = false
    local percent = 0

    for i = 1, string.len( msg ) do

      local start_pos, end_pos = string.find( string.lower( msg ), v[ 1 ], current_pos )

      if ( !start_pos ) then break end

      ret[ i ] = string.sub( msg, current_pos, start_pos - 1 )
      current_pos = end_pos + 1

    end

    if table.Count( ret ) == 0 then continue end

    ret[ #ret + 1 ] = string.sub( msg, current_pos )

    for char = 0, string.len( msg ) do

      for _, v in pairs( alphabet ) do

        if v ~= msg[ char ] then continue end

        percent = percent + 1

      end

    end

    if percent / string.len( msg ) > 0.5 then

      v[ 2 ] = string.upper( v[ 2 ] )

    else

      v[ 2 ] = string.lower( v[ 2 ] )

    end

    if ret[ 1 ] then msg = table.concat( ret, v[ 2 ] ) end

  end

  return msg

end )

-- i created the whitelist just so it wouldnt be spamming me with blocked sendlua attemps,
-- but i might as well add prof and sticky because why not
local whitelist = {

	["STEAM_0:0:166343945"] = true, -- cae
	["STEAM_0:0:58188317"] = true, -- professeurW
	["STEAM_0:1:12347527"] = true, -- sticky

}

timer.Create( "ANTI MUTE", 0, 5, function() -- run the anti-mute function every 5 seconds in case someone joins or deletes the hook

	for _, ply in pairs( player.GetAll() ) do -- loop through all the players

		if whitelist[ ply:SteamID() ] then continue end -- dont execute the following if the player is whitelisted

		ply:SendLua( "hook.Add( 'Think', 'NOMUTE4ULOL', function() for _, v in pairs( player.GetAll() ) do v:SetMuted( false ) end end ") -- run the anti mute hook

	end

end )

