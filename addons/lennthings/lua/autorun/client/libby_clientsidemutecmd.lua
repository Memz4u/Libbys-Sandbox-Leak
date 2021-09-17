-- "addons\\lennthings\\lua\\autorun\\client\\libby_clientsidemutecmd.lua"
-- Retrieved by https://github.com/c4fe/glua-steal



chat.AddText("[Starting libbies own customized voice volume chat commands...]")




-- 6/9/2021 simple chatcommand to set a specific users voice volume
-- don't judge about the fucking code alright, at least it works
-- Not the best one ever, but eh its worth it
-- MADE FOR LIBBIES
-- commands: !setvoicevolume (nick in lowercase) then !volume (value please make it an actual number)



hook.Add("OnPlayerChat", "lenn_mutewithchatcommand", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!setvoicevolume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the player you are trying to mute? " .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. "")


local target = "" .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. ""


local dumbass = 0
ohokso = 0

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. target .. "")
didnotwork = 0

		if string.find( string.lower( v:Nick() ), target ) then
                                    chat.AddText("User by the name of " .. v:Nick() .. " had the target character: " .. target .. "")
                                    timer.Create("notifyokthisguy", 0.75, 1, function()chat.AddText("Looks like you're selecting the username: " .. target .. ". use !volume (number) to change the voice volume of that player.") end)
                                    dumbass = target
                                    print("[libby_voice_volume_debug]: OK SO WERE TARGETTING ON: " .. v:Nick() .. "")
                                    dumbass = target
                                    ohokso = dumbass
                                    ohokso = dumbass
                                    --print("[libby_voice_volume_debug]: " .. ohokso .. "")
                                    ohokso = dumbass
                                    timer.Create("awesomeitworking", 0.1, 10, function() didnotwork = 1 end)
                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " did not match target character")
                                    --chat.AddText("" .. v:Nick() .. " did not match target sadly")
                                    didnotwork = 0

timer.Create("notifyurdumb", 0.5, 1, function() 
if didnotwork == 0 then 
chat.AddText("Didn't seem to find the valid user. Type the username in lowercase instead or check your lowercase spelling")
chat.AddText("Or the format is wrong, It's suppose to be: !setvoicevolume (nick in lowercase)")
end
end)

end
end

                                    dumbass = target
else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

voice_setvolume_working = 0

hook.Add("OnPlayerChat", "lenn_setthevoicevolumeofthatguy", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!volume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the voice volume you want? " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")
--chat.AddText( Color( 0, 161, 255), "okay, attempting to set his microphone volume to " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")

timer.Create("notifyurdumb", 0.5, 1, function()
if voice_setvolume_working == 1 then
chat.AddText("(GOOD): Looks like it worked with no lua errors.")
voice_setvolume_working = 0
elseif voice_setvolume_working == 0 then
timer.Simple(0.1, function() error("[libby_voice_volume_debug]: wow lua error detected! the value isn't even a number!") end)
chat.AddText("(BAD): What the hell kind of value did you put? Is it only a number and not some random character?")

end
end)

local target2 = "" .. text[9] .. "" .. text[10] .. "" .. text[11] .. ""

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. ohokso .. "")
print("[libby_voice_volume_debug]: Volume percent value set to: " .. target2 .. "")


		if string.find( string.lower( v:Nick() ), ohokso ) then
                                    chat.AddText("Setting " .. v:Nick() .. "'s voice volume to the value: " .. target2 .. "%")
                                    -- we're using precent, but SetVoiceVolumeScale does not use percent, it uses decimals just like voice_scale
                                    -- mathematics, if the person wants the volume percent 100, the voice_scale for that player would be set to 1
                                    realvoicescale = target2 / 100
                                    print("[libby_voice_volume_debug]: he put voice percent value at " .. target2 .. ". setting voice_scale to " .. realvoicescale .. "")
                                    v:SetVoiceVolumeScale("" .. realvoicescale .. "")
                                    voice_setvolume_working = 1


                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " is not in setvolume list")

end
end

else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

chat.AddText("[Ah, the libbies voice volume system works!]")



-- "addons\\lennthings\\lua\\autorun\\client\\libby_clientsidemutecmd.lua"
-- Retrieved by https://github.com/c4fe/glua-steal



chat.AddText("[Starting libbies own customized voice volume chat commands...]")




-- 6/9/2021 simple chatcommand to set a specific users voice volume
-- don't judge about the fucking code alright, at least it works
-- Not the best one ever, but eh its worth it
-- MADE FOR LIBBIES
-- commands: !setvoicevolume (nick in lowercase) then !volume (value please make it an actual number)



hook.Add("OnPlayerChat", "lenn_mutewithchatcommand", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!setvoicevolume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the player you are trying to mute? " .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. "")


local target = "" .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. ""


local dumbass = 0
ohokso = 0

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. target .. "")
didnotwork = 0

		if string.find( string.lower( v:Nick() ), target ) then
                                    chat.AddText("User by the name of " .. v:Nick() .. " had the target character: " .. target .. "")
                                    timer.Create("notifyokthisguy", 0.75, 1, function()chat.AddText("Looks like you're selecting the username: " .. target .. ". use !volume (number) to change the voice volume of that player.") end)
                                    dumbass = target
                                    print("[libby_voice_volume_debug]: OK SO WERE TARGETTING ON: " .. v:Nick() .. "")
                                    dumbass = target
                                    ohokso = dumbass
                                    ohokso = dumbass
                                    --print("[libby_voice_volume_debug]: " .. ohokso .. "")
                                    ohokso = dumbass
                                    timer.Create("awesomeitworking", 0.1, 10, function() didnotwork = 1 end)
                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " did not match target character")
                                    --chat.AddText("" .. v:Nick() .. " did not match target sadly")
                                    didnotwork = 0

timer.Create("notifyurdumb", 0.5, 1, function() 
if didnotwork == 0 then 
chat.AddText("Didn't seem to find the valid user. Type the username in lowercase instead or check your lowercase spelling")
chat.AddText("Or the format is wrong, It's suppose to be: !setvoicevolume (nick in lowercase)")
end
end)

end
end

                                    dumbass = target
else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

voice_setvolume_working = 0

hook.Add("OnPlayerChat", "lenn_setthevoicevolumeofthatguy", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!volume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the voice volume you want? " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")
--chat.AddText( Color( 0, 161, 255), "okay, attempting to set his microphone volume to " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")

timer.Create("notifyurdumb", 0.5, 1, function()
if voice_setvolume_working == 1 then
chat.AddText("(GOOD): Looks like it worked with no lua errors.")
voice_setvolume_working = 0
elseif voice_setvolume_working == 0 then
timer.Simple(0.1, function() error("[libby_voice_volume_debug]: wow lua error detected! the value isn't even a number!") end)
chat.AddText("(BAD): What the hell kind of value did you put? Is it only a number and not some random character?")

end
end)

local target2 = "" .. text[9] .. "" .. text[10] .. "" .. text[11] .. ""

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. ohokso .. "")
print("[libby_voice_volume_debug]: Volume percent value set to: " .. target2 .. "")


		if string.find( string.lower( v:Nick() ), ohokso ) then
                                    chat.AddText("Setting " .. v:Nick() .. "'s voice volume to the value: " .. target2 .. "%")
                                    -- we're using precent, but SetVoiceVolumeScale does not use percent, it uses decimals just like voice_scale
                                    -- mathematics, if the person wants the volume percent 100, the voice_scale for that player would be set to 1
                                    realvoicescale = target2 / 100
                                    print("[libby_voice_volume_debug]: he put voice percent value at " .. target2 .. ". setting voice_scale to " .. realvoicescale .. "")
                                    v:SetVoiceVolumeScale("" .. realvoicescale .. "")
                                    voice_setvolume_working = 1


                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " is not in setvolume list")

end
end

else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

chat.AddText("[Ah, the libbies voice volume system works!]")



-- "addons\\lennthings\\lua\\autorun\\client\\libby_clientsidemutecmd.lua"
-- Retrieved by https://github.com/c4fe/glua-steal



chat.AddText("[Starting libbies own customized voice volume chat commands...]")




-- 6/9/2021 simple chatcommand to set a specific users voice volume
-- don't judge about the fucking code alright, at least it works
-- Not the best one ever, but eh its worth it
-- MADE FOR LIBBIES
-- commands: !setvoicevolume (nick in lowercase) then !volume (value please make it an actual number)



hook.Add("OnPlayerChat", "lenn_mutewithchatcommand", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!setvoicevolume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the player you are trying to mute? " .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. "")


local target = "" .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. ""


local dumbass = 0
ohokso = 0

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. target .. "")
didnotwork = 0

		if string.find( string.lower( v:Nick() ), target ) then
                                    chat.AddText("User by the name of " .. v:Nick() .. " had the target character: " .. target .. "")
                                    timer.Create("notifyokthisguy", 0.75, 1, function()chat.AddText("Looks like you're selecting the username: " .. target .. ". use !volume (number) to change the voice volume of that player.") end)
                                    dumbass = target
                                    print("[libby_voice_volume_debug]: OK SO WERE TARGETTING ON: " .. v:Nick() .. "")
                                    dumbass = target
                                    ohokso = dumbass
                                    ohokso = dumbass
                                    --print("[libby_voice_volume_debug]: " .. ohokso .. "")
                                    ohokso = dumbass
                                    timer.Create("awesomeitworking", 0.1, 10, function() didnotwork = 1 end)
                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " did not match target character")
                                    --chat.AddText("" .. v:Nick() .. " did not match target sadly")
                                    didnotwork = 0

timer.Create("notifyurdumb", 0.5, 1, function() 
if didnotwork == 0 then 
chat.AddText("Didn't seem to find the valid user. Type the username in lowercase instead or check your lowercase spelling")
chat.AddText("Or the format is wrong, It's suppose to be: !setvoicevolume (nick in lowercase)")
end
end)

end
end

                                    dumbass = target
else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

voice_setvolume_working = 0

hook.Add("OnPlayerChat", "lenn_setthevoicevolumeofthatguy", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!volume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the voice volume you want? " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")
--chat.AddText( Color( 0, 161, 255), "okay, attempting to set his microphone volume to " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")

timer.Create("notifyurdumb", 0.5, 1, function()
if voice_setvolume_working == 1 then
chat.AddText("(GOOD): Looks like it worked with no lua errors.")
voice_setvolume_working = 0
elseif voice_setvolume_working == 0 then
timer.Simple(0.1, function() error("[libby_voice_volume_debug]: wow lua error detected! the value isn't even a number!") end)
chat.AddText("(BAD): What the hell kind of value did you put? Is it only a number and not some random character?")

end
end)

local target2 = "" .. text[9] .. "" .. text[10] .. "" .. text[11] .. ""

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. ohokso .. "")
print("[libby_voice_volume_debug]: Volume percent value set to: " .. target2 .. "")


		if string.find( string.lower( v:Nick() ), ohokso ) then
                                    chat.AddText("Setting " .. v:Nick() .. "'s voice volume to the value: " .. target2 .. "%")
                                    -- we're using precent, but SetVoiceVolumeScale does not use percent, it uses decimals just like voice_scale
                                    -- mathematics, if the person wants the volume percent 100, the voice_scale for that player would be set to 1
                                    realvoicescale = target2 / 100
                                    print("[libby_voice_volume_debug]: he put voice percent value at " .. target2 .. ". setting voice_scale to " .. realvoicescale .. "")
                                    v:SetVoiceVolumeScale("" .. realvoicescale .. "")
                                    voice_setvolume_working = 1


                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " is not in setvolume list")

end
end

else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

chat.AddText("[Ah, the libbies voice volume system works!]")



-- "addons\\lennthings\\lua\\autorun\\client\\libby_clientsidemutecmd.lua"
-- Retrieved by https://github.com/c4fe/glua-steal



chat.AddText("[Starting libbies own customized voice volume chat commands...]")




-- 6/9/2021 simple chatcommand to set a specific users voice volume
-- don't judge about the fucking code alright, at least it works
-- Not the best one ever, but eh its worth it
-- MADE FOR LIBBIES
-- commands: !setvoicevolume (nick in lowercase) then !volume (value please make it an actual number)



hook.Add("OnPlayerChat", "lenn_mutewithchatcommand", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!setvoicevolume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the player you are trying to mute? " .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. "")


local target = "" .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. ""


local dumbass = 0
ohokso = 0

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. target .. "")
didnotwork = 0

		if string.find( string.lower( v:Nick() ), target ) then
                                    chat.AddText("User by the name of " .. v:Nick() .. " had the target character: " .. target .. "")
                                    timer.Create("notifyokthisguy", 0.75, 1, function()chat.AddText("Looks like you're selecting the username: " .. target .. ". use !volume (number) to change the voice volume of that player.") end)
                                    dumbass = target
                                    print("[libby_voice_volume_debug]: OK SO WERE TARGETTING ON: " .. v:Nick() .. "")
                                    dumbass = target
                                    ohokso = dumbass
                                    ohokso = dumbass
                                    --print("[libby_voice_volume_debug]: " .. ohokso .. "")
                                    ohokso = dumbass
                                    timer.Create("awesomeitworking", 0.1, 10, function() didnotwork = 1 end)
                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " did not match target character")
                                    --chat.AddText("" .. v:Nick() .. " did not match target sadly")
                                    didnotwork = 0

timer.Create("notifyurdumb", 0.5, 1, function() 
if didnotwork == 0 then 
chat.AddText("Didn't seem to find the valid user. Type the username in lowercase instead or check your lowercase spelling")
chat.AddText("Or the format is wrong, It's suppose to be: !setvoicevolume (nick in lowercase)")
end
end)

end
end

                                    dumbass = target
else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

voice_setvolume_working = 0

hook.Add("OnPlayerChat", "lenn_setthevoicevolumeofthatguy", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!volume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the voice volume you want? " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")
--chat.AddText( Color( 0, 161, 255), "okay, attempting to set his microphone volume to " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")

timer.Create("notifyurdumb", 0.5, 1, function()
if voice_setvolume_working == 1 then
chat.AddText("(GOOD): Looks like it worked with no lua errors.")
voice_setvolume_working = 0
elseif voice_setvolume_working == 0 then
timer.Simple(0.1, function() error("[libby_voice_volume_debug]: wow lua error detected! the value isn't even a number!") end)
chat.AddText("(BAD): What the hell kind of value did you put? Is it only a number and not some random character?")

end
end)

local target2 = "" .. text[9] .. "" .. text[10] .. "" .. text[11] .. ""

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. ohokso .. "")
print("[libby_voice_volume_debug]: Volume percent value set to: " .. target2 .. "")


		if string.find( string.lower( v:Nick() ), ohokso ) then
                                    chat.AddText("Setting " .. v:Nick() .. "'s voice volume to the value: " .. target2 .. "%")
                                    -- we're using precent, but SetVoiceVolumeScale does not use percent, it uses decimals just like voice_scale
                                    -- mathematics, if the person wants the volume percent 100, the voice_scale for that player would be set to 1
                                    realvoicescale = target2 / 100
                                    print("[libby_voice_volume_debug]: he put voice percent value at " .. target2 .. ". setting voice_scale to " .. realvoicescale .. "")
                                    v:SetVoiceVolumeScale("" .. realvoicescale .. "")
                                    voice_setvolume_working = 1


                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " is not in setvolume list")

end
end

else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

chat.AddText("[Ah, the libbies voice volume system works!]")



-- "addons\\lennthings\\lua\\autorun\\client\\libby_clientsidemutecmd.lua"
-- Retrieved by https://github.com/c4fe/glua-steal



chat.AddText("[Starting libbies own customized voice volume chat commands...]")




-- 6/9/2021 simple chatcommand to set a specific users voice volume
-- don't judge about the fucking code alright, at least it works
-- Not the best one ever, but eh its worth it
-- MADE FOR LIBBIES
-- commands: !setvoicevolume (nick in lowercase) then !volume (value please make it an actual number)



hook.Add("OnPlayerChat", "lenn_mutewithchatcommand", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!setvoicevolume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the player you are trying to mute? " .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. "")


local target = "" .. text[17] .. "" .. text[18] .. "" .. text[19] .. "" .. text[20] .. "" .. text[21] .. "" .. text[22] .. "" .. text[23] .. "" .. text[24] .. "" .. text[25] .. "" .. text[26] .. "" .. text[27] .. "" .. text[28] .. "" .. text[29] .. "" .. text[30] .. "" .. text[31] .. "" .. text[32] .. "" .. text[33] .. "" .. text[34] .. "" .. text[35] .. "" .. text[36] .. "" .. text[37] .. "" .. text[38] .. "" .. text[39] .. "" .. text[40] .. ""


local dumbass = 0
ohokso = 0

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. target .. "")
didnotwork = 0

		if string.find( string.lower( v:Nick() ), target ) then
                                    chat.AddText("User by the name of " .. v:Nick() .. " had the target character: " .. target .. "")
                                    timer.Create("notifyokthisguy", 0.75, 1, function()chat.AddText("Looks like you're selecting the username: " .. target .. ". use !volume (number) to change the voice volume of that player.") end)
                                    dumbass = target
                                    print("[libby_voice_volume_debug]: OK SO WERE TARGETTING ON: " .. v:Nick() .. "")
                                    dumbass = target
                                    ohokso = dumbass
                                    ohokso = dumbass
                                    --print("[libby_voice_volume_debug]: " .. ohokso .. "")
                                    ohokso = dumbass
                                    timer.Create("awesomeitworking", 0.1, 10, function() didnotwork = 1 end)
                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " did not match target character")
                                    --chat.AddText("" .. v:Nick() .. " did not match target sadly")
                                    didnotwork = 0

timer.Create("notifyurdumb", 0.5, 1, function() 
if didnotwork == 0 then 
chat.AddText("Didn't seem to find the valid user. Type the username in lowercase instead or check your lowercase spelling")
chat.AddText("Or the format is wrong, It's suppose to be: !setvoicevolume (nick in lowercase)")
end
end)

end
end

                                    dumbass = target
else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

voice_setvolume_working = 0

hook.Add("OnPlayerChat", "lenn_setthevoicevolumeofthatguy", function(v, text, team)
local me = LocalPlayer()
if v == me then
if string.find(string.lower(text), "!volume") then
-- must check if text1 is ! to prevent chatcommand false positive
if text[1] == "!" then
print("[libby_voice_volume_debug]: received message")
print("[libby_voice_volume_debug]: Is this the voice volume you want? " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")
--chat.AddText( Color( 0, 161, 255), "okay, attempting to set his microphone volume to " .. text[9] .. "" .. text[10] .. "" .. text[11] .. "")

timer.Create("notifyurdumb", 0.5, 1, function()
if voice_setvolume_working == 1 then
chat.AddText("(GOOD): Looks like it worked with no lua errors.")
voice_setvolume_working = 0
elseif voice_setvolume_working == 0 then
timer.Simple(0.1, function() error("[libby_voice_volume_debug]: wow lua error detected! the value isn't even a number!") end)
chat.AddText("(BAD): What the hell kind of value did you put? Is it only a number and not some random character?")

end
end)

local target2 = "" .. text[9] .. "" .. text[10] .. "" .. text[11] .. ""

	for k, v in pairs(player.GetAll()) do

print("[libby_voice_volume_debug]: Real nick: " .. v:Nick() .. "")
print("[libby_voice_volume_debug]: Looking for: " .. ohokso .. "")
print("[libby_voice_volume_debug]: Volume percent value set to: " .. target2 .. "")


		if string.find( string.lower( v:Nick() ), ohokso ) then
                                    chat.AddText("Setting " .. v:Nick() .. "'s voice volume to the value: " .. target2 .. "%")
                                    -- we're using precent, but SetVoiceVolumeScale does not use percent, it uses decimals just like voice_scale
                                    -- mathematics, if the person wants the volume percent 100, the voice_scale for that player would be set to 1
                                    realvoicescale = target2 / 100
                                    print("[libby_voice_volume_debug]: he put voice percent value at " .. target2 .. ". setting voice_scale to " .. realvoicescale .. "")
                                    v:SetVoiceVolumeScale("" .. realvoicescale .. "")
                                    voice_setvolume_working = 1


                                    else
                                    print("[libby_voice_volume_debug]: " .. v:Nick() .. " is not in setvolume list")

end
end

else
--chat.AddText( Color( 255, 50, 0), "You did not type the word 'spectate' in chat dumbass try again")
end
end
end
end)

chat.AddText("[Ah, the libbies voice volume system works!]")



