-- "addons\\lennthings\\lua\\autorun\\client\\libby_antichatspam.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






-- casual chat anti-spam
-- not good, but works


chatcounts = 0
tries = 14

hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
local me = LocalPlayer()
if v == me then
chatcounts = chatcounts + 1
tries = tries - 1


print("You typed a message! chat counts per 10 seconds: " .. chatcounts .. "")

timer.Create("libby_chatcooldown", 4, 1, function()
tries = 14
chatcounts = 0
end)


if chatcounts > 9 then
timer.Create("libby_stopchatspammingbro", 0.1, 1, function() chat.AddText("[libby]: consider yourself to stop chat spamming, tries: " .. tries .. "") end)
end
if tries < 1 then
chat.AddText("[libby]: Kicking...")
-- hey lua stealers, just detour this l0l
RunConsoleCommand("retry")
end




end
end)

-- "addons\\lennthings\\lua\\autorun\\client\\libby_antichatspam.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






-- casual chat anti-spam
-- not good, but works


chatcounts = 0
tries = 14

hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
local me = LocalPlayer()
if v == me then
chatcounts = chatcounts + 1
tries = tries - 1


print("You typed a message! chat counts per 10 seconds: " .. chatcounts .. "")

timer.Create("libby_chatcooldown", 4, 1, function()
tries = 14
chatcounts = 0
end)


if chatcounts > 9 then
timer.Create("libby_stopchatspammingbro", 0.1, 1, function() chat.AddText("[libby]: consider yourself to stop chat spamming, tries: " .. tries .. "") end)
end
if tries < 1 then
chat.AddText("[libby]: Kicking...")
-- hey lua stealers, just detour this l0l
RunConsoleCommand("retry")
end




end
end)

-- "addons\\lennthings\\lua\\autorun\\client\\libby_antichatspam.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






-- casual chat anti-spam
-- not good, but works


chatcounts = 0
tries = 14

hook.Add("OnPlayerChat", "lenn_vertifyyourabot", function(v, text, team)
local me = LocalPlayer()
if v == me then
chatcounts = chatcounts + 1
tries = tries - 1


print("You typed a message! chat counts per 10 seconds: " .. chatcounts .. "")

timer.Create("libby_chatcooldown", 4, 1, function()
tries = 14
chatcounts = 0
end)


if chatcounts > 9 then
timer.Create("libby_stopchatspammingbro", 0.1, 1, function() chat.AddText("[libby]: consider yourself to stop chat spamming, tries: " .. tries .. "") end)
end
if tries < 1 then
chat.AddText("[libby]: Kicking...")
-- hey lua stealers, just detour this l0l
RunConsoleCommand("retry")
end




end
end)

-- "addons\\lennthings\\lua\\autorun\\client\\libby_antichatspam.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






-- casual chat anti-spam
-- not good, but works


chatcounts = 0
tries = 14

hook.Add("OnPlayerChat", "lenn_antispamchat", function(v, text, team)
local me = LocalPlayer()
if v == me then
chatcounts = chatcounts + 1
tries = tries - 1


print("You typed a message! chat counts per 10 seconds: " .. chatcounts .. "")

timer.Create("libby_chatcooldown", 4, 1, function()
tries = 18
chatcounts = 0
end)


if chatcounts > 12 then
timer.Create("libby_stopchatspammingbro", 0.1, 1, function() chat.AddText("[libby]: consider yourself to stop chat spamming, tries: " .. tries .. "") end)
end
if tries < 1 then
chat.AddText("[libby]: Kicking...")
-- hey lua stealers, just detour this l0l
RunConsoleCommand("retry")
end




end
end)

-- "addons\\lennthings\\lua\\autorun\\client\\libby_antichatspam.lua"
-- Retrieved by https://github.com/c4fe/glua-steal






-- casual chat anti-spam
-- not good, but works


chatcounts = 0
tries = 14

hook.Add("OnPlayerChat", "lenn_antispamchat", function(v, text, team)
local me = LocalPlayer()
if v == me then
chatcounts = chatcounts + 1
tries = tries - 1


print("You typed a message! chat counts per 10 seconds: " .. chatcounts .. "")

timer.Create("libby_chatcooldown", 4, 1, function()
tries = 18
chatcounts = 0
end)


if chatcounts > 12 then
timer.Create("libby_stopchatspammingbro", 0.1, 1, function() chat.AddText("[libby]: consider yourself to stop chat spamming, tries: " .. tries .. "") end)
end
if tries < 1 then
chat.AddText("[libby]: Kicking...")
-- hey lua stealers, just detour this l0l
RunConsoleCommand("retry")
end




end
end)

