-- "lua\\projectvalor.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 0, 0 )
DermaPanel:SetSize( 1925, 1250 )
DermaPanel:SetTitle( "                                                                                                                                                                                                                                                                                                               |  Project Valor  |" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( false )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()
surface.PlaySound ("buttons/blip1.wav")
DermaPanel.Paint = function( self, w, h ) -- 'function DermaPanel:Paint( w, h )' works too
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 230 ) ) -- Draw a red box instead of the frame
end

rook = "Rook_"
local ply = LocalPlayer()

local function espmenu2()
local DermaPanel4 = vgui.Create( "DFrame" )
DermaPanel4:SetPos( 0, 0 )
DermaPanel4:SetSize( 500, 300 )
DermaPanel4:SetTitle( "Project Valor | Esp Config" )
DermaPanel4:SetVisible( true )
DermaPanel4:SetDraggable( true )
DermaPanel4:ShowCloseButton( true )
DermaPanel4:MakePopup()
DermaPanel4.Paint = function( self, w, h ) -- 'function DermaPanel4:Paint( w, h )' works too
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 60 ) ) -- Draw a red box instead of the frame
    end
end

local tp = CreateClientConVar("_thirdperson", "0")
CreateClientConVar ("EZ_HandChams","0", true ,false )
CreateClientConVar ("EZ_NoRecoil","0", true ,false )
CreateClientConVar ("EZ_Aimbot","0", true ,false )
CreateClientConVar ("hitsound","0", true ,false )
CreateClientConVar ("ColoredChams","0", true ,false )
CreateClientConVar ("EZ_Chams","0", true ,false )
CreateClientConVar ("EZ_triggerbot","0", true ,false )
CreateClientConVar ("EZ_head","0", true ,false )
CreateClientConVar ("EZ_AimbotRage","0", true ,false )
CreateClientConVar ("Freecam","0", true ,false )
CreateClientConVar ("Crosshair","0", true ,false )
CreateClientConVar ("EZ_thirdperson","0", true ,false )
CreateClientConVar ("EZ_customfov","0", true ,false )
shouldnamechange = CreateClientConVar("name_change", "0", true, true)
shouldnamechangepreset = CreateClientConVar("name_change_preset", "0", true, true)

local hook = hook
local CreateConVar = CreateConVar
local GetConVarString = GetConVarString
local RunConsoleCommand = RunConsoleCommand
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


local SomeCollapsibleCategory3 = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory3:SetPos( 400,25 )
SomeCollapsibleCategory3:SetSize( 600, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory3:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory3:SetLabel( "Aimbot" )
SomeCollapsibleCategory3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

local SomeCollapsibleCategory4 = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory4:SetPos( 1000,25 )
SomeCollapsibleCategory4:SetSize( 550, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory4:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory4:SetLabel( "Visuals" )
SomeCollapsibleCategory4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

local SomeCollapsibleCategory5 = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory5:SetPos( 1550,25 )
SomeCollapsibleCategory5:SetSize( 800, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory5:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory5:SetLabel( "Movement" )
SomeCollapsibleCategory5.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

local SomeCollapsibleCategory = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory:SetPos( 1,25 )
SomeCollapsibleCategory:SetSize( 400, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory:SetLabel( "Misc" )
SomeCollapsibleCategory.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

CategoryList3 = vgui.Create( "DPanelList" )                                      
CategoryList3:SetSpacing( 5 )
CategoryList3:EnableHorizontal( false )
CategoryList3:EnableVerticalScrollbar( true )

CategoryList4 = vgui.Create( "DPanelList" )
CategoryList4:SetAutoSize( true )
CategoryList4:SetSpacing( 5 )
CategoryList4:EnableHorizontal( false )
CategoryList4:EnableVerticalScrollbar( true )
 
CategoryList5 = vgui.Create( "DPanelList" )
CategoryList5:SetAutoSize( true )
CategoryList5:SetSpacing( 5 )
CategoryList5:EnableHorizontal( false )
CategoryList5:EnableVerticalScrollbar( true )

CategoryList = vgui.Create( "DPanelList" )
CategoryList:SetAutoSize( true )
CategoryList:SetSpacing( 5 )
CategoryList:EnableHorizontal( false )
CategoryList:EnableVerticalScrollbar( true )


SomeCollapsibleCategory3:SetContents( CategoryList3 )
SomeCollapsibleCategory4:SetContents( CategoryList4 ) -- Add our list above us as the contents of the collapsible category
SomeCollapsibleCategory5:SetContents( CategoryList5 )
SomeCollapsibleCategory:SetContents( CategoryList )

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
	menu:SetTitle("Valor Hack Alpha | ESP Entity Config")
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
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a red box instead of the frame
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
				local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
				realboxesp(min, max, diff, v)
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

hook.Add("Think","C+P NoRecoil from gayDaap",function()

if GetConVar("EZ_NoRecoil"):GetInt() == 1 then
if wep.Recoil != 0 then
wep.OldRecoil = wep.Recoil
wep.Recoil = 0
end
if wep.Primary.Recoil != 0 then
wep.Primary.OldRecoil = wep.Primary.Recoil
wep.Primary.Recoil = 0
end
if wep.Secondary.Recoil != 0 then
wep.Secondary.OldRecoil = wep.Secondary.Recoil
wep.Secondary.Recoil = 0
      end
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
    end)

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
 if (GetConVarNumber("EZ_Aimbot") == 1 && GetConVarNumber("EZ_AimbotRage") == 0) then
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

local tp = CreateClientConVar("_thirdperson", "1")

local Thirdperson = function(ply, origin, angles, fov)
   if GetConVarNumber("EZ_thirdperson") == 1 then
	local view = {}
	local active = tp:GetBool()

	view.origin = active and origin - (angles:Forward() * 100) or origin
	view.drawviewer = active

	return view
   end
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
MsgC(Color(0,255,0), "\nWarning: This Project Is Very C+P Heavy")

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

    freecamAngles = Angle()
    freecamAngles2 = Angle()
    freecamPos = Vector()
    freecamEnabled = false
    freecamSpeed = 3
    keyPressed = false
     
    hook.Add("CreateMove", "lock_movement", function(ucmd)
        if(freecamEnabled) then
            ucmd:SetSideMove(0)
            ucmd:SetForwardMove(0)
            ucmd:SetViewAngles(freecamAngles2)
            ucmd:RemoveKey(IN_JUMP)
            ucmd:RemoveKey(IN_DUCK)
            
            freecamAngles = (freecamAngles + Angle(ucmd:GetMouseY() * .023, ucmd:GetMouseX() * -.023, 0));
            freecamAngles.p, freecamAngles.y, freecamAngles.x = math.Clamp(freecamAngles.p, -89, 89), math.NormalizeAngle(freecamAngles.y), math.NormalizeAngle(freecamAngles.x);
     
            local curFreecamSpeed = freecamSpeed
            if(input.IsKeyDown(KEY_LSHIFT)) then
                curFreecamSpeed = freecamSpeed * 2
            end
     
            if(input.IsKeyDown(KEY_W)) then
                freecamPos = freecamPos + (freecamAngles:Forward() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_S)) then
                freecamPos = freecamPos - (freecamAngles:Forward() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_A)) then
                freecamPos = freecamPos - (freecamAngles:Right() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_D)) then
                freecamPos = freecamPos + (freecamAngles:Right() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_SPACE)) then
                freecamPos = freecamPos + Vector(0,0,curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_LCONTROL)) then
                freecamPos = freecamPos - Vector(0,0,curFreecamSpeed)
            end
        end
    end)
     
    hook.Add("Tick", "checkKeybind", function()
     if (GetConVarNumber("Freecam") == 1 && GetConVarNumber("EZ_customfov") == 0) then
        if(input.IsKeyDown(KEY_LALT)) then
            if(!keyPressed) then
                freecamEnabled = !freecamEnabled
                freecamAngles = LocalPlayer():EyeAngles()
                freecamAngles2 = LocalPlayer():EyeAngles()
                freecamPos = LocalPlayer():EyePos()
                keyPressed = true
            end
        else
            keyPressed = false
         end
      end
   end)

    hook.Add("CalcView", "freeCam", function(ply, pos, angles, fov)
        local view = {}
        if(freecamEnabled) then
            view = {
                origin = freecamPos,
                angles = freecamAngles,
                fov = fov,
                drawviewer = true
            }
        else
            view = {
                origin = pos,
                angles = angles,
                fov = fov,
                drawviewer = false
            }
        end
     
    	return view
    end)

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

CreateClientConVar("ChatSpam", 0, true, false)
CreateClientConVar("ChatSpam_DarkRP", 0, true, false)

SpamMessages = {}
SpamMessages[1] = "Project Valor Still Hittin P."
SpamMessages[2] = "Ill Give You My Insta Soon SIMPS!"
SpamMessages[3] = "lol mad?"

local function funnyspam()
	if GetConVarNumber("ChatSpam") == 1 and GetConVarNumber("ChatSpam_DarkRP") == 1 then
		ply:ConCommand("say /ooc "..table.Random(SpamMessages).." " )
	elseif GetConVarNumber("ChatSpam") == 1 then
		ply:ConCommand("say "..table.Random(SpamMessages).." " )
	end
end

timer.Create("chatspamtimer", .25, 0, funnyspam)

    gameevent.Listen("player_hurt")
    local function hitSound(data)
     if GetConVarNumber("hitsound") == 1 then
    	local ply = LocalPlayer()
    	if data.attacker == ply:UserID() then
    		surface.PlaySound("buttons/button17.wav") // name of a sound that exists in gmod
       end
    end
 end
     
    hook.Add("player_hurt", "", hitSound)

    local CategoryContentNine = vgui.Create( "DCheckBoxLabel" )
    CategoryContentNine:SetText( "Legit Aimbot (PLAYER ONLY)" )
    CategoryContentNine:SetConVar( "EZ_Aimbot" )
    CategoryContentNine:SizeToContents()
CategoryList3:AddItem( CategoryContentNine )

    local CategoryContentThreeeee5 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeee5:SetText( "Rage Aimbot (PLAYER ONLY)" )
    CategoryContentThreeeee5:SetConVar( "EZ_AimbotRage" )
    CategoryContentThreeeee5:SizeToContents()
CategoryList3:AddItem( CategoryContentThreeeee5 )

    local CategoryContentNines = vgui.Create( "DCheckBoxLabel" )
    CategoryContentNines:SetText( "Triggerbot (PLAYER ONLY)" )
    CategoryContentNines:SetConVar( "auto" )
    CategoryContentNines:SizeToContents()
CategoryList3:AddItem( CategoryContentNines )

    local CategoryContentElevene = vgui.Create( "DCheckBoxLabel" )
    CategoryContentElevene:SetText( "Randomly Generated Name Changer" )
    CategoryContentElevene:SetConVar( "name_change" )
    CategoryContentElevene:SizeToContents()
CategoryList:AddItem( CategoryContentElevene )

--    local CategoryContentElevene2 = vgui.Create( "DCheckBoxLabel" )
--    CategoryContentElevene2:SetText( "Preset Name Changer" )
--    CategoryContentElevene2:SetConVar( "name_change_preset" )
--    CategoryContentElevene2:SizeToContents()
--CategoryList:AddItem( CategoryContentElevene2 )

    local CategoryContentThreee = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreee:SetText( "Project Valor Watermark" )
    CategoryContentThreee:SetConVar( "E_watermarkezhack" )
    CategoryContentThreee:SizeToContents()
CategoryList:AddItem( CategoryContentThreee )

    local CategoryContentThreeee32 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeee32:SetText( "Auto BHOP" )
    CategoryContentThreeee32:SetConVar( "cpyher_bunnyhop" )
    CategoryContentThreeee32:SizeToContents()
CategoryList5:AddItem( CategoryContentThreeee32 )

    local CategoryContentNines2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentNines2:SetText( "TFA Norecoil" )
    CategoryContentNines2:SetConVar( "EZ_NoRecoil" )
    CategoryContentNines2:SizeToContents()
CategoryList3:AddItem( CategoryContentNines2 )

    local CategoryContentThreeeee6 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeee6:SetText( "Rapid Fire" )
    CategoryContentThreeeee6:SetConVar( "lenny_rapidfire" )
    CategoryContentThreeeee6:SizeToContents()
CategoryList3:AddItem( CategoryContentThreeeee6 )

    local CategoryContentThreeeeee = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee:SetText( "Draw HUD" )
    CategoryContentThreeeeee:SetConVar( "cl_drawhud" )
    CategoryContentThreeeeee:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee )

    local CategoryContentThreeeeee3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee3:SetText( "Chat Spammer" )
    CategoryContentThreeeeee3:SetConVar( "ChatSpam" )
    CategoryContentThreeeeee3:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee3 )

    local CategoryContentThreeeeee32 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee32:SetText( "Dark RP ChatSpam Mode" )
    CategoryContentThreeeeee32:SetConVar( "ChatSpam_DarkRP" )
    CategoryContentThreeeeee32:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee32 )

    local CategoryContentThreeeeee2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee2:SetText( "Flashlight Spammer" )
    CategoryContentThreeeeee2:SetConVar( "FlashlightSpam" )
    CategoryContentThreeeeee2:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee2 )

    local CategoryContentThreeeeee33 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee33:SetText( "Hitsounds" )
    CategoryContentThreeeeee33:SetConVar( "hitsound" )
    CategoryContentThreeeeee33:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee33 )
   
    local CategoryContentThreeeeee25 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee25:SetText( "Rainbow Physgun" )
    CategoryContentThreeeeee25:SetConVar( "rainbowphys" )
    CategoryContentThreeeeee25:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee25 )

    local CategoryContentThreeeeeeee = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeeeee:SetText( "Follow Player Bot" )
    CategoryContentThreeeeeeee:SetConVar( "follow" )
    CategoryContentThreeeeeeee:SizeToContents()
CategoryList5:AddItem( CategoryContentThreeeeeeee )

    local CategoryContentThreeeeeeee3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeeeee3:SetText( "Follow Bot Ignore's Team" )
    CategoryContentThreeeeeeee3:SetConVar( "follow_team" )
    CategoryContentThreeeeeeee3:SizeToContents()
CategoryList5:AddItem( CategoryContentThreeeeeeee3 )

    local CategoryContentThreeeeee4 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee4:SetText( "Thirdperson" )
    CategoryContentThreeeeee4:SetConVar( "EZ_thirdperson" )
    CategoryContentThreeeeee4:SizeToContents()
CategoryList4:AddItem( CategoryContentThreeeeee4 )

    local CategoryContentThreeeeee45 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee45:SetText( "Freecam (LEFT ALT)" )
    CategoryContentThreeeeee45:SetConVar( "Freecam" )
    CategoryContentThreeeeee45:SizeToContents()
CategoryList4:AddItem( CategoryContentThreeeeee45 )

    local CategoryContentSixa = vgui.Create( "DNumSlider" )
    CategoryContentSixa:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa:SetText( "Net Graph/Fps Counter" )
    CategoryContentSixa:SetMin( 0 )
    CategoryContentSixa:SetMax( 3 )
    CategoryContentSixa:SetDecimals( 0 )
    CategoryContentSixa:SetConVar( "net_graph" )
CategoryList:AddItem( CategoryContentSixa )

    local CategoryContentThreeeeee45 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee45:SetText( "Custom FOV" )
    CategoryContentThreeeeee45:SetConVar( "EZ_customfov" )
    CategoryContentThreeeeee45:SizeToContents()
CategoryList4:AddItem( CategoryContentThreeeeee45 )

    local CategoryContentSixa23 = vgui.Create( "DNumSlider" )
    CategoryContentSixa23:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa23:SetText( "FOV Slider" )
    CategoryContentSixa23:SetMin( 54 )
    CategoryContentSixa23:SetMax( 300 )
    CategoryContentSixa23:SetDecimals( 0 )
    CategoryContentSixa23:SetConVar( "cheat_fov" )
CategoryList4:AddItem( CategoryContentSixa23 )

    local CategoryContentThreef3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef3:SetText( "Info ESP" )
    CategoryContentThreef3:SetConVar( "PlayerInfo" )
    CategoryContentThreef3:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef3 )

    local CategoryContentThreef2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef2:SetText( "Prop ESP" )
    CategoryContentThreef2:SetConVar( "PropESP" )
    CategoryContentThreef2:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef2 )

    local CategoryContentThreef = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef:SetText( "Box ESP" )
    CategoryContentThreef:SetConVar( "lenny_esp" )
    CategoryContentThreef:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef )

    local CategoryContentThree = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThree:SetText( "Chams" )
    CategoryContentThree:SetConVar( "EZ_Chams" )
    CategoryContentThree:SizeToContents()
CategoryList4:AddItem( CategoryContentThree )

    local CategoryContentThree3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThree3:SetText( "Colored Chams (BUGGY)" )
    CategoryContentThree3:SetConVar( "ColoredChams" )
    CategoryContentThree3:SizeToContents()
CategoryList4:AddItem( CategoryContentThree3 )

    local CategoryContentThreef2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef2:SetText( "Show Players View On ESP" )
    CategoryContentThreef2:SetConVar( "lenny_esp_view" )
    CategoryContentThreef2:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef2 )

    local CategoryContentSixa2 = vgui.Create( "DNumSlider" )
    CategoryContentSixa2:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa2:SetText( "ESP Radius" )
    CategoryContentSixa2:SetMin( 1500 )
    CategoryContentSixa2:SetMax( 10000 )
    CategoryContentSixa2:SetDecimals( 0 )
    CategoryContentSixa2:SetConVar( "lenny_esp_radius" )
CategoryList4:AddItem( CategoryContentSixa2 )

local DermaButton = vgui.Create( "DButton" ) // Create the button and parent it to the frame
DermaButton:SetText( "Box ESP Settings" )					// Set the text on the button
DermaButton:SetPos( 4, 0 )					// Set the position on the frame
DermaButton:SetSize( 150, 30 )	
CategoryList4:AddItem( DermaButton )				// Set the size
DermaButton.DoClick = function()			// A custom function run when clicked ( note the . instead of : )
	RunConsoleCommand("lenny_ents")
end

DermaButton.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 150 ) ) -- Draw a blue button			// Run the console command "say hi" when you click it ( command, args )
end

local DermaButton2 = vgui.Create( "DButton" ) // Create the button and parent it to the frame
DermaButton2:SetText( "Astroux's Profile" )					// Set the text on the button
DermaButton2:SetPos( 4, 0 )					// Set the position on the frame
DermaButton2:SetSize( 150, 30 )	
CategoryList:AddItem( DermaButton2 )				// Set the size
DermaButton2.DoClick = function()			// A custom function run when clicked ( note the . instead of : )
	RunConsoleCommand("profile")
end

DermaButton2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 150 ) ) -- Draw a blue button			// Run the console command "say hi" when you click it ( command, args )
end





-- "lua\\projectvalor.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 0, 0 )
DermaPanel:SetSize( 1925, 1250 )
DermaPanel:SetTitle( "                                                                                                                                                                                                                                                                                                               |  Project Valor  |" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( false )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()
surface.PlaySound ("buttons/blip1.wav")
DermaPanel.Paint = function( self, w, h ) -- 'function DermaPanel:Paint( w, h )' works too
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 230 ) ) -- Draw a red box instead of the frame
end

rook = "Rook_"
local ply = LocalPlayer()

local function espmenu2()
local DermaPanel4 = vgui.Create( "DFrame" )
DermaPanel4:SetPos( 0, 0 )
DermaPanel4:SetSize( 500, 300 )
DermaPanel4:SetTitle( "Project Valor | Esp Config" )
DermaPanel4:SetVisible( true )
DermaPanel4:SetDraggable( true )
DermaPanel4:ShowCloseButton( true )
DermaPanel4:MakePopup()
DermaPanel4.Paint = function( self, w, h ) -- 'function DermaPanel4:Paint( w, h )' works too
	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 60 ) ) -- Draw a red box instead of the frame
    end
end

local tp = CreateClientConVar("_thirdperson", "0")
CreateClientConVar ("EZ_HandChams","0", true ,false )
CreateClientConVar ("EZ_NoRecoil","0", true ,false )
CreateClientConVar ("EZ_Aimbot","0", true ,false )
CreateClientConVar ("hitsound","0", true ,false )
CreateClientConVar ("ColoredChams","0", true ,false )
CreateClientConVar ("EZ_Chams","0", true ,false )
CreateClientConVar ("EZ_triggerbot","0", true ,false )
CreateClientConVar ("EZ_head","0", true ,false )
CreateClientConVar ("EZ_AimbotRage","0", true ,false )
CreateClientConVar ("Freecam","0", true ,false )
CreateClientConVar ("Crosshair","0", true ,false )
CreateClientConVar ("EZ_thirdperson","0", true ,false )
CreateClientConVar ("EZ_customfov","0", true ,false )
shouldnamechange = CreateClientConVar("name_change", "0", true, true)
shouldnamechangepreset = CreateClientConVar("name_change_preset", "0", true, true)

local hook = hook
local CreateConVar = CreateConVar
local GetConVarString = GetConVarString
local RunConsoleCommand = RunConsoleCommand
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


local SomeCollapsibleCategory3 = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory3:SetPos( 400,25 )
SomeCollapsibleCategory3:SetSize( 600, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory3:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory3:SetLabel( "Aimbot" )
SomeCollapsibleCategory3.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

local SomeCollapsibleCategory4 = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory4:SetPos( 1000,25 )
SomeCollapsibleCategory4:SetSize( 550, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory4:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory4:SetLabel( "Visuals" )
SomeCollapsibleCategory4.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

local SomeCollapsibleCategory5 = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory5:SetPos( 1550,25 )
SomeCollapsibleCategory5:SetSize( 800, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory5:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory5:SetLabel( "Movement" )
SomeCollapsibleCategory5.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

local SomeCollapsibleCategory = vgui.Create("DCollapsibleCategory", DermaPanel)
SomeCollapsibleCategory:SetPos( 1,25 )
SomeCollapsibleCategory:SetSize( 400, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory:SetLabel( "Misc" )
SomeCollapsibleCategory.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a blue button
end

CategoryList3 = vgui.Create( "DPanelList" )                                      
CategoryList3:SetSpacing( 5 )
CategoryList3:EnableHorizontal( false )
CategoryList3:EnableVerticalScrollbar( true )

CategoryList4 = vgui.Create( "DPanelList" )
CategoryList4:SetAutoSize( true )
CategoryList4:SetSpacing( 5 )
CategoryList4:EnableHorizontal( false )
CategoryList4:EnableVerticalScrollbar( true )
 
CategoryList5 = vgui.Create( "DPanelList" )
CategoryList5:SetAutoSize( true )
CategoryList5:SetSpacing( 5 )
CategoryList5:EnableHorizontal( false )
CategoryList5:EnableVerticalScrollbar( true )

CategoryList = vgui.Create( "DPanelList" )
CategoryList:SetAutoSize( true )
CategoryList:SetSpacing( 5 )
CategoryList:EnableHorizontal( false )
CategoryList:EnableVerticalScrollbar( true )


SomeCollapsibleCategory3:SetContents( CategoryList3 )
SomeCollapsibleCategory4:SetContents( CategoryList4 ) -- Add our list above us as the contents of the collapsible category
SomeCollapsibleCategory5:SetContents( CategoryList5 )
SomeCollapsibleCategory:SetContents( CategoryList )

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
	menu:SetTitle("Valor Hack Alpha | ESP Entity Config")
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
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 50 ) ) -- Draw a red box instead of the frame
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
				local pos = (min+Vector(diff.x*.5, diff.y*.5,diff.z)):ToScreen()
				realboxesp(min, max, diff, v)
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

hook.Add("Think","C+P NoRecoil from gayDaap",function()

if GetConVar("EZ_NoRecoil"):GetInt() == 1 then
if wep.Recoil != 0 then
wep.OldRecoil = wep.Recoil
wep.Recoil = 0
end
if wep.Primary.Recoil != 0 then
wep.Primary.OldRecoil = wep.Primary.Recoil
wep.Primary.Recoil = 0
end
if wep.Secondary.Recoil != 0 then
wep.Secondary.OldRecoil = wep.Secondary.Recoil
wep.Secondary.Recoil = 0
      end
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
    end)

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
 if (GetConVarNumber("EZ_Aimbot") == 1 && GetConVarNumber("EZ_AimbotRage") == 0) then
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

local tp = CreateClientConVar("_thirdperson", "1")

local Thirdperson = function(ply, origin, angles, fov)
   if GetConVarNumber("EZ_thirdperson") == 1 then
	local view = {}
	local active = tp:GetBool()

	view.origin = active and origin - (angles:Forward() * 100) or origin
	view.drawviewer = active

	return view
   end
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
MsgC(Color(0,255,0), "\nWarning: This Project Is Very C+P Heavy")

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

    freecamAngles = Angle()
    freecamAngles2 = Angle()
    freecamPos = Vector()
    freecamEnabled = false
    freecamSpeed = 3
    keyPressed = false
     
    hook.Add("CreateMove", "lock_movement", function(ucmd)
        if(freecamEnabled) then
            ucmd:SetSideMove(0)
            ucmd:SetForwardMove(0)
            ucmd:SetViewAngles(freecamAngles2)
            ucmd:RemoveKey(IN_JUMP)
            ucmd:RemoveKey(IN_DUCK)
            
            freecamAngles = (freecamAngles + Angle(ucmd:GetMouseY() * .023, ucmd:GetMouseX() * -.023, 0));
            freecamAngles.p, freecamAngles.y, freecamAngles.x = math.Clamp(freecamAngles.p, -89, 89), math.NormalizeAngle(freecamAngles.y), math.NormalizeAngle(freecamAngles.x);
     
            local curFreecamSpeed = freecamSpeed
            if(input.IsKeyDown(KEY_LSHIFT)) then
                curFreecamSpeed = freecamSpeed * 2
            end
     
            if(input.IsKeyDown(KEY_W)) then
                freecamPos = freecamPos + (freecamAngles:Forward() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_S)) then
                freecamPos = freecamPos - (freecamAngles:Forward() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_A)) then
                freecamPos = freecamPos - (freecamAngles:Right() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_D)) then
                freecamPos = freecamPos + (freecamAngles:Right() * curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_SPACE)) then
                freecamPos = freecamPos + Vector(0,0,curFreecamSpeed)
            end
            if(input.IsKeyDown(KEY_LCONTROL)) then
                freecamPos = freecamPos - Vector(0,0,curFreecamSpeed)
            end
        end
    end)
     
    hook.Add("Tick", "checkKeybind", function()
     if (GetConVarNumber("Freecam") == 1 && GetConVarNumber("EZ_customfov") == 0) then
        if(input.IsKeyDown(KEY_LALT)) then
            if(!keyPressed) then
                freecamEnabled = !freecamEnabled
                freecamAngles = LocalPlayer():EyeAngles()
                freecamAngles2 = LocalPlayer():EyeAngles()
                freecamPos = LocalPlayer():EyePos()
                keyPressed = true
            end
        else
            keyPressed = false
         end
      end
   end)

    hook.Add("CalcView", "freeCam", function(ply, pos, angles, fov)
        local view = {}
        if(freecamEnabled) then
            view = {
                origin = freecamPos,
                angles = freecamAngles,
                fov = fov,
                drawviewer = true
            }
        else
            view = {
                origin = pos,
                angles = angles,
                fov = fov,
                drawviewer = false
            }
        end
     
    	return view
    end)

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

CreateClientConVar("ChatSpam", 0, true, false)
CreateClientConVar("ChatSpam_DarkRP", 0, true, false)

SpamMessages = {}
SpamMessages[1] = "Project Valor Still Hittin P."
SpamMessages[2] = "Ill Give You My Insta Soon SIMPS!"
SpamMessages[3] = "lol mad?"

local function funnyspam()
	if GetConVarNumber("ChatSpam") == 1 and GetConVarNumber("ChatSpam_DarkRP") == 1 then
		ply:ConCommand("say /ooc "..table.Random(SpamMessages).." " )
	elseif GetConVarNumber("ChatSpam") == 1 then
		ply:ConCommand("say "..table.Random(SpamMessages).." " )
	end
end

timer.Create("chatspamtimer", .25, 0, funnyspam)

    gameevent.Listen("player_hurt")
    local function hitSound(data)
     if GetConVarNumber("hitsound") == 1 then
    	local ply = LocalPlayer()
    	if data.attacker == ply:UserID() then
    		surface.PlaySound("buttons/button17.wav") // name of a sound that exists in gmod
       end
    end
 end
     
    hook.Add("player_hurt", "", hitSound)

    local CategoryContentNine = vgui.Create( "DCheckBoxLabel" )
    CategoryContentNine:SetText( "Legit Aimbot (PLAYER ONLY)" )
    CategoryContentNine:SetConVar( "EZ_Aimbot" )
    CategoryContentNine:SizeToContents()
CategoryList3:AddItem( CategoryContentNine )

    local CategoryContentThreeeee5 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeee5:SetText( "Rage Aimbot (PLAYER ONLY)" )
    CategoryContentThreeeee5:SetConVar( "EZ_AimbotRage" )
    CategoryContentThreeeee5:SizeToContents()
CategoryList3:AddItem( CategoryContentThreeeee5 )

    local CategoryContentNines = vgui.Create( "DCheckBoxLabel" )
    CategoryContentNines:SetText( "Triggerbot (PLAYER ONLY)" )
    CategoryContentNines:SetConVar( "auto" )
    CategoryContentNines:SizeToContents()
CategoryList3:AddItem( CategoryContentNines )

    local CategoryContentElevene = vgui.Create( "DCheckBoxLabel" )
    CategoryContentElevene:SetText( "Randomly Generated Name Changer" )
    CategoryContentElevene:SetConVar( "name_change" )
    CategoryContentElevene:SizeToContents()
CategoryList:AddItem( CategoryContentElevene )

--    local CategoryContentElevene2 = vgui.Create( "DCheckBoxLabel" )
--    CategoryContentElevene2:SetText( "Preset Name Changer" )
--    CategoryContentElevene2:SetConVar( "name_change_preset" )
--    CategoryContentElevene2:SizeToContents()
--CategoryList:AddItem( CategoryContentElevene2 )

    local CategoryContentThreee = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreee:SetText( "Project Valor Watermark" )
    CategoryContentThreee:SetConVar( "E_watermarkezhack" )
    CategoryContentThreee:SizeToContents()
CategoryList:AddItem( CategoryContentThreee )

    local CategoryContentThreeee32 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeee32:SetText( "Auto BHOP" )
    CategoryContentThreeee32:SetConVar( "cpyher_bunnyhop" )
    CategoryContentThreeee32:SizeToContents()
CategoryList5:AddItem( CategoryContentThreeee32 )

    local CategoryContentNines2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentNines2:SetText( "TFA Norecoil" )
    CategoryContentNines2:SetConVar( "EZ_NoRecoil" )
    CategoryContentNines2:SizeToContents()
CategoryList3:AddItem( CategoryContentNines2 )

    local CategoryContentThreeeee6 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeee6:SetText( "Rapid Fire" )
    CategoryContentThreeeee6:SetConVar( "lenny_rapidfire" )
    CategoryContentThreeeee6:SizeToContents()
CategoryList3:AddItem( CategoryContentThreeeee6 )

    local CategoryContentThreeeeee = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee:SetText( "Draw HUD" )
    CategoryContentThreeeeee:SetConVar( "cl_drawhud" )
    CategoryContentThreeeeee:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee )

    local CategoryContentThreeeeee3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee3:SetText( "Chat Spammer" )
    CategoryContentThreeeeee3:SetConVar( "ChatSpam" )
    CategoryContentThreeeeee3:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee3 )

    local CategoryContentThreeeeee32 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee32:SetText( "Dark RP ChatSpam Mode" )
    CategoryContentThreeeeee32:SetConVar( "ChatSpam_DarkRP" )
    CategoryContentThreeeeee32:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee32 )

    local CategoryContentThreeeeee2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee2:SetText( "Flashlight Spammer" )
    CategoryContentThreeeeee2:SetConVar( "FlashlightSpam" )
    CategoryContentThreeeeee2:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee2 )

    local CategoryContentThreeeeee33 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee33:SetText( "Hitsounds" )
    CategoryContentThreeeeee33:SetConVar( "hitsound" )
    CategoryContentThreeeeee33:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee33 )
   
    local CategoryContentThreeeeee25 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee25:SetText( "Rainbow Physgun" )
    CategoryContentThreeeeee25:SetConVar( "rainbowphys" )
    CategoryContentThreeeeee25:SizeToContents()
CategoryList:AddItem( CategoryContentThreeeeee25 )

    local CategoryContentThreeeeeeee = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeeeee:SetText( "Follow Player Bot" )
    CategoryContentThreeeeeeee:SetConVar( "follow" )
    CategoryContentThreeeeeeee:SizeToContents()
CategoryList5:AddItem( CategoryContentThreeeeeeee )

    local CategoryContentThreeeeeeee3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeeeee3:SetText( "Follow Bot Ignore's Team" )
    CategoryContentThreeeeeeee3:SetConVar( "follow_team" )
    CategoryContentThreeeeeeee3:SizeToContents()
CategoryList5:AddItem( CategoryContentThreeeeeeee3 )

    local CategoryContentThreeeeee4 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee4:SetText( "Thirdperson" )
    CategoryContentThreeeeee4:SetConVar( "EZ_thirdperson" )
    CategoryContentThreeeeee4:SizeToContents()
CategoryList4:AddItem( CategoryContentThreeeeee4 )

    local CategoryContentThreeeeee45 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee45:SetText( "Freecam (LEFT ALT)" )
    CategoryContentThreeeeee45:SetConVar( "Freecam" )
    CategoryContentThreeeeee45:SizeToContents()
CategoryList4:AddItem( CategoryContentThreeeeee45 )

    local CategoryContentSixa = vgui.Create( "DNumSlider" )
    CategoryContentSixa:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa:SetText( "Net Graph/Fps Counter" )
    CategoryContentSixa:SetMin( 0 )
    CategoryContentSixa:SetMax( 3 )
    CategoryContentSixa:SetDecimals( 0 )
    CategoryContentSixa:SetConVar( "net_graph" )
CategoryList:AddItem( CategoryContentSixa )

    local CategoryContentThreeeeee45 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreeeeee45:SetText( "Custom FOV" )
    CategoryContentThreeeeee45:SetConVar( "EZ_customfov" )
    CategoryContentThreeeeee45:SizeToContents()
CategoryList4:AddItem( CategoryContentThreeeeee45 )

    local CategoryContentSixa23 = vgui.Create( "DNumSlider" )
    CategoryContentSixa23:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa23:SetText( "FOV Slider" )
    CategoryContentSixa23:SetMin( 54 )
    CategoryContentSixa23:SetMax( 300 )
    CategoryContentSixa23:SetDecimals( 0 )
    CategoryContentSixa23:SetConVar( "cheat_fov" )
CategoryList4:AddItem( CategoryContentSixa23 )

    local CategoryContentThreef3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef3:SetText( "Info ESP" )
    CategoryContentThreef3:SetConVar( "PlayerInfo" )
    CategoryContentThreef3:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef3 )

    local CategoryContentThreef2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef2:SetText( "Prop ESP" )
    CategoryContentThreef2:SetConVar( "PropESP" )
    CategoryContentThreef2:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef2 )

    local CategoryContentThreef = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef:SetText( "Box ESP" )
    CategoryContentThreef:SetConVar( "lenny_esp" )
    CategoryContentThreef:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef )

    local CategoryContentThree = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThree:SetText( "Chams" )
    CategoryContentThree:SetConVar( "EZ_Chams" )
    CategoryContentThree:SizeToContents()
CategoryList4:AddItem( CategoryContentThree )

    local CategoryContentThree3 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThree3:SetText( "Colored Chams (BUGGY)" )
    CategoryContentThree3:SetConVar( "ColoredChams" )
    CategoryContentThree3:SizeToContents()
CategoryList4:AddItem( CategoryContentThree3 )

    local CategoryContentThreef2 = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThreef2:SetText( "Show Players View On ESP" )
    CategoryContentThreef2:SetConVar( "lenny_esp_view" )
    CategoryContentThreef2:SizeToContents()
CategoryList4:AddItem( CategoryContentThreef2 )

    local CategoryContentSixa2 = vgui.Create( "DNumSlider" )
    CategoryContentSixa2:SetSize( 150, 60 ) -- Keep the second number at 50
    CategoryContentSixa2:SetText( "ESP Radius" )
    CategoryContentSixa2:SetMin( 1500 )
    CategoryContentSixa2:SetMax( 10000 )
    CategoryContentSixa2:SetDecimals( 0 )
    CategoryContentSixa2:SetConVar( "lenny_esp_radius" )
CategoryList4:AddItem( CategoryContentSixa2 )

local DermaButton = vgui.Create( "DButton" ) // Create the button and parent it to the frame
DermaButton:SetText( "Box ESP Settings" )					// Set the text on the button
DermaButton:SetPos( 4, 0 )					// Set the position on the frame
DermaButton:SetSize( 150, 30 )	
CategoryList4:AddItem( DermaButton )				// Set the size
DermaButton.DoClick = function()			// A custom function run when clicked ( note the . instead of : )
	RunConsoleCommand("lenny_ents")
end

DermaButton.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 150 ) ) -- Draw a blue button			// Run the console command "say hi" when you click it ( command, args )
end

local DermaButton2 = vgui.Create( "DButton" ) // Create the button and parent it to the frame
DermaButton2:SetText( "Astroux's Profile" )					// Set the text on the button
DermaButton2:SetPos( 4, 0 )					// Set the position on the frame
DermaButton2:SetSize( 150, 30 )	
CategoryList:AddItem( DermaButton2 )				// Set the size
DermaButton2.DoClick = function()			// A custom function run when clicked ( note the . instead of : )
	RunConsoleCommand("profile")
end

DermaButton2.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 1, 1, 1, 150 ) ) -- Draw a blue button			// Run the console command "say hi" when you click it ( command, args )
end





