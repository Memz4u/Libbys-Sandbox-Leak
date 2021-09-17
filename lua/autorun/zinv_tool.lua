-- "lua\\autorun\\zinv_tool.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")
include("zinv_gui.lua")

if SERVER then return end

hook.Add("PopulateToolMenu", "ZINVmenu", function()
	spawnmenu.AddToolMenuOption("Options", "ZINV", "ZINV", "Settings", "", "", OnPopulateSettingsPanel)
end)

net.Receive("send_ztable_cl", function(len)
	profileList = net.ReadTable()
	profileName = net.ReadString()
	npcList = net.ReadTable()
	heroList = net.ReadTable()

	if SPAWN_MENU == nil then
		SPAWN_MENU = SpawnMenu:new()
	end
	
	SPAWN_MENU:refresh()
end)

function OnPopulateSettingsPanel(panel)
	local p = panel:AddControl("CheckBox", {
		Label = "Enabled?"
	})
	p:SetValue( GetConVarNumber( "zinv" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Exploded On Death?"
	})
	p:SetValue( GetConVarNumber( "zinv_explode" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_explode")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Chase Players?"
	})
	p:SetValue( GetConVarNumber( "zinv_chaseplayers" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_chaseplayers")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("Slider", {
		Label = "Minimum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000"
	})
	p:SetValue( GetConVarNumber( "zinv_mindist" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_mindist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs must be this far away from any player to spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000",
	})
	p:SetValue( GetConVarNumber( "zinv_maxdist" ))
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxdist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs will not spawn past this distance and if they are further away they will de-spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum NPCs Allowed",
		Type = "Long",
		Min = "0",
		Max = "300",
	})
	p:SetValue( GetConVarNumber( "zinv_maxspawn" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxspawn")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = ""
	})

	local p = panel:AddControl("Button", {
		Label = "Spawn Editor",
		Command = ""
	})
	p.DoClick = function() 
		if LocalPlayer():IsSuperAdmin() then
			SPAWN_MENU:show()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end
end

-- "lua\\autorun\\zinv_tool.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")
include("zinv_gui.lua")

if SERVER then return end

hook.Add("PopulateToolMenu", "ZINVmenu", function()
	spawnmenu.AddToolMenuOption("Options", "ZINV", "ZINV", "Settings", "", "", OnPopulateSettingsPanel)
end)

net.Receive("send_ztable_cl", function(len)
	profileList = net.ReadTable()
	profileName = net.ReadString()
	npcList = net.ReadTable()
	heroList = net.ReadTable()

	if SPAWN_MENU == nil then
		SPAWN_MENU = SpawnMenu:new()
	end
	
	SPAWN_MENU:refresh()
end)

function OnPopulateSettingsPanel(panel)
	local p = panel:AddControl("CheckBox", {
		Label = "Enabled?"
	})
	p:SetValue( GetConVarNumber( "zinv" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Exploded On Death?"
	})
	p:SetValue( GetConVarNumber( "zinv_explode" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_explode")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Chase Players?"
	})
	p:SetValue( GetConVarNumber( "zinv_chaseplayers" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_chaseplayers")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("Slider", {
		Label = "Minimum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000"
	})
	p:SetValue( GetConVarNumber( "zinv_mindist" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_mindist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs must be this far away from any player to spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000",
	})
	p:SetValue( GetConVarNumber( "zinv_maxdist" ))
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxdist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs will not spawn past this distance and if they are further away they will de-spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum NPCs Allowed",
		Type = "Long",
		Min = "0",
		Max = "300",
	})
	p:SetValue( GetConVarNumber( "zinv_maxspawn" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxspawn")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = ""
	})

	local p = panel:AddControl("Button", {
		Label = "Spawn Editor",
		Command = ""
	})
	p.DoClick = function() 
		if LocalPlayer():IsSuperAdmin() then
			SPAWN_MENU:show()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end
end

-- "lua\\autorun\\zinv_tool.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")
include("zinv_gui.lua")

if SERVER then return end

hook.Add("PopulateToolMenu", "ZINVmenu", function()
	spawnmenu.AddToolMenuOption("Options", "ZINV", "ZINV", "Settings", "", "", OnPopulateSettingsPanel)
end)

net.Receive("send_ztable_cl", function(len)
	profileList = net.ReadTable()
	profileName = net.ReadString()
	npcList = net.ReadTable()
	heroList = net.ReadTable()

	if SPAWN_MENU == nil then
		SPAWN_MENU = SpawnMenu:new()
	end
	
	SPAWN_MENU:refresh()
end)

function OnPopulateSettingsPanel(panel)
	local p = panel:AddControl("CheckBox", {
		Label = "Enabled?"
	})
	p:SetValue( GetConVarNumber( "zinv" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Exploded On Death?"
	})
	p:SetValue( GetConVarNumber( "zinv_explode" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_explode")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Chase Players?"
	})
	p:SetValue( GetConVarNumber( "zinv_chaseplayers" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_chaseplayers")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("Slider", {
		Label = "Minimum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000"
	})
	p:SetValue( GetConVarNumber( "zinv_mindist" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_mindist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs must be this far away from any player to spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000",
	})
	p:SetValue( GetConVarNumber( "zinv_maxdist" ))
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxdist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs will not spawn past this distance and if they are further away they will de-spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum NPCs Allowed",
		Type = "Long",
		Min = "0",
		Max = "300",
	})
	p:SetValue( GetConVarNumber( "zinv_maxspawn" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxspawn")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = ""
	})

	local p = panel:AddControl("Button", {
		Label = "Spawn Editor",
		Command = ""
	})
	p.DoClick = function() 
		if LocalPlayer():IsSuperAdmin() then
			SPAWN_MENU:show()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end
end

-- "lua\\autorun\\zinv_tool.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")
include("zinv_gui.lua")

if SERVER then return end

hook.Add("PopulateToolMenu", "ZINVmenu", function()
	spawnmenu.AddToolMenuOption("Options", "ZINV", "ZINV", "Settings", "", "", OnPopulateSettingsPanel)
end)

net.Receive("send_ztable_cl", function(len)
	profileList = net.ReadTable()
	profileName = net.ReadString()
	npcList = net.ReadTable()
	heroList = net.ReadTable()

	if SPAWN_MENU == nil then
		SPAWN_MENU = SpawnMenu:new()
	end
	
	SPAWN_MENU:refresh()
end)

function OnPopulateSettingsPanel(panel)
	local p = panel:AddControl("CheckBox", {
		Label = "Enabled?"
	})
	p:SetValue( GetConVarNumber( "zinv" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Exploded On Death?"
	})
	p:SetValue( GetConVarNumber( "zinv_explode" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_explode")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Chase Players?"
	})
	p:SetValue( GetConVarNumber( "zinv_chaseplayers" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_chaseplayers")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("Slider", {
		Label = "Minimum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000"
	})
	p:SetValue( GetConVarNumber( "zinv_mindist" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_mindist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs must be this far away from any player to spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000",
	})
	p:SetValue( GetConVarNumber( "zinv_maxdist" ))
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxdist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs will not spawn past this distance and if they are further away they will de-spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum NPCs Allowed",
		Type = "Long",
		Min = "0",
		Max = "300",
	})
	p:SetValue( GetConVarNumber( "zinv_maxspawn" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxspawn")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = ""
	})

	local p = panel:AddControl("Button", {
		Label = "Spawn Editor",
		Command = ""
	})
	p.DoClick = function() 
		if LocalPlayer():IsSuperAdmin() then
			SPAWN_MENU:show()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end
end

-- "lua\\autorun\\zinv_tool.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include("zinv_shared.lua")
include("zinv_gui.lua")

if SERVER then return end

hook.Add("PopulateToolMenu", "ZINVmenu", function()
	spawnmenu.AddToolMenuOption("Options", "ZINV", "ZINV", "Settings", "", "", OnPopulateSettingsPanel)
end)

net.Receive("send_ztable_cl", function(len)
	profileList = net.ReadTable()
	profileName = net.ReadString()
	npcList = net.ReadTable()
	heroList = net.ReadTable()

	if SPAWN_MENU == nil then
		SPAWN_MENU = SpawnMenu:new()
	end
	
	SPAWN_MENU:refresh()
end)

function OnPopulateSettingsPanel(panel)
	local p = panel:AddControl("CheckBox", {
		Label = "Enabled?"
	})
	p:SetValue( GetConVarNumber( "zinv" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Exploded On Death?"
	})
	p:SetValue( GetConVarNumber( "zinv_explode" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_explode")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("CheckBox", {
		Label = "Chase Players?"
	})
	p:SetValue( GetConVarNumber( "zinv_chaseplayers" ) )
	p.OnChange = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_chaseplayers")
			net.WriteFloat(self:GetChecked()==true and 1 or 0)
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	local p = panel:AddControl("Slider", {
		Label = "Minimum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000"
	})
	p:SetValue( GetConVarNumber( "zinv_mindist" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_mindist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs must be this far away from any player to spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum Spawn Distance",
		Type = "Long",
		Min = "0",
		Max = "20000",
	})
	p:SetValue( GetConVarNumber( "zinv_maxdist" ))
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxdist")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = "NPCs will not spawn past this distance and if they are further away they will de-spawn."
	})

	local p = panel:AddControl("Slider", {
		Label = "Maximum NPCs Allowed",
		Type = "Long",
		Min = "0",
		Max = "300",
	})
	p:SetValue( GetConVarNumber( "zinv_maxspawn" ) )
	p.OnValueChanged = function(self)
		if LocalPlayer():IsSuperAdmin() then
			net.Start("zinv_maxspawn")
			net.WriteFloat(self:GetValue())
			net.SendToServer()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end

	panel:AddControl("Label", {
		Text = ""
	})

	local p = panel:AddControl("Button", {
		Label = "Spawn Editor",
		Command = ""
	})
	p.DoClick = function() 
		if LocalPlayer():IsSuperAdmin() then
			SPAWN_MENU:show()
		else
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "You must be a super-admin to change this option.")
			chat.PlaySound()
		end			
	end
end

