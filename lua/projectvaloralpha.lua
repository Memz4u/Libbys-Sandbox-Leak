-- "lua\\projectvaloralpha.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local config = {}
local teamFilterSelected = {}
config.colors = {}
config.keybinds = {}

local function CreateCheckBox(lbl, x, y, cfg, col, par)

	local checkBox = vgui.Create("DCheckBoxLabel", par)
	checkBox:SetText(lbl)
	checkBox:SetPos(x, y)
	checkBox:SetValue( config[cfg] )
	function checkBox:OnChange( bVal )
		config[cfg] = bVal
	end
     end

local function CreateLabel(lbl, x, y, par)

	local label = vgui.Create("DLabel", par)
	label:SetText(lbl)
	local w, h = label:GetTextSize()
	label:SetSize(w, h)
	label:SetPos(x, y)

end

local function CreateKeybind(x, y, cfg, par)

	local keyBind = vgui.Create("DBinder", par)
	keyBind:SetValue(config.keybinds[cfg])
 	keyBind:SetSize(80, 16)
 	keyBind:SetPos(x, y)
 	keyBind.OnChange = function()
 		config.keybinds[cfg] = keyBind:GetValue()
 	

notification.AddLegacy("Loaded Project Valor - Welcome " .. LocalPlayer():Nick() .. " | " .. os.date("%I:%M %p"), NOTIFY_HINT, 5)

CreateClientConVar("_pkill_speed", 100)
CreateClientConVar("_pkill_prop", "models/props_c17/furnitureStove001a.mdl")
CreateClientConVar("_pkill_remover", 0.9)
CreateClientConVar("_weap_lagcomp", 0.1)

local pm = FindMetaTable"Player";
local cm = FindMetaTable"CUserCmd";
local function NormalizeAngle(ang)
	ang.x = math.NormalizeAngle(ang.x);
	ang.p = math.Clamp(ang.p, -89, 89);
end

local function Copy(tt, lt)
	local copy = {}
	if lt then
		if type(tt) == "table" then
			for k,v in next, tt do
				copy[k] = Copy(k, v)
			end
		else
			copy = lt
		end
		return copy
	end
	if type(tt) != "table" then
		copy = tt
	else
		for k,v in next, tt do
			copy[k] = Copy(k, v)
		end
	end
	return copy
end
 
local surface = Copy(surface);
local vgui = Copy(vgui);
local input = Copy(input);
local Color = Color;
local ScrW, ScrH = ScrW, ScrH;
local gui = Copy(gui);
local math = Copy(math);
local file = Copy(file);
local util = Copy(util);
local vm = FindMetaTable"Vector";
local me = LocalPlayer();
local em = FindMetaTable"Entity";

CreateClientConVar("EZ_norecoils", 0)

local function GetAngle(ang)
	if GetConVarNumber("EZ_norecoils") == 0 then return ang + pm.GetPunchAngle(me); end
	return ang;
end
 
local function meme(ucmd)
 if GetConVarNumber("EZ_norecoils") == 1 then
	if(!fa) then fa = cm.GetViewAngles(ucmd); end
	fa = fa + Angle(cm.GetMouseY(ucmd) * .023, cm.GetMouseX(ucmd) * -.023, 0);
	NormalizeAngle(fa);
	if(cm.CommandNumber(ucmd) == 0) then
		cm.SetViewAngles(ucmd, GetAngle(fa));
		return;
	end

	if(cm.KeyDown(ucmd, 2) && !em.IsOnGround(me)) then
		cm.SetButtons(ucmd, bit.band( cm.GetButtons(ucmd), bit.bnot( 2 ) ) );
	end
     end
  end
 
 
hook.Add("CreateMove", "funt", function(ucmd)
	meme(ucmd);
end);

surface.CreateFont("pcam_font",{font = "Arial", size = 40, weight = 100000, antialias = 0})
function DrawOutlinedText ( title, font, x, y, color, OUTsize, OUTcolor )
	draw.SimpleTextOutlined ( title, font, x, y, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, OUTsize, OUTcolor )
end

local function propkill()

	local atttime = GetConVarNumber("_weap_lagcomp")
	 if LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
		local lastwep = LocalPlayer():GetActiveWeapon()
		RunConsoleCommand("use", "weapon_physgun")
		atttime = 0.2
		timer.Simple(atttime+.3, function()
		RunConsoleCommand("use", lastwep:GetClass())
             end)

        end
	hook.Add( "CreateMove", "PKill", function(cmd)
		cmd:SetMouseWheel(GetConVarNumber("_pkill_speed"))
	end)
	RunConsoleCommand("gm_spawn", GetConVarString("_pkill_prop"))
	timer.Simple(atttime, function()
		RunConsoleCommand("+attack")
	end)
	
	timer.Simple(atttime+0.1, function()
		RunConsoleCommand("-attack")
	end)
	timer.Simple(atttime+GetConVarNumber("_pkill_remover"), function()
		hook.Remove("CreateMove", "PKill")
		RunConsoleCommand("undo")
	end )
end
concommand.Add("_pkill", propkill)

CreateClientConVar("lenny_fullbright", 0)
CreateClientConVar("lenny_fullbright_models", 1)
CreateClientConVar("lenny_fullbright_extend", 1)
local lightmodels = GetConVarNumber("lenny_fullbright_models")
local extend = GetConVarNumber("lenny_fullbright_extend")

local light = DynamicLight(LocalPlayer():EntIndex())
local light2 = DynamicLight(LocalPlayer():EntIndex() + 1)



local function fullbright()
	if light then
		local r, g, b = 255, 255, 255
		light.Pos = LocalPlayer():GetShootPos()
		light.Brightness = 0.5
		light.MinLight = 0.5    
		light.Size = 2048
		light.Decay = 1
		light.DieTime = CurTime() + 1
		light.Style = 0
		light.r = r
		light.g = g
		light.b = b
		light.NoModel = lightmodels == 0 and true or false
		light.NoWorld = false
	else
		light = DynamicLight(LocalPlayer():EntIndex())
	end
	if light2 then
		if extend == 1 then
			local r, g, b = 255, 255, 255
			light2.Pos = LocalPlayer():GetEyeTrace().HitPos
			light2.Brightness = 0.5
			light2.MinLight = 0.5
			light2.Size = 2048
			light2.Decay = 1
			light2.DieTime = CurTime() + 1
			light2.Style = 0
			light2.r = r
			light2.g = g
			light2.b = b
			light2.NoModel = lightmodels == 0 and true or false
			light2.NoWorld = false
		else
			light2.NoModel = true
			light2.NoWorld = true
		end
	else
		light2 = DynamicLight(LocalPlayer():EntIndex() + 1)
	end
end
local function callback()
	local enabled = GetConVarNumber("lenny_fullbright")
	if enabled == 1 then
		hook.Add("Think", "fullbright", fullbright)
	else
		light2.NoModel = true
		light2.NoWorld = true
		light.NoModel = true
		light.NoWorld = true
		hook.Remove("Think", "fullbright")
	end
end
callback()
cvars.AddChangeCallback("lenny_fullbright", callback)
cvars.AddChangeCallback("lenny_fullbright_models", function()
	lightmodels = GetConVarNumber("lenny_fullbright_models")
end)
cvars.AddChangeCallback("lenny_fullbright_extend", function()
	extend = GetConVarNumber("lenny_fullbright_extend")
end)

local function profile()

local frame = vgui.Create( "DFrame" )
frame:SetSize( ScrW() * 0.5, ScrH() * 0.5 )
frame:SetTitle( "Astroux's Profile" )
frame:Center()
frame:MakePopup()

local html = vgui.Create( "DHTML", frame )
html:Dock( FILL )
html:OpenURL( "https://steamcommunity.com/profiles/76561198159948937" )
frame.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
   end
end

local pm = FindMetaTable"Player";
local cm = FindMetaTable"CUserCmd";
local function NormalizeAngle(ang)
	ang.x = math.NormalizeAngle(ang.x);
	ang.p = math.Clamp(ang.p, -89, 89);
end

local function Copy(tt, lt)
	local copy = {}
	if lt then
		if type(tt) == "table" then
			for k,v in next, tt do
				copy[k] = Copy(k, v)
			end
		else
			copy = lt
		end
		return copy
	end
	if type(tt) != "table" then
		copy = tt
	else
		for k,v in next, tt do
			copy[k] = Copy(k, v)
		end
	end
	return copy
end
 
local surface = Copy(surface);
local vgui = Copy(vgui);
local input = Copy(input);
local Color = Color;
local ScrW, ScrH = ScrW, ScrH;
local gui = Copy(gui);
local math = Copy(math);
local file = Copy(file);
local util = Copy(util);
local vm = FindMetaTable"Vector";
local me = LocalPlayer();
local em = FindMetaTable"Entity";

CreateClientConVar("EZ_norecoils", 1)

local ChamMaterials = {
	["Platinum"] = "models/player/shared/ice_player",
	["Gold"] = "models/player/shared/gold_player",
	["Alien"] = "models/XQM/LightLinesRed_tool",
	["Flesh"] = "models/flesh",
	["Molten"] = "models/props_lab/Tank_Glass001",
	["Glass"] = "models/props_combine/com_shield001a",
	["Plasma"] = "models/props_combine/portalball001_sheet",
	["Water"] = "models/props_combine/stasisshield_sheet",
	["Fire"] = "models/shadertest/shader4",
	["Glow"] = "Models/effects/splodearc_sheet", -- LOOK AT OVERLAY
	["Reactor"] = "Models/effects/comball_tape",
	["Galaxy"] = "Models/effects/comball_sphere",
	["Water 2"] = "models/shadertest/shader3",
	["Chrome"] = "debug/env_cubemap_model",
	["Untextured"] = "1",
	["Wireframe"] = "!wireframe",
	["Flat"] = "!flat",
	["Textured"] = "!textured"
}

local ChamMaterials2 = {
	["Platinum"] = "models/player/shared/ice_player",
	["Gold"] = "models/player/shared/gold_player",
	["Alien"] = "models/XQM/LightLinesRed_tool",
	["Flesh"] = "models/flesh",
	["Molten"] = "models/props_lab/Tank_Glass001",
	["Glass"] = "models/props_combine/com_shield001a",
	["Plasma"] = "models/props_combine/portalball001_sheet",
	["Water"] = "models/props_combine/stasisshield_sheet",
	["Fire"] = "models/shadertest/shader4",
	["Glow"] = "Models/effects/splodearc_sheet", -- LOOK AT OVERLAY
	["Reactor"] = "Models/effects/comball_tape",
	["Galaxy"] = "Models/effects/comball_sphere",
	["Water 2"] = "models/shadertest/shader3",
	["Chrome"] = "debug/env_cubemap_model",
	["Untextured"] = "1",
	["Wireframe"] = "!wireframe",
	["Flat"] = "!flat",
	["Textured"] = "!textured"
}

CreateClientConVar("EZ_GlowESP","0", true ,false )

CreateClientConVar("EZ_Antiaim","0", true ,false )
CreateClientConVar("EZ_Fakeview","0", true ,false )
CreateClientConVar("EZ_AimbotTorso","0", true ,false )
CreateClientConVar("EZ_HandChams","0", true ,false )
CreateClientConVar("EZ_NoRecoil","0", true ,false )
CreateClientConVar("EZ_Catmode","0", true ,false )
CreateClientConVar("EZ_Aimbot","0", true ,false )
CreateClientConVar("hitsound","0", true ,false )
CreateClientConVar("ColoredChams","0", true ,false )
CreateClientConVar("EZ_Chams","0", true ,false )
CreateClientConVar("EZ_triggerbot","0", true ,false )
CreateClientConVar("EZ_head","0", true ,false )
CreateClientConVar("EZ_AimbotRage","0", true ,false )
CreateClientConVar("EZ_Viewmodelchams","0", true ,false )
CreateClientConVar("EZ_Freecam","0", true ,false )
CreateClientConVar("Crosshair","0", true ,false )
CreateClientConVar("EZ_thirdperson","0", true ,false )
CreateClientConVar("EZ_customfov","0", true ,false )
shouldnamechange = CreateClientConVar("name_change", "0", true, true)
CreateClientConVar("lenny_advcrosshair", 0)
CreateClientConVar("lenny_advcrosshair_money", 0)
CreateClientConVar("ChatSpam", 0, true, false)
CreateClientConVar("ChatSpam_DarkRP", 0, true, false)
CreateClientConVar("EZ_nosky", 0, true, false)
CreateClientConVar("lenny_wh_radius", 750)
CreateClientConVar("lenny_wh", 0)
CreateClientConVar("lenny_wh_type",0)
CreateClientConVar("lenny_wh_noprops", 0)
local radius = GetConVarNumber("lenny_wh_radius")
local whtype = GetConVarNumber("lenny_wh_type")
local noprops = GetConVarNumber("lenny_wh_noprops")
CreateClientConVar("lenny_advcrosshair", 0)
CreateClientConVar("lenny_advcrosshair_money", 0)


function GAMEMODE:PreDrawSkyBox()  	   
	if GetConVarNumber("EZ_nosky") == 0 then return; end  	   
	render.Clear(50, 50, 50, 255);  	   
	return true;  	   
end  	   

ply = LocalPlayer()

surface.PlaySound ("buttons/blip1.wav")[

local mx = ScrW()*.5 --middle x
local my = ScrH()*.5  --middle y

local function advcrosshair()
	if LocalPlayer():Health() > 0 then
		local target = LocalPlayer():GetEyeTrace().Entity
		if target:IsPlayer() or target:IsNPC() then
			surface.SetDrawColor(Color(255,255,255))

			surface.DrawLine(mx-5, my+5, mx+5, my-5)
			surface.DrawLine(mx-5, my-5, mx+5, my+5)

			draw.DrawText("Health: "..target:Health(), "Default", mx, my+20, Color(255,255,0), 1)
			if GetConVarNumber("lenny_advcrosshair_money") == 1 and target.DarkRPVars then

			local dosh = target.DarkRPVars.money
			if not dosh then dosh = "" end
		
			if LocalPlayer():GetActiveWeapon():Clip1() < 1 then -- Check if they are holding a gun(Where to draw money)
			draw.DrawText("Money: $"..tostring(dosh), "Default", mx, my+30, Color(0,255,255), 1)
			elseif (LocalPlayer():GetActiveWeapon().Primary or LocalPlayer():GetActiveWeapon().Primary.Damage) then
			draw.DrawText("Money: $"..tostring(dosh), "Default", mx, my+40, Color(0,255,255), 1)
			end
		
			end
		
			surface.SetDrawColor(Color(255,0,0))
			if LocalPlayer():GetActiveWeapon():IsValid() then
				if LocalPlayer():GetActiveWeapon():Clip1() > 0 and (LocalPlayer():GetActiveWeapon().Primary and LocalPlayer():GetActiveWeapon().Primary.Damage) then

					draw.DrawText("Shots to kill: "..math.ceil(target:Health()/LocalPlayer():GetActiveWeapon().Primary.Damage), "Default", mx, my+30, Color(0,255,255), 1)

					if LocalPlayer():KeyDown(IN_ATTACK)  then
						surface.DrawLine(mx-10, my+10, mx-5, my+5)
						surface.DrawLine(mx-10, my-10, mx-5, my-5)
							surface.DrawLine(mx+10, my+10, mx+5, my+5)
					surface.DrawLine(mx+10, my-10, mx+5, my-5)
					end
				end
			end
		else
			surface.SetDrawColor(Color(255,255,255))
		end
	end

	surface.DrawLine(mx-35, my, mx-20, my)
	surface.DrawLine(mx+35, my, mx+20, my)
	surface.DrawLine(mx, my-35, mx, my-20)
	surface.DrawLine(mx, my+35, mx, my+20)
end


-- prepping
hook.Remove("HUDPaint", "advcrosshair")

if GetConVarNumber("lenny_advcrosshair") == 1 then
	hook.Add("HUDPaint", "advcrosshair", advcrosshair)
end
--end of prep

cvars.AddChangeCallback("lenny_advcrosshair", function() 
	if GetConVarNumber("lenny_advcrosshair") == 1 then
		hook.Add("HUDPaint", "advcrosshair", advcrosshair)
	else
		hook.Remove("HUDPaint", "advcrosshair")
	end
end)

    local fakeRT = GetRenderTarget( "fakeRT" .. os.time(), ScrW(), ScrH() )
     
    hook.Add( "RenderScene", "AntiScreenGrab", function( vOrigin, vAngle, vFOV )
        local view = {
            x = 0,
            y = 0,
            w = ScrW(),
            h = ScrH(),
            dopostprocess = true,
            origin = vOrigin,
            angles = vAngle,
            fov = vFOV,
            drawhud = true,
            drawmonitors = true,
            drawviewmodel = true
        }
     
        render.RenderView( view )
        render.CopyTexture( nil, fakeRT )
     
        cam.Start2D()
            hook.Run( "CheatHUDPaint" )
        cam.End2D()
     
        render.SetRenderTarget( fakeRT )
     
        return true
    end )
     
    hook.Add( "ShutDown", "RemoveAntiScreenGrab", function()
        render.SetRenderTarget()
    end )

CreateClientConVar("lowhealthretry", 0)

local function retry()
	if LocalPlayer():Health() < 25 and LocalPlayer():Alive() then
		LocalPlayer():ConCommand("retry")
	end
end


hook.Remove("Think", "retry")
timer.Simple(1, function()
	if GetConVarNumber("lowhealthretry") == 1 then
		hook.Add("Think", "retry", retry)
	end
end)
-- end of prep


cvars.AddChangeCallback("lowhealthretry", function() 
	if GetConVarNumber("lowhealthretry") == 1 then
		hook.Add("Think", "retry", retry)
	else
		hook.Remove("Think", "retry")
	end
end)

   local mat0 = Material("models/shiny")
   local mat1 = Material("models/shiny")
    hook.Add("PreDrawViewModel", "viewmodelchams", function()
     if GetConVarNumber("EZ_Viewmodelchams") == 1 then
        render.SuppressEngineLighting(true)
        render.SetColorModulation(1, 0, 1)
        render.MaterialOverride(mat0)
        render.SetBlend(1)
    end
 end)
    hook.Add("PostDrawViewModel", "viewmodelchams", function()
     if GetConVarNumber("EZ_Viewmodelchams") == 1 then
        render.SetColorModulation(1, 0, 0)
        render.MaterialOverride(Material(""))
        render.SetBlend(1)
        render.SuppressEngineLighting(true)
    end
 end)   
    hook.Add("PreDrawPlayerHands", "handchams", function()
     if GetConVarNumber("EZ_Handchams") == 1 then
        render.SuppressEngineLighting(true)
        render.SetColorModulation(1, 0, 1)
        render.MaterialOverride(mat1)
        render.SetBlend(1)
    end
 end)
    hook.Add("PostDrawPlayerHands", "handchams", function()
     if GetConVarNumber("EZ_Handchams") == 1 then
        render.SetColorModulation(1, 0, 0)
        render.MaterialOverride(Material(""))
        render.SuppressEngineLighting(true)
        render.SetBlend(1)
    end
 end)

local hook = hook
local CreateConVar = CreateConVar
local GetConVarString = GetConVarString
local debug = debug
local a = hook.Add
local c = CreateConVar
local g = GetConVarString
local _R = debug.getregistry()
local r = RunConsoleCommand
local cmd = {"CreateMove","as"}

c("auto",1, {FCVAR_ARCHIVE})

_R.Player.GetEyeTrace = _R.Player.GetEyeTrace
local e = _R.Player.GetEyeTrace

a(cmd[1],cmd[2], function( c )
	if g("auto") == "0" then return end
	local eye = e(LocalPlayer()).Entity
	if eye:IsPlayer() then
		r("+attack")
	else
		r("-attack")
	end
end)

/*
##############################################
 WALLHACK by lenny will implement my own later 
##############################################
*/
CreateClientConVar("lenny_wh_radius", 750)
CreateClientConVar("lenny_wh", 0)
CreateClientConVar("lenny_wh_type",0)
CreateClientConVar("lenny_wh_noprops", 0)

local radius = GetConVarNumber("lenny_wh_radius")
local whtype = GetConVarNumber("lenny_wh_type")
local noprops = GetConVarNumber("lenny_wh_noprops")

local plys = {}
local props = {}
local trackents = { -- Set Default entities here, lenny_ents to add while you're ingame
"spawned_money",
"spawned_shipment",
"spawned_weapon",
"money_printer",
"weapon_ttt_knife",
"weapon_ttt_c4",
"npc_tripmine"
}






local function entmenu()
	local menu = vgui.Create("DFrame")
	menu:SetSize(500,350)
	menu:MakePopup()
	menu:SetTitle("Project Valor | ESP Entity Config")
	menu:Center()
	menu:SetKeyBoardInputEnabled()


	local noton = vgui.Create("DListView",menu)
	noton:SetSize(200,menu:GetTall()-40)
	noton:SetPos(10,30)
	noton:AddColumn("Not Being Tracked")

	local on = vgui.Create("DListView",menu)
	on:SetSize(200,menu:GetTall()-40)
	on:SetPos(menu:GetWide()-210,30)
	on:AddColumn("Being Tracked")

	local addent = vgui.Create("DButton",menu)
	addent:SetSize(50,25)
	addent:SetPos(menu:GetWide()/2-25,menu:GetTall()/2-20)
	addent:SetText("Add")
menu.Paint = function( self, w, h ) -- 'function menu:Paint( w, h )' works too
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 120 ) ) -- Draw a red box instead of the frame
	addent.DoClick = function() 
		if noton:GetSelectedLine() != nil then 
			local ent = noton:GetLine(noton:GetSelectedLine()):GetValue(1)
			if !table.HasValue(trackents,ent) then 
				table.insert(trackents,ent)
				noton:RemoveLine(noton:GetSelectedLine())
				on:AddLine(ent)

			end
		end
	end
end

	local rement = vgui.Create("DButton",menu)
	rement:SetSize(50,25)
	rement:SetPos(menu:GetWide()/2-25,menu:GetTall()/2+20)
	rement:SetText("Remove")
	rement.DoClick = function()
		if on:GetSelectedLine() != nil then
			local ent = on:GetLine(on:GetSelectedLine()):GetValue(1)
			if table.HasValue(trackents,ent) then 
				for k,v in pairs(trackents) do 
					if v == ent then 
					table.remove(trackents,k) 
					end 
				end
					on:RemoveLine(on:GetSelectedLine())
					noton:AddLine(ent)
			end
		end
	end

	local added = {}
	for _,v in pairs(ents.GetAll()) do

		if !table.HasValue(added,v:GetClass()) and !table.HasValue(trackents,v:GetClass()) and !string.find(v:GetClass(),"grav")  and !string.find(v:GetClass(),"phys") and v:GetClass() != "player" then
			
			table.insert(added,v:GetClass())
		end

	end
	table.sort(added)
	for k, v in pairs(added) do
		noton:AddLine(v)
	end
	table.sort(trackents)
	for _,v in pairs(trackents) do
		on:AddLine(v)
	end

end
concommand.Add("lenny_ents", entmenu)
concommand.Add("profile", profile)
concommand.Add("aimbotmenu", aimbotmenu)
concommand.Add("cpyher_espconfig", espmenu)
concommand.Add("cpyher_espmenu", espmenu2)


--this is more efficient than looping through every player in a drawing hook
timer.Create("entrefresh", 1, 0, function()
	plys = {}
	props = {}
	for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), radius)) do
		if (v:IsPlayer() and !(LocalPlayer() == v)) or v:IsNPC() then
			table.insert(plys, v)
		elseif v:GetClass() == "prop_physics" and noprops == 0 then
			table.insert(props, v)
		end
	end
end)

local function wh()
	cam.Start3D()
		for k, v in pairs(props) do
			if v:IsValid() then
				render.SetColorModulation( 0, 255, 0, 0)
				render.SetBlend(.4)
				v:DrawModel()
			end
		end
		for k, v in pairs(plys) do
			if v:IsValid()  then
				local teamcolor = v:IsPlayer() and team.GetColor(v:Team()) or Color(255,128,0,255)
				if whtype >= 1 then
				v:SetMaterial("models/debug/debugwhite") 
				else
				v:SetMaterial("models/wireframe")	
				end
				render.SetColorModulation(teamcolor.r / 255, teamcolor.g / 255, teamcolor.b / 255) 
				render.SetBlend(teamcolor.a / 255) 
				v:SetColor(teamcolor) 
				v:DrawModel() 
				v:SetColor(Color(255,255,255)) 
				v:SetMaterial("")
			end
		end
	cam.End3D()
end

-- prepping
hook.Remove("HUDPaint", "wh")

if GetConVarNumber("lenny_wh") == 1 then
	hook.Add("HUDPaint", "wh", wh)
end
-- end of prep


cvars.AddChangeCallback("lenny_wh_radius", function() 
	radius = GetConVarNumber("lenny_wh_radius")
end)
cvars.AddChangeCallback("lenny_wh_type", function() 
 whtype = GetConVarNumber("lenny_wh_type")
end)
cvars.AddChangeCallback("lenny_wh", function() 
	if GetConVarNumber("lenny_wh") == 1 then
		hook.Add("HUDPaint", "wh", wh)
	else
		hook.Remove("HUDPaint", "wh")
	end
end)



/*
####
 ESP
####
*/


-- getting all members of the nonanon groups to mark them for later
local nonanonp = {}
local nonanon = {}
local lennysuser = {}

local function NonAnonPSuccess(body)
	local ID64s = string.Explode("|", body)

	if #ID64s > 0 then
		table.remove(ID64s, #ID64s)
		for k, v in pairs(ID64s) do
			table.insert(nonanonp, v)
		end
	end
end

local function OnFail(error)
	--print("We failed to contact gmod.itslenny.de")
	print(error)
	
end

local function GetNonAnonPMembers()
	--http.Fetch("http://www.gmod.itslenny.de/lennys/nonanon/groupinfo", NonAnonPSuccess, OnFail)
end

function CurrentUsersSuccess(body) --Web scrapping is fun!
	local plys = {}
	local scopestart = string.find(body, "Server IP")
	local scopeend = string.find(body, "*only public profiles are displayed")
	local scope = string.sub(body, scopestart, scopeend)
	local results = {}
	for match in string.gmatch(scope, "<tr>.-</tr>") do
		table.insert(results, match)
	end
	for i = 1, #results do
		local subresults = {}
		for match in string.gmatch(results[i], "<td>.-</td>") do
			local submatch = string.gsub(match, "(<.-td>)", "")
			table.insert(subresults, submatch)
		end
		table.insert(plys, {name = subresults[1], ip = subresults[2]})
	end
	for i = 1, #plys do
		table.insert(lennysuser, plys[i].name)
	end
end


local function GetLennysUsers()
	--http.Fetch("http://gmod.itslenny.de/analytics", CurrentUsersSuccess, OnFail)
end
GetNonAnonPMembers()
GetLennysUsers()



CreateClientConVar("lenny_esp_radius", 1500)
CreateClientConVar("lenny_esp", 0)
CreateClientConVar("lenny_esp_view", 0) -- Ability to see where the player is looking
local espradius = GetConVarNumber("lenny_esp_radius")

local nonanons = {}
local lennysusers = {}
local espplys = {}
local espspecial= {}
local espnpcs = {}
local espfriends = {}
local esp

local espents = {}
--same reason as in the wh

local function isfriend(ent)
	if Lenny then
		if Lenny.friends then
			return table.HasValue(Lenny.friends, ent)
		end
	end
	return false
end

local function sortents(ent)
	if (ent:IsPlayer() and LocalPlayer() != ent) then
		local steamname = ""
		if SteamName != nil then
			steamname = ent:SteamName()
		else
			steamname = ent:Name()
		end
		if ent:GetFriendStatus() == "friend" then
			table.insert(espfriends, ent)
		elseif isfriend(ent) then
			table.insert(espfriends, ent)
		elseif table.HasValue(lennysuser, steamname) then
			table.insert(lennysusers, ent)
		elseif table.HasValue(nonanonp, ent:SteamID64()) then
			table.insert(nonanons, ent)
		elseif ent:GetNWString("usergroup") != "user" and ent:GetNWString("usergroup") != "" then
			table.insert(espspecial, ent)
		else
			table.insert(espplys, ent)
		end
	elseif ent:IsNPC() then
		table.insert(espnpcs, ent)
	elseif table.HasValue(trackents,ent:GetClass()) then
		table.insert(espents, ent)
	end
end

-- getting all releveant esp items
timer.Create("espentrefresh", 1, 0, function()
	nonanons = {}
	lennysusers = {}
	espplys = {}
	espspecial	= {}
	espnpcs = {}
	espfriends = {}

	espents = {}

	if espradius != 0 then
		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), espradius)) do
			sortents(v)
		end
	else
		for k, v in pairs(ents.GetAll()) do
			sortents(v)
		end
	end
end)

concommand.Add("lenny_printadmins", function()
	local plys = player.GetAll()
	for k, v in pairs(plys) do
		if v:GetNWString("usergroup") != "user" then
			print(v:GetName() .. string.rep("\t", math.Round(8 / #v:GetName())), v:GetNWString("usergroup"))
		end
	end
end)





-- fuck vectors now.
local function realboxesp(min, max, diff, ply)
	cam.Start3D()
	
		--vertical lines

		render.DrawLine( min, min+Vector(0,0,diff.z), Color(0,0,255) )
		render.DrawLine( min+Vector(diff.x,0,0), min+Vector(diff.x,0,diff.z), Color(0,0,255) )
		render.DrawLine( min+Vector(0,diff.y,0), min+Vector(0,diff.y,diff.z), Color(0,0,255) )
		render.DrawLine( min+Vector(diff.x,diff.y,0), min+Vector(diff.x,diff.y,diff.z), Color(0,0,255) )

		--horizontal lines top
		render.DrawLine( max, max-Vector(diff.x,0,0) , Color(0,0,255) )
		render.DrawLine( max, max-Vector(0,diff.y,0) , Color(0,0,255) )
		render.DrawLine( max-Vector(diff.x, diff.y,0), max-Vector(diff.x,0,0) , Color(0,0,255) )
		render.DrawLine( max-Vector(diff.x, diff.y,0), max-Vector(0,diff.y,0) , Color(0,0,255) )

		--horizontal lines bottom
		render.DrawLine( min, min+Vector(diff.x,0,0) , Color(0,255,0) )
		render.DrawLine( min, min+Vector(0,diff.y,0) , Color(0,255,0) )
		render.DrawLine( min+Vector(diff.x, diff.y,0), min+Vector(diff.x,0,0) , Color(0,255,0) )
		render.DrawLine( min+Vector(diff.x, diff.y,0), min+Vector(0,diff.y,0) , Color(0,255,0) )

	
	if GetConVarNumber("lenny_esp_view") == 1 then
		local shootpos = ply:IsPlayer() and ply:GetShootPos() or 0
		local eyetrace = ply:IsPlayer() and ply:GetEyeTrace().HitPos or 0

		if (shootpos != 0 and eyetrace != 0) then
		render.DrawBeam(shootpos, eyetrace,2,1,1, team.GetColor(ply:Team()))
		end
	end
		
		
	cam.End3D()
end


local function calctextopactity(ply)
	if espradius != 0 then
		dis = ply:GetPos():Distance(LocalPlayer():GetPos())
		return (dis / espradius) * 255
	else
		return 0
	end
end


local function drawesptext(text, posx, posy, color)
	draw.DrawText(text, "Default", posx, posy, color, 1)
end

local function esp()
	--text esp
	for k, v in pairs(nonanons) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[NoN-AnonP]"..v:GetName(), pos.x, pos.y-20, Color(0, 255, 255, 255 - calctextopactity(v)))
			--draw.DrawText("[Friend]"..v:GetName(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k, v in pairs(lennysusers) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[Lenny's User]"..v:GetName(), pos.x, pos.y-20, Color(0, 255, 255, 255 - calctextopactity(v)))
			--draw.DrawText("[Friend]"..v:GetName(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k, v in pairs(espnpcs) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			realboxesp(min, max, diff, v)
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			drawesptext("[NPC]"..v:GetClass(), pos.x, pos.y-10, Color(255,0,0,255 - calctextopactity(v)))
			--draw.DrawText("[NPC]" ..v:GetClass(), "Default", pos.x, pos.y-10, Color(255,0,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espplys) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext(v:GetName(), pos.x, pos.y-10, Color(255, 255,0,255 - calctextopactity(v)))
			--draw.DrawText(v:GetName(), "Default", pos.x, pos.y-10, Color(255, 255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espspecial) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("["..v:GetNWString("usergroup").."]"..v:GetName(), pos.x, pos.y-10, Color(255, 0, 255,255 -calctextopactity(v)))
			--draw.DrawText("[Admin]"..v:GetName(), "Default", pos.x, pos.y-10, Color(255,0,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	for k,v in pairs(espfriends) do
		if v:IsValid() then
			local min, max = v:WorldSpaceAABB()
			local diff = max-min
			local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
			realboxesp(min, max, diff, v)
			drawesptext("[Friend]"..v:GetName(), pos.x, pos.y-10, Color(0, 255, 0, 255 - calctextopactity(v)))
			--draw.DrawText("[Friend]"..v:GetName(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
		end
	end
	if espents then
		for k, v in pairs(espents) do
			if v:IsValid() then
				local min, max = v:WorldSpaceAABB()
				local diff = max-min
				local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()[
				drawesptext(v:GetClass(), pos.x, pos.y-10, Color(0 ,255, 0,255 - calctextopactity(v)))
				--draw.DrawText(v:GetClass(), "Default", pos.x, pos.y-10, Color(0,255,0,255 - calctextopactity(v:GetPos():Distance(LocalPlayer():GetPos()))), 1)
				if v:GetClass() == "spawned_money" then
					drawesptext("$"..v:Getamount(), pos.x, pos.y, Color(0 ,255, 255,255 - calctextopactity(v)))
				end
			end
		end
	end
end
local function checkstatus()
	GetNonAnonPMembers()
	GetLennysUsers()
end

    local mat = Material("models/debug/debugwhite")
    local SetStencilCompareFunction = render.SetStencilCompareFunction
    local SetStencilEnable = render.SetStencilEnable
    local SetStencilReferenceValue = render.SetStencilReferenceValue
    local SetStencilFailOperation = render.SetStencilFailOperation
    local SetStencilPassOperation = render.SetStencilPassOperation
    local SetStencilWriteMask = render.SetStencilWriteMask
    local SetStencilTestMask = render.SetStencilTestMask
    local SetStencilZFailOperation = render.SetStencilZFailOperation
    local ClearBuffersObeyStencil = render.ClearBuffersObeyStencil
    local ClearStencil = render.ClearStencil
    local SetDrawColor = surface.SetDrawColor
     
    local color_yellow = Color(125, 255, 40)
    local color_black = Color(0,0,0,0) or color_black
     
    local chamColour = Color(0, 255, 0)
     
    hook.Add("PostDrawOpaqueRenderables", "x", function()
     
        if GetConVarNumber("ColoredChams") == 1 then
            SetStencilWriteMask(0xFF)
            SetStencilTestMask(0xFF)
            SetStencilPassOperation(STENCIL_KEEP)
            SetStencilZFailOperation(STENCIL_KEEP)
            surface.SetDrawColor(color_white)
            SetStencilEnable(true)
            SetStencilReferenceValue(1)
            SetStencilCompareFunction(STENCIL_KEEP)
            SetStencilFailOperation(STENCIL_REPLACE)
            surface.DrawRect(0, 0, ScrW(), ScrH())
            SetStencilCompareFunction(STENCIL_EQUAL)
     
            cam.Start3D()
                ClearStencil()
                SetStencilEnable(true)
                SetStencilPassOperation( STENCIL_REPLACE )
                SetStencilReferenceValue( 1 )
                SetStencilCompareFunction( STENCIL_ALWAYS )
            
                for _, ent in ipairs(player.GetAll()) do
                    if not ent:Alive() then goto skipdrawing end
                    ent:DrawModel() 
                    ::skipdrawing::
                end
                
                SetStencilCompareFunction( STENCIL_EQUAL )
     
                ClearBuffersObeyStencil( chamColour.r,chamColour.g,chamColour.b, 255, false )
                SetStencilEnable( false )
     
            cam.End3D()
        end
     
        
        SetStencilEnable(false)
    end)

-- prepping
hook.Remove("HUDPaint", "esp")

if GetConVarNumber("lenny_esp") == 1 then
	hook.Add("HUDPaint", "esp", esp)
end

hook.Remove("PlayerConnect", "l_checkstatus")

if GetConVarNumber("lenny_esp") == 1 then
	hook.Add("PlayerConnect", "l_checkstatus", checkstatus)
end
--end of prep


cvars.AddChangeCallback("lenny_esp_radius", function() 
	espradius = GetConVarNumber("lenny_esp_radius")
end)

cvars.AddChangeCallback("lenny_esp", function() 
	if GetConVarNumber("lenny_esp") == 1 then
		hook.Add("HUDPaint", "esp", esp)
		hook.Add("PlayerConnect", "l_checkstatus", checkstatus)
		checkstatus()
	else
		hook.Remove("HUDPaint", "esp")
		hook.Remove("PlayerConnect", "l_checkstatus")
	end
end)

    local util = util;
    local player = player;
    local input = input;
    local bit = bit;
    local hook = hook;
    local me = LocalPlayer();
    local aimtarget;
    local KEY_LALT = KEY_LALT;
    local MASK_SHOT = MASK_SHOT;
     
    local function GetPos(v)
            local eyes = v:LookupAttachment("eyes");
            return(eyes && v:GetAttachment(eyes).Pos || v:LocalToWorld(v:OBBCenter()));
    end
     
    local function Valid(v)
            if(!v || !v:IsValid() || v:Health() < 1 || v:IsDormant() || v == me) then return false; end
            local trace = {
                    mask = MASK_SHOT,
                    endpos = GetPos(v),
                    start = me:EyePos(),
                    filter = {me, v},
            };
            return(util.TraceLine(trace).Fraction == 1);
    end
     
    local function GetTarget()
            if (Valid(aimtarget)) then return; end
            aimtarget = nil;
            local allplys = player.GetAll();
            for i = 1, #allplys do
                    local v = allplys[i];
                    if (!Valid(v)) then continue; end
                    aimtarget = v;
                    return;
            end
    end
     
    hook.Add("CreateMove", "", function(ucmd)
            GetTarget();
            if (GetConVarNumber("EZ_AimbotRage") == 1 && GetConVarNumber("EZ_Aimbot") == 0 && aimtarget) then
                    local pos = (GetPos(aimtarget) - me:EyePos()):Angle();
                    ucmd:SetViewAngles(pos);
                    --ucmd:SetButtons(bit.bor(ucmd:GetButtons(), 1));
                    -- ^autofire
            end
    end

hook.Add("PlayerSwitchWeapon", "norecoil", norecoil)

CreateClientConVar("cpyher_esp", 0, true, false)
CreateClientConVar("cpyher_esp_printers", 0, true, false)

CreateClientConVar("cpyher_bunnyhop", 0, true, false)

function Bunnyhop()
	if GetConVar("cpyher_bunnyhop"):GetInt() == 1 then
	 	if input.IsKeyDown(KEY_SPACE) then
	 		if LocalPlayer():IsOnGround() then
	 			RunConsoleCommand("+jump")
	 			timer.Create("Bhop", 0, 0.01, function()
	 		 	RunConsoleCommand("-jump")
	 		 	
	 		 	end)
	 		end
	 	end
	end
end

hook.Add("Think", "Bunnyhop", Bunnyhop )

local should_follow = CreateClientConVar( "follow", "0")
local should_draw = CreateClientConVar( "follow_draw", "1")
local follow_team = CreateClientConVar( "follow_team", "0", true, false, "0 follow any team, 1 follow same team as localplayer, 2 follow opposite team as localplayer")


function is_movement_keys_down()
	return input.IsButtonDown( 33 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 11 ) or input.IsButtonDown( 29 ) or input.IsButtonDown( 14 )
end


function moveToPos(cmd, pos)
	local world_forward = pos - LocalPlayer():GetPos()
	local ang_LocalPlayer = cmd:GetViewAngles()

	cmd:SetForwardMove( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 300 )
	cmd:SetSideMove( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 300 )
end


function closest_player(team)
	best = 99999999
	current_e = nil
	for k, v in pairs(player.GetAll()) do
		dist = v:GetPos():Distance(LocalPlayer():GetPos())
		if LocalPlayer():Alive() and v:Alive() and v ~= LocalPlayer() and dist < best and v:Health() > 0 and v:GetObserverMode() == 0 then
			if team == nil then
				best = dist
				current_e = v
			elseif not team and LocalPlayer():Team() ~= v:Team() then
				best = dist
				current_e = v
			elseif team and LocalPlayer():Team() == v:Team() then
				best = dist
				current_e = v
			end
		end
	end
	return current_e
end

local target = nil
hook.Add("CreateMove", "PlayerFollow", function(cmd)
	if should_follow:GetInt() == 1 then
		if is_movement_keys_down() then return end
		
		if follow_team:GetInt() == 0 then
			target = closest_player()
		elseif follow_team:GetInt() == 1 then
			target = closest_player(true)
		elseif follow_team:GetInt() == 2 then
			target = closest_player(false)
		end
		
		if not target then return end
		moveToPos(cmd, target:GetPos())
	end
end)

if shouldnamechange:GetBool() then
	LocalPlayer():ConCommand( "say /rpname " ..tostring( math.random( 9999999, 99999999 ) ) )
end

-- Simple Triggerbot by DeVo 
local toggle = true
 
concommand.Add("triggerbot",function()
toggle = not toggle
end)

hook.Add("Think","aimbot", function()

local ply = LocalPlayer()
 if (GetConVarNumber("EZ_Aimbot") == 1 && if GetConVarNumber("EZ_AimbotRage") == 0) then
     local trace = util.GetPlayerTrace( ply )
     local traceRes = util.TraceLine( trace )
     if traceRes.HitNonWorld then
        local target = traceRes.Entity
        if target:IsPlayer() then
            local targethead = target:LookupBone("ValveBiped.Bip01_Head1")
            local targetheadpos,targetheadang = target:GetBonePosition(targethead)
            ply:SetEyeAngles((targetheadpos - ply:GetShootPos()):Angle())
        end
    end
end
end)

local tp = CreateClientConVar("BHop", "0", true, false)
local tp = CreateClientConVar("autostrafe", "0", true, false)

local bhop = { }
bhop.MetaPlayer = FindMetaTable( "Player") 
bhop.oldKeyDown = bhop.MetaPlayer['KeyDown']
bhop.On = true
bhop.SOn = true
bhop.Hooks = { hook = { }, name = { } }
bhop.jump = false
function bhop.AddHook(hookname, name, func)
    table.insert( bhop.Hooks.hook, hookname )
    table.insert( bhop.Hooks.name, name )
    hook.Add( hookname, name, func ) --Hopefully you have something better
end
bhop.MetaPlayer['KeyDown'] = function( self, key )
    if self ~= LocalPlayer() then return end
    
    if (key == IN_MOVELEFT) and bhop.left then
        return true
    elseif (key == IN_MOVERIGHT) and bhop.right then
        return true
    elseif (key == IN_JUMP) and bhop.jump then
        return true
    else
        return bhop.oldKeyDown( self, key )
    end
end

local oldEyePos = LocalPlayer():EyeAngles()--This is to see where player is looking
function bhop.CreateMove( cmd )
 if GetConVarNumber("autostrafe") == 1 then
    bhop.jump = false
    if (cmd:KeyDown( IN_JUMP )) then
    
        if (not bhop.jump) then
            if (bhop.On and not LocalPlayer():OnGround()) then --Bhop here
                cmd:RemoveKey( IN_JUMP )
            end
        else
            bhop.jump = false
        end
     end

        if GetConVarNumber("autostrafe") == 1 then
            local traceRes2 = LocalPlayer():EyeAngles()
                                   
            if( traceRes2.y > oldEyePos.y ) then --If you move your mouse left, walk left, if you're jumping
                oldEyePos = traceRes2
                cmd:SetSideMove( -1000000 )
                bhop.left = true
                bhop.right = false 
            elseif( oldEyePos.y > traceRes2.y )  then --If you move your mouse right, move right,  while jumping
                oldEyePos = traceRes2
                cmd:SetSideMove( 1000000 )
                bhop.right = true
                bhop.left = false
            end
        end
    elseif (not bhop.jump) then
        bhop.jump = true
    end      
end
           
bhop.AddHook( "CreateMove", tostring(math.random(0, 133712837)), bhop.CreateMove )--add the hook

local tp = CreateClientConVar("tp", "0", true, false)

local Thirdperson = function(ply, origin, angles, fov)
	local view = {}
	local active = tp:GetBool()

	view.origin = active and origin - (angles:Forward() * 100) or origin
	view.drawviewer = active

	return view
end
hook.Add("CalcView", "Thirdperson", Thirdperson)

CreateClientConVar("cheat_fov", "110", true, false)
  function CalcView(ply, pos, angles, fov)
    if GetConVarNumber("EZ_customfov") == 1 then
	local view = {}
	view.origin = pos
	view.angles = angles
	view.fov = GetConVarNumber("cheat_fov")
	return view
   end
end
hook.Add("CalcView", tostring(math.random(666, 1221312)), CalcView)

local function UtilityCheck(v)
    if v != ply and v:Alive() and v:IsValid() then
        return true
    else
        return false
    end
end

MsgC(Color(0,255,0), "\nProject Valor Loaded!\n")
MsgC(Color(0,255,0), "\nNote: Thirdperson doesn't work with custom fov on and freecam won't either\n")
MsgC(Color(0,255,0), "\nWarning: This Project Is Very C+P Heavy\n")
MsgC(Color(0,255,0), "\nType Valormenu To Load The Cheat GUI")

hook.Add( "HUDPaint", "PlayerChams", function()
	for k, v in pairs ( player.GetAll() ) do
	if GetConVarNumber("EZ_Chams") == 1 then
		if UtilityCheck(v) == true then
				cam.Start3D(EyePos(), EyeAngles())
					cam.IgnoreZ( true )
					render.SuppressEngineLighting( true )
					v:DrawModel()
					cam.IgnoreZ( false )
					render.SuppressEngineLighting( false )
				cam.End3D()
			end
		end
	end
end)

CreateClientConVar("lenny_rapidfire", 0)
CreateClientConVar("FlashlightSpam", 0, true, false)
CreateClientConVar("rainbowphys", 0, true, false)


local function flashspammer(cmd)
	if  input.IsKeyDown(KEY_F) then
		cmd:SetImpulse(100)
	end
 end
hook.Remove("CreateMove", "flashspam")

if GetConVarNumber("FlashlightSpam") == 1 then
	hook.Add("CreateMove", "flashspam", flashspammer)
end
cvars.AddChangeCallback("FlashlightSpam", function() 
	if GetConVarNumber("FlashlightSpam") == 1 then
		hook.Add("CreateMove", "flashspam", flashspammer)
	else
		hook.Remove("CreateMove", "flashspam")
	end
end)

local toggler = 0

local function rapidfire(cmd)
	if LocalPlayer():KeyDown(IN_ATTACK) then
		if LocalPlayer():Alive() then
			if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
				if toggler == 0 then
					cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
					toggler = 1
				else
					cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
					toggler = 0
				end
			end
		end
	end
end

surface.CreateFont( "HUGETextForHUD", {
	font = "trebuchet18",
	size = 100,
	weight = 500,
	 } )

surface.CreateFont( "BigTextForHUD", {
	font = "trebuchet18",
	size = 30,
	weight = 500,
	 } )

surface.CreateFont( "SmallTextForHUD", {
	font = "DebugFixed",
	size = 12,
	weight = 500,
	 } )

CreateClientConVar("PlayerInfo", 1, true, false)

hook.Add( "HUDPaint", "PlayerInfo", function()
	if (GetConVarNumber("PlayerInfo") == 1) then
	for k, v in pairs ( player.GetAll() ) do
		if UtilityCheck(v) == true then
			local plyName = v:Nick()
			local plyPos = v:GetPos()
			local plyinfopos = ( plyPos + Vector( 0, 0, 90 )):ToScreen()
			draw.SimpleTextOutlined( plyName, "TargetID", plyinfopos.x, plyinfopos.y - 50, team.GetColor(v:Team()), 1, 1, 1, Color( 0, 0, 0 ) )
				local plyDistance = "Distance: "..math.Round(((ply:GetPos():Distance( v:GetPos()))))
				draw.SimpleTextOutlined( plyDistance, "SmallTextForHUD", plyinfopos.x, plyinfopos.y - 40, team.GetColor(v:Team()), 1, 1, 1, Color( 0, 0, 0 ) )
				local plyGroup = v:GetUserGroup()
				draw.SimpleTextOutlined( plyGroup, "SmallTextForHUD", plyinfopos.x, plyinfopos.y - 30, Color( 255, 0, 255 ), 1, 1, 1, Color( 0, 0, 0 ) )
				local plyHP = "HP: " .. v:Health()
				draw.SimpleTextOutlined( plyHP, "SmallTextForHUD", plyinfopos.x, plyinfopos.y - 20, Color( 255, 0, 0 ), 1, 1, 1, Color( 0, 0, 0 ) )
				local plyARMOR = "Armor: " .. v:Armor()
				draw.SimpleTextOutlined( plyARMOR, "SmallTextForHUD", plyinfopos.x, plyinfopos.y - 10, Color( 0, 255, 155 ), 1, 1, 1, Color( 0, 0, 0 ) )
				local plySTEAM = "SteamID: " .. v:SteamID()
				draw.SimpleTextOutlined( plySTEAM, "SmallTextForHUD", plyinfopos.x, plyinfopos.y + 10, Color( 255, 255, 255 ), 1, 1, 1, Color( 0, 0, 0 ) )
				local plyPING = "Ping: " .. v:Ping()
				draw.SimpleTextOutlined( plyPING, "SmallTextForHUD", plyinfopos.x, plyinfopos.y - 0, Color( 255, 255, 255 ), 1, 1, 1, Color( 0, 0, 0 ) )
			end
		end
	end
end)

CreateClientConVar("PropESP", 0, true, false)

hook.Add( "HUDPaint", "PropESP", function()
	for k,v in pairs (ents.FindByClass("prop_physics")) do
		if GetConVarNumber("PropESP") == 1 then
			cam.Start3D(EyePos(), EyeAngles())
				if v:IsValid() then
					cam.IgnoreZ( true )
					render.SuppressEngineLighting( true )
					render.SetColorModulation( 255, 255, 255)
					render.SetBlend(0.5)
					v:DrawModel()
					cam.IgnoreZ( false )
					render.SuppressEngineLighting( false )
				cam.End3D()
			end
		end
	end
end)


-- prepping
hook.Remove("CreateMove", "rapidfire")

if GetConVarNumber("lenny_rapidfire") == 1 then
	hook.Add("CreateMove", "rapidfire", rapidfire)
end
--end of prep

cvars.AddChangeCallback("lenny_rapidfire", function() 
	if GetConVarNumber("lenny_rapidfire") == 1 then
		hook.Add("CreateMove", "rapidfire", rapidfire)
	else
		hook.Remove("CreateMove", "rapidfire")
	end
end)



CreateClientConVar ("EZ_killsay","1", true ,false )

CreateClientConVar ("E_watermarkezhack","1", true ,false )
    hook.Add("HUDPaint", "watermark",function() 
        if GetConVarNumber("E_watermarkezhack") != 1 then return end
            surface.DrawRect( 0, 0, 255, 25 )
            draw.SimpleTextOutlined( "Project Valor", "Trebuchet24", 80,  50,  Color( 1, 1, 1, 255 ), TEXT_ALIGN_TOP, TEXT_ALIGN_TOP, 1, Color( 9, 94 , 0 ))
    end)

local Num = 0
local function rainbow()
	if GetConVarNumber("rainbowphys") == 1 then
		Num = Num + 1
        ply:SetWeaponColor(Vector(math.Rand(0,1),math.Rand(0,1),math.Rand(0,1)))
        Num = 0
	end
end
if GetConVarNumber("rainbowphys") == 1 then
	hook.Add("Think","rainbowphys",rainbow)
else
	hook.Remove("Think","rainbowphys",rainbow)
end
cvars.AddChangeCallback("rainbowphys", function() 
	if GetConVarNumber("rainbowphys") == 1 then
		hook.Add("CreateMove", "rainbowphys", rainbow)
	else
		hook.Remove("CreateMove", "rainbowphys")
	    ply:SetWeaponColor(Vector(0,1,1))
        Num = 0
	end
end)

SpamMessages = {}
SpamMessages[1] = "Project Valor Still Hittin P."
SpamMessages[2] = "lmao get rekt"
SpamMessages[3] = "lol mad?"
SpamMessages[4] = "Injecting Shitware26.dll... DONE"
SpamMessages[5] = "GET GOOD GET LAUGHING MY ASS OFF BOX actually don't its bad"
SpamMessages[6] = "ur mom"
SpamMessages[7] = "Garry Has Joined The Game"
SpamMessages[8] = "aA aB bC cD dE eF fG gH hI iJ jK kL lM mN nO oP pQ qR rS sT tU uV vW wX xY yZ z"
SpamMessages[9] = "this is hell and we both know it"
SpamMessages[10] = "hnghgngn your mom!!!"
SpamMessages[11] = "why are you gae"
SpamMessages[12] = "بعغباثهخنبانبغاضغخع عؤن ىثباقتباتباخنتبمضهاتبانبانثضت"
SpamMessages[13] = "I picked on little kids dammit -Zrehondier"

local function funnyspam()
	if GetConVarNumber("ChatSpam") == 1 and GetConVarNumber("ChatSpam_DarkRP") == 1 then
		ply:ConCommand("say /ooc "..table.Random(SpamMessages).." " )
	elseif GetConVarNumber("ChatSpam") == 1 then
		ply:ConCommand("say "..table.Random(SpamMessages).." " )
	end
end

timer.Create("chatspamtimer", 6, 0, funnyspam)

local ply = LocalPlayer()

Spam2Messages = {}
Spam2Messages[1] = "That Must Sting."
Spam2Messages[2] = "Ohhh Yikes You Got Messed Up"
Spam2Messages[3] = "just leave already"

    gameevent.Listen("player_hurt")

    local function hitSound(data)
     if GetConVarNumber("hitsound") == 1 then
    	local ply = LocalPlayer()
    	if data.attacker == ply:UserID() then
                surface.PlaySound("buttons/button17.wav")
       end
    end
 end
     
    hook.Add("player_hurt", "", hitSound)

    gameevent.Listen("player_hurt")

    local function killsay(data)
     if GetConVarNumber("EZ_killsay") == 1 then
    	local ply = LocalPlayer()
    	if data.attacker == ply:UserID() then
    		ply:ConCommand("say "..table.Random(Spam2Messages).." " )
       end
    end
 end
     
    hook.Add("player_hurt", "1", killsay)

CategoryList3 = vgui.Create( "DPanelList" )                                      
CategoryList3:SetSpacing( 5 )
CategoryList3:EnableHorizontal( false )
CategoryList3:EnableVerticalScrollbar( true )

CategoryList4 = vgui.Create( "DPanelList" )                                      
CategoryList4:SetSpacing( 5 )
CategoryList4:EnableHorizontal( false )
CategoryList4:EnableVerticalScrollbar( true )

local function cat()

 local frames = vgui.Create( "DFrame" )
 frames:SetText( "Project Valor" )
 frames:SetSize( 390, 390 )
 frames:SetTitle( "CATMODE!!!" )
 frames:Center()
 frames.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 frames:MakePopup()
		
local mat = vgui.Create("Material", frames)
mat:SetPos(0, 0)
mat:SetSize(390, 390)
mat:SetMaterial("cat/cat.png")
mat.AutoSize = false

end

local function main()

surface.PlaySound ("buttons/button14.wav")

 local frame = vgui.Create( "DFrame" )
 frame:SetText( "Project Valor" )
 frame:SetSize( 1000, 500 )
 frame:SetTitle( "Project Valor" )
 frame:Center()
 frame.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 frame:MakePopup()

 local sheet = vgui.Create( "DColumnSheet", frame ) 
 sheet:Dock( FILL )
 sheet.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 sheet:SetText( "Project Valor" )

 local panel1 = vgui.Create( "DPanel", sheet )
 panel1:SetText( "Aimbot" )
 panel1:Dock( FILL )
 panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 sheet:AddSheet( "Aimbot", panel1 )

 local panel2 = vgui.Create( "DPanel", sheet )
 panel2:SetText( "Visuals" )
 panel2:Dock( FILL )
 panel2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 sheet:AddSheet( "Visuals", panel2 )

 local panel3 = vgui.Create( "DPanel", sheet )
 panel3:SetText( "Misc" )
 panel3:Dock( FILL )
 panel3.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 sheet:AddSheet( "Misc", panel3 )

 local panel4 = vgui.Create( "DPanel", sheet )
 panel4:SetText( "Misc" )
 panel4:Dock( FILL )
 panel4.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 sheet:AddSheet( "Chat", panel4 )

 local panel5 = vgui.Create( "DPanel", sheet )
 panel5:SetText( "About" )
 panel5:Dock( FILL )
 panel5.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
 sheet:AddSheet( "About", panel5 )
  
 local SheetItemOne = vgui.Create( "DCheckBoxLabel", panel1)
 SheetItemOne:SetText( "Legit Aimbot (PLAYER ONLY)" )
 SheetItemOne:SetConVar( "EZ_Aimbot" )
 SheetItemOne:SetPos( 4, 0 )	
 SheetItemOne:SizeToContents()

 local SheetItemOne2 = vgui.Create( "DCheckBoxLabel", panel1)
 SheetItemOne2:SetText( "Rage Aimbot (PLAYER ONLY)" )
 SheetItemOne2:SetConVar( "EZ_AimbotRage" )
 SheetItemOne2:SetSize( 75, 15 )
 SheetItemOne2:SetPos( 4, 20 )	
 SheetItemOne2:SizeToContents()

 local chatbox = vgui.Create( "HTML", panel4 ) 
	chatbox:SetParent( panel4 )
	chatbox:SetPos( 0, 0 )
	chatbox:SetSize( 1000, 245 )
	chatbox:SizeToContents()
	chatbox:OpenURL( "https://projectvalor.chatovod.com/", panel4)

 local SheetItemOne23 = vgui.Create( "DCheckBoxLabel", panel1)
 SheetItemOne23:SetText( "Triggerbot (PLAYER ONLY)" )
 SheetItemOne23:SetConVar( "auto" )
 SheetItemOne23:SetSize( 75, 15 )	
 SheetItemOne23:SetPos( 4, 40 )	
 SheetItemOne23:SizeToContents()
 
 local SheetItemOne2345 = vgui.Create( "DCheckBoxLabel", panel1)
 SheetItemOne2345:SetText( "Auto Pistol" )
 SheetItemOne2345:SetConVar( "lenny_rapidfire" )
 SheetItemOne2345:SetPos( 4, 60 )	
 SheetItemOne2345:SizeToContents()

 local SheetItemOne23454 = vgui.Create( "DCheckBoxLabel", panel1)
 SheetItemOne23454:SetText( "TFA Norecoil (BUGGY)" )
 SheetItemOne23454:SetConVar( "EZ_Norecoil" )
 SheetItemOne23454:SetPos( 4, 80 )	
 SheetItemOne23454:SizeToContents()
 
  local SheetItemOne234545 = vgui.Create( "DCheckBoxLabel", panel1)
 SheetItemOne234545:SetText( "Norecoil" )
 SheetItemOne234545:SetConVar( "EZ_norecoils" )
 SheetItemOne234545:SetPos( 4, 100 )	
 SheetItemOne234545:SizeToContents()

  
local SheetItemTwo = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo:SetText( "Box ESP (SCREENGRABBABLE)" )
SheetItemTwo:SetConVar( "lenny_esp" )
SheetItemTwo:SetSize( 75, 15 )
SheetItemTwo:SetPos( 4, 0 )	
SheetItemTwo:SizeToContents()

local SheetItemTwo342 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo342:SetText( "Chams (SCREENGRABBABLE)" )
SheetItemTwo342:SetConVar( "EZ_Chams" )
SheetItemTwo342:SetSize( 75, 15 )
SheetItemTwo342:SetPos( 4, 20 )	
SheetItemTwo342:SizeToContents()

local SheetItemTwo3423 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo3423:SetText( "Colored Chams (SCREENGRABBABLE)" )
SheetItemTwo3423:SetConVar( "ColoredChams" )
SheetItemTwo3423:SetSize( 75, 15 )
SheetItemTwo3423:SetPos( 4, 40 )	
SheetItemTwo3423:SizeToContents()

local SheetItemTwo344 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo344:SetText( "Prop ESP (SCREENGRABBABLE)" )
SheetItemTwo344:SetConVar( "PropEsp" )
SheetItemTwo344:SetSize( 75, 15 )
SheetItemTwo344:SetPos( 4, 80 )	
SheetItemTwo344:SizeToContents()

local SheetItemTwo3445 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo3445:SetText( "Info ESP (SCREENGRABBABLE)" )
SheetItemTwo3445:SetConVar( "PlayerInfo" )
SheetItemTwo3445:SetSize( 75, 15 )
SheetItemTwo3445:SetPos( 4, 60 )	
SheetItemTwo3445:SizeToContents()

local SheetItemTwo3445 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo3445:SetText( "Show Players View On ESP" )
SheetItemTwo3445:SetConVar( "lenny_esp_view" )
SheetItemTwo3445:SetPos( 4, 100 )
SheetItemTwo3445:SetSize( 75, 15 )	
SheetItemTwo3445:SizeToContents()

local SheetItemTwo344556 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo344556:SetText( "Thirdperson (SCREENGRABBABLE)" )
SheetItemTwo344556:SetConVar( "tp" )
SheetItemTwo344556:SetPos( 4, 140 )
SheetItemTwo344556:SetSize( 75, 15 )	
SheetItemTwo344556:SizeToContents()

local SheetItemTwo3445563 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo3445563:SetText( "Custom FOV (SCREENGRABBABLE)" )
SheetItemTwo3445563:SetConVar( "EZ_customfov" )
SheetItemTwo3445563:SetPos( 4, 120 )
SheetItemTwo3445563:SetSize( 75, 15 )	
SheetItemTwo3445563:SizeToContents()

local SheetItemTwo3445563 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo3445563:SetText( "Hand Chams (SCREENGRABBABLE)" )
SheetItemTwo3445563:SetConVar( "EZ_Handchams" )
SheetItemTwo3445563:SetPos( 4, 160 )
SheetItemTwo3445563:SetSize( 75, 15 )	
SheetItemTwo3445563:SizeToContents()

local SheetItemTwo34455635 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo34455635:SetText( "Viewmodel Chams (SCREENGRABBABLE)" )
SheetItemTwo34455635:SetConVar( "EZ_Viewmodelchams" )
SheetItemTwo34455635:SetPos( 250, 0 )
SheetItemTwo34455635:SetSize( 75, 15 )	
SheetItemTwo34455635:SizeToContents()

local SheetItemTwo344556345 = vgui.Create( "DCheckBoxLabel" , panel2 )
SheetItemTwo344556345:SetText( "Fullbright (SCREENGRABBABLE)" )
SheetItemTwo344556345:SetConVar( "lenny_fullbright" )
SheetItemTwo344556345:SetPos( 250, 20 )
SheetItemTwo344556345:SetSize( 75, 15 )	
SheetItemTwo344556345:SizeToContents()

local SheetItemTwo3445563 = vgui.Create( "DCheckBoxLabel" , panel3 )
SheetItemTwo3445563:SetText( "Chat Spammer" )
SheetItemTwo3445563:SetConVar( "ChatSpam" )
SheetItemTwo3445563:SetPos( 4, 0 )
SheetItemTwo3445563:SetSize( 75, 15 )	
SheetItemTwo3445563:SizeToContents()

    local CategoryContentThreeee32 = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeee32:SetText( "Auto Bunnyhop" )
    CategoryContentThreeee32:SetConVar( "cpyher_bunnyhop" )
    CategoryContentThreeee32:SetPos( 4, 20 )
    CategoryContentThreeee32:SizeToContents()

    local CategoryContentThreeee322 = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeee322:SetText( "AutoStrafe" )
    CategoryContentThreeee322:SetConVar( "autostrafe" )
    CategoryContentThreeee322:SetPos( 4, 40 )
    CategoryContentThreeee322:SizeToContents()

    local CategoryContentThreeeeeeee = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeeeeeee:SetText( "Follow Player Bot" )
    CategoryContentThreeeeeeee:SetConVar( "follow" )
    CategoryContentThreeeeeeee:SetPos( 4, 60 )
    CategoryContentThreeeeeeee:SizeToContents()

    local CategoryContentThreeeeeeee = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeeeeeee:SetText( "Rainbow Physgun (SCREENGRABBABLE)" )
    CategoryContentThreeeeeeee:SetConVar( "rainbowphys" )
    CategoryContentThreeeeeeee:SetPos( 4, 240 )
    CategoryContentThreeeeeeee:SizeToContents()

    local CategoryContentThreeeeeeee3 = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeeeeeee3:SetText( "Follow Bot Ignore's Team" )
    CategoryContentThreeeeeeee3:SetConVar( "follow_team" )
    CategoryContentThreeeeeeee3:SetPos( 4, 80 )
    CategoryContentThreeeeeeee3:SizeToContents()

    local Misccheat5 = vgui.Create( "DCheckBoxLabel", panel3 )
	
        Misccheat5:SetPos( 4, 100 )
	Misccheat5:SetText( "Name Changer (DarkRP)" )
	Misccheat5:SetConVar( "shouldnamechange" )
	Misccheat5:SizeToContents()
        local Misccheat6 = vgui.Create( "DCheckBoxLabel", panel3 )
        Misccheat6:SetPos( 4, 120 )
	
	Misccheat6:SetText( "Project Valor Watermark" )
	Misccheat6:SetConVar( "E_watermarkezhack" )
	Misccheat6:SizeToContents()
        local Misccheat7 = vgui.Create( "DCheckBoxLabel", panel3 )
        Misccheat7:SetPos( 4, 140 )

        local Misccheat66 = vgui.Create( "DCheckBoxLabel", panel3 )
        Misccheat66:SetPos( 250, 160 )

        Misccheat66:SetText( "HurtSay/Killsay" )
	Misccheat66:SetConVar( "EZ_killsay" )
	Misccheat66:SizeToContents()

                local Misccheat664 = vgui.Create( "DCheckBoxLabel", panel3 )
        Misccheat664:SetPos( 250, 180 )

        Misccheat664:SetText( "Disable Skybox" )
	Misccheat664:SetConVar( "aim_master_toggle" )
	Misccheat664:SizeToContents()
	
	Misccheat7:SetText( "Reconnect On Low Health (25 HP)" )
	Misccheat7:SetConVar( "lowhealthretry" )
	Misccheat7:SizeToContents()
        local Misccheat8 = vgui.Create( "DCheckBoxLabel", panel3 )
        Misccheat8:SetPos( 4, 160 )
	
    local CategoryContentThreeeeee32 = vgui.Create( "DCheckBoxLabel", panel3)
    CategoryContentThreeeeee32:SetText( "Dark RP ChatSpam Mode" )
    CategoryContentThreeeeee32:SetPos( 4, 180 )
    CategoryContentThreeeeee32:SetConVar( "ChatSpam_DarkRP" )
    CategoryContentThreeeeee32:SizeToContents()

      
	Misccheat8:SetText( "Hitsounds" )
	Misccheat8:SetConVar( "hitsound" )
	Misccheat8:SizeToContents()

    
    local CategoryContentThreeeeeeee33 = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeeeeeee33:SetText( "Flashlight Spammer" )
    CategoryContentThreeeeeeee33:SetConVar( "FlashlightSpam" )
    CategoryContentThreeeeeeee33:SetPos( 4, 200 )
    CategoryContentThreeeeeeee33:SizeToContents()
    
    local CategoryContentThreeeeeeee3322 = vgui.Create( "DCheckBoxLabel", panel3 )
    CategoryContentThreeeeeeee3322:SetText( "Custom Crosshair" )
    CategoryContentThreeeeeeee3322:SetConVar( "lenny_advcrosshair" )
    CategoryContentThreeeeeeee3322:SetPos( 4, 220 )
    CategoryContentThreeeeeeee3322:SizeToContents()

    local CategoryContentSixa23 = vgui.Create( "DNumSlider", panel2 )
    CategoryContentSixa23:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa23:SetText( "FOV Slider" )
    CategoryContentSixa23:SetPos( 4, 180 )
    CategoryContentSixa23:SetMin( 54 )
    CategoryContentSixa23:SetMax( 360 )
    CategoryContentSixa23:SetDecimals( 0 )
    CategoryContentSixa23:SetConVar( "cheat_fov" )

        local CategoryContentSixa234 = vgui.Create( "DNumSlider", panel3 )
    CategoryContentSixa234:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa234:SetText( "Propkill Remove Timer" )
    CategoryContentSixa234:SetPos( 250, 70 )
    CategoryContentSixa234:SetMin( 1 )
    CategoryContentSixa234:SetMax( 10 )
    CategoryContentSixa234:SetDecimals( 0 )
    CategoryContentSixa234:SetConVar( "_pkill_remover" )

            local CategoryContentSixa233 = vgui.Create( "DNumSlider", panel3 )
    CategoryContentSixa233:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa233:SetText( "Propkill Speed" )
    CategoryContentSixa233:SetPos( 250, 100 )
    CategoryContentSixa233:SetMin( 100 )
    CategoryContentSixa233:SetMax( 2000 )
    CategoryContentSixa233:SetDecimals( 0 )
    CategoryContentSixa233:SetConVar( "_pkill_speed" )

    local CategoryContentSixa232 = vgui.Create( "DNumSlider", panel2 )
    CategoryContentSixa232:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa232:SetText( "Box ESP Radius" )
    CategoryContentSixa232:SetPos( 4, 210 )
    CategoryContentSixa232:SetMin( 1500 )
    CategoryContentSixa232:SetMax( 10000 )
    CategoryContentSixa232:SetDecimals( 0 )
    CategoryContentSixa232:SetConVar( "lenny_esp_radius" )

    local DermaButton2 = vgui.Create( "DButton", panel3 ) // Create the button and parent it to the frame
DermaButton2:SetText( "Propkill Help" )					// Set the text on the button
DermaButton2:SetPos( 250, 0 )					// Set the position on the frame
DermaButton2:SetSize( 150, 30 )				// Set the size
DermaButton2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
DermaButton2.DoClick = function() Derma_Message(" bind <key> _pkill ", "How To Use Propkill", "OK") end	// A custom function run when clicked ( note the . instead of : )

    local DermaButton22 = vgui.Create( "DButton", panel5 ) // Create the button and parent it to the frame
DermaButton22:SetText( "About Project Valor" )					// Set the text on the button
DermaButton22:SetPos( 0, 0 )					// Set the position on the frame
DermaButton22:SetSize( 150, 30 )				// Set the size
DermaButton22.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
DermaButton22.DoClick = function() Derma_Message("Project Valor\n\nBy Astroux.", "About Project Valor", "OK") end	// A custom function run when clicked ( note the . instead of : )

    local DermaButton223 = vgui.Create( "DButton", panel5 ) // Create the button and parent it to the frame
DermaButton223:SetText( "Changelog" )					// Set the text on the button
DermaButton223:SetPos( 130, 0 )					// Set the position on the frame
DermaButton223:SetSize( 150, 30 )				// Set the size
DermaButton223.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
DermaButton223.DoClick = function() Derma_Message("+ Added AutoPropkill\n+ Added About Tab\n+ Added Fullbright\n+ Added Killsay/Hurtsay\n+ Added NoRecoil\n+ Added NoSky", "Changelog", "OK") end

    local DermaButton2243 = vgui.Create( "DButton", panel5 ) // Create the button and parent it to the frame
DermaButton2243:SetText( "Astroux's Profile" )					// Set the text on the button
DermaButton2243:SetPos( 260, 0 )					// Set the position on the frame
DermaButton2243:SetSize( 150, 30 )				// Set the size
DermaButton2243.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
DermaButton2243.DoClick = function() RunConsoleCommand("profile") end


    local DermaButton22434 = vgui.Create( "DButton", panel2 ) // Create the button and parent it to the frame
DermaButton22434:SetText( "Box ESP Config" )					// Set the text on the button
DermaButton22434:SetPos( 250, 40 )					// Set the position on the frame
DermaButton22434:SetSize( 150, 30 )				// Set the size
DermaButton22434.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 1, 1, 1, 200 ) ) end 
DermaButton22434.DoClick = function() RunConsoleCommand("lenny_ents") end

	local TextEntryPH = vgui.Create( "DTextEntry", panel2 )
        TextEntryPH:SetSize( 150, 20 )
	TextEntryPH:SetPlaceholderText( "Colored Chams Red" )
        TextEntryPH:SetPos( 250, 80 )
	TextEntryPH.OnEnter = function( self )
		chamColour.r = self:GetValue()  end 
        local TextEntryPH2 = vgui.Create( "DTextEntry", panel2 )
        TextEntryPH2:SetSize( 150, 20 )
        TextEntryPH2:SetPos( 250, 100 )
	TextEntryPH2:SetPlaceholderText( "Colored Chams Green" )
	TextEntryPH2.OnEnter = function( self2 )
		chamColour.g = self2:GetValue()  end 
        local TextEntryPH3 = vgui.Create( "DTextEntry", panel2 )
        TextEntryPH3:SetSize( 150, 20 )
        TextEntryPH3:SetPos( 250, 120 )
	TextEntryPH3:SetPlaceholderText( "Colored Chams Blue" )
	TextEntryPH3.OnEnter = function( self3 )                            
		chamColour.b = self3:GetValue()  end 

-- Combo box
local cbox = vgui.Create("DComboBox", panel2)	
cbox:SetPos(675, 0)
cbox:SetSize(190, 20)

local cbox2 = vgui.Create("DComboBox", panel2)
cbox2:SetPos(485, 0)
cbox2:SetSize(190, 20)

-- Choices
cbox:AddChoice("Galaxy", 1)
cbox:AddChoice("Chrome", 2)
cbox:AddChoice("Plasma", 3)
cbox:AddChoice("Default", 4)
cbox:AddChoice("Wireframe", 52)
cbox:AddChoice("Platinum", 6)
cbox:AddChoice("Alien", 7)
cbox:AddChoice("Molten", 8)
cbox:AddChoice("Fire", 9)
cbox:AddChoice("Glow", 10)
cbox:AddChoice("Reactor", 11)
cbox:AddChoice("Water", 12)
cbox:AddChoice("Water 2", 13)

cbox2:AddChoice("Galaxy", 1)
cbox2:AddChoice("Chrome", 2)
cbox2:AddChoice("Plasma", 3)
cbox2:AddChoice("Default", 4)
cbox2:AddChoice("Wireframe", 5)
cbox2:AddChoice("Platinum", 6)
cbox2:AddChoice("Alien", 7)
cbox2:AddChoice("Molten", 8)
cbox2:AddChoice("Fire", 9)
cbox2:AddChoice("Glow", 10)
cbox2:AddChoice("Reactor", 11)
cbox2:AddChoice("Water", 12)
cbox2:AddChoice("Water 2", 13)

function cbox:OnSelect(index, value, data)

	if(data == 1) then				
		mat1 = Material("Models/effects/comball_sphere")
        end
        if(data == 2) then				
		mat1 = Material("debug/env_cubemap_model")
        end
        if(data == 3) then				
		mat1 = Material("models/props_combine/portalball001_sheet")
        end
        if(data == 4) then				
		mat1 = Material("models/shiny")
        end
        if(data == 52) then				
		mat1 = Material("models/wireframe")
        end
        if(data == 6) then				
		mat1 = Material("models/player/shared/ice_player")
        end
        if(data == 7) then				
		mat1 = Material("models/XQM/LightLinesRed_tool")
        end
        if(data == 8) then				
		mat1 = Material("models/props_lab/Tank_Glass001")
        end
        if(data == 9) then				
		mat1 = Material("models/shadertest/shader4")
        end
        if(data == 10) then				
		mat1 = Material("Models/effects/splodearc_sheet")
        end
        if(data == 11) then				
		mat1 = Material("Models/effects/comball_tape")
        end
        if(data == 12) then				
		mat1 = Material("models/props_combine/stasisshield_sheet")
        end
        if(data == 13) then				
		mat1 = Material("models/shadertest/shader3")
        end
     end
  

function cbox2:OnSelect(index, value, data)

	if(data == 1) then				
		mat0 = Material("Models/effects/comball_sphere")
        end
        if(data == 2) then				
		mat0 = Material("debug/env_cubemap_model")
        end
        if(data == 3) then				
		mat0 = Material("models/props_combine/portalball001_sheet")
        end
        if(data == 4) then				
		mat0 = Material("models/shiny")
        end
        if(data == 5) then				
		mat0 = Material("models/wireframe")
        end
        if(data == 6) then				
		mat0 = Material("models/player/shared/ice_player")
        end
        if(data == 7) then				
		mat0 = Material("models/XQM/LightLinesRed_tool")
        end
        if(data == 8) then				
		mat0 = Material("models/props_lab/Tank_Glass001")
        end
        if(data == 9) then				
		mat0 = Material("models/shadertest/shader4")
        end
        if(data == 10) then				
		mat0 = Material("Models/effects/splodearc_sheet")
        end
        if(data == 11) then				
		mat0 = Material("Models/effects/comball_tape")
        end
        if(data == 12) then				
		mat0 = Material("models/props_combine/stasisshield_sheet")
        end
        if(data == 13) then				
		mat0 = Material("models/shadertest/shader3")
        end
     end
  end





concommand.Add("Valormenu", main)
concommand.Add("catmode", cat)
concommand.Add("test", test)


