-- "lua\\ulx\\modules\\sh\\setname.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--[[
   _____      _     _   _                        ______           _    _ _      
  / ____|    | |   | \ | |                      |  ____|         | |  | | |     
 | (___   ___| |_  |  \| | __ _ _ __ ___   ___  | |__ ___  _ __  | |  | | |_  __
  \___ \ / _ \ __| | . ` |/ _` | '_ ` _ \ / _ \ |  __/ _ \| '__| | |  | | \ \/ /
  ____) |  __/ |_  | |\  | (_| | | | | | |  __/ | | | (_) | |    | |__| | |>  < 
 |_____/ \___|\__| |_| \_|\__,_|_| |_| |_|\___| |_|  \___/|_|     \____/|_/_/\_\
                                                                                
                                                                                
  ____          _    _                           ______    _                _   __ ____ ____ ______ 
 |  _ \        | |  | |                         |  ____|  (_)              | | /_ |___ \___ \____  |
 | |_) |_   _  | |__| | __ _ _ __  _ __  _   _  | |__ _ __ _  ___ _ __   __| |  | | __) |__) |  / / 
 |  _ <| | | | |  __  |/ _` | '_ \| '_ \| | | | |  __| '__| |/ _ \ '_ \ / _` |  | ||__ <|__ <  / /  
 | |_) | |_| | | |  | | (_| | |_) | |_) | |_| | | |  | |  | |  __/ | | | (_| |  | |___) |__) |/ /   
 |____/ \__, | |_|  |_|\__,_| .__/| .__/ \__, | |_|  |_|  |_|\___|_| |_|\__,_|  |_|____/____//_/    
         __/ |              | |   | |     __/ |                                                     
        |___/               |_|   |_|    |___/                                                      
--]]
local CATEGORY_NAME = "HAPPY-Power"

local PlayerNameOrNick = debug.getregistry().Player
PlayerNameOrNick.RealName = PlayerNameOrNick.Nick
PlayerNameOrNick.Nick = function(self) if self != nil then return self:GetNWString("PlayerName", self:RealName()) else return "" end end
PlayerNameOrNick.Name = PlayerNameOrNick.Nick
PlayerNameOrNick.GetName = PlayerNameOrNick.Nick

function ulx.setName( calling_ply, target_ply, name )
local PlayerNick = target_ply:Nick() 
    target_ply:SetNWString("PlayerName",name)
    ulx.fancyLogAdmin( calling_ply, "#A set "..PlayerNick.." Name to "..name, target_ply, name )
end
local setName = ulx.command( CATEGORY_NAME, "ulx setname", ulx.setName, "!setname" )
setName:addParam{ type=ULib.cmds.PlayerArg }
setName:addParam{ type=ULib.cmds.StringArg, hint="name", ULib.cmds.takeRestOfLine }
setName:defaultAccess( ULib.ACCESS_ADMIN )
setName:help( "Sets target's Name \n SetName By Happy friend1337" )


-- "lua\\ulx\\modules\\sh\\setname.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--[[
   _____      _     _   _                        ______           _    _ _      
  / ____|    | |   | \ | |                      |  ____|         | |  | | |     
 | (___   ___| |_  |  \| | __ _ _ __ ___   ___  | |__ ___  _ __  | |  | | |_  __
  \___ \ / _ \ __| | . ` |/ _` | '_ ` _ \ / _ \ |  __/ _ \| '__| | |  | | \ \/ /
  ____) |  __/ |_  | |\  | (_| | | | | | |  __/ | | | (_) | |    | |__| | |>  < 
 |_____/ \___|\__| |_| \_|\__,_|_| |_| |_|\___| |_|  \___/|_|     \____/|_/_/\_\
                                                                                
                                                                                
  ____          _    _                           ______    _                _   __ ____ ____ ______ 
 |  _ \        | |  | |                         |  ____|  (_)              | | /_ |___ \___ \____  |
 | |_) |_   _  | |__| | __ _ _ __  _ __  _   _  | |__ _ __ _  ___ _ __   __| |  | | __) |__) |  / / 
 |  _ <| | | | |  __  |/ _` | '_ \| '_ \| | | | |  __| '__| |/ _ \ '_ \ / _` |  | ||__ <|__ <  / /  
 | |_) | |_| | | |  | | (_| | |_) | |_) | |_| | | |  | |  | |  __/ | | | (_| |  | |___) |__) |/ /   
 |____/ \__, | |_|  |_|\__,_| .__/| .__/ \__, | |_|  |_|  |_|\___|_| |_|\__,_|  |_|____/____//_/    
         __/ |              | |   | |     __/ |                                                     
        |___/               |_|   |_|    |___/                                                      
--]]
local CATEGORY_NAME = "HAPPY-Power"

local PlayerNameOrNick = debug.getregistry().Player
PlayerNameOrNick.RealName = PlayerNameOrNick.Nick
PlayerNameOrNick.Nick = function(self) if self != nil then return self:GetNWString("PlayerName", self:RealName()) else return "" end end
PlayerNameOrNick.Name = PlayerNameOrNick.Nick
PlayerNameOrNick.GetName = PlayerNameOrNick.Nick

function ulx.setName( calling_ply, target_ply, name )
local PlayerNick = target_ply:Nick() 
    target_ply:SetNWString("PlayerName",name)
    ulx.fancyLogAdmin( calling_ply, "#A set "..PlayerNick.." Name to "..name, target_ply, name )
end
local setName = ulx.command( CATEGORY_NAME, "ulx setname", ulx.setName, "!setname" )
setName:addParam{ type=ULib.cmds.PlayerArg }
setName:addParam{ type=ULib.cmds.StringArg, hint="name", ULib.cmds.takeRestOfLine }
setName:defaultAccess( ULib.ACCESS_ADMIN )
setName:help( "Sets target's Name \n SetName By Happy friend1337" )


-- "lua\\ulx\\modules\\sh\\setname.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--[[
   _____      _     _   _                        ______           _    _ _      
  / ____|    | |   | \ | |                      |  ____|         | |  | | |     
 | (___   ___| |_  |  \| | __ _ _ __ ___   ___  | |__ ___  _ __  | |  | | |_  __
  \___ \ / _ \ __| | . ` |/ _` | '_ ` _ \ / _ \ |  __/ _ \| '__| | |  | | \ \/ /
  ____) |  __/ |_  | |\  | (_| | | | | | |  __/ | | | (_) | |    | |__| | |>  < 
 |_____/ \___|\__| |_| \_|\__,_|_| |_| |_|\___| |_|  \___/|_|     \____/|_/_/\_\
                                                                                
                                                                                
  ____          _    _                           ______    _                _   __ ____ ____ ______ 
 |  _ \        | |  | |                         |  ____|  (_)              | | /_ |___ \___ \____  |
 | |_) |_   _  | |__| | __ _ _ __  _ __  _   _  | |__ _ __ _  ___ _ __   __| |  | | __) |__) |  / / 
 |  _ <| | | | |  __  |/ _` | '_ \| '_ \| | | | |  __| '__| |/ _ \ '_ \ / _` |  | ||__ <|__ <  / /  
 | |_) | |_| | | |  | | (_| | |_) | |_) | |_| | | |  | |  | |  __/ | | | (_| |  | |___) |__) |/ /   
 |____/ \__, | |_|  |_|\__,_| .__/| .__/ \__, | |_|  |_|  |_|\___|_| |_|\__,_|  |_|____/____//_/    
         __/ |              | |   | |     __/ |                                                     
        |___/               |_|   |_|    |___/                                                      
--]]
local CATEGORY_NAME = "HAPPY-Power"

local PlayerNameOrNick = debug.getregistry().Player
PlayerNameOrNick.RealName = PlayerNameOrNick.Nick
PlayerNameOrNick.Nick = function(self) if self != nil then return self:GetNWString("PlayerName", self:RealName()) else return "" end end
PlayerNameOrNick.Name = PlayerNameOrNick.Nick
PlayerNameOrNick.GetName = PlayerNameOrNick.Nick

function ulx.setName( calling_ply, target_ply, name )
local PlayerNick = target_ply:Nick() 
    target_ply:SetNWString("PlayerName",name)
    ulx.fancyLogAdmin( calling_ply, "#A set "..PlayerNick.." Name to "..name, target_ply, name )
end
local setName = ulx.command( CATEGORY_NAME, "ulx setname", ulx.setName, "!setname" )
setName:addParam{ type=ULib.cmds.PlayerArg }
setName:addParam{ type=ULib.cmds.StringArg, hint="name", ULib.cmds.takeRestOfLine }
setName:defaultAccess( ULib.ACCESS_ADMIN )
setName:help( "Sets target's Name \n SetName By Happy friend1337" )


-- "lua\\ulx\\modules\\sh\\setname.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--[[
   _____      _     _   _                        ______           _    _ _      
  / ____|    | |   | \ | |                      |  ____|         | |  | | |     
 | (___   ___| |_  |  \| | __ _ _ __ ___   ___  | |__ ___  _ __  | |  | | |_  __
  \___ \ / _ \ __| | . ` |/ _` | '_ ` _ \ / _ \ |  __/ _ \| '__| | |  | | \ \/ /
  ____) |  __/ |_  | |\  | (_| | | | | | |  __/ | | | (_) | |    | |__| | |>  < 
 |_____/ \___|\__| |_| \_|\__,_|_| |_| |_|\___| |_|  \___/|_|     \____/|_/_/\_\
                                                                                
                                                                                
  ____          _    _                           ______    _                _   __ ____ ____ ______ 
 |  _ \        | |  | |                         |  ____|  (_)              | | /_ |___ \___ \____  |
 | |_) |_   _  | |__| | __ _ _ __  _ __  _   _  | |__ _ __ _  ___ _ __   __| |  | | __) |__) |  / / 
 |  _ <| | | | |  __  |/ _` | '_ \| '_ \| | | | |  __| '__| |/ _ \ '_ \ / _` |  | ||__ <|__ <  / /  
 | |_) | |_| | | |  | | (_| | |_) | |_) | |_| | | |  | |  | |  __/ | | | (_| |  | |___) |__) |/ /   
 |____/ \__, | |_|  |_|\__,_| .__/| .__/ \__, | |_|  |_|  |_|\___|_| |_|\__,_|  |_|____/____//_/    
         __/ |              | |   | |     __/ |                                                     
        |___/               |_|   |_|    |___/                                                      
--]]
local CATEGORY_NAME = "HAPPY-Power"

local PlayerNameOrNick = debug.getregistry().Player
PlayerNameOrNick.RealName = PlayerNameOrNick.Nick
PlayerNameOrNick.Nick = function(self) if self != nil then return self:GetNWString("PlayerName", self:RealName()) else return "" end end
PlayerNameOrNick.Name = PlayerNameOrNick.Nick
PlayerNameOrNick.GetName = PlayerNameOrNick.Nick

function ulx.setName( calling_ply, target_ply, name )
local PlayerNick = target_ply:Nick() 
    target_ply:SetNWString("PlayerName",name)
    ulx.fancyLogAdmin( calling_ply, "#A set "..PlayerNick.." Name to "..name, target_ply, name )
end
local setName = ulx.command( CATEGORY_NAME, "ulx setname", ulx.setName, "!setname" )
setName:addParam{ type=ULib.cmds.PlayerArg }
setName:addParam{ type=ULib.cmds.StringArg, hint="name", ULib.cmds.takeRestOfLine }
setName:defaultAccess( ULib.ACCESS_ADMIN )
setName:help( "Sets target's Name \n SetName By Happy friend1337" )


-- "lua\\ulx\\modules\\sh\\setname.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
--[[
   _____      _     _   _                        ______           _    _ _      
  / ____|    | |   | \ | |                      |  ____|         | |  | | |     
 | (___   ___| |_  |  \| | __ _ _ __ ___   ___  | |__ ___  _ __  | |  | | |_  __
  \___ \ / _ \ __| | . ` |/ _` | '_ ` _ \ / _ \ |  __/ _ \| '__| | |  | | \ \/ /
  ____) |  __/ |_  | |\  | (_| | | | | | |  __/ | | | (_) | |    | |__| | |>  < 
 |_____/ \___|\__| |_| \_|\__,_|_| |_| |_|\___| |_|  \___/|_|     \____/|_/_/\_\
                                                                                
                                                                                
  ____          _    _                           ______    _                _   __ ____ ____ ______ 
 |  _ \        | |  | |                         |  ____|  (_)              | | /_ |___ \___ \____  |
 | |_) |_   _  | |__| | __ _ _ __  _ __  _   _  | |__ _ __ _  ___ _ __   __| |  | | __) |__) |  / / 
 |  _ <| | | | |  __  |/ _` | '_ \| '_ \| | | | |  __| '__| |/ _ \ '_ \ / _` |  | ||__ <|__ <  / /  
 | |_) | |_| | | |  | | (_| | |_) | |_) | |_| | | |  | |  | |  __/ | | | (_| |  | |___) |__) |/ /   
 |____/ \__, | |_|  |_|\__,_| .__/| .__/ \__, | |_|  |_|  |_|\___|_| |_|\__,_|  |_|____/____//_/    
         __/ |              | |   | |     __/ |                                                     
        |___/               |_|   |_|    |___/                                                      
--]]
local CATEGORY_NAME = "HAPPY-Power"

local PlayerNameOrNick = debug.getregistry().Player
PlayerNameOrNick.RealName = PlayerNameOrNick.Nick
PlayerNameOrNick.Nick = function(self) if self != nil then return self:GetNWString("PlayerName", self:RealName()) else return "" end end
PlayerNameOrNick.Name = PlayerNameOrNick.Nick
PlayerNameOrNick.GetName = PlayerNameOrNick.Nick

function ulx.setName( calling_ply, target_ply, name )
local PlayerNick = target_ply:Nick() 
    target_ply:SetNWString("PlayerName",name)
    ulx.fancyLogAdmin( calling_ply, "#A set "..PlayerNick.." Name to "..name, target_ply, name )
end
local setName = ulx.command( CATEGORY_NAME, "ulx setname", ulx.setName, "!setname" )
setName:addParam{ type=ULib.cmds.PlayerArg }
setName:addParam{ type=ULib.cmds.StringArg, hint="name", ULib.cmds.takeRestOfLine }
setName:defaultAccess( ULib.ACCESS_ADMIN )
setName:help( "Sets target's Name \n SetName By Happy friend1337" )


