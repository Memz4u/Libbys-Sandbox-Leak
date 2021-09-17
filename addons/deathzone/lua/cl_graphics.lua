-- "addons\\deathzone\\lua\\cl_graphics.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Damage Messages

local DMGMessageCache = {}

local function DrawDMGMessageCache()
	for k, v in pairs(DMGMessageCache) do
		if v.alpha <= 0 and not v.alphaUp then table.remove(DMGMessageCache, k) end
		v.timer = v.timer - 1

		if v.alphaUp and v.alpha < 255 then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		elseif not v.alphaUp then
			local amount = 255 / 100
			v.alpha = v.alpha - amount
		end

		if (CurTime() >= v.time + 1) and v.alphaUp then
			v.alphaUp = false
			v.downtime = CurTime()
		end

		local col = Color(255, 255, 255, 255)

		if v.amount >= 25 and v.amount < 50 then col = Color(255, 204, 204, 255)
		elseif v.amount >= 50 and v.amount < 100 then col = Color(255, 204, 102, 255)
		elseif v.amount >= 100 and v.amount < 150 then col = Color(255, 204, 0, 255)
		elseif v.amount >= 150 and v.amount < 200 then col = Color(255, 102, 0, 255)
		elseif v.amount >= 200 then col = Color(255, 0, 0, 255)
		end

		if v.squash then
			col = Color(255, 0, 0, 255)
		end

		local pos = (v.pos + Vector(0, 0, 20)):ToScreen()

		if v.alphaUp then
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10, Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10 + ((math.sin(CurTime() - v.downtime) * 5) * 20), Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end

hook.Add("HUDPaint", "PK_DrawDMGMessageCache", DrawDMGMessageCache)

net.Receive("PK_DamagePos", function()
	local data = net.ReadTable()
	local text = "-" .. data.amount

	if data.amount >= 100 then
		text = "Critical Hit!"
	end

	if data.squash then
		text = "SQUASHED!"
	end

	table.insert(DMGMessageCache, {text = text, amount = data.amount, pos = data.pos, time = CurTime(), downtime = CurTime(), timer = 0, alpha = 0, alphaUp = true, squash = data.squash})
end)

// HUD Messages

local MessageCache = {}


local function DrawMessageCache()
	for i, v in pairs(MessageCache) do
		if v.goingUp then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		else
			local amount = 255 / 100
			v.alpha = v.alpha - amount
			if v.alpha <= 0 then
				v.alpha = 0
			end
		end

		if CurTime() >= v.time + 3 then
			v.goingUp = false
		end

		if not v.goingUp and v.alpha <= 0 then
			table.remove(MessageCache, i)
		end

		local targetY
		if v.goingUp then
			targetY = -(i * 20)
			v.y = v.y + ((targetY - v.y) / 20)

			targetX = 30
			v.x = v.x + ((targetX - v.x) / 40)
		else
			targetY = 200
			v.y = v.y + ((targetY - v.y) / 80)

			targetX = -100
			v.x = v.x + ((targetX - v.x) / 60)
		end

		surface.SetMaterial(Material( "icon16/add.png" ,"nocull" ))
		surface.SetDrawColor(Color(255, 255, 255, v.alpha))
		surface.DrawTexturedRect(10 + v.x, (ScrH() / 2) + v.y - 8, 16, 16)
		draw.SimpleTextOutlined(v.data.text, "Trebuchet18", 30 + v.x, (ScrH() / 2) + v.y, Color(v.data.col.r, v.data.col.g, v.data.col.b, v.alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(v.data.col.r / 2, v.data.col.g / 2, v.data.col.b / 2, v.alpha / 2))
	end
end
hook.Add("HUDPaint", "PK_DrawMessageCache", DrawMessageCache)

net.Receive("PK_HUDMessage", function()
	local data = net.ReadTable()
	surface.PlaySound("buttons/lightswitch2.wav")
	MsgN(data.text)

	for k, v in pairs(MessageCache) do
		v.time = v.time + 1
	end

	table.insert(MessageCache, {data = {text = data.text, col = data.col}, x = 0, y = 0, goingUp = true, time = CurTime(), alpha = 0})
end)

local StreakCache = {}
	StreakCache.active = false
	StreakCache.text = ""
	StreakCache.alpha = 0
	StreakCache.alphaUp = false
	StreakCache.time = 0

local function DrawStreakCache()
	if StreakCache.active then
		if StreakCache.alphaUp then
			local amount = 255 / 30
			if StreakCache.alpha + amount <= 255 then
				StreakCache.alpha = StreakCache.alpha + amount
			else
				StreakCache.alpha = 255
			end
		else
			local amount = 255 / 100
			StreakCache.alpha = StreakCache.alpha - amount
			if StreakCache.alpha <= 0 then
				StreakCache.alpha = 0
			end
		end

		if StreakCache.alpha <= 0 then
			StreakCache.active = false
		end

		if CurTime() >= StreakCache.time + 3 then
			StreakCache.alphaUp = false
		end

		draw.SimpleText(StreakCache.text, "DermaLarge", ScrW() / 2, ScrH() / 6, Color(255, 255, 255, StreakCache.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end

hook.Add("HUDPaint", "PK_DrawStreakMessage", DrawStreakCache)
net.Receive("PK_KillStreakMessage", function()
	local data = net.ReadTable()
	StreakCache = {}
		StreakCache.active = true
		StreakCache.text = data.text
		StreakCache.alpha = 0
		StreakCache.alphaUp = true
		StreakCache.time = CurTime()
	if( GetConVar("_streaksounds"):GetBool() and data.sound != nil ) then
		surface.PlaySound(data.sound)
	end
	MsgN(data.text)
end)

usermessage.Hook("PK_ToggleSounds", function()
	if GetConVar("_streaksounds"):GetBool() then
		RunConsoleCommand("_streaksounds", 0)
		chat.AddText("You have disabled streak sounds!")
		surface.PlaySound("hl1/fvox/deactivated.wav")
	else
		RunConsoleCommand("_streaksounds", 1)
		chat.AddText("You have enabled streak sounds!")
		surface.PlaySound("hl1/fvox/activated.wav")
	end
end)

CreateClientConVar("_streaksounds", 1, true, false)

-- "addons\\deathzone\\lua\\cl_graphics.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Damage Messages

local DMGMessageCache = {}

local function DrawDMGMessageCache()
	for k, v in pairs(DMGMessageCache) do
		if v.alpha <= 0 and not v.alphaUp then table.remove(DMGMessageCache, k) end
		v.timer = v.timer - 1

		if v.alphaUp and v.alpha < 255 then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		elseif not v.alphaUp then
			local amount = 255 / 100
			v.alpha = v.alpha - amount
		end

		if (CurTime() >= v.time + 1) and v.alphaUp then
			v.alphaUp = false
			v.downtime = CurTime()
		end

		local col = Color(255, 255, 255, 255)

		if v.amount >= 25 and v.amount < 50 then col = Color(255, 204, 204, 255)
		elseif v.amount >= 50 and v.amount < 100 then col = Color(255, 204, 102, 255)
		elseif v.amount >= 100 and v.amount < 150 then col = Color(255, 204, 0, 255)
		elseif v.amount >= 150 and v.amount < 200 then col = Color(255, 102, 0, 255)
		elseif v.amount >= 200 then col = Color(255, 0, 0, 255)
		end

		if v.squash then
			col = Color(255, 0, 0, 255)
		end

		local pos = (v.pos + Vector(0, 0, 20)):ToScreen()

		if v.alphaUp then
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10, Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10 + ((math.sin(CurTime() - v.downtime) * 5) * 20), Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end

hook.Add("HUDPaint", "PK_DrawDMGMessageCache", DrawDMGMessageCache)

net.Receive("PK_DamagePos", function()
	local data = net.ReadTable()
	local text = "-" .. data.amount

	if data.amount >= 100 then
		text = "Critical Hit!"
	end

	if data.squash then
		text = "SQUASHED!"
	end

	table.insert(DMGMessageCache, {text = text, amount = data.amount, pos = data.pos, time = CurTime(), downtime = CurTime(), timer = 0, alpha = 0, alphaUp = true, squash = data.squash})
end)

// HUD Messages

local MessageCache = {}


local function DrawMessageCache()
	for i, v in pairs(MessageCache) do
		if v.goingUp then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		else
			local amount = 255 / 100
			v.alpha = v.alpha - amount
			if v.alpha <= 0 then
				v.alpha = 0
			end
		end

		if CurTime() >= v.time + 3 then
			v.goingUp = false
		end

		if not v.goingUp and v.alpha <= 0 then
			table.remove(MessageCache, i)
		end

		local targetY
		if v.goingUp then
			targetY = -(i * 20)
			v.y = v.y + ((targetY - v.y) / 20)

			targetX = 30
			v.x = v.x + ((targetX - v.x) / 40)
		else
			targetY = 200
			v.y = v.y + ((targetY - v.y) / 80)

			targetX = -100
			v.x = v.x + ((targetX - v.x) / 60)
		end

		surface.SetMaterial(Material( "icon16/add.png" ,"nocull" ))
		surface.SetDrawColor(Color(255, 255, 255, v.alpha))
		surface.DrawTexturedRect(10 + v.x, (ScrH() / 2) + v.y - 8, 16, 16)
		draw.SimpleTextOutlined(v.data.text, "Trebuchet18", 30 + v.x, (ScrH() / 2) + v.y, Color(v.data.col.r, v.data.col.g, v.data.col.b, v.alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(v.data.col.r / 2, v.data.col.g / 2, v.data.col.b / 2, v.alpha / 2))
	end
end
hook.Add("HUDPaint", "PK_DrawMessageCache", DrawMessageCache)

net.Receive("PK_HUDMessage", function()
	local data = net.ReadTable()
	surface.PlaySound("buttons/lightswitch2.wav")
	MsgN(data.text)

	for k, v in pairs(MessageCache) do
		v.time = v.time + 1
	end

	table.insert(MessageCache, {data = {text = data.text, col = data.col}, x = 0, y = 0, goingUp = true, time = CurTime(), alpha = 0})
end)

local StreakCache = {}
	StreakCache.active = false
	StreakCache.text = ""
	StreakCache.alpha = 0
	StreakCache.alphaUp = false
	StreakCache.time = 0

local function DrawStreakCache()
	if StreakCache.active then
		if StreakCache.alphaUp then
			local amount = 255 / 30
			if StreakCache.alpha + amount <= 255 then
				StreakCache.alpha = StreakCache.alpha + amount
			else
				StreakCache.alpha = 255
			end
		else
			local amount = 255 / 100
			StreakCache.alpha = StreakCache.alpha - amount
			if StreakCache.alpha <= 0 then
				StreakCache.alpha = 0
			end
		end

		if StreakCache.alpha <= 0 then
			StreakCache.active = false
		end

		if CurTime() >= StreakCache.time + 3 then
			StreakCache.alphaUp = false
		end

		draw.SimpleText(StreakCache.text, "DermaLarge", ScrW() / 2, ScrH() / 6, Color(255, 255, 255, StreakCache.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end

hook.Add("HUDPaint", "PK_DrawStreakMessage", DrawStreakCache)
net.Receive("PK_KillStreakMessage", function()
	local data = net.ReadTable()
	StreakCache = {}
		StreakCache.active = true
		StreakCache.text = data.text
		StreakCache.alpha = 0
		StreakCache.alphaUp = true
		StreakCache.time = CurTime()
	if( GetConVar("_streaksounds"):GetBool() and data.sound != nil ) then
		surface.PlaySound(data.sound)
	end
	MsgN(data.text)
end)

usermessage.Hook("PK_ToggleSounds", function()
	if GetConVar("_streaksounds"):GetBool() then
		RunConsoleCommand("_streaksounds", 0)
		chat.AddText("You have disabled streak sounds!")
		surface.PlaySound("hl1/fvox/deactivated.wav")
	else
		RunConsoleCommand("_streaksounds", 1)
		chat.AddText("You have enabled streak sounds!")
		surface.PlaySound("hl1/fvox/activated.wav")
	end
end)

CreateClientConVar("_streaksounds", 1, true, false)

-- "addons\\deathzone\\lua\\cl_graphics.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Damage Messages

local DMGMessageCache = {}

local function DrawDMGMessageCache()
	for k, v in pairs(DMGMessageCache) do
		if v.alpha <= 0 and not v.alphaUp then table.remove(DMGMessageCache, k) end
		v.timer = v.timer - 1

		if v.alphaUp and v.alpha < 255 then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		elseif not v.alphaUp then
			local amount = 255 / 100
			v.alpha = v.alpha - amount
		end

		if (CurTime() >= v.time + 1) and v.alphaUp then
			v.alphaUp = false
			v.downtime = CurTime()
		end

		local col = Color(255, 255, 255, 255)

		if v.amount >= 25 and v.amount < 50 then col = Color(255, 204, 204, 255)
		elseif v.amount >= 50 and v.amount < 100 then col = Color(255, 204, 102, 255)
		elseif v.amount >= 100 and v.amount < 150 then col = Color(255, 204, 0, 255)
		elseif v.amount >= 150 and v.amount < 200 then col = Color(255, 102, 0, 255)
		elseif v.amount >= 200 then col = Color(255, 0, 0, 255)
		end

		if v.squash then
			col = Color(255, 0, 0, 255)
		end

		local pos = (v.pos + Vector(0, 0, 20)):ToScreen()

		if v.alphaUp then
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10, Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10 + ((math.sin(CurTime() - v.downtime) * 5) * 20), Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end

hook.Add("HUDPaint", "PK_DrawDMGMessageCache", DrawDMGMessageCache)

net.Receive("PK_DamagePos", function()
	local data = net.ReadTable()
	local text = "-" .. data.amount

	if data.amount >= 100 then
		text = "Critical Hit!"
	end

	if data.squash then
		text = "SQUASHED!"
	end

	table.insert(DMGMessageCache, {text = text, amount = data.amount, pos = data.pos, time = CurTime(), downtime = CurTime(), timer = 0, alpha = 0, alphaUp = true, squash = data.squash})
end)

// HUD Messages

local MessageCache = {}


local function DrawMessageCache()
	for i, v in pairs(MessageCache) do
		if v.goingUp then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		else
			local amount = 255 / 100
			v.alpha = v.alpha - amount
			if v.alpha <= 0 then
				v.alpha = 0
			end
		end

		if CurTime() >= v.time + 3 then
			v.goingUp = false
		end

		if not v.goingUp and v.alpha <= 0 then
			table.remove(MessageCache, i)
		end

		local targetY
		if v.goingUp then
			targetY = -(i * 20)
			v.y = v.y + ((targetY - v.y) / 20)

			targetX = 30
			v.x = v.x + ((targetX - v.x) / 40)
		else
			targetY = 200
			v.y = v.y + ((targetY - v.y) / 80)

			targetX = -100
			v.x = v.x + ((targetX - v.x) / 60)
		end

		surface.SetMaterial(Material( "icon16/add.png" ,"nocull" ))
		surface.SetDrawColor(Color(255, 255, 255, v.alpha))
		surface.DrawTexturedRect(10 + v.x, (ScrH() / 2) + v.y - 8, 16, 16)
		draw.SimpleTextOutlined(v.data.text, "Trebuchet18", 30 + v.x, (ScrH() / 2) + v.y, Color(v.data.col.r, v.data.col.g, v.data.col.b, v.alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(v.data.col.r / 2, v.data.col.g / 2, v.data.col.b / 2, v.alpha / 2))
	end
end
hook.Add("HUDPaint", "PK_DrawMessageCache", DrawMessageCache)

net.Receive("PK_HUDMessage", function()
	local data = net.ReadTable()
	surface.PlaySound("buttons/lightswitch2.wav")
	MsgN(data.text)

	for k, v in pairs(MessageCache) do
		v.time = v.time + 1
	end

	table.insert(MessageCache, {data = {text = data.text, col = data.col}, x = 0, y = 0, goingUp = true, time = CurTime(), alpha = 0})
end)

local StreakCache = {}
	StreakCache.active = false
	StreakCache.text = ""
	StreakCache.alpha = 0
	StreakCache.alphaUp = false
	StreakCache.time = 0

local function DrawStreakCache()
	if StreakCache.active then
		if StreakCache.alphaUp then
			local amount = 255 / 30
			if StreakCache.alpha + amount <= 255 then
				StreakCache.alpha = StreakCache.alpha + amount
			else
				StreakCache.alpha = 255
			end
		else
			local amount = 255 / 100
			StreakCache.alpha = StreakCache.alpha - amount
			if StreakCache.alpha <= 0 then
				StreakCache.alpha = 0
			end
		end

		if StreakCache.alpha <= 0 then
			StreakCache.active = false
		end

		if CurTime() >= StreakCache.time + 3 then
			StreakCache.alphaUp = false
		end

		draw.SimpleText(StreakCache.text, "DermaLarge", ScrW() / 2, ScrH() / 6, Color(255, 255, 255, StreakCache.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end

hook.Add("HUDPaint", "PK_DrawStreakMessage", DrawStreakCache)
net.Receive("PK_KillStreakMessage", function()
	local data = net.ReadTable()
	StreakCache = {}
		StreakCache.active = true
		StreakCache.text = data.text
		StreakCache.alpha = 0
		StreakCache.alphaUp = true
		StreakCache.time = CurTime()
	if( GetConVar("_streaksounds"):GetBool() and data.sound != nil ) then
		surface.PlaySound(data.sound)
	end
	MsgN(data.text)
end)

usermessage.Hook("PK_ToggleSounds", function()
	if GetConVar("_streaksounds"):GetBool() then
		RunConsoleCommand("_streaksounds", 0)
		chat.AddText("You have disabled streak sounds!")
		surface.PlaySound("hl1/fvox/deactivated.wav")
	else
		RunConsoleCommand("_streaksounds", 1)
		chat.AddText("You have enabled streak sounds!")
		surface.PlaySound("hl1/fvox/activated.wav")
	end
end)

CreateClientConVar("_streaksounds", 1, true, false)

-- "addons\\deathzone\\lua\\cl_graphics.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Damage Messages

local DMGMessageCache = {}

local function DrawDMGMessageCache()
	for k, v in pairs(DMGMessageCache) do
		if v.alpha <= 0 and not v.alphaUp then table.remove(DMGMessageCache, k) end
		v.timer = v.timer - 1

		if v.alphaUp and v.alpha < 255 then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		elseif not v.alphaUp then
			local amount = 255 / 100
			v.alpha = v.alpha - amount
		end

		if (CurTime() >= v.time + 1) and v.alphaUp then
			v.alphaUp = false
			v.downtime = CurTime()
		end

		local col = Color(255, 255, 255, 255)

		if v.amount >= 25 and v.amount < 50 then col = Color(255, 204, 204, 255)
		elseif v.amount >= 50 and v.amount < 100 then col = Color(255, 204, 102, 255)
		elseif v.amount >= 100 and v.amount < 150 then col = Color(255, 204, 0, 255)
		elseif v.amount >= 150 and v.amount < 200 then col = Color(255, 102, 0, 255)
		elseif v.amount >= 200 then col = Color(255, 0, 0, 255)
		end

		if v.squash then
			col = Color(255, 0, 0, 255)
		end

		local pos = (v.pos + Vector(0, 0, 20)):ToScreen()

		if v.alphaUp then
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10, Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10 + ((math.sin(CurTime() - v.downtime) * 5) * 20), Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end

hook.Add("HUDPaint", "PK_DrawDMGMessageCache", DrawDMGMessageCache)

net.Receive("PK_DamagePos", function()
	local data = net.ReadTable()
	local text = "-" .. data.amount

	if data.amount >= 100 then
		text = "Critical Hit!"
	end

	if data.squash then
		text = "SQUASHED!"
	end

	table.insert(DMGMessageCache, {text = text, amount = data.amount, pos = data.pos, time = CurTime(), downtime = CurTime(), timer = 0, alpha = 0, alphaUp = true, squash = data.squash})
end)

// HUD Messages

local MessageCache = {}


local function DrawMessageCache()
	for i, v in pairs(MessageCache) do
		if v.goingUp then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		else
			local amount = 255 / 100
			v.alpha = v.alpha - amount
			if v.alpha <= 0 then
				v.alpha = 0
			end
		end

		if CurTime() >= v.time + 3 then
			v.goingUp = false
		end

		if not v.goingUp and v.alpha <= 0 then
			table.remove(MessageCache, i)
		end

		local targetY
		if v.goingUp then
			targetY = -(i * 20)
			v.y = v.y + ((targetY - v.y) / 20)

			targetX = 30
			v.x = v.x + ((targetX - v.x) / 40)
		else
			targetY = 200
			v.y = v.y + ((targetY - v.y) / 80)

			targetX = -100
			v.x = v.x + ((targetX - v.x) / 60)
		end

		surface.SetMaterial(Material( "icon16/add.png" ,"nocull" ))
		surface.SetDrawColor(Color(255, 255, 255, v.alpha))
		surface.DrawTexturedRect(10 + v.x, (ScrH() / 2) + v.y - 8, 16, 16)
		draw.SimpleTextOutlined(v.data.text, "Trebuchet18", 30 + v.x, (ScrH() / 2) + v.y, Color(v.data.col.r, v.data.col.g, v.data.col.b, v.alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(v.data.col.r / 2, v.data.col.g / 2, v.data.col.b / 2, v.alpha / 2))
	end
end
hook.Add("HUDPaint", "PK_DrawMessageCache", DrawMessageCache)

net.Receive("PK_HUDMessage", function()
	local data = net.ReadTable()
	surface.PlaySound("buttons/lightswitch2.wav")
	MsgN(data.text)

	for k, v in pairs(MessageCache) do
		v.time = v.time + 1
	end

	table.insert(MessageCache, {data = {text = data.text, col = data.col}, x = 0, y = 0, goingUp = true, time = CurTime(), alpha = 0})
end)

local StreakCache = {}
	StreakCache.active = false
	StreakCache.text = ""
	StreakCache.alpha = 0
	StreakCache.alphaUp = false
	StreakCache.time = 0

local function DrawStreakCache()
	if StreakCache.active then
		if StreakCache.alphaUp then
			local amount = 255 / 30
			if StreakCache.alpha + amount <= 255 then
				StreakCache.alpha = StreakCache.alpha + amount
			else
				StreakCache.alpha = 255
			end
		else
			local amount = 255 / 100
			StreakCache.alpha = StreakCache.alpha - amount
			if StreakCache.alpha <= 0 then
				StreakCache.alpha = 0
			end
		end

		if StreakCache.alpha <= 0 then
			StreakCache.active = false
		end

		if CurTime() >= StreakCache.time + 3 then
			StreakCache.alphaUp = false
		end

		draw.SimpleText(StreakCache.text, "DermaLarge", ScrW() / 2, ScrH() / 6, Color(255, 255, 255, StreakCache.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end

hook.Add("HUDPaint", "PK_DrawStreakMessage", DrawStreakCache)
net.Receive("PK_KillStreakMessage", function()
	local data = net.ReadTable()
	StreakCache = {}
		StreakCache.active = true
		StreakCache.text = data.text
		StreakCache.alpha = 0
		StreakCache.alphaUp = true
		StreakCache.time = CurTime()
	if( GetConVar("_streaksounds"):GetBool() and data.sound != nil ) then
		surface.PlaySound(data.sound)
	end
	MsgN(data.text)
end)

usermessage.Hook("PK_ToggleSounds", function()
	if GetConVar("_streaksounds"):GetBool() then
		RunConsoleCommand("_streaksounds", 0)
		chat.AddText("You have disabled streak sounds!")
		surface.PlaySound("hl1/fvox/deactivated.wav")
	else
		RunConsoleCommand("_streaksounds", 1)
		chat.AddText("You have enabled streak sounds!")
		surface.PlaySound("hl1/fvox/activated.wav")
	end
end)

CreateClientConVar("_streaksounds", 1, true, false)

-- "addons\\deathzone\\lua\\cl_graphics.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Damage Messages

local DMGMessageCache = {}

local function DrawDMGMessageCache()
	for k, v in pairs(DMGMessageCache) do
		if v.alpha <= 0 and not v.alphaUp then table.remove(DMGMessageCache, k) end
		v.timer = v.timer - 1

		if v.alphaUp and v.alpha < 255 then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		elseif not v.alphaUp then
			local amount = 255 / 100
			v.alpha = v.alpha - amount
		end

		if (CurTime() >= v.time + 1) and v.alphaUp then
			v.alphaUp = false
			v.downtime = CurTime()
		end

		local col = Color(255, 255, 255, 255)

		if v.amount >= 25 and v.amount < 50 then col = Color(255, 204, 204, 255)
		elseif v.amount >= 50 and v.amount < 100 then col = Color(255, 204, 102, 255)
		elseif v.amount >= 100 and v.amount < 150 then col = Color(255, 204, 0, 255)
		elseif v.amount >= 150 and v.amount < 200 then col = Color(255, 102, 0, 255)
		elseif v.amount >= 200 then col = Color(255, 0, 0, 255)
		end

		if v.squash then
			col = Color(255, 0, 0, 255)
		end

		local pos = (v.pos + Vector(0, 0, 20)):ToScreen()

		if v.alphaUp then
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10, Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			draw.SimpleText(v.text, "DermaLarge", pos.x, pos.y - 10 + ((math.sin(CurTime() - v.downtime) * 5) * 20), Color(col.r, col.g, col.b, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end
end

hook.Add("HUDPaint", "PK_DrawDMGMessageCache", DrawDMGMessageCache)

net.Receive("PK_DamagePos", function()
	local data = net.ReadTable()
	local text = "-" .. data.amount

	if data.amount >= 100 then
		text = "Critical Hit!"
	end

	if data.squash then
		text = "SQUASHED!"
	end

	table.insert(DMGMessageCache, {text = text, amount = data.amount, pos = data.pos, time = CurTime(), downtime = CurTime(), timer = 0, alpha = 0, alphaUp = true, squash = data.squash})
end)

// HUD Messages

local MessageCache = {}


local function DrawMessageCache()
	for i, v in pairs(MessageCache) do
		if v.goingUp then
			local amount = 255 / 30
			if v.alpha + amount <= 255 then
				v.alpha = v.alpha + amount
			else
				v.alpha = 255
			end
		else
			local amount = 255 / 100
			v.alpha = v.alpha - amount
			if v.alpha <= 0 then
				v.alpha = 0
			end
		end

		if CurTime() >= v.time + 3 then
			v.goingUp = false
		end

		if not v.goingUp and v.alpha <= 0 then
			table.remove(MessageCache, i)
		end

		local targetY
		if v.goingUp then
			targetY = -(i * 20)
			v.y = v.y + ((targetY - v.y) / 20)

			targetX = 30
			v.x = v.x + ((targetX - v.x) / 40)
		else
			targetY = 200
			v.y = v.y + ((targetY - v.y) / 80)

			targetX = -100
			v.x = v.x + ((targetX - v.x) / 60)
		end

		surface.SetMaterial(Material( "icon16/add.png" ,"nocull" ))
		surface.SetDrawColor(Color(255, 255, 255, v.alpha))
		surface.DrawTexturedRect(10 + v.x, (ScrH() / 2) + v.y - 8, 16, 16)
		draw.SimpleTextOutlined(v.data.text, "Trebuchet18", 30 + v.x, (ScrH() / 2) + v.y, Color(v.data.col.r, v.data.col.g, v.data.col.b, v.alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(v.data.col.r / 2, v.data.col.g / 2, v.data.col.b / 2, v.alpha / 2))
	end
end
hook.Add("HUDPaint", "PK_DrawMessageCache", DrawMessageCache)

net.Receive("PK_HUDMessage", function()
	local data = net.ReadTable()
	surface.PlaySound("buttons/lightswitch2.wav")
	MsgN(data.text)

	for k, v in pairs(MessageCache) do
		v.time = v.time + 1
	end

	table.insert(MessageCache, {data = {text = data.text, col = data.col}, x = 0, y = 0, goingUp = true, time = CurTime(), alpha = 0})
end)

local StreakCache = {}
	StreakCache.active = false
	StreakCache.text = ""
	StreakCache.alpha = 0
	StreakCache.alphaUp = false
	StreakCache.time = 0

local function DrawStreakCache()
	if StreakCache.active then
		if StreakCache.alphaUp then
			local amount = 255 / 30
			if StreakCache.alpha + amount <= 255 then
				StreakCache.alpha = StreakCache.alpha + amount
			else
				StreakCache.alpha = 255
			end
		else
			local amount = 255 / 100
			StreakCache.alpha = StreakCache.alpha - amount
			if StreakCache.alpha <= 0 then
				StreakCache.alpha = 0
			end
		end

		if StreakCache.alpha <= 0 then
			StreakCache.active = false
		end

		if CurTime() >= StreakCache.time + 3 then
			StreakCache.alphaUp = false
		end

		draw.SimpleText(StreakCache.text, "DermaLarge", ScrW() / 2, ScrH() / 6, Color(255, 255, 255, StreakCache.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
end

hook.Add("HUDPaint", "PK_DrawStreakMessage", DrawStreakCache)
net.Receive("PK_KillStreakMessage", function()
	local data = net.ReadTable()
	StreakCache = {}
		StreakCache.active = true
		StreakCache.text = data.text
		StreakCache.alpha = 0
		StreakCache.alphaUp = true
		StreakCache.time = CurTime()
	if( GetConVar("_streaksounds"):GetBool() and data.sound != nil ) then
		surface.PlaySound(data.sound)
	end
	MsgN(data.text)
end)

usermessage.Hook("PK_ToggleSounds", function()
	if GetConVar("_streaksounds"):GetBool() then
		RunConsoleCommand("_streaksounds", 0)
		chat.AddText("You have disabled streak sounds!")
		surface.PlaySound("hl1/fvox/deactivated.wav")
	else
		RunConsoleCommand("_streaksounds", 1)
		chat.AddText("You have enabled streak sounds!")
		surface.PlaySound("hl1/fvox/activated.wav")
	end
end)

CreateClientConVar("_streaksounds", 1, true, false)

