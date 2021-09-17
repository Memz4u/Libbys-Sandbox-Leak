-- "lua\\autorun\\mkmchatsounds.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- mkm's chatsounds

-- Modified by lenn to only play 1 sound instead of multiple sounds



-- Only modification was timer.Create





hook.Add( "PlayerSay", "foolucalledlolllollllol", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "fool" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_youfool.wav')")
        return ddd
end)
    end
end )

hook.Add( "PlayerSay", "covid", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "covid" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('ambient/voices/cough2.wav')")
        return dddd
end)
    end
end )


hook.Add( "PlayerSay", "yea", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "yeah" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/yeah02.wav')")
        return ddddd
end)
    end
end )


hook.Add( "PlayerSay", "cuseme", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "excuse me" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/excuseme02.wav')")
        return dddddd
end)
    end
end )




hook.Add( "PlayerSay", "sorry", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "sorry" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/sorry02.wav')")
        return ddddddd
end)
    end
end )



hook.Add( "PlayerSay", "hey", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "hey" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/canals/shanty_hey.wav')")
        return dddddddd
end)
    end
end )


hook.Add( "PlayerSay", "no", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "no" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_no.wav')")
        return ddddddddd
end)
    end
end )




hook.Add( "PlayerSay", "ha", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "ha" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_laugh01.wav')")
        return dddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "omg", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "omg" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/NovaProspekt/al_ohmygod.wav')")
        return ddddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "ohshit", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "oh shit" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_ohshit03.wav')")
        return dddddddddddd
end)
    end
end )

-- "lua\\autorun\\mkmchatsounds.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- mkm's chatsounds

-- Modified by lenn to only play 1 sound instead of multiple sounds



-- Only modification was timer.Create





hook.Add( "PlayerSay", "foolucalledlolllollllol", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "fool" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_youfool.wav')")
        return ddd
end)
    end
end )

hook.Add( "PlayerSay", "covid", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "covid" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('ambient/voices/cough2.wav')")
        return dddd
end)
    end
end )


hook.Add( "PlayerSay", "yea", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "yeah" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/yeah02.wav')")
        return ddddd
end)
    end
end )


hook.Add( "PlayerSay", "cuseme", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "excuse me" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/excuseme02.wav')")
        return dddddd
end)
    end
end )




hook.Add( "PlayerSay", "sorry", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "sorry" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/sorry02.wav')")
        return ddddddd
end)
    end
end )



hook.Add( "PlayerSay", "hey", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "hey" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/canals/shanty_hey.wav')")
        return dddddddd
end)
    end
end )


hook.Add( "PlayerSay", "no", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "no" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_no.wav')")
        return ddddddddd
end)
    end
end )




hook.Add( "PlayerSay", "ha", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "ha" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_laugh01.wav')")
        return dddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "omg", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "omg" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/NovaProspekt/al_ohmygod.wav')")
        return ddddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "ohshit", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "oh shit" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_ohshit03.wav')")
        return dddddddddddd
end)
    end
end )

-- "lua\\autorun\\mkmchatsounds.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- mkm's chatsounds

-- Modified by lenn to only play 1 sound instead of multiple sounds



-- Only modification was timer.Create





hook.Add( "PlayerSay", "foolucalledlolllollllol", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "fool" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_youfool.wav')")
        return ddd
end)
    end
end )

hook.Add( "PlayerSay", "covid", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "covid" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('ambient/voices/cough2.wav')")
        return dddd
end)
    end
end )


hook.Add( "PlayerSay", "yea", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "yeah" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/yeah02.wav')")
        return ddddd
end)
    end
end )


hook.Add( "PlayerSay", "cuseme", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "excuse me" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/excuseme02.wav')")
        return dddddd
end)
    end
end )




hook.Add( "PlayerSay", "sorry", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "sorry" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/sorry02.wav')")
        return ddddddd
end)
    end
end )



hook.Add( "PlayerSay", "hey", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "hey" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/canals/shanty_hey.wav')")
        return dddddddd
end)
    end
end )


hook.Add( "PlayerSay", "no", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "no" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_no.wav')")
        return ddddddddd
end)
    end
end )




hook.Add( "PlayerSay", "ha", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "ha" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_laugh01.wav')")
        return dddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "omg", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "omg" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/NovaProspekt/al_ohmygod.wav')")
        return ddddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "ohshit", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "oh shit" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_ohshit03.wav')")
        return dddddddddddd
end)
    end
end )

-- "lua\\autorun\\mkmchatsounds.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- mkm's chatsounds

-- Modified by lenn to only play 1 sound instead of multiple sounds



-- Only modification was timer.Create





hook.Add( "PlayerSay", "foolucalledlolllollllol", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "fool" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_youfool.wav')")
        return ddd
end)
    end
end )

hook.Add( "PlayerSay", "covid", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "covid" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('ambient/voices/cough2.wav')")
        return dddd
end)
    end
end )


hook.Add( "PlayerSay", "yea", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "yeah" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/yeah02.wav')")
        return ddddd
end)
    end
end )


hook.Add( "PlayerSay", "cuseme", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "excuse me" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/excuseme02.wav')")
        return dddddd
end)
    end
end )




hook.Add( "PlayerSay", "sorry", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "sorry" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/sorry02.wav')")
        return ddddddd
end)
    end
end )



hook.Add( "PlayerSay", "hey", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "hey" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/canals/shanty_hey.wav')")
        return dddddddd
end)
    end
end )


hook.Add( "PlayerSay", "no", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "no" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_no.wav')")
        return ddddddddd
end)
    end
end )




hook.Add( "PlayerSay", "ha", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "ha" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_laugh01.wav')")
        return dddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "omg", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "omg" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/NovaProspekt/al_ohmygod.wav')")
        return ddddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "ohshit", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "oh shit" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_ohshit03.wav')")
        return dddddddddddd
end)
    end
end )

-- "lua\\autorun\\mkmchatsounds.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- mkm's chatsounds

-- Modified by lenn to only play 1 sound instead of multiple sounds



-- Only modification was timer.Create





hook.Add( "PlayerSay", "foolucalledlolllollllol", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "fool" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_youfool.wav')")
        return ddd
end)
    end
end )

hook.Add( "PlayerSay", "covid", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "covid" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('ambient/voices/cough2.wav')")
        return dddd
end)
    end
end )


hook.Add( "PlayerSay", "yea", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "yeah" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/yeah02.wav')")
        return ddddd
end)
    end
end )


hook.Add( "PlayerSay", "cuseme", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "excuse me" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/excuseme02.wav')")
        return dddddd
end)
    end
end )




hook.Add( "PlayerSay", "sorry", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "sorry" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/male01/sorry02.wav')")
        return ddddddd
end)
    end
end )



hook.Add( "PlayerSay", "hey", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "hey" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/canals/shanty_hey.wav')")
        return dddddddd
end)
    end
end )


hook.Add( "PlayerSay", "no", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "no" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/Citadel/br_no.wav')")
        return ddddddddd
end)
    end
end )




hook.Add( "PlayerSay", "ha", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "ha" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_laugh01.wav')")
        return dddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "omg", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "omg" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local ddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/NovaProspekt/al_ohmygod.wav')")
        return ddddddddddd
end)
    end
end )

hook.Add( "PlayerSay", "ohshit", function( ply, text )
    local heckStart, heckEnd = string.find( text:lower(), "oh shit" )
    if heckStart then
timer.Create("playthesoundonlyonetime", 0.5, 1, function()
        local dddddddddddd = RunConsoleCommand("ulx", "sendlua", "*", "surface.PlaySound('vo/npc/Barney/ba_ohshit03.wav')")
        return dddddddddddd
end)
    end
end )

