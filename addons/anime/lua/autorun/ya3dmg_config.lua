-- "addons\\anime\\lua\\autorun\\ya3dmg_config.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Ya, it's 3DMG!

// Yet Another 3DMG
// Author: mmys
// ya3dmg_config.lua
//  Handles the configuration menus for YA3DMG.
//  Please see the main weapon file for blurbs and more information.

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

//function SetClientCVIfBlank(name, val)
//	CreateClientConVar("sv_ya3dmg_cl_" .. name, val, true, false);
//end

function SetCVIfBlank(name, val)
	// This can potentially cause issues, so it's disabled for the time being.
	//if(!ConVarExists("sv_ya3dmg_" .. name))then
		CreateConVar("sv_ya3dmg_" .. name, val, FCVAR_REPLICATED + FCVAR_NOTIFY);
	//	print("Created " .. name);
	//end
end

SetCVIfBlank("hookspeed", "1500.0");
SetCVIfBlank("hookspeedretract", "2000.0");
SetCVIfBlank("hookspeed_super", "3000.0");
SetCVIfBlank("hookspeedretract_super", "5000.0");
SetCVIfBlank("maxcentripetal", "8500.0");
SetCVIfBlank("tracing_distance", "20000.0");
SetCVIfBlank("hook_distance", "5000.0");
SetCVIfBlank("smoke_enabled", "0");
SetCVIfBlank("smoke_normal_time", "0.8");
SetCVIfBlank("smoke_super_time", "1.4");

if(SERVER)then
	util.AddNetworkString(NET_UPDATE_STRING);
end
	
function AddHeading(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetFont("DermaDefaultBold");
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	textElement:SizeToContents();
	panel:AddItem(textElement);
	return textElement;
end

function AddLabel(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	panel:AddItem(textElement);
	return textElement;
end

function AddAnnotation(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetWrap(true);
	textElement:SetAutoStretchVertical(true);
	textElement:SetText(text);
	textElement:SetTextColor(Color(30,30,150));
	panel:AddItem(textElement);
	return textElement;
end

function AddCVarEntry(panel, text, var)
	local entryElement = panel:TextEntry(text,"sv_ya3dmg_" .. var);
	entryElement:SetText(GetConVarString("sv_ya3dmg_" .. var));
	entryElement:SetNumeric(true);
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		entryElement:SetDisabled(true);
	end
	return entryElement;
end

function AddDivider(panel)
	AddLabel(panel,"____________________________________________________________________________________________________________________________________");
end

function DrawAdminPanel(panel)
	AddHeading(panel,"Ordinary hook settings (not holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed");
	AddAnnotation(panel, "Ordinary acceleration of one hook.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract");
	AddAnnotation(panel, "If the hook has grown longer, this is the acceleration it will use.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Speedy hook settings (holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed_super");
	AddAnnotation(panel, "As with ordinary settings.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract_super");
	
	AddDivider(panel);
	
	AddHeading(panel,"Swinging hook settings (holding SNEAK.)");
	AddCVarEntry(panel, "Maximum force", "maxcentripetal");
	AddAnnotation(panel, "Max centripetal force. Increasing lets you make tighter turns.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Hook range settings");
	AddCVarEntry(panel, "Trace distance", "tracing_distance");
	AddAnnotation(panel, "Should be longer than hook range. Affects the distance reticle/crosshair.");
	AddCVarEntry(panel, "Hook range", "hook_distance");
	AddAnnotation(panel, "How far you can fire a hook.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Smoke settings");
	local cb = panel:CheckBox("Enable smoke?","sv_ya3dmg_smoke_enabled");
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		cb:SetDisabled(true);
	end
	AddCVarEntry(panel, "Persist Time", "smoke_normal_time");
	AddAnnotation(panel, "If you were using ordinary hook speed, this is how long you'll keep smoking even after you're done with your hooks.");
	AddCVarEntry(panel, "Speedy Persist", "smoke_super_time");
	AddAnnotation(panel, "As above, but if you were using the speedy option.");
end

function PreparePanels()
	if(CLIENT)then
		/*
		hook.Add( "PopulateToolMenu", "YA3DMG-Client-Menu", function()
			spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Client Settings", "Client Settings", "", "", function( panel )
				local ele;
				
				AddLabel(panel,"Under construction! ^^;");
			end )
		end )
		*/
		
		//if(LocalPlayer():IsAdmin())then
			hook.Add( "PopulateToolMenu", "YA3DMG-Admin-Menu", function()
				spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Admin Settings", "Admin Settings", "", "", function( panel )
					DrawAdminPanel(panel);
				end )
			end )
		//end
		
	end
end

	PreparePanels();

-- "addons\\anime\\lua\\autorun\\ya3dmg_config.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Ya, it's 3DMG!

// Yet Another 3DMG
// Author: mmys
// ya3dmg_config.lua
//  Handles the configuration menus for YA3DMG.
//  Please see the main weapon file for blurbs and more information.

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

//function SetClientCVIfBlank(name, val)
//	CreateClientConVar("sv_ya3dmg_cl_" .. name, val, true, false);
//end

function SetCVIfBlank(name, val)
	// This can potentially cause issues, so it's disabled for the time being.
	//if(!ConVarExists("sv_ya3dmg_" .. name))then
		CreateConVar("sv_ya3dmg_" .. name, val, FCVAR_REPLICATED + FCVAR_NOTIFY);
	//	print("Created " .. name);
	//end
end

SetCVIfBlank("hookspeed", "1500.0");
SetCVIfBlank("hookspeedretract", "2000.0");
SetCVIfBlank("hookspeed_super", "3000.0");
SetCVIfBlank("hookspeedretract_super", "5000.0");
SetCVIfBlank("maxcentripetal", "8500.0");
SetCVIfBlank("tracing_distance", "20000.0");
SetCVIfBlank("hook_distance", "5000.0");
SetCVIfBlank("smoke_enabled", "0");
SetCVIfBlank("smoke_normal_time", "0.8");
SetCVIfBlank("smoke_super_time", "1.4");

if(SERVER)then
	util.AddNetworkString(NET_UPDATE_STRING);
end
	
function AddHeading(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetFont("DermaDefaultBold");
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	textElement:SizeToContents();
	panel:AddItem(textElement);
	return textElement;
end

function AddLabel(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	panel:AddItem(textElement);
	return textElement;
end

function AddAnnotation(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetWrap(true);
	textElement:SetAutoStretchVertical(true);
	textElement:SetText(text);
	textElement:SetTextColor(Color(30,30,150));
	panel:AddItem(textElement);
	return textElement;
end

function AddCVarEntry(panel, text, var)
	local entryElement = panel:TextEntry(text,"sv_ya3dmg_" .. var);
	entryElement:SetText(GetConVarString("sv_ya3dmg_" .. var));
	entryElement:SetNumeric(true);
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		entryElement:SetDisabled(true);
	end
	return entryElement;
end

function AddDivider(panel)
	AddLabel(panel,"____________________________________________________________________________________________________________________________________");
end

function DrawAdminPanel(panel)
	AddHeading(panel,"Ordinary hook settings (not holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed");
	AddAnnotation(panel, "Ordinary acceleration of one hook.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract");
	AddAnnotation(panel, "If the hook has grown longer, this is the acceleration it will use.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Speedy hook settings (holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed_super");
	AddAnnotation(panel, "As with ordinary settings.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract_super");
	
	AddDivider(panel);
	
	AddHeading(panel,"Swinging hook settings (holding SNEAK.)");
	AddCVarEntry(panel, "Maximum force", "maxcentripetal");
	AddAnnotation(panel, "Max centripetal force. Increasing lets you make tighter turns.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Hook range settings");
	AddCVarEntry(panel, "Trace distance", "tracing_distance");
	AddAnnotation(panel, "Should be longer than hook range. Affects the distance reticle/crosshair.");
	AddCVarEntry(panel, "Hook range", "hook_distance");
	AddAnnotation(panel, "How far you can fire a hook.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Smoke settings");
	local cb = panel:CheckBox("Enable smoke?","sv_ya3dmg_smoke_enabled");
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		cb:SetDisabled(true);
	end
	AddCVarEntry(panel, "Persist Time", "smoke_normal_time");
	AddAnnotation(panel, "If you were using ordinary hook speed, this is how long you'll keep smoking even after you're done with your hooks.");
	AddCVarEntry(panel, "Speedy Persist", "smoke_super_time");
	AddAnnotation(panel, "As above, but if you were using the speedy option.");
end

function PreparePanels()
	if(CLIENT)then
		/*
		hook.Add( "PopulateToolMenu", "YA3DMG-Client-Menu", function()
			spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Client Settings", "Client Settings", "", "", function( panel )
				local ele;
				
				AddLabel(panel,"Under construction! ^^;");
			end )
		end )
		*/
		
		//if(LocalPlayer():IsAdmin())then
			hook.Add( "PopulateToolMenu", "YA3DMG-Admin-Menu", function()
				spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Admin Settings", "Admin Settings", "", "", function( panel )
					DrawAdminPanel(panel);
				end )
			end )
		//end
		
	end
end

	PreparePanels();

-- "addons\\anime\\lua\\autorun\\ya3dmg_config.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Ya, it's 3DMG!

// Yet Another 3DMG
// Author: mmys
// ya3dmg_config.lua
//  Handles the configuration menus for YA3DMG.
//  Please see the main weapon file for blurbs and more information.

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

//function SetClientCVIfBlank(name, val)
//	CreateClientConVar("sv_ya3dmg_cl_" .. name, val, true, false);
//end

function SetCVIfBlank(name, val)
	// This can potentially cause issues, so it's disabled for the time being.
	//if(!ConVarExists("sv_ya3dmg_" .. name))then
		CreateConVar("sv_ya3dmg_" .. name, val, FCVAR_REPLICATED + FCVAR_NOTIFY);
	//	print("Created " .. name);
	//end
end

SetCVIfBlank("hookspeed", "1500.0");
SetCVIfBlank("hookspeedretract", "2000.0");
SetCVIfBlank("hookspeed_super", "3000.0");
SetCVIfBlank("hookspeedretract_super", "5000.0");
SetCVIfBlank("maxcentripetal", "8500.0");
SetCVIfBlank("tracing_distance", "20000.0");
SetCVIfBlank("hook_distance", "5000.0");
SetCVIfBlank("smoke_enabled", "0");
SetCVIfBlank("smoke_normal_time", "0.8");
SetCVIfBlank("smoke_super_time", "1.4");

if(SERVER)then
	util.AddNetworkString(NET_UPDATE_STRING);
end
	
function AddHeading(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetFont("DermaDefaultBold");
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	textElement:SizeToContents();
	panel:AddItem(textElement);
	return textElement;
end

function AddLabel(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	panel:AddItem(textElement);
	return textElement;
end

function AddAnnotation(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetWrap(true);
	textElement:SetAutoStretchVertical(true);
	textElement:SetText(text);
	textElement:SetTextColor(Color(30,30,150));
	panel:AddItem(textElement);
	return textElement;
end

function AddCVarEntry(panel, text, var)
	local entryElement = panel:TextEntry(text,"sv_ya3dmg_" .. var);
	entryElement:SetText(GetConVarString("sv_ya3dmg_" .. var));
	entryElement:SetNumeric(true);
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		entryElement:SetDisabled(true);
	end
	return entryElement;
end

function AddDivider(panel)
	AddLabel(panel,"____________________________________________________________________________________________________________________________________");
end

function DrawAdminPanel(panel)
	AddHeading(panel,"Ordinary hook settings (not holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed");
	AddAnnotation(panel, "Ordinary acceleration of one hook.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract");
	AddAnnotation(panel, "If the hook has grown longer, this is the acceleration it will use.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Speedy hook settings (holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed_super");
	AddAnnotation(panel, "As with ordinary settings.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract_super");
	
	AddDivider(panel);
	
	AddHeading(panel,"Swinging hook settings (holding SNEAK.)");
	AddCVarEntry(panel, "Maximum force", "maxcentripetal");
	AddAnnotation(panel, "Max centripetal force. Increasing lets you make tighter turns.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Hook range settings");
	AddCVarEntry(panel, "Trace distance", "tracing_distance");
	AddAnnotation(panel, "Should be longer than hook range. Affects the distance reticle/crosshair.");
	AddCVarEntry(panel, "Hook range", "hook_distance");
	AddAnnotation(panel, "How far you can fire a hook.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Smoke settings");
	local cb = panel:CheckBox("Enable smoke?","sv_ya3dmg_smoke_enabled");
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		cb:SetDisabled(true);
	end
	AddCVarEntry(panel, "Persist Time", "smoke_normal_time");
	AddAnnotation(panel, "If you were using ordinary hook speed, this is how long you'll keep smoking even after you're done with your hooks.");
	AddCVarEntry(panel, "Speedy Persist", "smoke_super_time");
	AddAnnotation(panel, "As above, but if you were using the speedy option.");
end

function PreparePanels()
	if(CLIENT)then
		/*
		hook.Add( "PopulateToolMenu", "YA3DMG-Client-Menu", function()
			spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Client Settings", "Client Settings", "", "", function( panel )
				local ele;
				
				AddLabel(panel,"Under construction! ^^;");
			end )
		end )
		*/
		
		//if(LocalPlayer():IsAdmin())then
			hook.Add( "PopulateToolMenu", "YA3DMG-Admin-Menu", function()
				spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Admin Settings", "Admin Settings", "", "", function( panel )
					DrawAdminPanel(panel);
				end )
			end )
		//end
		
	end
end

	PreparePanels();

-- "addons\\anime\\lua\\autorun\\ya3dmg_config.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Ya, it's 3DMG!

// Yet Another 3DMG
// Author: mmys
// ya3dmg_config.lua
//  Handles the configuration menus for YA3DMG.
//  Please see the main weapon file for blurbs and more information.

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

//function SetClientCVIfBlank(name, val)
//	CreateClientConVar("sv_ya3dmg_cl_" .. name, val, true, false);
//end

function SetCVIfBlank(name, val)
	// This can potentially cause issues, so it's disabled for the time being.
	//if(!ConVarExists("sv_ya3dmg_" .. name))then
		CreateConVar("sv_ya3dmg_" .. name, val, FCVAR_REPLICATED + FCVAR_NOTIFY);
	//	print("Created " .. name);
	//end
end

SetCVIfBlank("hookspeed", "1500.0");
SetCVIfBlank("hookspeedretract", "2000.0");
SetCVIfBlank("hookspeed_super", "3000.0");
SetCVIfBlank("hookspeedretract_super", "5000.0");
SetCVIfBlank("maxcentripetal", "8500.0");
SetCVIfBlank("tracing_distance", "20000.0");
SetCVIfBlank("hook_distance", "5000.0");
SetCVIfBlank("smoke_enabled", "0");
SetCVIfBlank("smoke_normal_time", "0.8");
SetCVIfBlank("smoke_super_time", "1.4");

if(SERVER)then
	util.AddNetworkString(NET_UPDATE_STRING);
end
	
function AddHeading(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetFont("DermaDefaultBold");
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	textElement:SizeToContents();
	panel:AddItem(textElement);
	return textElement;
end

function AddLabel(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	panel:AddItem(textElement);
	return textElement;
end

function AddAnnotation(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetWrap(true);
	textElement:SetAutoStretchVertical(true);
	textElement:SetText(text);
	textElement:SetTextColor(Color(30,30,150));
	panel:AddItem(textElement);
	return textElement;
end

function AddCVarEntry(panel, text, var)
	local entryElement = panel:TextEntry(text,"sv_ya3dmg_" .. var);
	entryElement:SetText(GetConVarString("sv_ya3dmg_" .. var));
	entryElement:SetNumeric(true);
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		entryElement:SetDisabled(true);
	end
	return entryElement;
end

function AddDivider(panel)
	AddLabel(panel,"____________________________________________________________________________________________________________________________________");
end

function DrawAdminPanel(panel)
	AddHeading(panel,"Ordinary hook settings (not holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed");
	AddAnnotation(panel, "Ordinary acceleration of one hook.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract");
	AddAnnotation(panel, "If the hook has grown longer, this is the acceleration it will use.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Speedy hook settings (holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed_super");
	AddAnnotation(panel, "As with ordinary settings.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract_super");
	
	AddDivider(panel);
	
	AddHeading(panel,"Swinging hook settings (holding SNEAK.)");
	AddCVarEntry(panel, "Maximum force", "maxcentripetal");
	AddAnnotation(panel, "Max centripetal force. Increasing lets you make tighter turns.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Hook range settings");
	AddCVarEntry(panel, "Trace distance", "tracing_distance");
	AddAnnotation(panel, "Should be longer than hook range. Affects the distance reticle/crosshair.");
	AddCVarEntry(panel, "Hook range", "hook_distance");
	AddAnnotation(panel, "How far you can fire a hook.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Smoke settings");
	local cb = panel:CheckBox("Enable smoke?","sv_ya3dmg_smoke_enabled");
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		cb:SetDisabled(true);
	end
	AddCVarEntry(panel, "Persist Time", "smoke_normal_time");
	AddAnnotation(panel, "If you were using ordinary hook speed, this is how long you'll keep smoking even after you're done with your hooks.");
	AddCVarEntry(panel, "Speedy Persist", "smoke_super_time");
	AddAnnotation(panel, "As above, but if you were using the speedy option.");
end

function PreparePanels()
	if(CLIENT)then
		/*
		hook.Add( "PopulateToolMenu", "YA3DMG-Client-Menu", function()
			spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Client Settings", "Client Settings", "", "", function( panel )
				local ele;
				
				AddLabel(panel,"Under construction! ^^;");
			end )
		end )
		*/
		
		//if(LocalPlayer():IsAdmin())then
			hook.Add( "PopulateToolMenu", "YA3DMG-Admin-Menu", function()
				spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Admin Settings", "Admin Settings", "", "", function( panel )
					DrawAdminPanel(panel);
				end )
			end )
		//end
		
	end
end

	PreparePanels();

-- "addons\\anime\\lua\\autorun\\ya3dmg_config.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
// Ya, it's 3DMG!

// Yet Another 3DMG
// Author: mmys
// ya3dmg_config.lua
//  Handles the configuration menus for YA3DMG.
//  Please see the main weapon file for blurbs and more information.

local NET_UPDATE_STRING = "ya3dmg_update_stop_sv";

//function SetClientCVIfBlank(name, val)
//	CreateClientConVar("sv_ya3dmg_cl_" .. name, val, true, false);
//end

function SetCVIfBlank(name, val)
	// This can potentially cause issues, so it's disabled for the time being.
	//if(!ConVarExists("sv_ya3dmg_" .. name))then
		CreateConVar("sv_ya3dmg_" .. name, val, FCVAR_REPLICATED + FCVAR_NOTIFY);
	//	print("Created " .. name);
	//end
end

SetCVIfBlank("hookspeed", "1500.0");
SetCVIfBlank("hookspeedretract", "2000.0");
SetCVIfBlank("hookspeed_super", "3000.0");
SetCVIfBlank("hookspeedretract_super", "5000.0");
SetCVIfBlank("maxcentripetal", "8500.0");
SetCVIfBlank("tracing_distance", "20000.0");
SetCVIfBlank("hook_distance", "5000.0");
SetCVIfBlank("smoke_enabled", "0");
SetCVIfBlank("smoke_normal_time", "0.8");
SetCVIfBlank("smoke_super_time", "1.4");

if(SERVER)then
	util.AddNetworkString(NET_UPDATE_STRING);
end
	
function AddHeading(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetFont("DermaDefaultBold");
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	textElement:SizeToContents();
	panel:AddItem(textElement);
	return textElement;
end

function AddLabel(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetText(text);
	textElement:SetTextColor(Color(0,0,0));
	panel:AddItem(textElement);
	return textElement;
end

function AddAnnotation(panel, text)
	local textElement = vgui.Create("DLabel", panel)
	textElement:SetWrap(true);
	textElement:SetAutoStretchVertical(true);
	textElement:SetText(text);
	textElement:SetTextColor(Color(30,30,150));
	panel:AddItem(textElement);
	return textElement;
end

function AddCVarEntry(panel, text, var)
	local entryElement = panel:TextEntry(text,"sv_ya3dmg_" .. var);
	entryElement:SetText(GetConVarString("sv_ya3dmg_" .. var));
	entryElement:SetNumeric(true);
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		entryElement:SetDisabled(true);
	end
	return entryElement;
end

function AddDivider(panel)
	AddLabel(panel,"____________________________________________________________________________________________________________________________________");
end

function DrawAdminPanel(panel)
	AddHeading(panel,"Ordinary hook settings (not holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed");
	AddAnnotation(panel, "Ordinary acceleration of one hook.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract");
	AddAnnotation(panel, "If the hook has grown longer, this is the acceleration it will use.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Speedy hook settings (holding JUMP.)");
	AddCVarEntry(panel, "Speed", "hookspeed_super");
	AddAnnotation(panel, "As with ordinary settings.");
	AddCVarEntry(panel, "Retract Speed", "hookspeedretract_super");
	
	AddDivider(panel);
	
	AddHeading(panel,"Swinging hook settings (holding SNEAK.)");
	AddCVarEntry(panel, "Maximum force", "maxcentripetal");
	AddAnnotation(panel, "Max centripetal force. Increasing lets you make tighter turns.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Hook range settings");
	AddCVarEntry(panel, "Trace distance", "tracing_distance");
	AddAnnotation(panel, "Should be longer than hook range. Affects the distance reticle/crosshair.");
	AddCVarEntry(panel, "Hook range", "hook_distance");
	AddAnnotation(panel, "How far you can fire a hook.");
	
	AddDivider(panel);
	
	AddHeading(panel,"Smoke settings");
	local cb = panel:CheckBox("Enable smoke?","sv_ya3dmg_smoke_enabled");
	if(!(LocalPlayer():IsAdmin() || LocalPlayer():IsAdmin()))then
		cb:SetDisabled(true);
	end
	AddCVarEntry(panel, "Persist Time", "smoke_normal_time");
	AddAnnotation(panel, "If you were using ordinary hook speed, this is how long you'll keep smoking even after you're done with your hooks.");
	AddCVarEntry(panel, "Speedy Persist", "smoke_super_time");
	AddAnnotation(panel, "As above, but if you were using the speedy option.");
end

function PreparePanels()
	if(CLIENT)then
		/*
		hook.Add( "PopulateToolMenu", "YA3DMG-Client-Menu", function()
			spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Client Settings", "Client Settings", "", "", function( panel )
				local ele;
				
				AddLabel(panel,"Under construction! ^^;");
			end )
		end )
		*/
		
		//if(LocalPlayer():IsAdmin())then
			hook.Add( "PopulateToolMenu", "YA3DMG-Admin-Menu", function()
				spawnmenu.AddToolMenuOption("Options", "Yet Another 3DMG", "Admin Settings", "Admin Settings", "", "", function( panel )
					DrawAdminPanel(panel);
				end )
			end )
		//end
		
	end
end

	PreparePanels();

