-- "lua\\autorun\\client\\esp.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- 8/9/2021 last modification
-- 9/6/2021 newest modification


-- Modification by lenn
-- Changed font, too old!
-- Old code will stay commented below









surface.CreateFont("VerdanaB_libby_simpleesp", { font = "Verdana", size = 13, weight = 1500, antialias = false, outline = true })
surface.CreateFont("ArialB_libby_simpleesp_health", { font = "Arial Black", size = 12, antialias = false, outline = true })






	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "VerdanaB_libby_simpleesp", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "ArialB_libby_simpleesp_health", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")












--[[



	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



-- 2/4/2021 edited by Lenn
-- Changes: Made it so that ESP doesn't draw invisible players

local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "TargetIDSmall", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")

]]--

-- "lua\\autorun\\client\\esp.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- 8/9/2021 last modification
-- 9/6/2021 newest modification


-- Modification by lenn
-- Changed font, too old!
-- Old code will stay commented below









surface.CreateFont("VerdanaB_libby_simpleesp", { font = "Verdana", size = 13, weight = 1500, antialias = false, outline = true })
surface.CreateFont("ArialB_libby_simpleesp_health", { font = "Arial Black", size = 12, antialias = false, outline = true })






	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "VerdanaB_libby_simpleesp", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "ArialB_libby_simpleesp_health", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")












--[[



	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



-- 2/4/2021 edited by Lenn
-- Changes: Made it so that ESP doesn't draw invisible players

local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "TargetIDSmall", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")

]]--

-- "lua\\autorun\\client\\esp.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- 8/9/2021 last modification
-- 9/6/2021 newest modification


-- Modification by lenn
-- Changed font, too old!
-- Old code will stay commented below









surface.CreateFont("VerdanaB_libby_simpleesp", { font = "Verdana", size = 13, weight = 1500, antialias = false, outline = true })
surface.CreateFont("ArialB_libby_simpleesp_health", { font = "Arial Black", size = 12, antialias = false, outline = true })






	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "VerdanaB_libby_simpleesp", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "ArialB_libby_simpleesp_health", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")












--[[



	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



-- 2/4/2021 edited by Lenn
-- Changes: Made it so that ESP doesn't draw invisible players

local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "TargetIDSmall", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")

]]--

-- "lua\\autorun\\client\\esp.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- 8/9/2021 last modification
-- 9/6/2021 newest modification


-- Modification by lenn
-- Changed font, too old!
-- Old code will stay commented below









surface.CreateFont("VerdanaB_libby_simpleesp", { font = "Verdana", size = 13, weight = 1500, antialias = false, outline = true })
surface.CreateFont("ArialB_libby_simpleesp_health", { font = "Arial Black", size = 12, antialias = false, outline = true })






	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 2000 * 2000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "VerdanaB_libby_simpleesp", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "ArialB_libby_simpleesp_health", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")












--[[



	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



-- 2/4/2021 edited by Lenn
-- Changes: Made it so that ESP doesn't draw invisible players

local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "TargetIDSmall", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")

]]--

-- "lua\\autorun\\client\\esp.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

-- 8/9/2021 last modification
-- 9/6/2021 newest modification


-- Modification by lenn
-- Changed font, too old!
-- Old code will stay commented below









surface.CreateFont("VerdanaB_libby_simpleesp", { font = "Verdana", size = 13, weight = 1500, antialias = false, outline = true })
surface.CreateFont("ArialB_libby_simpleesp_health", { font = "Arial Black", size = 12, antialias = false, outline = true })






	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 2000 * 2000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "VerdanaB_libby_simpleesp", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "ArialB_libby_simpleesp_health", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")












--[[



	--Simple ESP by Crave 4. (steamcommunity.com/id/Crave4)

	--Coded in 15 minutes, LUA, Sublime Text 3, on 25th November 2017.

	--Updated on 5th June 2018.

	--Updated again on 28th August 2018.



-- 2/4/2021 edited by Lenn
-- Changes: Made it so that ESP doesn't draw invisible players

local color = Color(0, 255, 127)
local pLocal;
local MURDER = engine.ActiveGamemode() == "murder";
local HEALTH_DIST_SQR = 4000 * 4000;
local draw_SimpleText = draw.SimpleText;
local math_max = math.max;
local math_clamp = math.Clamp;

local function chatmsg(text)
	surface.PlaySound("buttons/button1.wav")

	chat.AddText(color, text)
end


local function esp()
	if (!IsValid(pLocal)) then
		pLocal = LocalPlayer();
		return;
	end

	local myPos = pLocal:GetPos();
	local gayOffset = Vector(0, 0, 50);
	for k,v in next, player.GetAll() do 
                                    if v:GetColor().a == 0 then return true end -- added code from lenn 2/4/2021
		if v:IsDormant() || !v:Alive() || v == pLocal then continue end

		local pos = v:GetPos();
		local name_pos = (pos+gayOffset):ToScreen()
		local health_pos = pos:ToScreen()

		if MURDER then
			draw_SimpleText(v:Nick().." ("..v:GetNWString("bystanderName")..")", "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw_SimpleText(v:Nick(), "TargetIDSmall", name_pos.x, name_pos.y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((pos - myPos):LengthSqr() <= HEALTH_DIST_SQR)then
			local health = v:Health();
			local hpFrac = math_clamp(health / math_max(v:GetMaxHealth(), 1), 0, 1);
			draw_SimpleText(health.." HP", "TargetIDSmall", health_pos.x, health_pos.y, HSVToColor(120 * hpFrac, 1, 1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

hook.Add("HUDPaint", "ESP", esp)

concommand.Add("esp_unload", function()
	hook.Remove("HUDPaint", "ESP")
	chat.PlaySound()

	chatmsg("Simple ESP has been unloaded successfully. You won't be able to see peoples names through walls anymore.")
end)

chatmsg("Simple ESP has been loaded successfully. Use the command \"esp_unload\" to unload.")
print("\n Simple ESP, coded by Crave4. steamcommunity.com/id/Crave4\n")

]]--

