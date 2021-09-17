-- "addons\\joinshit\\lua\\autorun\\client\\cl_joinmessages.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then return end

--Join
function JoinMessage()
    local name = net.ReadString()
    local steamid = net.ReadString()

    chat.AddText( Color( 235, 173, 32 ), "[C] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
    LocalPlayer():EmitSound("npc/metropolice/vo/on1.wav")
end
net.Receive("JoinMsg", JoinMessage)

--Spawn
function SpawnMessage()
    local name = net.ReadString()

    chat.AddText(Color(235, 173, 32), "Player ", Color(0,255,0), name, Color(235, 173, 32), " has spawned.")
    LocalPlayer():EmitSound("npc/metropolice/vo/on2.wav")
end
net.Receive("SpawnMsg", SpawnMessage)

--Leave
function LeaveMessage()
    if not (LocalPlayer():IsSuperAdmin()) or not (LocalPlayer():IsAdmin()) then
        local name = net.ReadString()
        local steamid = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    else
        local name = net.ReadString()
        local steamid = net.ReadString()
        local reason = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        MsgN("[Admen stuff] "..name.." Disconnected | Reason: "..reason)
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    end
end
net.Receive("LeaveMsg", LeaveMessage)

-- "addons\\joinshit\\lua\\autorun\\client\\cl_joinmessages.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then return end

--Join
function JoinMessage()
    local name = net.ReadString()
    local steamid = net.ReadString()

    chat.AddText( Color( 235, 173, 32 ), "[C] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
    LocalPlayer():EmitSound("npc/metropolice/vo/on1.wav")
end
net.Receive("JoinMsg", JoinMessage)

--Spawn
function SpawnMessage()
    local name = net.ReadString()

    chat.AddText(Color(235, 173, 32), "Player ", Color(0,255,0), name, Color(235, 173, 32), " has spawned.")
    LocalPlayer():EmitSound("npc/metropolice/vo/on2.wav")
end
net.Receive("SpawnMsg", SpawnMessage)

--Leave
function LeaveMessage()
    if not (LocalPlayer():IsSuperAdmin()) or not (LocalPlayer():IsAdmin()) then
        local name = net.ReadString()
        local steamid = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    else
        local name = net.ReadString()
        local steamid = net.ReadString()
        local reason = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        MsgN("[Admen stuff] "..name.." Disconnected | Reason: "..reason)
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    end
end
net.Receive("LeaveMsg", LeaveMessage)

-- "addons\\joinshit\\lua\\autorun\\client\\cl_joinmessages.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then return end

--Join
function JoinMessage()
    local name = net.ReadString()
    local steamid = net.ReadString()

    chat.AddText( Color( 235, 173, 32 ), "[C] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
    LocalPlayer():EmitSound("npc/metropolice/vo/on1.wav")
end
net.Receive("JoinMsg", JoinMessage)

--Spawn
function SpawnMessage()
    local name = net.ReadString()

    chat.AddText(Color(235, 173, 32), "Player ", Color(0,255,0), name, Color(235, 173, 32), " has spawned.")
    LocalPlayer():EmitSound("npc/metropolice/vo/on2.wav")
end
net.Receive("SpawnMsg", SpawnMessage)

--Leave
function LeaveMessage()
    if not (LocalPlayer():IsSuperAdmin()) or not (LocalPlayer():IsAdmin()) then
        local name = net.ReadString()
        local steamid = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    else
        local name = net.ReadString()
        local steamid = net.ReadString()
        local reason = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        MsgN("[Admen stuff] "..name.." Disconnected | Reason: "..reason)
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    end
end
net.Receive("LeaveMsg", LeaveMessage)

-- "addons\\joinshit\\lua\\autorun\\client\\cl_joinmessages.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then return end

--Join
function JoinMessage()
    local name = net.ReadString()
    local steamid = net.ReadString()

    chat.AddText( Color( 235, 173, 32 ), "[C] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
    LocalPlayer():EmitSound("npc/metropolice/vo/on1.wav")
end
net.Receive("JoinMsg", JoinMessage)

--Spawn
function SpawnMessage()
    local name = net.ReadString()

    chat.AddText(Color(235, 173, 32), "Player ", Color(0,255,0), name, Color(235, 173, 32), " has spawned.")
    LocalPlayer():EmitSound("npc/metropolice/vo/on2.wav")
end
net.Receive("SpawnMsg", SpawnMessage)

--Leave
function LeaveMessage()
    if not (LocalPlayer():IsSuperAdmin()) or not (LocalPlayer():IsAdmin()) then
        local name = net.ReadString()
        local steamid = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    else
        local name = net.ReadString()
        local steamid = net.ReadString()
        local reason = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        MsgN("[Admen stuff] "..name.." Disconnected | Reason: "..reason)
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    end
end
net.Receive("LeaveMsg", LeaveMessage)

-- "addons\\joinshit\\lua\\autorun\\client\\cl_joinmessages.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if SERVER then return end

--Join
function JoinMessage()
    local name = net.ReadString()
    local steamid = net.ReadString()

    chat.AddText( Color( 235, 173, 32 ), "[C] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
    LocalPlayer():EmitSound("npc/metropolice/vo/on1.wav")
end
net.Receive("JoinMsg", JoinMessage)

--Spawn
function SpawnMessage()
    local name = net.ReadString()

    chat.AddText(Color(235, 173, 32), "Player ", Color(0,255,0), name, Color(235, 173, 32), " has spawned.")
    LocalPlayer():EmitSound("npc/metropolice/vo/on2.wav")
end
net.Receive("SpawnMsg", SpawnMessage)

--Leave
function LeaveMessage()
    if not (LocalPlayer():IsSuperAdmin()) or not (LocalPlayer():IsAdmin()) then
        local name = net.ReadString()
        local steamid = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    else
        local name = net.ReadString()
        local steamid = net.ReadString()
        local reason = net.ReadString()

        chat.AddText( Color( 235, 173, 32 ), "[D] ", Color( 135,240,135 ), name, Color( 235, 173, 32 ), "<", Color( 135,240,135 ), steamid, Color( 235, 173, 32 ), ">" )
        MsgN("[Admen stuff] "..name.." Disconnected | Reason: "..reason)
        LocalPlayer():EmitSound("npc/metropolice/vo/off4.wav")
    end
end
net.Receive("LeaveMsg", LeaveMessage)

