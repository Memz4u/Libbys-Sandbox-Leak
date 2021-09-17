-- "addons\\lennthings\\lua\\autorun\\client\\hatedyingtolucky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- I don't know why lucky has admin and is randomly killing people with OP weapons, but this will do
-- Tell those poor victims that they just got killed by this retard over and over again

gameevent.Listen("entity_killed")
gameevent.Listen("player_hurt")

local function whodefukkilledme(data)
	local thatguywhokilledyou = Entity(data.entindex_attacker)
	local victim2 = Entity(data.entindex_killed)



  
	if thatguywhokilledyou:IsValid() and victim2:IsValid() and thatguywhokilledyou:IsPlayer() and victim2:IsPlayer() then
        print("" .. thatguywhokilledyou:Nick() .. " killed " .. victim2:Nick() .. "")
        if thatguywhokilledyou:Nick() == "REAL Lucky" and victim2:Nick() == "" .. LocalPlayer():Nick() .. "" then
        chat.AddText("hate dying from that 'REAL Lucky' guy? just type !build in chat")
        end
end
end


hook.Add("entity_killed","thatoneguyyouhatedyingtoo", function(data)
whodefukkilledme(data)
end)

-- "addons\\lennthings\\lua\\autorun\\client\\hatedyingtolucky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- I don't know why lucky has admin and is randomly killing people with OP weapons, but this will do
-- Tell those poor victims that they just got killed by this retard over and over again

gameevent.Listen("entity_killed")
gameevent.Listen("player_hurt")

local function whodefukkilledme(data)
	local thatguywhokilledyou = Entity(data.entindex_attacker)
	local victim2 = Entity(data.entindex_killed)



  
	if thatguywhokilledyou:IsValid() and victim2:IsValid() and thatguywhokilledyou:IsPlayer() and victim2:IsPlayer() then
        print("" .. thatguywhokilledyou:Nick() .. " killed " .. victim2:Nick() .. "")
        if thatguywhokilledyou:Nick() == "REAL Lucky" and victim2:Nick() == "" .. LocalPlayer():Nick() .. "" then
        chat.AddText("hate dying from that 'REAL Lucky' guy? just type !build in chat")
        end
end
end


hook.Add("entity_killed","thatoneguyyouhatedyingtoo", function(data)
whodefukkilledme(data)
end)

-- "addons\\lennthings\\lua\\autorun\\client\\hatedyingtolucky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- I don't know why lucky has admin and is randomly killing people with OP weapons, but this will do
-- Tell those poor victims that they just got killed by this retard over and over again

gameevent.Listen("entity_killed")
gameevent.Listen("player_hurt")

local function whodefukkilledme(data)
	local thatguywhokilledyou = Entity(data.entindex_attacker)
	local victim2 = Entity(data.entindex_killed)



  
	if thatguywhokilledyou:IsValid() and victim2:IsValid() and thatguywhokilledyou:IsPlayer() and victim2:IsPlayer() then
        print("" .. thatguywhokilledyou:Nick() .. " killed " .. victim2:Nick() .. "")
        if thatguywhokilledyou:Nick() == "REAL Lucky" and victim2:Nick() == "" .. LocalPlayer():Nick() .. "" then
        chat.AddText("hate dying from that 'REAL Lucky' guy? just type !build in chat")
        end
end
end


hook.Add("entity_killed","thatoneguyyouhatedyingtoo", function(data)
whodefukkilledme(data)
end)

-- "addons\\lennthings\\lua\\autorun\\client\\hatedyingtolucky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- I don't know why lucky has admin and is randomly killing people with OP weapons, but this will do
-- Tell those poor victims that they just got killed by this retard over and over again

gameevent.Listen("entity_killed")
gameevent.Listen("player_hurt")

local function whodefukkilledme(data)
	local thatguywhokilledyou = Entity(data.entindex_attacker)
	local victim2 = Entity(data.entindex_killed)



  
	if thatguywhokilledyou:IsValid() and victim2:IsValid() and thatguywhokilledyou:IsPlayer() and victim2:IsPlayer() then
        print("" .. thatguywhokilledyou:Nick() .. " killed " .. victim2:Nick() .. "")
        if thatguywhokilledyou:Nick() == "REAL Lucky" and victim2:Nick() == "" .. LocalPlayer():Nick() .. "" then
        chat.AddText("hate dying from that 'REAL Lucky' guy? just type !build in chat")
        end
end
end


hook.Add("entity_killed","thatoneguyyouhatedyingtoo", function(data)
whodefukkilledme(data)
end)

-- "addons\\lennthings\\lua\\autorun\\client\\hatedyingtolucky.lua"
-- Retrieved by https://github.com/c4fe/glua-steal


-- I don't know why lucky has admin and is randomly killing people with OP weapons, but this will do
-- Tell those poor victims that they just got killed by this retard over and over again

gameevent.Listen("entity_killed")
gameevent.Listen("player_hurt")

local function whodefukkilledme(data)
	local thatguywhokilledyou = Entity(data.entindex_attacker)
	local victim2 = Entity(data.entindex_killed)



  
	if thatguywhokilledyou:IsValid() and victim2:IsValid() and thatguywhokilledyou:IsPlayer() and victim2:IsPlayer() then
        print("" .. thatguywhokilledyou:Nick() .. " killed " .. victim2:Nick() .. "")
        if thatguywhokilledyou:Nick() == "REAL Lucky" and victim2:Nick() == "" .. LocalPlayer():Nick() .. "" then
        chat.AddText("hate dying from that 'REAL Lucky' guy? just type !build in chat")
        end
end
end


hook.Add("entity_killed","thatoneguyyouhatedyingtoo", function(data)
whodefukkilledme(data)
end)

