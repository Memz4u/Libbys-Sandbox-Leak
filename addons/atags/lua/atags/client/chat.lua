-- "addons\\atags\\lua\\atags\\client\\chat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- HatsChat support, player's name color
hook.Add( 'HatsChatPlayerColor', 'aTags-ChatSupport', function( ply )
	local _, _, tagNameColor = ply:getChatTag()
	return tagNameColor
end)

local function ConsoleChat( msg, _team, dead )
	
	local message = {}
	
	if dead then
		table.insert( message, Color( 255, 0, 0 ) )
		table.insert( message, "*DEAD* " )
	end
	
	if _team then
		table.insert( message, Color( 20, 160, 35 ) )
		table.insert( message, "(TEAM) ")
	end
	
	table.insert( message, Color( 130, 160, 255 ) )
	table.insert( message, "(Console)" )
	
	table.insert( message, Color( 255, 255, 255 ) )
	table.insert( message, ": " .. msg )
		
	chat.AddText( unpack( message ) )
		
	return true

end

local function NormalChat()

	hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
		if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
		
		local pieces, messageColor, nameColor = ply:getChatTag()
		if not pieces then return end
		
		local message = {}
		
		if dead then
			table.insert( message, Color( 255, 0, 0 ) )
			table.insert( message, "*DEAD* " )
		end
		
		if _team then
			table.insert( message, Color( 20, 160, 35 ) )
			table.insert( message, "(TEAM) ")
		end
		
		if ATAG.Gamemode_TeamTag then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
		end
		
		if ( #pieces > 0 ) then
			for k, v in pairs( pieces ) do
				table.insert( message, v.color or Color( 255, 255, 255 ) )
				table.insert( message, v.name or "" )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		
		if nameColor and nameColor != "" then
			table.insert( message, nameColor )
		elseif ATAG.Gamemode_TeamColor then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
		end
		if atlaschat or HatsChat then
			-- Suport for Atlas Chat
			-- Atlas Chat needs the entity in order to work and it will apply the last color used to the name
			-- Default chat does not do this, that is why i use ply:Nick()
			table.insert( message, ply )
		else
			table.insert( message, ply:Nick() )
		end
		
		if messageColor and messageColor != "" then
			table.insert( message, messageColor )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. msg )
		
		chat.AddText( unpack( message ) )
		
		return true
		
	end)
	
end

local function createChatHook()
	
	ATAG.gamemode = ""
	
	local detective = Color( 50, 200, 255 )

	if GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
	
		ATAG.gamemode = "Terrortown"
		
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
			
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			local isSpectator = ply:Team() == TEAM_SPEC
			if isSpectator and not dead then
				dead = true
			end
			
			if _team and ((not _team and not ply:IsSpecial()) or _team) then
				_team = false
			end
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
					table.insert( message, "(Detectives) " )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
					table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
				end
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				end
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		end)
		
		
		-- TTT Radio
		--[[
		local GetTranslation = LANG.GetTranslation
		local GetPTranslation = LANG.GetParamTranslation
		
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
		   
			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then

				if sender:IsDetective() then
					AddDetectiveText( sender, text )
				else
					chat.AddText( sender, COLOR_WHITE, ": " .. text )
				end
			else
			
				local message = {}
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. text )
				
				chat.AddText( unpack( message ) )
			
			end
		   
		end
		net.Receive( "TTT_RadioMsg", RadioMsgRecv )
		]]
		
		-- TTT Last words
		--[[
		local function LastWordsRecv()
		   local sender = net.ReadEntity()
		   local words  = net.ReadString()

		   local was_detective = IsValid(sender) and sender:IsDetective()
		   local nick = IsValid(sender) and sender:Nick() or "<Unknown>"

			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then
			
			   chat.AddText(Color( 150, 150, 150 ),
							Format("(%s) ", string.upper(GetTranslation("last_words"))),
							was_detective and Color(50, 200, 255) or Color(0, 200, 0),
							nick,
							COLOR_WHITE,
							": " .. words)
						
			else
				
				local message = {}
				
				table.insert( message, Color( 150, 150, 150 ) )
				table.insert( message, Format("(%s) ", string.upper(GetTranslation("last_words"))) )
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. words )
				
				chat.AddText( unpack( message ) )
			
			end
			
		end
		net.Receive("TTT_LastWordsMsg", LastWordsRecv)
		]]
		
	elseif DarkRP or ATAG.DarkRP then
		
		ATAG.gamemode = "DarkRP"
	
		local function DefaultMessage( ply, prefixText, textCol, msg, msgCol )
		
			local shouldShow
					
			if msg and msg ~= "" then
				if IsValid( ply ) then
					shouldShow = hook.Call( "OnPlayerChat", GAMEMODE, ply, msg, false, not ply:Alive(), prefixText, textCol, msgCol )
				end

				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText, msgCol, ": "..msg )
				end
			else
				shouldShow = hook.Call( "ChatText", GAMEMODE, "0", prefixText, prefixText, "none" )
				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText )
				end
			end
			
			chat.PlaySound()
		
		end
		
		local function DisassembleName( NameString, ply )
		
			-- /me not going to change.
			-- /radio not going to change.
			-- Normal chat
			-- (group)
			-- [Broadcast!]
			-- [Advert]
			-- (yell)
			-- (OOC)
			-- (PM)
			-- (whisper)
			
			local Name = string.Replace( NameString, ply:Nick(), "" )
			local Name = string.Replace( Name, ply:SteamName(), "" )
			
			if Name == "" then
				return ""
			elseif Name == "(OOC) " then
				return "(OOC)"
			elseif Name == "[Advert] " then
				return "[Advert]", true
			elseif Name == "(yell) " then
				return "(yell)"
			elseif Name == "(group) " then
				return "(group)"
			elseif Name == "(PM) " then
				return "(PM)"
			elseif Name == "(whisper) " then
				return "(whisper)"
			elseif Name == "[Broadcast!] " then
				return "[Broadcast!]"
			else
				return nil
			end
			
		end
		
		local function AddToChat( bits )
			
			local textCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			
			local prefixText = net.ReadString()
			
			local ply = net.ReadEntity()
			
			ply = IsValid( ply ) and ply or LocalPlayer()
			
			if prefixText == "" or not prefixText then
				prefixText = ply:Nick()
				prefixText = prefixText ~= "" and prefixText or ply:SteamName()
			end
			
			local msgCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			local msg = net.ReadString()
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if pieces then
			
				local TypeChat, useMessageColor = DisassembleName( prefixText, ply )
				
				if TypeChat then
					
					local message = {}
					
					local teamCol = GAMEMODE:GetTeamColor( ply ) or Color( 255, 255, 255 )
					
					if TypeChat and TypeChat ~= "" then
						table.insert( message, teamCol )
						table.insert( message, TypeChat .. " " )
					end
					
					if ATAG.Gamemode_TeamTag then
						table.insert( message, teamCol )
						table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
					end
					
					if ( #pieces > 0 ) then
						for k, v in pairs( pieces ) do
							table.insert( message, v.color or Color( 255, 255, 255 ) )
							table.insert( message, v.name or "" )
						end
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					
					if nameColor and nameColor != "" then
						table.insert( message, nameColor )
					elseif ATAG.Gamemode_TeamColor then
						table.insert( message, teamCol )
					end
					if atlaschat or HatsChat then
						table.insert( message, ply )
					else
						table.insert( message, ply:Nick() )
					end
					
					if useMessageColor then
						table.insert( message, msgCol or Color( 255, 255, 255 ) )
					elseif messageColor and messageColor != "" then
						table.insert( message, messageColor )
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					table.insert( message, ": " .. msg )
					
					chat.AddText( unpack( message ) )
					
					chat.PlaySound()
				
				else
				
					DefaultMessage( ply, prefixText, textCol, msg, msgCol )
					
				end
				
			else
			
				DefaultMessage( ply, prefixText, textCol, msg, msgCol )
			
			end
		end
		net.Receive( "DarkRP_Chat", AddToChat )
		
	elseif BHOP or ATAG.Bhop then -- Bunny Hop by Ilya
	
		ATAG.gamemode = "Bhop"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then ConsoleChat( msg, _team, dead ) return end
					
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ply:GetBhopRankName() then
				table.insert( message, ply:GetBhopRankColor() )
				table.insert( message, "(" .. ply:GetBhopRankName() .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		
		end)
	
	elseif PHDayZ or ATAG.DayZ then
	
		local function CChat( ply, msg, typeName, typeColor )
			
			local message = {}
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then
			
				local color = Color( 150, 0, 0 )
				if ChatPlayer:IsAdmin() then
					color = Color( 0, 255, 0 )
				elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
					color = Color( 0, 0, 255 )
				end
				
				table.insert( message, color )
				table.insert( message, ply:Nick() )
				
				table.insert( message, typeColor or Color( 255, 255, 255 ) )
				table.insert( message, " " .. typeName .. " " )
				
				table.insert( message, Color( 200, 200, 200 ) )
				table.insert( message, ": " .. msg )
			
			else
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				else
					local color = Color( 150, 0, 0 )
					if ChatPlayer:IsAdmin() then
						color = Color( 0, 255, 0 )
					elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
						color = Color( 0, 0, 255 )
					end
					table.insert( message, color )
				end
				if atlaschat or HatsChat then
					table.insert( message, ply )
				else
					table.insert( message, ply:Nick() )
				end
				
				if typeName and typeColor then
					table.insert( message, typeColor )
					table.insert( message, " " .. typeName .. " " )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 200, 200, 200 ) )
				end
				table.insert( message, ": " .. msg )
			
			end
			
			chat.AddText( unpack( message ) )

		end
	
		net.Receive("GlobalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
			
			CChat( ChatPlayer, net.ReadString(), "[Global]", Color( 125, 125, 125 ) )
			
			chat.PlaySound()
			
		end)

		net.Receive("LocalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Local]", Color( 255, 255, 255 ) )	
			
			chat.PlaySound()
			
		end)

		net.Receive("TradeChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Echange]", Color( 255, 150, 50 ) )	
			
			chat.PlaySound()
		
		end)
	
	elseif ThisClass == "gamemode_cinema" or ATAG.Cinema then
	
		ATAG.gamemode = "Cinema"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then 
			
				local message = {}
				
				if dead then
					table.insert( message, Color( 255, 0, 0 ) )
					table.insert( message, "*DEAD* " )
				end
				
				if _team then
					table.insert( message, Color( 123, 32, 29 ) )
					table.insert( message, "(GLOBAL)" )
				end
				
				table.insert( message, Color( 255, 255, 255 ) )
				table.insert( message, ": " .. msg )
					
				chat.AddText( unpack( message ) )
					
				return true
			end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 123, 32, 29 ) )
				table.insert( message, "(GLOBAL) ")
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		ATAG.gamemode = "Hide and Seek"
		
		local function chatping()
			timer.Simple(0.05,function()
				local ssn = tostring(file.Read("hideandseek/notifsound.txt","DATA"))
				if not (ssn == "None" or ssn == nil) then
					surface.PlaySound(notifsnds[ssn])
				end
			end)
		end
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			elseif _team then
				table.insert( message, COLOR_TEAM or Color( 255, 255, 255 ) )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			chatping()
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == 'gamemode_nutscript' or ATAG.NutScript then
		
		ATAG.gamemode = "NutScript"
		
		include('atags/client/nutscript_chat/nutscript_chat.lua')
		
	else
	
		ATAG.gamemode = "Default"
		
		-- Gamemodes Tested.
		-- Deathrun
		-- PropHunt
		-- JailBreak
		-- Stranded
		
		NormalChat()
		
	end
	
	-- print( "aTags, Using detected chat " .. ATAG.gamemode .. "." )
	
end

hook.Add( "PostGamemodeLoaded", "aTags_chat", createChatHook )
timer.Simple( 0.1, createChatHook )

-- "addons\\atags\\lua\\atags\\client\\chat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- HatsChat support, player's name color
hook.Add( 'HatsChatPlayerColor', 'aTags-ChatSupport', function( ply )
	local _, _, tagNameColor = ply:getChatTag()
	return tagNameColor
end)

local function ConsoleChat( msg, _team, dead )
	
	local message = {}
	
	if dead then
		table.insert( message, Color( 255, 0, 0 ) )
		table.insert( message, "*DEAD* " )
	end
	
	if _team then
		table.insert( message, Color( 20, 160, 35 ) )
		table.insert( message, "(TEAM) ")
	end
	
	table.insert( message, Color( 130, 160, 255 ) )
	table.insert( message, "(Console)" )
	
	table.insert( message, Color( 255, 255, 255 ) )
	table.insert( message, ": " .. msg )
		
	chat.AddText( unpack( message ) )
		
	return true

end

local function NormalChat()

	hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
		if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
		
		local pieces, messageColor, nameColor = ply:getChatTag()
		if not pieces then return end
		
		local message = {}
		
		if dead then
			table.insert( message, Color( 255, 0, 0 ) )
			table.insert( message, "*DEAD* " )
		end
		
		if _team then
			table.insert( message, Color( 20, 160, 35 ) )
			table.insert( message, "(TEAM) ")
		end
		
		if ATAG.Gamemode_TeamTag then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
		end
		
		if ( #pieces > 0 ) then
			for k, v in pairs( pieces ) do
				table.insert( message, v.color or Color( 255, 255, 255 ) )
				table.insert( message, v.name or "" )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		
		if nameColor and nameColor != "" then
			table.insert( message, nameColor )
		elseif ATAG.Gamemode_TeamColor then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
		end
		if atlaschat or HatsChat then
			-- Suport for Atlas Chat
			-- Atlas Chat needs the entity in order to work and it will apply the last color used to the name
			-- Default chat does not do this, that is why i use ply:Nick()
			table.insert( message, ply )
		else
			table.insert( message, ply:Nick() )
		end
		
		if messageColor and messageColor != "" then
			table.insert( message, messageColor )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. msg )
		
		chat.AddText( unpack( message ) )
		
		return true
		
	end)
	
end

local function createChatHook()
	
	ATAG.gamemode = ""
	
	local detective = Color( 50, 200, 255 )

	if GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
	
		ATAG.gamemode = "Terrortown"
		
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
			
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			local isSpectator = ply:Team() == TEAM_SPEC
			if isSpectator and not dead then
				dead = true
			end
			
			if _team and ((not _team and not ply:IsSpecial()) or _team) then
				_team = false
			end
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
					table.insert( message, "(Detectives) " )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
					table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
				end
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				end
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		end)
		
		
		-- TTT Radio
		--[[
		local GetTranslation = LANG.GetTranslation
		local GetPTranslation = LANG.GetParamTranslation
		
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
		   
			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then

				if sender:IsDetective() then
					AddDetectiveText( sender, text )
				else
					chat.AddText( sender, COLOR_WHITE, ": " .. text )
				end
			else
			
				local message = {}
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. text )
				
				chat.AddText( unpack( message ) )
			
			end
		   
		end
		net.Receive( "TTT_RadioMsg", RadioMsgRecv )
		]]
		
		-- TTT Last words
		--[[
		local function LastWordsRecv()
		   local sender = net.ReadEntity()
		   local words  = net.ReadString()

		   local was_detective = IsValid(sender) and sender:IsDetective()
		   local nick = IsValid(sender) and sender:Nick() or "<Unknown>"

			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then
			
			   chat.AddText(Color( 150, 150, 150 ),
							Format("(%s) ", string.upper(GetTranslation("last_words"))),
							was_detective and Color(50, 200, 255) or Color(0, 200, 0),
							nick,
							COLOR_WHITE,
							": " .. words)
						
			else
				
				local message = {}
				
				table.insert( message, Color( 150, 150, 150 ) )
				table.insert( message, Format("(%s) ", string.upper(GetTranslation("last_words"))) )
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. words )
				
				chat.AddText( unpack( message ) )
			
			end
			
		end
		net.Receive("TTT_LastWordsMsg", LastWordsRecv)
		]]
		
	elseif DarkRP or ATAG.DarkRP then
		
		ATAG.gamemode = "DarkRP"
	
		local function DefaultMessage( ply, prefixText, textCol, msg, msgCol )
		
			local shouldShow
					
			if msg and msg ~= "" then
				if IsValid( ply ) then
					shouldShow = hook.Call( "OnPlayerChat", GAMEMODE, ply, msg, false, not ply:Alive(), prefixText, textCol, msgCol )
				end

				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText, msgCol, ": "..msg )
				end
			else
				shouldShow = hook.Call( "ChatText", GAMEMODE, "0", prefixText, prefixText, "none" )
				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText )
				end
			end
			
			chat.PlaySound()
		
		end
		
		local function DisassembleName( NameString, ply )
		
			-- /me not going to change.
			-- /radio not going to change.
			-- Normal chat
			-- (group)
			-- [Broadcast!]
			-- [Advert]
			-- (yell)
			-- (OOC)
			-- (PM)
			-- (whisper)
			
			local Name = string.Replace( NameString, ply:Nick(), "" )
			local Name = string.Replace( Name, ply:SteamName(), "" )
			
			if Name == "" then
				return ""
			elseif Name == "(OOC) " then
				return "(OOC)"
			elseif Name == "[Advert] " then
				return "[Advert]", true
			elseif Name == "(yell) " then
				return "(yell)"
			elseif Name == "(group) " then
				return "(group)"
			elseif Name == "(PM) " then
				return "(PM)"
			elseif Name == "(whisper) " then
				return "(whisper)"
			elseif Name == "[Broadcast!] " then
				return "[Broadcast!]"
			else
				return nil
			end
			
		end
		
		local function AddToChat( bits )
			
			local textCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			
			local prefixText = net.ReadString()
			
			local ply = net.ReadEntity()
			
			ply = IsValid( ply ) and ply or LocalPlayer()
			
			if prefixText == "" or not prefixText then
				prefixText = ply:Nick()
				prefixText = prefixText ~= "" and prefixText or ply:SteamName()
			end
			
			local msgCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			local msg = net.ReadString()
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if pieces then
			
				local TypeChat, useMessageColor = DisassembleName( prefixText, ply )
				
				if TypeChat then
					
					local message = {}
					
					local teamCol = GAMEMODE:GetTeamColor( ply ) or Color( 255, 255, 255 )
					
					if TypeChat and TypeChat ~= "" then
						table.insert( message, teamCol )
						table.insert( message, TypeChat .. " " )
					end
					
					if ATAG.Gamemode_TeamTag then
						table.insert( message, teamCol )
						table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
					end
					
					if ( #pieces > 0 ) then
						for k, v in pairs( pieces ) do
							table.insert( message, v.color or Color( 255, 255, 255 ) )
							table.insert( message, v.name or "" )
						end
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					
					if nameColor and nameColor != "" then
						table.insert( message, nameColor )
					elseif ATAG.Gamemode_TeamColor then
						table.insert( message, teamCol )
					end
					if atlaschat or HatsChat then
						table.insert( message, ply )
					else
						table.insert( message, ply:Nick() )
					end
					
					if useMessageColor then
						table.insert( message, msgCol or Color( 255, 255, 255 ) )
					elseif messageColor and messageColor != "" then
						table.insert( message, messageColor )
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					table.insert( message, ": " .. msg )
					
					chat.AddText( unpack( message ) )
					
					chat.PlaySound()
				
				else
				
					DefaultMessage( ply, prefixText, textCol, msg, msgCol )
					
				end
				
			else
			
				DefaultMessage( ply, prefixText, textCol, msg, msgCol )
			
			end
		end
		net.Receive( "DarkRP_Chat", AddToChat )
		
	elseif BHOP or ATAG.Bhop then -- Bunny Hop by Ilya
	
		ATAG.gamemode = "Bhop"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then ConsoleChat( msg, _team, dead ) return end
					
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ply:GetBhopRankName() then
				table.insert( message, ply:GetBhopRankColor() )
				table.insert( message, "(" .. ply:GetBhopRankName() .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		
		end)
	
	elseif PHDayZ or ATAG.DayZ then
	
		local function CChat( ply, msg, typeName, typeColor )
			
			local message = {}
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then
			
				local color = Color( 150, 0, 0 )
				if ChatPlayer:IsAdmin() then
					color = Color( 0, 255, 0 )
				elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
					color = Color( 0, 0, 255 )
				end
				
				table.insert( message, color )
				table.insert( message, ply:Nick() )
				
				table.insert( message, typeColor or Color( 255, 255, 255 ) )
				table.insert( message, " " .. typeName .. " " )
				
				table.insert( message, Color( 200, 200, 200 ) )
				table.insert( message, ": " .. msg )
			
			else
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				else
					local color = Color( 150, 0, 0 )
					if ChatPlayer:IsAdmin() then
						color = Color( 0, 255, 0 )
					elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
						color = Color( 0, 0, 255 )
					end
					table.insert( message, color )
				end
				if atlaschat or HatsChat then
					table.insert( message, ply )
				else
					table.insert( message, ply:Nick() )
				end
				
				if typeName and typeColor then
					table.insert( message, typeColor )
					table.insert( message, " " .. typeName .. " " )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 200, 200, 200 ) )
				end
				table.insert( message, ": " .. msg )
			
			end
			
			chat.AddText( unpack( message ) )

		end
	
		net.Receive("GlobalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
			
			CChat( ChatPlayer, net.ReadString(), "[Global]", Color( 125, 125, 125 ) )
			
			chat.PlaySound()
			
		end)

		net.Receive("LocalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Local]", Color( 255, 255, 255 ) )	
			
			chat.PlaySound()
			
		end)

		net.Receive("TradeChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Echange]", Color( 255, 150, 50 ) )	
			
			chat.PlaySound()
		
		end)
	
	elseif ThisClass == "gamemode_cinema" or ATAG.Cinema then
	
		ATAG.gamemode = "Cinema"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then 
			
				local message = {}
				
				if dead then
					table.insert( message, Color( 255, 0, 0 ) )
					table.insert( message, "*DEAD* " )
				end
				
				if _team then
					table.insert( message, Color( 123, 32, 29 ) )
					table.insert( message, "(GLOBAL)" )
				end
				
				table.insert( message, Color( 255, 255, 255 ) )
				table.insert( message, ": " .. msg )
					
				chat.AddText( unpack( message ) )
					
				return true
			end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 123, 32, 29 ) )
				table.insert( message, "(GLOBAL) ")
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		ATAG.gamemode = "Hide and Seek"
		
		local function chatping()
			timer.Simple(0.05,function()
				local ssn = tostring(file.Read("hideandseek/notifsound.txt","DATA"))
				if not (ssn == "None" or ssn == nil) then
					surface.PlaySound(notifsnds[ssn])
				end
			end)
		end
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			elseif _team then
				table.insert( message, COLOR_TEAM or Color( 255, 255, 255 ) )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			chatping()
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == 'gamemode_nutscript' or ATAG.NutScript then
		
		ATAG.gamemode = "NutScript"
		
		include('atags/client/nutscript_chat/nutscript_chat.lua')
		
	else
	
		ATAG.gamemode = "Default"
		
		-- Gamemodes Tested.
		-- Deathrun
		-- PropHunt
		-- JailBreak
		-- Stranded
		
		NormalChat()
		
	end
	
	-- print( "aTags, Using detected chat " .. ATAG.gamemode .. "." )
	
end

hook.Add( "PostGamemodeLoaded", "aTags_chat", createChatHook )
timer.Simple( 0.1, createChatHook )

-- "addons\\atags\\lua\\atags\\client\\chat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- HatsChat support, player's name color
hook.Add( 'HatsChatPlayerColor', 'aTags-ChatSupport', function( ply )
	local _, _, tagNameColor = ply:getChatTag()
	return tagNameColor
end)

local function ConsoleChat( msg, _team, dead )
	
	local message = {}
	
	if dead then
		table.insert( message, Color( 255, 0, 0 ) )
		table.insert( message, "*DEAD* " )
	end
	
	if _team then
		table.insert( message, Color( 20, 160, 35 ) )
		table.insert( message, "(TEAM) ")
	end
	
	table.insert( message, Color( 130, 160, 255 ) )
	table.insert( message, "(Console)" )
	
	table.insert( message, Color( 255, 255, 255 ) )
	table.insert( message, ": " .. msg )
		
	chat.AddText( unpack( message ) )
		
	return true

end

local function NormalChat()

	hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
		if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
		
		local pieces, messageColor, nameColor = ply:getChatTag()
		if not pieces then return end
		
		local message = {}
		
		if dead then
			table.insert( message, Color( 255, 0, 0 ) )
			table.insert( message, "*DEAD* " )
		end
		
		if _team then
			table.insert( message, Color( 20, 160, 35 ) )
			table.insert( message, "(TEAM) ")
		end
		
		if ATAG.Gamemode_TeamTag then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
		end
		
		if ( #pieces > 0 ) then
			for k, v in pairs( pieces ) do
				table.insert( message, v.color or Color( 255, 255, 255 ) )
				table.insert( message, v.name or "" )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		
		if nameColor and nameColor != "" then
			table.insert( message, nameColor )
		elseif ATAG.Gamemode_TeamColor then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
		end
		if atlaschat or HatsChat then
			-- Suport for Atlas Chat
			-- Atlas Chat needs the entity in order to work and it will apply the last color used to the name
			-- Default chat does not do this, that is why i use ply:Nick()
			table.insert( message, ply )
		else
			table.insert( message, ply:Nick() )
		end
		
		if messageColor and messageColor != "" then
			table.insert( message, messageColor )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. msg )
		
		chat.AddText( unpack( message ) )
		
		return true
		
	end)
	
end

local function createChatHook()
	
	ATAG.gamemode = ""
	
	local detective = Color( 50, 200, 255 )

	if GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
	
		ATAG.gamemode = "Terrortown"
		
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
			
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			local isSpectator = ply:Team() == TEAM_SPEC
			if isSpectator and not dead then
				dead = true
			end
			
			if _team and ((not _team and not ply:IsSpecial()) or _team) then
				_team = false
			end
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
					table.insert( message, "(Detectives) " )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
					table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
				end
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				end
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		end)
		
		
		-- TTT Radio
		--[[
		local GetTranslation = LANG.GetTranslation
		local GetPTranslation = LANG.GetParamTranslation
		
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
		   
			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then

				if sender:IsDetective() then
					AddDetectiveText( sender, text )
				else
					chat.AddText( sender, COLOR_WHITE, ": " .. text )
				end
			else
			
				local message = {}
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. text )
				
				chat.AddText( unpack( message ) )
			
			end
		   
		end
		net.Receive( "TTT_RadioMsg", RadioMsgRecv )
		]]
		
		-- TTT Last words
		--[[
		local function LastWordsRecv()
		   local sender = net.ReadEntity()
		   local words  = net.ReadString()

		   local was_detective = IsValid(sender) and sender:IsDetective()
		   local nick = IsValid(sender) and sender:Nick() or "<Unknown>"

			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then
			
			   chat.AddText(Color( 150, 150, 150 ),
							Format("(%s) ", string.upper(GetTranslation("last_words"))),
							was_detective and Color(50, 200, 255) or Color(0, 200, 0),
							nick,
							COLOR_WHITE,
							": " .. words)
						
			else
				
				local message = {}
				
				table.insert( message, Color( 150, 150, 150 ) )
				table.insert( message, Format("(%s) ", string.upper(GetTranslation("last_words"))) )
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. words )
				
				chat.AddText( unpack( message ) )
			
			end
			
		end
		net.Receive("TTT_LastWordsMsg", LastWordsRecv)
		]]
		
	elseif DarkRP or ATAG.DarkRP then
		
		ATAG.gamemode = "DarkRP"
	
		local function DefaultMessage( ply, prefixText, textCol, msg, msgCol )
		
			local shouldShow
					
			if msg and msg ~= "" then
				if IsValid( ply ) then
					shouldShow = hook.Call( "OnPlayerChat", GAMEMODE, ply, msg, false, not ply:Alive(), prefixText, textCol, msgCol )
				end

				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText, msgCol, ": "..msg )
				end
			else
				shouldShow = hook.Call( "ChatText", GAMEMODE, "0", prefixText, prefixText, "none" )
				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText )
				end
			end
			
			chat.PlaySound()
		
		end
		
		local function DisassembleName( NameString, ply )
		
			-- /me not going to change.
			-- /radio not going to change.
			-- Normal chat
			-- (group)
			-- [Broadcast!]
			-- [Advert]
			-- (yell)
			-- (OOC)
			-- (PM)
			-- (whisper)
			
			local Name = string.Replace( NameString, ply:Nick(), "" )
			local Name = string.Replace( Name, ply:SteamName(), "" )
			
			if Name == "" then
				return ""
			elseif Name == "(OOC) " then
				return "(OOC)"
			elseif Name == "[Advert] " then
				return "[Advert]", true
			elseif Name == "(yell) " then
				return "(yell)"
			elseif Name == "(group) " then
				return "(group)"
			elseif Name == "(PM) " then
				return "(PM)"
			elseif Name == "(whisper) " then
				return "(whisper)"
			elseif Name == "[Broadcast!] " then
				return "[Broadcast!]"
			else
				return nil
			end
			
		end
		
		local function AddToChat( bits )
			
			local textCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			
			local prefixText = net.ReadString()
			
			local ply = net.ReadEntity()
			
			ply = IsValid( ply ) and ply or LocalPlayer()
			
			if prefixText == "" or not prefixText then
				prefixText = ply:Nick()
				prefixText = prefixText ~= "" and prefixText or ply:SteamName()
			end
			
			local msgCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			local msg = net.ReadString()
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if pieces then
			
				local TypeChat, useMessageColor = DisassembleName( prefixText, ply )
				
				if TypeChat then
					
					local message = {}
					
					local teamCol = GAMEMODE:GetTeamColor( ply ) or Color( 255, 255, 255 )
					
					if TypeChat and TypeChat ~= "" then
						table.insert( message, teamCol )
						table.insert( message, TypeChat .. " " )
					end
					
					if ATAG.Gamemode_TeamTag then
						table.insert( message, teamCol )
						table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
					end
					
					if ( #pieces > 0 ) then
						for k, v in pairs( pieces ) do
							table.insert( message, v.color or Color( 255, 255, 255 ) )
							table.insert( message, v.name or "" )
						end
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					
					if nameColor and nameColor != "" then
						table.insert( message, nameColor )
					elseif ATAG.Gamemode_TeamColor then
						table.insert( message, teamCol )
					end
					if atlaschat or HatsChat then
						table.insert( message, ply )
					else
						table.insert( message, ply:Nick() )
					end
					
					if useMessageColor then
						table.insert( message, msgCol or Color( 255, 255, 255 ) )
					elseif messageColor and messageColor != "" then
						table.insert( message, messageColor )
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					table.insert( message, ": " .. msg )
					
					chat.AddText( unpack( message ) )
					
					chat.PlaySound()
				
				else
				
					DefaultMessage( ply, prefixText, textCol, msg, msgCol )
					
				end
				
			else
			
				DefaultMessage( ply, prefixText, textCol, msg, msgCol )
			
			end
		end
		net.Receive( "DarkRP_Chat", AddToChat )
		
	elseif BHOP or ATAG.Bhop then -- Bunny Hop by Ilya
	
		ATAG.gamemode = "Bhop"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then ConsoleChat( msg, _team, dead ) return end
					
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ply:GetBhopRankName() then
				table.insert( message, ply:GetBhopRankColor() )
				table.insert( message, "(" .. ply:GetBhopRankName() .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		
		end)
	
	elseif PHDayZ or ATAG.DayZ then
	
		local function CChat( ply, msg, typeName, typeColor )
			
			local message = {}
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then
			
				local color = Color( 150, 0, 0 )
				if ChatPlayer:IsAdmin() then
					color = Color( 0, 255, 0 )
				elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
					color = Color( 0, 0, 255 )
				end
				
				table.insert( message, color )
				table.insert( message, ply:Nick() )
				
				table.insert( message, typeColor or Color( 255, 255, 255 ) )
				table.insert( message, " " .. typeName .. " " )
				
				table.insert( message, Color( 200, 200, 200 ) )
				table.insert( message, ": " .. msg )
			
			else
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				else
					local color = Color( 150, 0, 0 )
					if ChatPlayer:IsAdmin() then
						color = Color( 0, 255, 0 )
					elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
						color = Color( 0, 0, 255 )
					end
					table.insert( message, color )
				end
				if atlaschat or HatsChat then
					table.insert( message, ply )
				else
					table.insert( message, ply:Nick() )
				end
				
				if typeName and typeColor then
					table.insert( message, typeColor )
					table.insert( message, " " .. typeName .. " " )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 200, 200, 200 ) )
				end
				table.insert( message, ": " .. msg )
			
			end
			
			chat.AddText( unpack( message ) )

		end
	
		net.Receive("GlobalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
			
			CChat( ChatPlayer, net.ReadString(), "[Global]", Color( 125, 125, 125 ) )
			
			chat.PlaySound()
			
		end)

		net.Receive("LocalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Local]", Color( 255, 255, 255 ) )	
			
			chat.PlaySound()
			
		end)

		net.Receive("TradeChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Echange]", Color( 255, 150, 50 ) )	
			
			chat.PlaySound()
		
		end)
	
	elseif ThisClass == "gamemode_cinema" or ATAG.Cinema then
	
		ATAG.gamemode = "Cinema"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then 
			
				local message = {}
				
				if dead then
					table.insert( message, Color( 255, 0, 0 ) )
					table.insert( message, "*DEAD* " )
				end
				
				if _team then
					table.insert( message, Color( 123, 32, 29 ) )
					table.insert( message, "(GLOBAL)" )
				end
				
				table.insert( message, Color( 255, 255, 255 ) )
				table.insert( message, ": " .. msg )
					
				chat.AddText( unpack( message ) )
					
				return true
			end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 123, 32, 29 ) )
				table.insert( message, "(GLOBAL) ")
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		ATAG.gamemode = "Hide and Seek"
		
		local function chatping()
			timer.Simple(0.05,function()
				local ssn = tostring(file.Read("hideandseek/notifsound.txt","DATA"))
				if not (ssn == "None" or ssn == nil) then
					surface.PlaySound(notifsnds[ssn])
				end
			end)
		end
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			elseif _team then
				table.insert( message, COLOR_TEAM or Color( 255, 255, 255 ) )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			chatping()
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == 'gamemode_nutscript' or ATAG.NutScript then
		
		ATAG.gamemode = "NutScript"
		
		include('atags/client/nutscript_chat/nutscript_chat.lua')
		
	else
	
		ATAG.gamemode = "Default"
		
		-- Gamemodes Tested.
		-- Deathrun
		-- PropHunt
		-- JailBreak
		-- Stranded
		
		NormalChat()
		
	end
	
	-- print( "aTags, Using detected chat " .. ATAG.gamemode .. "." )
	
end

hook.Add( "PostGamemodeLoaded", "aTags_chat", createChatHook )
timer.Simple( 0.1, createChatHook )

-- "addons\\atags\\lua\\atags\\client\\chat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- HatsChat support, player's name color
hook.Add( 'HatsChatPlayerColor', 'aTags-ChatSupport', function( ply )
	local _, _, tagNameColor = ply:getChatTag()
	return tagNameColor
end)

local function ConsoleChat( msg, _team, dead )
	
	local message = {}
	
	if dead then
		table.insert( message, Color( 255, 0, 0 ) )
		table.insert( message, "*DEAD* " )
	end
	
	if _team then
		table.insert( message, Color( 20, 160, 35 ) )
		table.insert( message, "(TEAM) ")
	end
	
	table.insert( message, Color( 130, 160, 255 ) )
	table.insert( message, "(Console)" )
	
	table.insert( message, Color( 255, 255, 255 ) )
	table.insert( message, ": " .. msg )
		
	chat.AddText( unpack( message ) )
		
	return true

end

local function NormalChat()

	hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
		if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
		
		local pieces, messageColor, nameColor = ply:getChatTag()
		if not pieces then return end
		
		local message = {}
		
		if dead then
			table.insert( message, Color( 255, 0, 0 ) )
			table.insert( message, "*DEAD* " )
		end
		
		if _team then
			table.insert( message, Color( 20, 160, 35 ) )
			table.insert( message, "(TEAM) ")
		end
		
		if ATAG.Gamemode_TeamTag then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
		end
		
		if ( #pieces > 0 ) then
			for k, v in pairs( pieces ) do
				table.insert( message, v.color or Color( 255, 255, 255 ) )
				table.insert( message, v.name or "" )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		
		if nameColor and nameColor != "" then
			table.insert( message, nameColor )
		elseif ATAG.Gamemode_TeamColor then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
		end
		if atlaschat or HatsChat then
			-- Suport for Atlas Chat
			-- Atlas Chat needs the entity in order to work and it will apply the last color used to the name
			-- Default chat does not do this, that is why i use ply:Nick()
			table.insert( message, ply )
		else
			table.insert( message, ply:Nick() )
		end
		
		if messageColor and messageColor != "" then
			table.insert( message, messageColor )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. msg )
		
		chat.AddText( unpack( message ) )
		
		return true
		
	end)
	
end

local function createChatHook()
	
	ATAG.gamemode = ""
	
	local detective = Color( 50, 200, 255 )

	if GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
	
		ATAG.gamemode = "Terrortown"
		
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
			
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			local isSpectator = ply:Team() == TEAM_SPEC
			if isSpectator and not dead then
				dead = true
			end
			
			if _team and ((not _team and not ply:IsSpecial()) or _team) then
				_team = false
			end
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
					table.insert( message, "(Detectives) " )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
					table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
				end
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				end
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		end)
		
		
		-- TTT Radio
		--[[
		local GetTranslation = LANG.GetTranslation
		local GetPTranslation = LANG.GetParamTranslation
		
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
		   
			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then

				if sender:IsDetective() then
					AddDetectiveText( sender, text )
				else
					chat.AddText( sender, COLOR_WHITE, ": " .. text )
				end
			else
			
				local message = {}
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. text )
				
				chat.AddText( unpack( message ) )
			
			end
		   
		end
		net.Receive( "TTT_RadioMsg", RadioMsgRecv )
		]]
		
		-- TTT Last words
		--[[
		local function LastWordsRecv()
		   local sender = net.ReadEntity()
		   local words  = net.ReadString()

		   local was_detective = IsValid(sender) and sender:IsDetective()
		   local nick = IsValid(sender) and sender:Nick() or "<Unknown>"

			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then
			
			   chat.AddText(Color( 150, 150, 150 ),
							Format("(%s) ", string.upper(GetTranslation("last_words"))),
							was_detective and Color(50, 200, 255) or Color(0, 200, 0),
							nick,
							COLOR_WHITE,
							": " .. words)
						
			else
				
				local message = {}
				
				table.insert( message, Color( 150, 150, 150 ) )
				table.insert( message, Format("(%s) ", string.upper(GetTranslation("last_words"))) )
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. words )
				
				chat.AddText( unpack( message ) )
			
			end
			
		end
		net.Receive("TTT_LastWordsMsg", LastWordsRecv)
		]]
		
	elseif DarkRP or ATAG.DarkRP then
		
		ATAG.gamemode = "DarkRP"
	
		local function DefaultMessage( ply, prefixText, textCol, msg, msgCol )
		
			local shouldShow
					
			if msg and msg ~= "" then
				if IsValid( ply ) then
					shouldShow = hook.Call( "OnPlayerChat", GAMEMODE, ply, msg, false, not ply:Alive(), prefixText, textCol, msgCol )
				end

				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText, msgCol, ": "..msg )
				end
			else
				shouldShow = hook.Call( "ChatText", GAMEMODE, "0", prefixText, prefixText, "none" )
				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText )
				end
			end
			
			chat.PlaySound()
		
		end
		
		local function DisassembleName( NameString, ply )
		
			-- /me not going to change.
			-- /radio not going to change.
			-- Normal chat
			-- (group)
			-- [Broadcast!]
			-- [Advert]
			-- (yell)
			-- (OOC)
			-- (PM)
			-- (whisper)
			
			local Name = string.Replace( NameString, ply:Nick(), "" )
			local Name = string.Replace( Name, ply:SteamName(), "" )
			
			if Name == "" then
				return ""
			elseif Name == "(OOC) " then
				return "(OOC)"
			elseif Name == "[Advert] " then
				return "[Advert]", true
			elseif Name == "(yell) " then
				return "(yell)"
			elseif Name == "(group) " then
				return "(group)"
			elseif Name == "(PM) " then
				return "(PM)"
			elseif Name == "(whisper) " then
				return "(whisper)"
			elseif Name == "[Broadcast!] " then
				return "[Broadcast!]"
			else
				return nil
			end
			
		end
		
		local function AddToChat( bits )
			
			local textCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			
			local prefixText = net.ReadString()
			
			local ply = net.ReadEntity()
			
			ply = IsValid( ply ) and ply or LocalPlayer()
			
			if prefixText == "" or not prefixText then
				prefixText = ply:Nick()
				prefixText = prefixText ~= "" and prefixText or ply:SteamName()
			end
			
			local msgCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			local msg = net.ReadString()
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if pieces then
			
				local TypeChat, useMessageColor = DisassembleName( prefixText, ply )
				
				if TypeChat then
					
					local message = {}
					
					local teamCol = GAMEMODE:GetTeamColor( ply ) or Color( 255, 255, 255 )
					
					if TypeChat and TypeChat ~= "" then
						table.insert( message, teamCol )
						table.insert( message, TypeChat .. " " )
					end
					
					if ATAG.Gamemode_TeamTag then
						table.insert( message, teamCol )
						table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
					end
					
					if ( #pieces > 0 ) then
						for k, v in pairs( pieces ) do
							table.insert( message, v.color or Color( 255, 255, 255 ) )
							table.insert( message, v.name or "" )
						end
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					
					if nameColor and nameColor != "" then
						table.insert( message, nameColor )
					elseif ATAG.Gamemode_TeamColor then
						table.insert( message, teamCol )
					end
					if atlaschat or HatsChat then
						table.insert( message, ply )
					else
						table.insert( message, ply:Nick() )
					end
					
					if useMessageColor then
						table.insert( message, msgCol or Color( 255, 255, 255 ) )
					elseif messageColor and messageColor != "" then
						table.insert( message, messageColor )
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					table.insert( message, ": " .. msg )
					
					chat.AddText( unpack( message ) )
					
					chat.PlaySound()
				
				else
				
					DefaultMessage( ply, prefixText, textCol, msg, msgCol )
					
				end
				
			else
			
				DefaultMessage( ply, prefixText, textCol, msg, msgCol )
			
			end
		end
		net.Receive( "DarkRP_Chat", AddToChat )
		
	elseif BHOP or ATAG.Bhop then -- Bunny Hop by Ilya
	
		ATAG.gamemode = "Bhop"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then ConsoleChat( msg, _team, dead ) return end
					
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ply:GetBhopRankName() then
				table.insert( message, ply:GetBhopRankColor() )
				table.insert( message, "(" .. ply:GetBhopRankName() .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		
		end)
	
	elseif PHDayZ or ATAG.DayZ then
	
		local function CChat( ply, msg, typeName, typeColor )
			
			local message = {}
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then
			
				local color = Color( 150, 0, 0 )
				if ChatPlayer:IsAdmin() then
					color = Color( 0, 255, 0 )
				elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
					color = Color( 0, 0, 255 )
				end
				
				table.insert( message, color )
				table.insert( message, ply:Nick() )
				
				table.insert( message, typeColor or Color( 255, 255, 255 ) )
				table.insert( message, " " .. typeName .. " " )
				
				table.insert( message, Color( 200, 200, 200 ) )
				table.insert( message, ": " .. msg )
			
			else
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				else
					local color = Color( 150, 0, 0 )
					if ChatPlayer:IsAdmin() then
						color = Color( 0, 255, 0 )
					elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
						color = Color( 0, 0, 255 )
					end
					table.insert( message, color )
				end
				if atlaschat or HatsChat then
					table.insert( message, ply )
				else
					table.insert( message, ply:Nick() )
				end
				
				if typeName and typeColor then
					table.insert( message, typeColor )
					table.insert( message, " " .. typeName .. " " )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 200, 200, 200 ) )
				end
				table.insert( message, ": " .. msg )
			
			end
			
			chat.AddText( unpack( message ) )

		end
	
		net.Receive("GlobalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
			
			CChat( ChatPlayer, net.ReadString(), "[Global]", Color( 125, 125, 125 ) )
			
			chat.PlaySound()
			
		end)

		net.Receive("LocalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Local]", Color( 255, 255, 255 ) )	
			
			chat.PlaySound()
			
		end)

		net.Receive("TradeChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Echange]", Color( 255, 150, 50 ) )	
			
			chat.PlaySound()
		
		end)
	
	elseif ThisClass == "gamemode_cinema" or ATAG.Cinema then
	
		ATAG.gamemode = "Cinema"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then 
			
				local message = {}
				
				if dead then
					table.insert( message, Color( 255, 0, 0 ) )
					table.insert( message, "*DEAD* " )
				end
				
				if _team then
					table.insert( message, Color( 123, 32, 29 ) )
					table.insert( message, "(GLOBAL)" )
				end
				
				table.insert( message, Color( 255, 255, 255 ) )
				table.insert( message, ": " .. msg )
					
				chat.AddText( unpack( message ) )
					
				return true
			end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 123, 32, 29 ) )
				table.insert( message, "(GLOBAL) ")
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		ATAG.gamemode = "Hide and Seek"
		
		local function chatping()
			timer.Simple(0.05,function()
				local ssn = tostring(file.Read("hideandseek/notifsound.txt","DATA"))
				if not (ssn == "None" or ssn == nil) then
					surface.PlaySound(notifsnds[ssn])
				end
			end)
		end
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			elseif _team then
				table.insert( message, COLOR_TEAM or Color( 255, 255, 255 ) )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			chatping()
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == 'gamemode_nutscript' or ATAG.NutScript then
		
		ATAG.gamemode = "NutScript"
		
		include('atags/client/nutscript_chat/nutscript_chat.lua')
		
	else
	
		ATAG.gamemode = "Default"
		
		-- Gamemodes Tested.
		-- Deathrun
		-- PropHunt
		-- JailBreak
		-- Stranded
		
		NormalChat()
		
	end
	
	-- print( "aTags, Using detected chat " .. ATAG.gamemode .. "." )
	
end

hook.Add( "PostGamemodeLoaded", "aTags_chat", createChatHook )
timer.Simple( 0.1, createChatHook )

-- "addons\\atags\\lua\\atags\\client\\chat.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- HatsChat support, player's name color
hook.Add( 'HatsChatPlayerColor', 'aTags-ChatSupport', function( ply )
	local _, _, tagNameColor = ply:getChatTag()
	return tagNameColor
end)

local function ConsoleChat( msg, _team, dead )
	
	local message = {}
	
	if dead then
		table.insert( message, Color( 255, 0, 0 ) )
		table.insert( message, "*DEAD* " )
	end
	
	if _team then
		table.insert( message, Color( 20, 160, 35 ) )
		table.insert( message, "(TEAM) ")
	end
	
	table.insert( message, Color( 130, 160, 255 ) )
	table.insert( message, "(Console)" )
	
	table.insert( message, Color( 255, 255, 255 ) )
	table.insert( message, ": " .. msg )
		
	chat.AddText( unpack( message ) )
		
	return true

end

local function NormalChat()

	hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
		if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
		
		local pieces, messageColor, nameColor = ply:getChatTag()
		if not pieces then return end
		
		local message = {}
		
		if dead then
			table.insert( message, Color( 255, 0, 0 ) )
			table.insert( message, "*DEAD* " )
		end
		
		if _team then
			table.insert( message, Color( 20, 160, 35 ) )
			table.insert( message, "(TEAM) ")
		end
		
		if ATAG.Gamemode_TeamTag then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
		end
		
		if ( #pieces > 0 ) then
			for k, v in pairs( pieces ) do
				table.insert( message, v.color or Color( 255, 255, 255 ) )
				table.insert( message, v.name or "" )
			end
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		
		if nameColor and nameColor != "" then
			table.insert( message, nameColor )
		elseif ATAG.Gamemode_TeamColor then
			table.insert( message, GAMEMODE:GetTeamColor( ply ) )
		end
		if atlaschat or HatsChat then
			-- Suport for Atlas Chat
			-- Atlas Chat needs the entity in order to work and it will apply the last color used to the name
			-- Default chat does not do this, that is why i use ply:Nick()
			table.insert( message, ply )
		else
			table.insert( message, ply:Nick() )
		end
		
		if messageColor and messageColor != "" then
			table.insert( message, messageColor )
		else
			table.insert( message, Color( 255, 255, 255 ) )
		end
		table.insert( message, ": " .. msg )
		
		chat.AddText( unpack( message ) )
		
		return true
		
	end)
	
end

local function createChatHook()
	
	ATAG.gamemode = ""
	
	local detective = Color( 50, 200, 255 )

	if GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
	
		ATAG.gamemode = "Terrortown"
		
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
			
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			local isSpectator = ply:Team() == TEAM_SPEC
			if isSpectator and not dead then
				dead = true
			end
			
			if _team and ((not _team and not ply:IsSpecial()) or _team) then
				_team = false
			end
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
					table.insert( message, "(Detectives) " )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
					table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
				end
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				if ply:IsActiveDetective() then
					table.insert( message, detective )
				else
					table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				end
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		end)
		
		
		-- TTT Radio
		--[[
		local GetTranslation = LANG.GetTranslation
		local GetPTranslation = LANG.GetParamTranslation
		
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
		   
			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then

				if sender:IsDetective() then
					AddDetectiveText( sender, text )
				else
					chat.AddText( sender, COLOR_WHITE, ": " .. text )
				end
			else
			
				local message = {}
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. text )
				
				chat.AddText( unpack( message ) )
			
			end
		   
		end
		net.Receive( "TTT_RadioMsg", RadioMsgRecv )
		]]
		
		-- TTT Last words
		--[[
		local function LastWordsRecv()
		   local sender = net.ReadEntity()
		   local words  = net.ReadString()

		   local was_detective = IsValid(sender) and sender:IsDetective()
		   local nick = IsValid(sender) and sender:Nick() or "<Unknown>"

			local pieces, messageColor, nameColor = sender:getChatTag()
			if not pieces then
			
			   chat.AddText(Color( 150, 150, 150 ),
							Format("(%s) ", string.upper(GetTranslation("last_words"))),
							was_detective and Color(50, 200, 255) or Color(0, 200, 0),
							nick,
							COLOR_WHITE,
							": " .. words)
						
			else
				
				local message = {}
				
				table.insert( message, Color( 150, 150, 150 ) )
				table.insert( message, Format("(%s) ", string.upper(GetTranslation("last_words"))) )
			
				if ATAG.Gamemode_TeamTag then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
						table.insert( message, "(Detectives) " )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
						table.insert( message, "(" .. team.GetName( sender:Team() ) .. ") " )
					end
				end
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				elseif ATAG.Gamemode_TeamColor then
					if sender:IsActiveDetective() then
						table.insert( message, detective )
					else
						table.insert( message, GAMEMODE:GetTeamColor( sender ) )
					end
				end
				if atlaschat or HatsChat then
					table.insert( message, sender )
				else
					table.insert( message, sender:Nick() )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				table.insert( message, ": " .. words )
				
				chat.AddText( unpack( message ) )
			
			end
			
		end
		net.Receive("TTT_LastWordsMsg", LastWordsRecv)
		]]
		
	elseif DarkRP or ATAG.DarkRP then
		
		ATAG.gamemode = "DarkRP"
	
		local function DefaultMessage( ply, prefixText, textCol, msg, msgCol )
		
			local shouldShow
					
			if msg and msg ~= "" then
				if IsValid( ply ) then
					shouldShow = hook.Call( "OnPlayerChat", GAMEMODE, ply, msg, false, not ply:Alive(), prefixText, textCol, msgCol )
				end

				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText, msgCol, ": "..msg )
				end
			else
				shouldShow = hook.Call( "ChatText", GAMEMODE, "0", prefixText, prefixText, "none" )
				if shouldShow ~= true then
					chat.AddNonParsedText( textCol, prefixText )
				end
			end
			
			chat.PlaySound()
		
		end
		
		local function DisassembleName( NameString, ply )
		
			-- /me not going to change.
			-- /radio not going to change.
			-- Normal chat
			-- (group)
			-- [Broadcast!]
			-- [Advert]
			-- (yell)
			-- (OOC)
			-- (PM)
			-- (whisper)
			
			local Name = string.Replace( NameString, ply:Nick(), "" )
			local Name = string.Replace( Name, ply:SteamName(), "" )
			
			if Name == "" then
				return ""
			elseif Name == "(OOC) " then
				return "(OOC)"
			elseif Name == "[Advert] " then
				return "[Advert]", true
			elseif Name == "(yell) " then
				return "(yell)"
			elseif Name == "(group) " then
				return "(group)"
			elseif Name == "(PM) " then
				return "(PM)"
			elseif Name == "(whisper) " then
				return "(whisper)"
			elseif Name == "[Broadcast!] " then
				return "[Broadcast!]"
			else
				return nil
			end
			
		end
		
		local function AddToChat( bits )
			
			local textCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			
			local prefixText = net.ReadString()
			
			local ply = net.ReadEntity()
			
			ply = IsValid( ply ) and ply or LocalPlayer()
			
			if prefixText == "" or not prefixText then
				prefixText = ply:Nick()
				prefixText = prefixText ~= "" and prefixText or ply:SteamName()
			end
			
			local msgCol = Color( net.ReadUInt( 8 ), net.ReadUInt( 8 ), net.ReadUInt( 8 ) )
			local msg = net.ReadString()
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if pieces then
			
				local TypeChat, useMessageColor = DisassembleName( prefixText, ply )
				
				if TypeChat then
					
					local message = {}
					
					local teamCol = GAMEMODE:GetTeamColor( ply ) or Color( 255, 255, 255 )
					
					if TypeChat and TypeChat ~= "" then
						table.insert( message, teamCol )
						table.insert( message, TypeChat .. " " )
					end
					
					if ATAG.Gamemode_TeamTag then
						table.insert( message, teamCol )
						table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
					end
					
					if ( #pieces > 0 ) then
						for k, v in pairs( pieces ) do
							table.insert( message, v.color or Color( 255, 255, 255 ) )
							table.insert( message, v.name or "" )
						end
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					
					if nameColor and nameColor != "" then
						table.insert( message, nameColor )
					elseif ATAG.Gamemode_TeamColor then
						table.insert( message, teamCol )
					end
					if atlaschat or HatsChat then
						table.insert( message, ply )
					else
						table.insert( message, ply:Nick() )
					end
					
					if useMessageColor then
						table.insert( message, msgCol or Color( 255, 255, 255 ) )
					elseif messageColor and messageColor != "" then
						table.insert( message, messageColor )
					else
						table.insert( message, Color( 255, 255, 255 ) )
					end
					table.insert( message, ": " .. msg )
					
					chat.AddText( unpack( message ) )
					
					chat.PlaySound()
				
				else
				
					DefaultMessage( ply, prefixText, textCol, msg, msgCol )
					
				end
				
			else
			
				DefaultMessage( ply, prefixText, textCol, msg, msgCol )
			
			end
		end
		net.Receive( "DarkRP_Chat", AddToChat )
		
	elseif BHOP or ATAG.Bhop then -- Bunny Hop by Ilya
	
		ATAG.gamemode = "Bhop"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then ConsoleChat( msg, _team, dead ) return end
					
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 20, 160, 35 ) )
				table.insert( message, "(TEAM) ")
			end
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ply:GetBhopRankName() then
				table.insert( message, ply:GetBhopRankColor() )
				table.insert( message, "(" .. ply:GetBhopRankName() .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
		
		end)
	
	elseif PHDayZ or ATAG.DayZ then
	
		local function CChat( ply, msg, typeName, typeColor )
			
			local message = {}
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then
			
				local color = Color( 150, 0, 0 )
				if ChatPlayer:IsAdmin() then
					color = Color( 0, 255, 0 )
				elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
					color = Color( 0, 0, 255 )
				end
				
				table.insert( message, color )
				table.insert( message, ply:Nick() )
				
				table.insert( message, typeColor or Color( 255, 255, 255 ) )
				table.insert( message, " " .. typeName .. " " )
				
				table.insert( message, Color( 200, 200, 200 ) )
				table.insert( message, ": " .. msg )
			
			else
				
				if ( #pieces > 0 ) then
					for k, v in pairs( pieces ) do
						table.insert( message, v.color or Color( 255, 255, 255 ) )
						table.insert( message, v.name or "" )
					end
				else
					table.insert( message, Color( 255, 255, 255 ) )
				end
				
				if nameColor and nameColor != "" then
					table.insert( message, nameColor )
				else
					local color = Color( 150, 0, 0 )
					if ChatPlayer:IsAdmin() then
						color = Color( 0, 255, 0 )
					elseif ChatPlayer:IsVIP() and PHDayZ.ShowVIPColors then
						color = Color( 0, 0, 255 )
					end
					table.insert( message, color )
				end
				if atlaschat or HatsChat then
					table.insert( message, ply )
				else
					table.insert( message, ply:Nick() )
				end
				
				if typeName and typeColor then
					table.insert( message, typeColor )
					table.insert( message, " " .. typeName .. " " )
				end
				
				if messageColor and messageColor != "" then
					table.insert( message, messageColor )
				else
					table.insert( message, Color( 200, 200, 200 ) )
				end
				table.insert( message, ": " .. msg )
			
			end
			
			chat.AddText( unpack( message ) )

		end
	
		net.Receive("GlobalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
			
			CChat( ChatPlayer, net.ReadString(), "[Global]", Color( 125, 125, 125 ) )
			
			chat.PlaySound()
			
		end)

		net.Receive("LocalChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Local]", Color( 255, 255, 255 ) )	
			
			chat.PlaySound()
			
		end)

		net.Receive("TradeChat", function(len)
			ChatPlayer = player.GetByID( net.ReadFloat() )
			
			if !ChatPlayer:IsValid() then return end
				
			CChat( ChatPlayer, net.ReadString(), "[Echange]", Color( 255, 150, 50 ) )	
			
			chat.PlaySound()
		
		end)
	
	elseif ThisClass == "gamemode_cinema" or ATAG.Cinema then
	
		ATAG.gamemode = "Cinema"
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then 
			
				local message = {}
				
				if dead then
					table.insert( message, Color( 255, 0, 0 ) )
					table.insert( message, "*DEAD* " )
				end
				
				if _team then
					table.insert( message, Color( 123, 32, 29 ) )
					table.insert( message, "(GLOBAL)" )
				end
				
				table.insert( message, Color( 255, 255, 255 ) )
				table.insert( message, ": " .. msg )
					
				chat.AddText( unpack( message ) )
					
				return true
			end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if dead then
				table.insert( message, Color( 255, 0, 0 ) )
				table.insert( message, "*DEAD* " )
			end
			
			if _team then
				table.insert( message, Color( 123, 32, 29 ) )
				table.insert( message, "(GLOBAL) ")
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		ATAG.gamemode = "Hide and Seek"
		
		local function chatping()
			timer.Simple(0.05,function()
				local ssn = tostring(file.Read("hideandseek/notifsound.txt","DATA"))
				if not (ssn == "None" or ssn == nil) then
					surface.PlaySound(notifsnds[ssn])
				end
			end)
		end
	
		hook.Add( "OnPlayerChat", "ATAG_ChatTags", function( ply, msg, _team, dead )
		
			if not IsValid( ply ) then --[[ConsoleChat( msg, _team, dead )]] return end
			
			local pieces, messageColor, nameColor = ply:getChatTag()
			if not pieces then return end
			
			local message = {}
			
			if ATAG.Gamemode_TeamTag then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
				table.insert( message, "(" .. team.GetName( ply:Team() ) .. ") " )
			end
			
			if ( #pieces > 0 ) then
				for k, v in pairs( pieces ) do
					table.insert( message, v.color or Color( 255, 255, 255 ) )
					table.insert( message, v.name or "" )
				end
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			
			if nameColor and nameColor != "" then
				table.insert( message, nameColor )
			elseif ATAG.Gamemode_TeamColor then
				table.insert( message, GAMEMODE:GetTeamColor( ply ) )
			end
			if atlaschat or HatsChat then
				table.insert( message, ply )
			else
				table.insert( message, ply:Nick() )
			end
			
			if messageColor and messageColor != "" then
				table.insert( message, messageColor )
			elseif _team then
				table.insert( message, COLOR_TEAM or Color( 255, 255, 255 ) )
			else
				table.insert( message, Color( 255, 255, 255 ) )
			end
			table.insert( message, ": " .. msg )
			
			chat.AddText( unpack( message ) )
			
			chatping()
			
			return true
			
		end)
		
	elseif GAMEMODE.ThisClass == 'gamemode_nutscript' or ATAG.NutScript then
		
		ATAG.gamemode = "NutScript"
		
		include('atags/client/nutscript_chat/nutscript_chat.lua')
		
	else
	
		ATAG.gamemode = "Default"
		
		-- Gamemodes Tested.
		-- Deathrun
		-- PropHunt
		-- JailBreak
		-- Stranded
		
		NormalChat()
		
	end
	
	-- print( "aTags, Using detected chat " .. ATAG.gamemode .. "." )
	
end

hook.Add( "PostGamemodeLoaded", "aTags_chat", createChatHook )
timer.Simple( 0.1, createChatHook )

