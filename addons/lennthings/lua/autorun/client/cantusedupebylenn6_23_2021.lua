-- "addons\\lennthings\\lua\\autorun\\client\\cantusedupebylenn6_23_2021.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- not needed 7/17/2021
-- fux u warneren





waRAbr a WSET Ryd





-- OH I WONDER WHY I CAN'T USE DUPLICATOR
-- sticky made restrictions, so yeah


duplicate = 0

hook.Add( "CanTool", "antidupespam", function( ply, tr, tool, timer )


if tool == 'duplicator' then
print("[libby]: Checking his rank... Rank: " .. ply:GetUserGroup() .. "")

-- checks to see which ranks are restricted from using dupe

if ply:GetUserGroup() == "user" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Super User" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-ish" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-er" then 
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
end





end
end)



timer.Create("wtf_checker", 0, 0, function()
if duplicate == 1 then
timer.Create("libre_saysomething2", 0.1, 1, function() chat.AddText("[Libby]: We're sorry that you cannot use duplicator at the rank you are on, " .. LocalPlayer():Nick() .. ". which is " .. LocalPlayer():GetUserGroup() .. "") end)
timer.Create("libre_saysomething3", 0.1, 1, function() chat.AddText("[Libby]: Use advance duplicator instead to save your stuff, and also spawn your copied stuff.") end)
timer.Create("libre_notifications1", 0.5, 1, function() notification.AddLegacy( "[Libby] You can't use duplicator on the rank you're on '" .. LocalPlayer():Nick() .. "'! Which is: '" .. LocalPlayer():GetUserGroup() .. "'", NOTIFY_UNDO, 12 ) surface.PlaySound("ambient/energy/whiteflash.wav") end)
timer.Create("libre_notifications2", 0.4, 1, function() notification.AddLegacy( "[Libby] Use advance duplicator instead to save your stuff, and spawn your dupes. for the rank you're on", NOTIFY_UNDO, 16 ) end)
duplicate = 0
end
end)





-- "addons\\lennthings\\lua\\autorun\\client\\cantusedupebylenn6_23_2021.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- not needed 7/17/2021
-- fux u warneren





waRAbr a WSET Ryd





-- OH I WONDER WHY I CAN'T USE DUPLICATOR
-- sticky made restrictions, so yeah


duplicate = 0

hook.Add( "CanTool", "antidupespam", function( ply, tr, tool, timer )


if tool == 'duplicator' then
print("[libby]: Checking his rank... Rank: " .. ply:GetUserGroup() .. "")

-- checks to see which ranks are restricted from using dupe

if ply:GetUserGroup() == "user" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Super User" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-ish" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-er" then 
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
end





end
end)



timer.Create("wtf_checker", 0, 0, function()
if duplicate == 1 then
timer.Create("libre_saysomething2", 0.1, 1, function() chat.AddText("[Libby]: We're sorry that you cannot use duplicator at the rank you are on, " .. LocalPlayer():Nick() .. ". which is " .. LocalPlayer():GetUserGroup() .. "") end)
timer.Create("libre_saysomething3", 0.1, 1, function() chat.AddText("[Libby]: Use advance duplicator instead to save your stuff, and also spawn your copied stuff.") end)
timer.Create("libre_notifications1", 0.5, 1, function() notification.AddLegacy( "[Libby] You can't use duplicator on the rank you're on '" .. LocalPlayer():Nick() .. "'! Which is: '" .. LocalPlayer():GetUserGroup() .. "'", NOTIFY_UNDO, 12 ) surface.PlaySound("ambient/energy/whiteflash.wav") end)
timer.Create("libre_notifications2", 0.4, 1, function() notification.AddLegacy( "[Libby] Use advance duplicator instead to save your stuff, and spawn your dupes. for the rank you're on", NOTIFY_UNDO, 16 ) end)
duplicate = 0
end
end)





-- "addons\\lennthings\\lua\\autorun\\client\\cantusedupebylenn6_23_2021.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- not needed 7/17/2021
-- fux u warneren





waRAbr a WSET Ryd





-- OH I WONDER WHY I CAN'T USE DUPLICATOR
-- sticky made restrictions, so yeah


duplicate = 0

hook.Add( "CanTool", "antidupespam", function( ply, tr, tool, timer )


if tool == 'duplicator' then
print("[libby]: Checking his rank... Rank: " .. ply:GetUserGroup() .. "")

-- checks to see which ranks are restricted from using dupe

if ply:GetUserGroup() == "user" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Super User" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-ish" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-er" then 
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
end





end
end)



timer.Create("wtf_checker", 0, 0, function()
if duplicate == 1 then
timer.Create("libre_saysomething2", 0.1, 1, function() chat.AddText("[Libby]: We're sorry that you cannot use duplicator at the rank you are on, " .. LocalPlayer():Nick() .. ". which is " .. LocalPlayer():GetUserGroup() .. "") end)
timer.Create("libre_saysomething3", 0.1, 1, function() chat.AddText("[Libby]: Use advance duplicator instead to save your stuff, and also spawn your copied stuff.") end)
timer.Create("libre_notifications1", 0.5, 1, function() notification.AddLegacy( "[Libby] You can't use duplicator on the rank you're on '" .. LocalPlayer():Nick() .. "'! Which is: '" .. LocalPlayer():GetUserGroup() .. "'", NOTIFY_UNDO, 12 ) surface.PlaySound("ambient/energy/whiteflash.wav") end)
timer.Create("libre_notifications2", 0.4, 1, function() notification.AddLegacy( "[Libby] Use advance duplicator instead to save your stuff, and spawn your dupes. for the rank you're on", NOTIFY_UNDO, 16 ) end)
duplicate = 0
end
end)





-- "addons\\lennthings\\lua\\autorun\\client\\cantusedupebylenn6_23_2021.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- not needed 7/17/2021
-- fux u warneren





waRAbr a WSET Ryd





-- OH I WONDER WHY I CAN'T USE DUPLICATOR
-- sticky made restrictions, so yeah


duplicate = 0

hook.Add( "CanTool", "antidupespam", function( ply, tr, tool, timer )


if tool == 'duplicator' then
print("[libby]: Checking his rank... Rank: " .. ply:GetUserGroup() .. "")

-- checks to see which ranks are restricted from using dupe

if ply:GetUserGroup() == "user" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Super User" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-ish" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-er" then 
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
end





end
end)



timer.Create("wtf_checker", 0, 0, function()
if duplicate == 1 then
timer.Create("libre_saysomething2", 0.1, 1, function() chat.AddText("[Libby]: We're sorry that you cannot use duplicator at the rank you are on, " .. LocalPlayer():Nick() .. ". which is " .. LocalPlayer():GetUserGroup() .. "") end)
timer.Create("libre_saysomething3", 0.1, 1, function() chat.AddText("[Libby]: Use advance duplicator instead to save your stuff, and also spawn your copied stuff.") end)
timer.Create("libre_notifications1", 0.5, 1, function() notification.AddLegacy( "[Libby] You can't use duplicator on the rank you're on '" .. LocalPlayer():Nick() .. "'! Which is: '" .. LocalPlayer():GetUserGroup() .. "'", NOTIFY_UNDO, 12 ) surface.PlaySound("ambient/energy/whiteflash.wav") end)
timer.Create("libre_notifications2", 0.4, 1, function() notification.AddLegacy( "[Libby] Use advance duplicator instead to save your stuff, and spawn your dupes. for the rank you're on", NOTIFY_UNDO, 16 ) end)
duplicate = 0
end
end)





-- "addons\\lennthings\\lua\\autorun\\client\\cantusedupebylenn6_23_2021.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- not needed 7/17/2021
-- fux u warneren





waRAbr a WSET Ryd





-- OH I WONDER WHY I CAN'T USE DUPLICATOR
-- sticky made restrictions, so yeah


duplicate = 0

hook.Add( "CanTool", "antidupespam", function( ply, tr, tool, timer )


if tool == 'duplicator' then
print("[libby]: Checking his rank... Rank: " .. ply:GetUserGroup() .. "")

-- checks to see which ranks are restricted from using dupe

if ply:GetUserGroup() == "user" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Super User" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-ish" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted-er" then 
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
elseif ply:GetUserGroup() == "Trusted" then
print("[libby]: This rank cannot use duplicator! User rank is: " .. ply:GetUserGroup() .. "")
duplicate = 1
end





end
end)



timer.Create("wtf_checker", 0, 0, function()
if duplicate == 1 then
timer.Create("libre_saysomething2", 0.1, 1, function() chat.AddText("[Libby]: We're sorry that you cannot use duplicator at the rank you are on, " .. LocalPlayer():Nick() .. ". which is " .. LocalPlayer():GetUserGroup() .. "") end)
timer.Create("libre_saysomething3", 0.1, 1, function() chat.AddText("[Libby]: Use advance duplicator instead to save your stuff, and also spawn your copied stuff.") end)
timer.Create("libre_notifications1", 0.5, 1, function() notification.AddLegacy( "[Libby] You can't use duplicator on the rank you're on '" .. LocalPlayer():Nick() .. "'! Which is: '" .. LocalPlayer():GetUserGroup() .. "'", NOTIFY_UNDO, 12 ) surface.PlaySound("ambient/energy/whiteflash.wav") end)
timer.Create("libre_notifications2", 0.4, 1, function() notification.AddLegacy( "[Libby] Use advance duplicator instead to save your stuff, and spawn your dupes. for the rank you're on", NOTIFY_UNDO, 16 ) end)
duplicate = 0
end
end)





