-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\custom\\cl_remoteupload.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
usermessage.Hook("e2_remoteupload_request", function(um)
	local target = um:ReadEntity()
	local filepath = um:ReadString()

	if target and target:IsValid() and filepath and file.Exists("expression2/" .. filepath, "DATA") then
		local str = file.Read("expression2/" .. filepath)
		WireLib.Expression2Upload(target, str, "expression2/" .. filepath)
	end
end)


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\custom\\cl_remoteupload.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
usermessage.Hook("e2_remoteupload_request", function(um)
	local target = um:ReadEntity()
	local filepath = um:ReadString()

	if target and target:IsValid() and filepath and file.Exists("expression2/" .. filepath, "DATA") then
		local str = file.Read("expression2/" .. filepath)
		WireLib.Expression2Upload(target, str, "expression2/" .. filepath)
	end
end)


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\custom\\cl_remoteupload.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
usermessage.Hook("e2_remoteupload_request", function(um)
	local target = um:ReadEntity()
	local filepath = um:ReadString()

	if target and target:IsValid() and filepath and file.Exists("expression2/" .. filepath, "DATA") then
		local str = file.Read("expression2/" .. filepath)
		WireLib.Expression2Upload(target, str, "expression2/" .. filepath)
	end
end)


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\custom\\cl_remoteupload.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
usermessage.Hook("e2_remoteupload_request", function(um)
	local target = um:ReadEntity()
	local filepath = um:ReadString()

	if target and target:IsValid() and filepath and file.Exists("expression2/" .. filepath, "DATA") then
		local str = file.Read("expression2/" .. filepath)
		WireLib.Expression2Upload(target, str, "expression2/" .. filepath)
	end
end)


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\custom\\cl_remoteupload.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
usermessage.Hook("e2_remoteupload_request", function(um)
	local target = um:ReadEntity()
	local filepath = um:ReadString()

	if target and target:IsValid() and filepath and file.Exists("expression2/" .. filepath, "DATA") then
		local str = file.Read("expression2/" .. filepath)
		WireLib.Expression2Upload(target, str, "expression2/" .. filepath)
	end
end)


