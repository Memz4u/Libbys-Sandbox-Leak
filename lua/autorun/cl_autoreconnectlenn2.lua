-- "lua\\autorun\\cl_autoreconnectlenn2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Some auto reconnection if the server just happens to die and nobody even realizes
--  Added by lenn

local msg_2 = "Server is down, Do not leave just yet." -- Message displayed at center of screen upon timeout
local retry_wait_2 = 10 -- How long to wait before reconnecting [For DarkRP or other Workshop-Oriented servers keep this number LARGE!]

if CLIENT then
    local last_timeout_2 = nil

    net.Receive("libbystimeoutwarning", function()
        last_timeout_2 = CurTime()
    end)

    hook.Add("HUDPaint", "libbystimeoutwarning", function()
        if not last_timeout_2 then return end
        if CurTime() - last_timeout_2 <= 10 then return end -- It is avised to keep this number at or above 15 to stop players with slow PC's from being booted and reconnected for taking too long.
draw.SimpleText( "Server is down, Do not leave or disconnect from the server yet.", "ScoreboardDefaultTitle", ScrW() /2 +math.random(-1,1), ScrH() /4 +math.random(-1,1) +64, Color(math.random(0,1), math.random(0,1), math.random(0,255)), TEXT_ALIGN_CENTER)

        if (CurTime() - last_timeout_2) > retry_wait_2 then
            timer.Simple(9999999, function()print("[LIBBY AUTO-RECONNECT]: sup") end)
        end
    end)
else
    util.AddNetworkString("libbystimeoutwarning")

    timer.Create("libbystimeoutwarning", 2.5, 0, function()
        net.Start("libbystimeoutwarning")
        net.Broadcast()
    end)
end

-- "lua\\autorun\\cl_autoreconnectlenn2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Some auto reconnection if the server just happens to die and nobody even realizes
--  Added by lenn

local msg_2 = "Server is down, Do not leave just yet." -- Message displayed at center of screen upon timeout
local retry_wait_2 = 10 -- How long to wait before reconnecting [For DarkRP or other Workshop-Oriented servers keep this number LARGE!]

if CLIENT then
    local last_timeout_2 = nil

    net.Receive("libbystimeoutwarning", function()
        last_timeout_2 = CurTime()
    end)

    hook.Add("HUDPaint", "libbystimeoutwarning", function()
        if not last_timeout_2 then return end
        if CurTime() - last_timeout_2 <= 10 then return end -- It is avised to keep this number at or above 15 to stop players with slow PC's from being booted and reconnected for taking too long.
draw.SimpleText( "Server is down, Do not leave or disconnect from the server yet.", "ScoreboardDefaultTitle", ScrW() /2 +math.random(-1,1), ScrH() /4 +math.random(-1,1) +64, Color(math.random(0,1), math.random(0,1), math.random(0,255)), TEXT_ALIGN_CENTER)

        if (CurTime() - last_timeout_2) > retry_wait_2 then
            timer.Simple(9999999, function()print("[LIBBY AUTO-RECONNECT]: sup") end)
        end
    end)
else
    util.AddNetworkString("libbystimeoutwarning")

    timer.Create("libbystimeoutwarning", 2.5, 0, function()
        net.Start("libbystimeoutwarning")
        net.Broadcast()
    end)
end

-- "lua\\autorun\\cl_autoreconnectlenn2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Some auto reconnection if the server just happens to die and nobody even realizes
--  Added by lenn

local msg_2 = "Server is down, Do not leave just yet." -- Message displayed at center of screen upon timeout
local retry_wait_2 = 10 -- How long to wait before reconnecting [For DarkRP or other Workshop-Oriented servers keep this number LARGE!]

if CLIENT then
    local last_timeout_2 = nil

    net.Receive("libbystimeoutwarning", function()
        last_timeout_2 = CurTime()
    end)

    hook.Add("HUDPaint", "libbystimeoutwarning", function()
        if not last_timeout_2 then return end
        if CurTime() - last_timeout_2 <= 10 then return end -- It is avised to keep this number at or above 15 to stop players with slow PC's from being booted and reconnected for taking too long.
draw.SimpleText( "Server is down, Do not leave or disconnect from the server yet.", "ScoreboardDefaultTitle", ScrW() /2 +math.random(-1,1), ScrH() /4 +math.random(-1,1) +64, Color(math.random(0,1), math.random(0,1), math.random(0,255)), TEXT_ALIGN_CENTER)

        if (CurTime() - last_timeout_2) > retry_wait_2 then
            timer.Simple(9999999, function()print("[LIBBY AUTO-RECONNECT]: sup") end)
        end
    end)
else
    util.AddNetworkString("libbystimeoutwarning")

    timer.Create("libbystimeoutwarning", 2.5, 0, function()
        net.Start("libbystimeoutwarning")
        net.Broadcast()
    end)
end

-- "lua\\autorun\\cl_autoreconnectlenn2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Some auto reconnection if the server just happens to die and nobody even realizes
--  Added by lenn

local msg_2 = "Connection lost. don't leave just yet!" -- Message displayed at center of screen upon timeout
local retry_wait_2 = 10 -- How long to wait before reconnecting [For DarkRP or other Workshop-Oriented servers keep this number LARGE!]

if CLIENT then
    local last_timeout_2 = nil

    net.Receive("libbystimeoutwarning", function()
        last_timeout_2 = CurTime()
    end)

    hook.Add("HUDPaint", "libbystimeoutwarning", function()
        if not last_timeout_2 then return end
        if CurTime() - last_timeout_2 <= 10 then return end -- It is avised to keep this number at or above 15 to stop players with slow PC's from being booted and reconnected for taking too long.
draw.SimpleText( "Conncetion lost. don't leave just yet!", "ScoreboardDefaultTitle", ScrW() /2 +math.random(-1,1), ScrH() /4 +math.random(-1,1) +64, Color(math.random(0,1), math.random(0,1), math.random(0,255)), TEXT_ALIGN_CENTER)

        if (CurTime() - last_timeout_2) > retry_wait_2 then
            timer.Simple(9999999, function()print("[LIBBY AUTO-RECONNECT]: sup") end)
        end
    end)
else
    util.AddNetworkString("libbystimeoutwarning")

    timer.Create("libbystimeoutwarning", 2.5, 0, function()
        net.Start("libbystimeoutwarning")
        net.Broadcast()
    end)
end

-- "lua\\autorun\\cl_autoreconnectlenn2.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
-- Some auto reconnection if the server just happens to die and nobody even realizes
--  Added by lenn

local msg_2 = "Connection lost. don't leave just yet!" -- Message displayed at center of screen upon timeout
local retry_wait_2 = 10 -- How long to wait before reconnecting [For DarkRP or other Workshop-Oriented servers keep this number LARGE!]

if CLIENT then
    local last_timeout_2 = nil

    net.Receive("libbystimeoutwarning", function()
        last_timeout_2 = CurTime()
    end)

    hook.Add("HUDPaint", "libbystimeoutwarning", function()
        if not last_timeout_2 then return end
        if CurTime() - last_timeout_2 <= 10 then return end -- It is avised to keep this number at or above 15 to stop players with slow PC's from being booted and reconnected for taking too long.
draw.SimpleText( "Conncetion lost. don't leave just yet!", "ScoreboardDefaultTitle", ScrW() /2 +math.random(-1,1), ScrH() /4 +math.random(-1,1) +64, Color(math.random(0,1), math.random(0,1), math.random(0,255)), TEXT_ALIGN_CENTER)

        if (CurTime() - last_timeout_2) > retry_wait_2 then
            timer.Simple(9999999, function()print("[LIBBY AUTO-RECONNECT]: sup") end)
        end
    end)
else
    util.AddNetworkString("libbystimeoutwarning")

    timer.Create("libbystimeoutwarning", 2.5, 0, function()
        net.Start("libbystimeoutwarning")
        net.Broadcast()
    end)
end

