-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_console.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local convars = {
	wire_expression2_concmd = 0,
	wire_expression2_concmd_whitelist = "",
}

local function CreateCVars()
	for name,default in pairs(convars) do
		local current_cvar = CreateClientConVar(name, default, true, true)
		local value = current_cvar:GetString() or default
		RunConsoleCommand(name, value)
	end
end

if CanRunConsoleCommand() then
	CreateCVars()
else
	hook.Add("Initialize", "wire_expression2_console", function()
		CreateCVars()
	end)
end


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_console.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local convars = {
	wire_expression2_concmd = 0,
	wire_expression2_concmd_whitelist = "",
}

local function CreateCVars()
	for name,default in pairs(convars) do
		local current_cvar = CreateClientConVar(name, default, true, true)
		local value = current_cvar:GetString() or default
		RunConsoleCommand(name, value)
	end
end

if CanRunConsoleCommand() then
	CreateCVars()
else
	hook.Add("Initialize", "wire_expression2_console", function()
		CreateCVars()
	end)
end


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_console.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local convars = {
	wire_expression2_concmd = 0,
	wire_expression2_concmd_whitelist = "",
}

local function CreateCVars()
	for name,default in pairs(convars) do
		local current_cvar = CreateClientConVar(name, default, true, true)
		local value = current_cvar:GetString() or default
		RunConsoleCommand(name, value)
	end
end

if CanRunConsoleCommand() then
	CreateCVars()
else
	hook.Add("Initialize", "wire_expression2_console", function()
		CreateCVars()
	end)
end


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_console.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local convars = {
	wire_expression2_concmd = 0,
	wire_expression2_concmd_whitelist = "",
}

local function CreateCVars()
	for name,default in pairs(convars) do
		local current_cvar = CreateClientConVar(name, default, true, true)
		local value = current_cvar:GetString() or default
		RunConsoleCommand(name, value)
	end
end

if CanRunConsoleCommand() then
	CreateCVars()
else
	hook.Add("Initialize", "wire_expression2_console", function()
		CreateCVars()
	end)
end


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_console.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local convars = {
	wire_expression2_concmd = 0,
	wire_expression2_concmd_whitelist = "",
}

local function CreateCVars()
	for name,default in pairs(convars) do
		local current_cvar = CreateClientConVar(name, default, true, true)
		local value = current_cvar:GetString() or default
		RunConsoleCommand(name, value)
	end
end

if CanRunConsoleCommand() then
	CreateCVars()
else
	hook.Add("Initialize", "wire_expression2_console", function()
		CreateCVars()
	end)
end


