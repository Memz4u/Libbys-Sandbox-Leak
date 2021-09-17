-- "addons\\atags\\lua\\autorun\\client\\ttt_radiochat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local enabled = false

timer.Simple( 1, function()
	
if !( enabled ) then return end

local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation

local function AddDetectiveText(ply, text)
   chat.AddText(Color(50, 200, 255),
                ply:Nick(),
                Color(255,255,255),
                ": " .. text)
end

local function RadioMsgRecv()
   local sender = net.ReadEntity()
   local msg    = net.ReadString()
   local param  = net.ReadString()

   if not (IsValid(sender) and sender:IsPlayer()) then return end

   GAMEMODE:PlayerSentRadioCommand(sender, msg, param)

   -- if param is a language string, translate it
   -- else it's a nickname
   local lang_param = LANG.GetNameParam(param)
   if lang_param then
      if lang_param == "quick_corpse_id" then
         -- special case where nested translation is needed
         param = GetPTranslation(lang_param, {player = net.ReadString()})
      else
         param = GetTranslation(lang_param)
      end
   end

   local text = GetPTranslation(msg, {player = param})

   -- don't want to capitalize nicks, but everything else is fair game
   if lang_param then
      text = util.Capitalize(text)
   end
	
	local ply = sender
	
	if not ply:GetNWBool( "aTags_ch_hasTag", false ) then
	
		if sender:IsDetective() then
		  AddDetectiveText(sender, text)
		else
		  chat.AddText(sender,
					   COLOR_WHITE,
					   ": " .. text)
		end
		
	else
	
		local message = {}

		if ply:GetNWInt( "aTags_ch_tagLength" ) > 0 then
			for i=1, ply:GetNWInt( "aTags_ch_tagLength" ) do
				table.insert( message, string.ToColor( ply:GetNWString( "aTags_ch_tagColor_" .. i ) ) )
				table.insert( message, ply:GetNWString( "aTags_ch_tagName_" .. i ) )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end

		local nameColor = ply:GetNWString( "aTags_ch_nameColor", "" )
		local chatColor = ply:GetNWString( "aTags_ch_chatColor", "" )

		if nameColor and nameColor != "" then
			table.insert( message, string.ToColor( nameColor ) )
		elseif ATAG.Gamemode_TeamColor then

			if ply:IsActiveDetective() then
				table.insert( message, detective )
			else
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			
		end
		table.insert( message, ply:Nick() )

		if chatColor and chatColor != "" then
			table.insert( message, string.ToColor( chatColor ) )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. text )

		chat.AddText( unpack( message ) )
	
	end
	
end
net.Receive("TTT_RadioMsg", RadioMsgRecv)

end)

-- "addons\\atags\\lua\\autorun\\client\\ttt_radiochat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local enabled = false

timer.Simple( 1, function()
	
if !( enabled ) then return end

local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation

local function AddDetectiveText(ply, text)
   chat.AddText(Color(50, 200, 255),
                ply:Nick(),
                Color(255,255,255),
                ": " .. text)
end

local function RadioMsgRecv()
   local sender = net.ReadEntity()
   local msg    = net.ReadString()
   local param  = net.ReadString()

   if not (IsValid(sender) and sender:IsPlayer()) then return end

   GAMEMODE:PlayerSentRadioCommand(sender, msg, param)

   -- if param is a language string, translate it
   -- else it's a nickname
   local lang_param = LANG.GetNameParam(param)
   if lang_param then
      if lang_param == "quick_corpse_id" then
         -- special case where nested translation is needed
         param = GetPTranslation(lang_param, {player = net.ReadString()})
      else
         param = GetTranslation(lang_param)
      end
   end

   local text = GetPTranslation(msg, {player = param})

   -- don't want to capitalize nicks, but everything else is fair game
   if lang_param then
      text = util.Capitalize(text)
   end
	
	local ply = sender
	
	if not ply:GetNWBool( "aTags_ch_hasTag", false ) then
	
		if sender:IsDetective() then
		  AddDetectiveText(sender, text)
		else
		  chat.AddText(sender,
					   COLOR_WHITE,
					   ": " .. text)
		end
		
	else
	
		local message = {}

		if ply:GetNWInt( "aTags_ch_tagLength" ) > 0 then
			for i=1, ply:GetNWInt( "aTags_ch_tagLength" ) do
				table.insert( message, string.ToColor( ply:GetNWString( "aTags_ch_tagColor_" .. i ) ) )
				table.insert( message, ply:GetNWString( "aTags_ch_tagName_" .. i ) )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end

		local nameColor = ply:GetNWString( "aTags_ch_nameColor", "" )
		local chatColor = ply:GetNWString( "aTags_ch_chatColor", "" )

		if nameColor and nameColor != "" then
			table.insert( message, string.ToColor( nameColor ) )
		elseif ATAG.Gamemode_TeamColor then

			if ply:IsActiveDetective() then
				table.insert( message, detective )
			else
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			
		end
		table.insert( message, ply:Nick() )

		if chatColor and chatColor != "" then
			table.insert( message, string.ToColor( chatColor ) )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. text )

		chat.AddText( unpack( message ) )
	
	end
	
end
net.Receive("TTT_RadioMsg", RadioMsgRecv)

end)

-- "addons\\atags\\lua\\autorun\\client\\ttt_radiochat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local enabled = false

timer.Simple( 1, function()
	
if !( enabled ) then return end

local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation

local function AddDetectiveText(ply, text)
   chat.AddText(Color(50, 200, 255),
                ply:Nick(),
                Color(255,255,255),
                ": " .. text)
end

local function RadioMsgRecv()
   local sender = net.ReadEntity()
   local msg    = net.ReadString()
   local param  = net.ReadString()

   if not (IsValid(sender) and sender:IsPlayer()) then return end

   GAMEMODE:PlayerSentRadioCommand(sender, msg, param)

   -- if param is a language string, translate it
   -- else it's a nickname
   local lang_param = LANG.GetNameParam(param)
   if lang_param then
      if lang_param == "quick_corpse_id" then
         -- special case where nested translation is needed
         param = GetPTranslation(lang_param, {player = net.ReadString()})
      else
         param = GetTranslation(lang_param)
      end
   end

   local text = GetPTranslation(msg, {player = param})

   -- don't want to capitalize nicks, but everything else is fair game
   if lang_param then
      text = util.Capitalize(text)
   end
	
	local ply = sender
	
	if not ply:GetNWBool( "aTags_ch_hasTag", false ) then
	
		if sender:IsDetective() then
		  AddDetectiveText(sender, text)
		else
		  chat.AddText(sender,
					   COLOR_WHITE,
					   ": " .. text)
		end
		
	else
	
		local message = {}

		if ply:GetNWInt( "aTags_ch_tagLength" ) > 0 then
			for i=1, ply:GetNWInt( "aTags_ch_tagLength" ) do
				table.insert( message, string.ToColor( ply:GetNWString( "aTags_ch_tagColor_" .. i ) ) )
				table.insert( message, ply:GetNWString( "aTags_ch_tagName_" .. i ) )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end

		local nameColor = ply:GetNWString( "aTags_ch_nameColor", "" )
		local chatColor = ply:GetNWString( "aTags_ch_chatColor", "" )

		if nameColor and nameColor != "" then
			table.insert( message, string.ToColor( nameColor ) )
		elseif ATAG.Gamemode_TeamColor then

			if ply:IsActiveDetective() then
				table.insert( message, detective )
			else
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			
		end
		table.insert( message, ply:Nick() )

		if chatColor and chatColor != "" then
			table.insert( message, string.ToColor( chatColor ) )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. text )

		chat.AddText( unpack( message ) )
	
	end
	
end
net.Receive("TTT_RadioMsg", RadioMsgRecv)

end)

-- "addons\\atags\\lua\\autorun\\client\\ttt_radiochat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local enabled = false

timer.Simple( 1, function()
	
if !( enabled ) then return end

local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation

local function AddDetectiveText(ply, text)
   chat.AddText(Color(50, 200, 255),
                ply:Nick(),
                Color(255,255,255),
                ": " .. text)
end

local function RadioMsgRecv()
   local sender = net.ReadEntity()
   local msg    = net.ReadString()
   local param  = net.ReadString()

   if not (IsValid(sender) and sender:IsPlayer()) then return end

   GAMEMODE:PlayerSentRadioCommand(sender, msg, param)

   -- if param is a language string, translate it
   -- else it's a nickname
   local lang_param = LANG.GetNameParam(param)
   if lang_param then
      if lang_param == "quick_corpse_id" then
         -- special case where nested translation is needed
         param = GetPTranslation(lang_param, {player = net.ReadString()})
      else
         param = GetTranslation(lang_param)
      end
   end

   local text = GetPTranslation(msg, {player = param})

   -- don't want to capitalize nicks, but everything else is fair game
   if lang_param then
      text = util.Capitalize(text)
   end
	
	local ply = sender
	
	if not ply:GetNWBool( "aTags_ch_hasTag", false ) then
	
		if sender:IsDetective() then
		  AddDetectiveText(sender, text)
		else
		  chat.AddText(sender,
					   COLOR_WHITE,
					   ": " .. text)
		end
		
	else
	
		local message = {}

		if ply:GetNWInt( "aTags_ch_tagLength" ) > 0 then
			for i=1, ply:GetNWInt( "aTags_ch_tagLength" ) do
				table.insert( message, string.ToColor( ply:GetNWString( "aTags_ch_tagColor_" .. i ) ) )
				table.insert( message, ply:GetNWString( "aTags_ch_tagName_" .. i ) )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end

		local nameColor = ply:GetNWString( "aTags_ch_nameColor", "" )
		local chatColor = ply:GetNWString( "aTags_ch_chatColor", "" )

		if nameColor and nameColor != "" then
			table.insert( message, string.ToColor( nameColor ) )
		elseif ATAG.Gamemode_TeamColor then

			if ply:IsActiveDetective() then
				table.insert( message, detective )
			else
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			
		end
		table.insert( message, ply:Nick() )

		if chatColor and chatColor != "" then
			table.insert( message, string.ToColor( chatColor ) )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. text )

		chat.AddText( unpack( message ) )
	
	end
	
end
net.Receive("TTT_RadioMsg", RadioMsgRecv)

end)

-- "addons\\atags\\lua\\autorun\\client\\ttt_radiochat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local enabled = false

timer.Simple( 1, function()
	
if !( enabled ) then return end

local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation

local function AddDetectiveText(ply, text)
   chat.AddText(Color(50, 200, 255),
                ply:Nick(),
                Color(255,255,255),
                ": " .. text)
end

local function RadioMsgRecv()
   local sender = net.ReadEntity()
   local msg    = net.ReadString()
   local param  = net.ReadString()

   if not (IsValid(sender) and sender:IsPlayer()) then return end

   GAMEMODE:PlayerSentRadioCommand(sender, msg, param)

   -- if param is a language string, translate it
   -- else it's a nickname
   local lang_param = LANG.GetNameParam(param)
   if lang_param then
      if lang_param == "quick_corpse_id" then
         -- special case where nested translation is needed
         param = GetPTranslation(lang_param, {player = net.ReadString()})
      else
         param = GetTranslation(lang_param)
      end
   end

   local text = GetPTranslation(msg, {player = param})

   -- don't want to capitalize nicks, but everything else is fair game
   if lang_param then
      text = util.Capitalize(text)
   end
	
	local ply = sender
	
	if not ply:GetNWBool( "aTags_ch_hasTag", false ) then
	
		if sender:IsDetective() then
		  AddDetectiveText(sender, text)
		else
		  chat.AddText(sender,
					   COLOR_WHITE,
					   ": " .. text)
		end
		
	else
	
		local message = {}

		if ply:GetNWInt( "aTags_ch_tagLength" ) > 0 then
			for i=1, ply:GetNWInt( "aTags_ch_tagLength" ) do
				table.insert( message, string.ToColor( ply:GetNWString( "aTags_ch_tagColor_" .. i ) ) )
				table.insert( message, ply:GetNWString( "aTags_ch_tagName_" .. i ) )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end

		local nameColor = ply:GetNWString( "aTags_ch_nameColor", "" )
		local chatColor = ply:GetNWString( "aTags_ch_chatColor", "" )

		if nameColor and nameColor != "" then
			table.insert( message, string.ToColor( nameColor ) )
		elseif ATAG.Gamemode_TeamColor then

			if ply:IsActiveDetective() then
				table.insert( message, detective )
			else
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			
		end
		table.insert( message, ply:Nick() )

		if chatColor and chatColor != "" then
			table.insert( message, string.ToColor( chatColor ) )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. text )

		chat.AddText( unpack( message ) )
	
	end
	
end
net.Receive("TTT_RadioMsg", RadioMsgRecv)

end)

