-- "lua\\browser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if (SERVER) then
	AddCSLuaFile("autorun/clock.lua")
end
 
if (CLIENT) then
 
	function clockhud()
		draw.RoundedBox( 0, ScrW()*0.01, ScrH()*0.01, 128, 46, Color( 25, 25, 25, 255 ) )
		draw.RoundedBox( 20, ScrW()*0.01, ScrH()*0.01, 128, 46, Color( 125, 125, 125, 125 ) )
		draw.SimpleText(os.date( "%a, %I:%M:%S %p" ), "Default", ScrW()*0.024, ScrH()*0.02, Color( 255, 104, 86, 255 ),0,0)
		draw.SimpleText(os.date( "%m/%d/20%y" ), "Default", ScrW()*0.035, ScrH()*0.04, Color( 255, 104, 86, 255 ),0,0)
	end
	hook.Add("HUDPaint", "clockhud", clockhud)
end

-- "lua\\browser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
hook.Add( "PlayerConnect", "JoinGlobalMessage", function( name, ip )
	PrintMessage( HUD_PRINTTALK, name .. " has joined the game." )
end )

-- "lua\\browser.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


    require ("cvar3")
     
    GetConVar("sv_allowcslua"):SetFlags(0)
    GetConVar("sv_cheats"):SetFlags(0)
    GetConVar("sv_allowcslua"):SetValue(1)
    GetConVar("sv_cheats"):SetValue(1)
    if CLIENT and GetConVarNumber("sv_allowcslua") == 1 then
    	chat.AddText(Color(255,69,0,255), "Airstuck Loaded, Enjoy THE Most Useless Feature")
    end
     
    hook.Add( "KeyPress", "keypress_airstuck_on", function( ply, key )
    	if ( key == KEY_8 ) then
    		RunConsoleCommand("net_fakeloss 99")
    	end
    end )
     
    hook.Add( "KeyPress", "keypress_airstuck_off", function( ply, key )
    	if ( key == KEY_9 ) then
    		RunConsoleCommand("net_fakeloss 0")
    	end
    end )

