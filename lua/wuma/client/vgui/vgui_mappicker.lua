-- "lua\\wuma\\client\\vgui\\vgui_mappicker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local PANEL = {}

function PANEL:AddOptions(options)
	for _, map in pairs(options) do
		map = string.gsub(map, ".bsp", "")
		if (map == game.GetMap()) then
			self:AddChoice(map, nil, true)
		else
			self:AddChoice(map)
		end
	end
end
	
function PANEL:GetArgument()
	local text, data = self:GetSelected()

	return text
end

vgui.Register("WMapPicker", PANEL, 'DComboBox');

-- "lua\\wuma\\client\\vgui\\vgui_mappicker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local PANEL = {}

function PANEL:AddOptions(options)
	for _, map in pairs(options) do
		map = string.gsub(map, ".bsp", "")
		if (map == game.GetMap()) then
			self:AddChoice(map, nil, true)
		else
			self:AddChoice(map)
		end
	end
end
	
function PANEL:GetArgument()
	local text, data = self:GetSelected()

	return text
end

vgui.Register("WMapPicker", PANEL, 'DComboBox');

-- "lua\\wuma\\client\\vgui\\vgui_mappicker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local PANEL = {}

function PANEL:AddOptions(options)
	for _, map in pairs(options) do
		map = string.gsub(map, ".bsp", "")
		if (map == game.GetMap()) then
			self:AddChoice(map, nil, true)
		else
			self:AddChoice(map)
		end
	end
end
	
function PANEL:GetArgument()
	local text, data = self:GetSelected()

	return text
end

vgui.Register("WMapPicker", PANEL, 'DComboBox');

-- "lua\\wuma\\client\\vgui\\vgui_mappicker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local PANEL = {}

function PANEL:AddOptions(options)
	for _, map in pairs(options) do
		map = string.gsub(map, ".bsp", "")
		if (map == game.GetMap()) then
			self:AddChoice(map, nil, true)
		else
			self:AddChoice(map)
		end
	end
end
	
function PANEL:GetArgument()
	local text, data = self:GetSelected()

	return text
end

vgui.Register("WMapPicker", PANEL, 'DComboBox');

-- "lua\\wuma\\client\\vgui\\vgui_mappicker.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local PANEL = {}

function PANEL:AddOptions(options)
	for _, map in pairs(options) do
		map = string.gsub(map, ".bsp", "")
		if (map == game.GetMap()) then
			self:AddChoice(map, nil, true)
		else
			self:AddChoice(map)
		end
	end
end
	
function PANEL:GetArgument()
	local text, data = self:GetSelected()

	return text
end

vgui.Register("WMapPicker", PANEL, 'DComboBox');

