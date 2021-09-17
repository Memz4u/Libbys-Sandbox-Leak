-- "addons\\atags\\lua\\atags\\shared\\scoreboard_override.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function GetGamemode()

	if DarkRP or ATAG.DarkRP then
	
		return "darkrp"
		
	elseif GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
		
		return "terrortown"
	
	elseif GAMEMODE.ThisClass == "gamemode_deathrun" or ATAG.Deathrun then
	
		return "deathrun"
	
	elseif GAMEMODE.ThisClass == "gamemode_gmstranded" or GMS or ATAG.GMStranded then
		
		return "gmstranded"
		
	elseif GAMEMODE.ThisClass == "gamemode_zombiesurvival" or ATAG.ZombieSurvival then
		
		return "zombiesurvival"
		
	elseif GAMEMODE.ThisClass == "gamemode_cinema" or ATAG.Cinema then
		
		return "cinema"
		
	elseif GAMEMODE.ThisClass == "gamemode_sandbox" or ATAG.Sandbox then
		
		return "base"
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		return "hideandseek"
		
	elseif GAMEMODE.ThisClass == "gamemode_murder" or ATAG.Murder then
		
		return "murder"
		
	else
	
		return ""
	
	end
	
end

local function GetFiles()
	local files, _ = file.Find( "scoreboard/*", "LUA" )
	return files
end

local function Override( file )

	GMTemp = GM
	GM = GAMEMODE

	if SERVER then
	
		AddCSLuaFile( "scoreboard/" .. file )
	
	else
	
		include( "scoreboard/" .. file )
		
	end
	
	GM = GMTemp
	
end

local function SetScoreboard()

	if not ATAG.EnableScoreboardOverride then return end

	local files = GetFiles()
	
	for k, v in pairs( files ) do
	
		if GetGamemode() .. ".lua" == v then
		
			Override( v )
			
			-- print( "aTags, Using detected scoreboard " .. GetGamemode() .. "." )
			
		end
	
	end	

end
hook.Add( "Initialize", "aTags Scoreboard Initialize", function()

	SetScoreboard()
	
end)

-- "addons\\atags\\lua\\atags\\shared\\scoreboard_override.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function GetGamemode()

	if DarkRP or ATAG.DarkRP then
	
		return "darkrp"
		
	elseif GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
		
		return "terrortown"
	
	elseif GAMEMODE.ThisClass == "gamemode_deathrun" or ATAG.Deathrun then
	
		return "deathrun"
	
	elseif GAMEMODE.ThisClass == "gamemode_gmstranded" or GMS or ATAG.GMStranded then
		
		return "gmstranded"
		
	elseif GAMEMODE.ThisClass == "gamemode_zombiesurvival" or ATAG.ZombieSurvival then
		
		return "zombiesurvival"
		
	elseif GAMEMODE.ThisClass == "gamemode_cinema" or ATAG.Cinema then
		
		return "cinema"
		
	elseif GAMEMODE.ThisClass == "gamemode_sandbox" or ATAG.Sandbox then
		
		return "base"
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		return "hideandseek"
		
	elseif GAMEMODE.ThisClass == "gamemode_murder" or ATAG.Murder then
		
		return "murder"
		
	else
	
		return ""
	
	end
	
end

local function GetFiles()
	local files, _ = file.Find( "scoreboard/*", "LUA" )
	return files
end

local function Override( file )

	GMTemp = GM
	GM = GAMEMODE

	if SERVER then
	
		AddCSLuaFile( "scoreboard/" .. file )
	
	else
	
		include( "scoreboard/" .. file )
		
	end
	
	GM = GMTemp
	
end

local function SetScoreboard()

	if not ATAG.EnableScoreboardOverride then return end

	local files = GetFiles()
	
	for k, v in pairs( files ) do
	
		if GetGamemode() .. ".lua" == v then
		
			Override( v )
			
			-- print( "aTags, Using detected scoreboard " .. GetGamemode() .. "." )
			
		end
	
	end	

end
hook.Add( "Initialize", "aTags Scoreboard Initialize", function()

	SetScoreboard()
	
end)

-- "addons\\atags\\lua\\atags\\shared\\scoreboard_override.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function GetGamemode()

	if DarkRP or ATAG.DarkRP then
	
		return "darkrp"
		
	elseif GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
		
		return "terrortown"
	
	elseif GAMEMODE.ThisClass == "gamemode_deathrun" or ATAG.Deathrun then
	
		return "deathrun"
	
	elseif GAMEMODE.ThisClass == "gamemode_gmstranded" or GMS or ATAG.GMStranded then
		
		return "gmstranded"
		
	elseif GAMEMODE.ThisClass == "gamemode_zombiesurvival" or ATAG.ZombieSurvival then
		
		return "zombiesurvival"
		
	elseif GAMEMODE.ThisClass == "gamemode_cinema" or ATAG.Cinema then
		
		return "cinema"
		
	elseif GAMEMODE.ThisClass == "gamemode_sandbox" or ATAG.Sandbox then
		
		return "base"
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		return "hideandseek"
		
	elseif GAMEMODE.ThisClass == "gamemode_murder" or ATAG.Murder then
		
		return "murder"
		
	else
	
		return ""
	
	end
	
end

local function GetFiles()
	local files, _ = file.Find( "scoreboard/*", "LUA" )
	return files
end

local function Override( file )

	GMTemp = GM
	GM = GAMEMODE

	if SERVER then
	
		AddCSLuaFile( "scoreboard/" .. file )
	
	else
	
		include( "scoreboard/" .. file )
		
	end
	
	GM = GMTemp
	
end

local function SetScoreboard()

	if not ATAG.EnableScoreboardOverride then return end

	local files = GetFiles()
	
	for k, v in pairs( files ) do
	
		if GetGamemode() .. ".lua" == v then
		
			Override( v )
			
			-- print( "aTags, Using detected scoreboard " .. GetGamemode() .. "." )
			
		end
	
	end	

end
hook.Add( "Initialize", "aTags Scoreboard Initialize", function()

	SetScoreboard()
	
end)

-- "addons\\atags\\lua\\atags\\shared\\scoreboard_override.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function GetGamemode()

	if DarkRP or ATAG.DarkRP then
	
		return "darkrp"
		
	elseif GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
		
		return "terrortown"
	
	elseif GAMEMODE.ThisClass == "gamemode_deathrun" or ATAG.Deathrun then
	
		return "deathrun"
	
	elseif GAMEMODE.ThisClass == "gamemode_gmstranded" or GMS or ATAG.GMStranded then
		
		return "gmstranded"
		
	elseif GAMEMODE.ThisClass == "gamemode_zombiesurvival" or ATAG.ZombieSurvival then
		
		return "zombiesurvival"
		
	elseif GAMEMODE.ThisClass == "gamemode_cinema" or ATAG.Cinema then
		
		return "cinema"
		
	elseif GAMEMODE.ThisClass == "gamemode_sandbox" or ATAG.Sandbox then
		
		return "base"
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		return "hideandseek"
		
	elseif GAMEMODE.ThisClass == "gamemode_murder" or ATAG.Murder then
		
		return "murder"
		
	else
	
		return ""
	
	end
	
end

local function GetFiles()
	local files, _ = file.Find( "scoreboard/*", "LUA" )
	return files
end

local function Override( file )

	GMTemp = GM
	GM = GAMEMODE

	if SERVER then
	
		AddCSLuaFile( "scoreboard/" .. file )
	
	else
	
		include( "scoreboard/" .. file )
		
	end
	
	GM = GMTemp
	
end

local function SetScoreboard()

	if not ATAG.EnableScoreboardOverride then return end

	local files = GetFiles()
	
	for k, v in pairs( files ) do
	
		if GetGamemode() .. ".lua" == v then
		
			Override( v )
			
			-- print( "aTags, Using detected scoreboard " .. GetGamemode() .. "." )
			
		end
	
	end	

end
hook.Add( "Initialize", "aTags Scoreboard Initialize", function()

	SetScoreboard()
	
end)

-- "addons\\atags\\lua\\atags\\shared\\scoreboard_override.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function GetGamemode()

	if DarkRP or ATAG.DarkRP then
	
		return "darkrp"
		
	elseif GAMEMODE.ThisClass == "gamemode_terrortown" or ATAG.Terrortown then
		
		return "terrortown"
	
	elseif GAMEMODE.ThisClass == "gamemode_deathrun" or ATAG.Deathrun then
	
		return "deathrun"
	
	elseif GAMEMODE.ThisClass == "gamemode_gmstranded" or GMS or ATAG.GMStranded then
		
		return "gmstranded"
		
	elseif GAMEMODE.ThisClass == "gamemode_zombiesurvival" or ATAG.ZombieSurvival then
		
		return "zombiesurvival"
		
	elseif GAMEMODE.ThisClass == "gamemode_cinema" or ATAG.Cinema then
		
		return "cinema"
		
	elseif GAMEMODE.ThisClass == "gamemode_sandbox" or ATAG.Sandbox then
		
		return "base"
		
	elseif GAMEMODE.ThisClass == "gamemode_hideandseek" or ATAG.HideAndSeek then
		
		return "hideandseek"
		
	elseif GAMEMODE.ThisClass == "gamemode_murder" or ATAG.Murder then
		
		return "murder"
		
	else
	
		return ""
	
	end
	
end

local function GetFiles()
	local files, _ = file.Find( "scoreboard/*", "LUA" )
	return files
end

local function Override( file )

	GMTemp = GM
	GM = GAMEMODE

	if SERVER then
	
		AddCSLuaFile( "scoreboard/" .. file )
	
	else
	
		include( "scoreboard/" .. file )
		
	end
	
	GM = GMTemp
	
end

local function SetScoreboard()

	if not ATAG.EnableScoreboardOverride then return end

	local files = GetFiles()
	
	for k, v in pairs( files ) do
	
		if GetGamemode() .. ".lua" == v then
		
			Override( v )
			
			-- print( "aTags, Using detected scoreboard " .. GetGamemode() .. "." )
			
		end
	
	end	

end
hook.Add( "Initialize", "aTags Scoreboard Initialize", function()

	SetScoreboard()
	
end)

