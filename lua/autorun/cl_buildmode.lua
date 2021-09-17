-- "lua\\autorun\\cl_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if not CLIENT then return end
surface.CreateFont( "BM_Large", {
	font = "Tahoma",
	size =  ScreenScale( 15 ),
	weight = 500
} )
surface.CreateFont( "BM_Medium", {
	font = "Tahoma",
	size =  ScreenScale( 10 ),
	weight = 500
} )
surface.CreateFont( "BM_Small", {
	font = "Tahoma",
	size =  ScreenScale( 7 ),
	weight = 500
} )
local function Buildmode_Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( ScreenScale(200), ScreenScale(200) )
	Frame:SetTitle( "" )
	Frame:ShowCloseButton(true)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 255 ) )
	end
	local function stage2(choice)
		--ChoiceLabel
		--First Label
		if choice == "PVP" then
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("   You have chosen PVP mode.\n  To switch to build mode, type \n                 '!build'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:Center()
		else
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("  You have chosen build mode.\n   To switch to PVP mode, type \n                  '!pvp'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:SetPos(0,ScreenScale(10))
			label_choice:Center()
		end
		--PVP Mode
		local but_close = vgui.Create( "DButton", Frame )
		but_close:SetText( "Close" )
		but_close:SetTextColor( Color( 255, 255, 255 ) )
		but_close:SetFont("BM_Large")
		but_close:SetSize( ScreenScale(100), ScreenScale(30) )
		but_close:SetPos( 0, ScreenScale(150) )
		but_close:CenterHorizontal()
		but_close.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		but_close.DoClick = function()
			Frame:Remove()
		end
		--[[
		local label_build = vgui.Create("DLabel", Frame)
		label_build:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_build:SetTextColor( Color(200,200,200))
		label_build:SetPos(100,50)
		--PVP Label
		local label_pvp = vgui.Create("DLabel", Frame)
		label_pvp:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvp:SetTextColor( Color(200,200,200))
		label_pvp:SetPos(100,50)
		--You Have Chosen Label
		local label_choice = vgui.Create("DLabel", Frame)
		label_choice:SetText("")
		label_choice:SetTextColor( Color(200,200,200))
		label_choice:SetPos(100,50)
		label_choice:SetText("You have chosen Build Mode. However, you may change this at any time by typing '!pvp' in chat.")
		]]
	end
	local function stage1()
		--First Label
		local label_choose = vgui.Create("DLabel", Frame)
		label_choose:SetFont("BM_Medium")
		label_choose:SetText("             Welcome to Hybrid Gaming - Sandbox.\n Please choose which mode you would like to play in. \n                    You can change it later.")
		label_choose:SizeToContents()	
		label_choose:SetTextColor( Color(200,200,200))
		label_choose:SetPos(0,ScreenScale(10))
		label_choose:CenterHorizontal()
		--Build Mode
		local but_build = vgui.Create( "DButton", Frame )
		but_build:SetText( "Build Mode" )
		but_build:SetTextColor( Color( 255, 255, 255 ) )
		but_build:SetFont("BM_Large")
		but_build:SetSize( ScreenScale(100), ScreenScale(30) )
		but_build:SetPos( 0, ScreenScale(70) )
		but_build:CenterHorizontal()
		but_build.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) ) 
		end
		--Build Desc
		local label_builddesc = vgui.Create("DLabel", Frame)
		label_builddesc:SetFont("BM_Small")
		label_builddesc:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_builddesc:SizeToContents()	
		label_builddesc:SetTextColor( Color(200,200,200))
		label_builddesc:SetPos(0,ScreenScale(110))
		label_builddesc:CenterHorizontal()
		--PVP Mode
		local but_pvp = vgui.Create( "DButton", Frame )
		but_pvp:SetText( "PVP Mode" )
		but_pvp:SetTextColor( Color( 255, 255, 255 ) )
		but_pvp:SetFont("BM_Large")
		but_pvp:SetSize( ScreenScale(100), ScreenScale(30) )
		but_pvp:SetPos( 0, ScreenScale(150) )
		but_pvp:CenterHorizontal()
		but_pvp.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		--PVP Desc
		local label_pvpdesc = vgui.Create("DLabel", Frame)
		label_pvpdesc:SetFont("BM_Small")
		label_pvpdesc:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvpdesc:SizeToContents()	
		label_pvpdesc:SetTextColor( Color(200,200,200))
		label_pvpdesc:SetPos(0,ScreenScale(190))
		label_pvpdesc:CenterHorizontal()
		but_build.DoClick = function()
			--SetBuild
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			
			net.Start("InitBuild")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("Build")
		end
		but_pvp.DoClick = function()
			--SetPVP
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			net.Start("InitPVP")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("PVP")
			--Start Timer to close
		end
	end
	stage1()
end

hook.Add("InitPostEntity", "PlayerJoinThing", function()
	local ply = LocalPlayer()
	if ply:IsBot() then	
		net.Start("InitPVP")
		net.WriteEntity(LocalPlayer())
		net.SendToServer()
	else
		net.Start("PlayerJoin")
		net.SendToServer()
		for k, v in pairs(player.GetAll()) do
		end
	end
end)
net.Receive("RightBackAtYou", function(len)
	Buildmode_Menu()
end)
//TITLE SHIT

function DrawNameTitle()
	local textalign = 1
	local distancemulti = 2
	local vStart = LocalPlayer():GetPos()
	local vEnd
	for k, v in pairs(player.GetAll()) do
		local vmode = "Error/Not Loaded In"
		local vtestmode = v:GetNWBool("BuildMode",nil)
		if vtestmode != nil then
			vmode=vtestmode
		end
		if (vmode != LocalPlayer():GetNWBool("BuildMode",nil) or vmode == "Error/Not Loaded In") and v:Alive() then

			local vStart = LocalPlayer():GetPos()
			local vEnd = v:GetPos() + Vector(0,0,40)
			local trace = util.TraceLine( {
				start = vStart,
				endpos = vEnd,
				filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
			} )
			if trace.Entity != NULL then
				--Do nothing!
			else
				local mepos = LocalPlayer():GetPos()
				local tpos = v:GetPos()
				local tdist = mepos:Distance(tpos)
				
				if tdist <= 3000 then
					local zadj = 0.03334 * tdist
					local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
					pos = pos:ToScreen()
					
					local alphavalue = (600 * distancemulti) - (tdist/1.5)
					alphavalue = math.Clamp(alphavalue, 0, 255)
					
					local outlinealpha = (450 * distancemulti) - (tdist/2)
					outlinealpha = math.Clamp(outlinealpha, 0, 255)
					
					
					local playercolour = Color(255,255,255)
					titlefont = "Trebuchet18"
					if v!=LocalPlayer() then
						if vmode == "Error/Not Loaded In" then
							draw.SimpleTextOutlined("ERROR/NOT LOADED IN", titlefont, pos.x, pos.y + 6, Color(255,255,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == true then
							draw.SimpleTextOutlined("BUILD MODE", titlefont, pos.x, pos.y + 6, Color(0,150,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == false then
							draw.SimpleTextOutlined("PVP MODE", titlefont, pos.x, pos.y + 6, Color(255,0,0,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						end
					end
				end
			end
		end
	end
end

net.Receive("CheckBM_Back", function(len,ply)
	local netply = net.ReadEntity()
	local mode = net.ReadBool()
	local netply = Player(netply:UserID())
	--netply.buildmode = mode
end)
timer.Simple(0,function()
	hook.Add("HUDPaint", "DrawNameTitle", DrawNameTitle)
end)

-- "lua\\autorun\\cl_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if not CLIENT then return end
surface.CreateFont( "BM_Large", {
	font = "Tahoma",
	size =  ScreenScale( 15 ),
	weight = 500
} )
surface.CreateFont( "BM_Medium", {
	font = "Tahoma",
	size =  ScreenScale( 10 ),
	weight = 500
} )
surface.CreateFont( "BM_Small", {
	font = "Tahoma",
	size =  ScreenScale( 7 ),
	weight = 500
} )
local function Buildmode_Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( ScreenScale(200), ScreenScale(200) )
	Frame:SetTitle( "" )
	Frame:ShowCloseButton(true)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 255 ) )
	end
	local function stage2(choice)
		--ChoiceLabel
		--First Label
		if choice == "PVP" then
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("   You have chosen PVP mode.\n  To switch to build mode, type \n                 '!build'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:Center()
		else
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("  You have chosen build mode.\n   To switch to PVP mode, type \n                  '!pvp'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:SetPos(0,ScreenScale(10))
			label_choice:Center()
		end
		--PVP Mode
		local but_close = vgui.Create( "DButton", Frame )
		but_close:SetText( "Close" )
		but_close:SetTextColor( Color( 255, 255, 255 ) )
		but_close:SetFont("BM_Large")
		but_close:SetSize( ScreenScale(100), ScreenScale(30) )
		but_close:SetPos( 0, ScreenScale(150) )
		but_close:CenterHorizontal()
		but_close.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		but_close.DoClick = function()
			Frame:Remove()
		end
		--[[
		local label_build = vgui.Create("DLabel", Frame)
		label_build:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_build:SetTextColor( Color(200,200,200))
		label_build:SetPos(100,50)
		--PVP Label
		local label_pvp = vgui.Create("DLabel", Frame)
		label_pvp:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvp:SetTextColor( Color(200,200,200))
		label_pvp:SetPos(100,50)
		--You Have Chosen Label
		local label_choice = vgui.Create("DLabel", Frame)
		label_choice:SetText("")
		label_choice:SetTextColor( Color(200,200,200))
		label_choice:SetPos(100,50)
		label_choice:SetText("You have chosen Build Mode. However, you may change this at any time by typing '!pvp' in chat.")
		]]
	end
	local function stage1()
		--First Label
		local label_choose = vgui.Create("DLabel", Frame)
		label_choose:SetFont("BM_Medium")
		label_choose:SetText("             Welcome to Hybrid Gaming - Sandbox.\n Please choose which mode you would like to play in. \n                    You can change it later.")
		label_choose:SizeToContents()	
		label_choose:SetTextColor( Color(200,200,200))
		label_choose:SetPos(0,ScreenScale(10))
		label_choose:CenterHorizontal()
		--Build Mode
		local but_build = vgui.Create( "DButton", Frame )
		but_build:SetText( "Build Mode" )
		but_build:SetTextColor( Color( 255, 255, 255 ) )
		but_build:SetFont("BM_Large")
		but_build:SetSize( ScreenScale(100), ScreenScale(30) )
		but_build:SetPos( 0, ScreenScale(70) )
		but_build:CenterHorizontal()
		but_build.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) ) 
		end
		--Build Desc
		local label_builddesc = vgui.Create("DLabel", Frame)
		label_builddesc:SetFont("BM_Small")
		label_builddesc:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_builddesc:SizeToContents()	
		label_builddesc:SetTextColor( Color(200,200,200))
		label_builddesc:SetPos(0,ScreenScale(110))
		label_builddesc:CenterHorizontal()
		--PVP Mode
		local but_pvp = vgui.Create( "DButton", Frame )
		but_pvp:SetText( "PVP Mode" )
		but_pvp:SetTextColor( Color( 255, 255, 255 ) )
		but_pvp:SetFont("BM_Large")
		but_pvp:SetSize( ScreenScale(100), ScreenScale(30) )
		but_pvp:SetPos( 0, ScreenScale(150) )
		but_pvp:CenterHorizontal()
		but_pvp.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		--PVP Desc
		local label_pvpdesc = vgui.Create("DLabel", Frame)
		label_pvpdesc:SetFont("BM_Small")
		label_pvpdesc:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvpdesc:SizeToContents()	
		label_pvpdesc:SetTextColor( Color(200,200,200))
		label_pvpdesc:SetPos(0,ScreenScale(190))
		label_pvpdesc:CenterHorizontal()
		but_build.DoClick = function()
			--SetBuild
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			
			net.Start("InitBuild")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("Build")
		end
		but_pvp.DoClick = function()
			--SetPVP
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			net.Start("InitPVP")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("PVP")
			--Start Timer to close
		end
	end
	stage1()
end

hook.Add("InitPostEntity", "PlayerJoinThing", function()
	local ply = LocalPlayer()
	if ply:IsBot() then	
		net.Start("InitPVP")
		net.WriteEntity(LocalPlayer())
		net.SendToServer()
	else
		net.Start("PlayerJoin")
		net.SendToServer()
		for k, v in pairs(player.GetAll()) do
		end
	end
end)
net.Receive("RightBackAtYou", function(len)
	Buildmode_Menu()
end)
//TITLE SHIT

function DrawNameTitle()
	local textalign = 1
	local distancemulti = 2
	local vStart = LocalPlayer():GetPos()
	local vEnd
	for k, v in pairs(player.GetAll()) do
		local vmode = "Error/Not Loaded In"
		local vtestmode = v:GetNWBool("BuildMode",nil)
		if vtestmode != nil then
			vmode=vtestmode
		end
		if (vmode != LocalPlayer():GetNWBool("BuildMode",nil) or vmode == "Error/Not Loaded In") and v:Alive() then

			local vStart = LocalPlayer():GetPos()
			local vEnd = v:GetPos() + Vector(0,0,40)
			local trace = util.TraceLine( {
				start = vStart,
				endpos = vEnd,
				filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
			} )
			if trace.Entity != NULL then
				--Do nothing!
			else
				local mepos = LocalPlayer():GetPos()
				local tpos = v:GetPos()
				local tdist = mepos:Distance(tpos)
				
				if tdist <= 3000 then
					local zadj = 0.03334 * tdist
					local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
					pos = pos:ToScreen()
					
					local alphavalue = (600 * distancemulti) - (tdist/1.5)
					alphavalue = math.Clamp(alphavalue, 0, 255)
					
					local outlinealpha = (450 * distancemulti) - (tdist/2)
					outlinealpha = math.Clamp(outlinealpha, 0, 255)
					
					
					local playercolour = Color(255,255,255)
					titlefont = "Trebuchet18"
					if v!=LocalPlayer() then
						if vmode == "Error/Not Loaded In" then
							draw.SimpleTextOutlined("ERROR/NOT LOADED IN", titlefont, pos.x, pos.y + 6, Color(255,255,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == true then
							draw.SimpleTextOutlined("BUILD MODE", titlefont, pos.x, pos.y + 6, Color(0,150,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == false then
							draw.SimpleTextOutlined("PVP MODE", titlefont, pos.x, pos.y + 6, Color(255,0,0,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						end
					end
				end
			end
		end
	end
end

net.Receive("CheckBM_Back", function(len,ply)
	local netply = net.ReadEntity()
	local mode = net.ReadBool()
	local netply = Player(netply:UserID())
	--netply.buildmode = mode
end)
timer.Simple(0,function()
	hook.Add("HUDPaint", "DrawNameTitle", DrawNameTitle)
end)

-- "lua\\autorun\\cl_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if not CLIENT then return end
surface.CreateFont( "BM_Large", {
	font = "Tahoma",
	size =  ScreenScale( 15 ),
	weight = 500
} )
surface.CreateFont( "BM_Medium", {
	font = "Tahoma",
	size =  ScreenScale( 10 ),
	weight = 500
} )
surface.CreateFont( "BM_Small", {
	font = "Tahoma",
	size =  ScreenScale( 7 ),
	weight = 500
} )
local function Buildmode_Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( ScreenScale(200), ScreenScale(200) )
	Frame:SetTitle( "" )
	Frame:ShowCloseButton(true)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 255 ) )
	end
	local function stage2(choice)
		--ChoiceLabel
		--First Label
		if choice == "PVP" then
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("   You have chosen PVP mode.\n  To switch to build mode, type \n                 '!build'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:Center()
		else
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("  You have chosen build mode.\n   To switch to PVP mode, type \n                  '!pvp'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:SetPos(0,ScreenScale(10))
			label_choice:Center()
		end
		--PVP Mode
		local but_close = vgui.Create( "DButton", Frame )
		but_close:SetText( "Close" )
		but_close:SetTextColor( Color( 255, 255, 255 ) )
		but_close:SetFont("BM_Large")
		but_close:SetSize( ScreenScale(100), ScreenScale(30) )
		but_close:SetPos( 0, ScreenScale(150) )
		but_close:CenterHorizontal()
		but_close.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		but_close.DoClick = function()
			Frame:Remove()
		end
		--[[
		local label_build = vgui.Create("DLabel", Frame)
		label_build:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_build:SetTextColor( Color(200,200,200))
		label_build:SetPos(100,50)
		--PVP Label
		local label_pvp = vgui.Create("DLabel", Frame)
		label_pvp:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvp:SetTextColor( Color(200,200,200))
		label_pvp:SetPos(100,50)
		--You Have Chosen Label
		local label_choice = vgui.Create("DLabel", Frame)
		label_choice:SetText("")
		label_choice:SetTextColor( Color(200,200,200))
		label_choice:SetPos(100,50)
		label_choice:SetText("You have chosen Build Mode. However, you may change this at any time by typing '!pvp' in chat.")
		]]
	end
	local function stage1()
		--First Label
		local label_choose = vgui.Create("DLabel", Frame)
		label_choose:SetFont("BM_Medium")
		label_choose:SetText("             Welcome to Hybrid Gaming - Sandbox.\n Please choose which mode you would like to play in. \n                    You can change it later.")
		label_choose:SizeToContents()	
		label_choose:SetTextColor( Color(200,200,200))
		label_choose:SetPos(0,ScreenScale(10))
		label_choose:CenterHorizontal()
		--Build Mode
		local but_build = vgui.Create( "DButton", Frame )
		but_build:SetText( "Build Mode" )
		but_build:SetTextColor( Color( 255, 255, 255 ) )
		but_build:SetFont("BM_Large")
		but_build:SetSize( ScreenScale(100), ScreenScale(30) )
		but_build:SetPos( 0, ScreenScale(70) )
		but_build:CenterHorizontal()
		but_build.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) ) 
		end
		--Build Desc
		local label_builddesc = vgui.Create("DLabel", Frame)
		label_builddesc:SetFont("BM_Small")
		label_builddesc:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_builddesc:SizeToContents()	
		label_builddesc:SetTextColor( Color(200,200,200))
		label_builddesc:SetPos(0,ScreenScale(110))
		label_builddesc:CenterHorizontal()
		--PVP Mode
		local but_pvp = vgui.Create( "DButton", Frame )
		but_pvp:SetText( "PVP Mode" )
		but_pvp:SetTextColor( Color( 255, 255, 255 ) )
		but_pvp:SetFont("BM_Large")
		but_pvp:SetSize( ScreenScale(100), ScreenScale(30) )
		but_pvp:SetPos( 0, ScreenScale(150) )
		but_pvp:CenterHorizontal()
		but_pvp.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		--PVP Desc
		local label_pvpdesc = vgui.Create("DLabel", Frame)
		label_pvpdesc:SetFont("BM_Small")
		label_pvpdesc:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvpdesc:SizeToContents()	
		label_pvpdesc:SetTextColor( Color(200,200,200))
		label_pvpdesc:SetPos(0,ScreenScale(190))
		label_pvpdesc:CenterHorizontal()
		but_build.DoClick = function()
			--SetBuild
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			
			net.Start("InitBuild")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("Build")
		end
		but_pvp.DoClick = function()
			--SetPVP
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			net.Start("InitPVP")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("PVP")
			--Start Timer to close
		end
	end
	stage1()
end

hook.Add("InitPostEntity", "PlayerJoinThing", function()
	local ply = LocalPlayer()
	if ply:IsBot() then	
		net.Start("InitPVP")
		net.WriteEntity(LocalPlayer())
		net.SendToServer()
	else
		net.Start("PlayerJoin")
		net.SendToServer()
		for k, v in pairs(player.GetAll()) do
		end
	end
end)
net.Receive("RightBackAtYou", function(len)
	Buildmode_Menu()
end)
//TITLE SHIT

function DrawNameTitle()
	local textalign = 1
	local distancemulti = 2
	local vStart = LocalPlayer():GetPos()
	local vEnd
	for k, v in pairs(player.GetAll()) do
		local vmode = "Error/Not Loaded In"
		local vtestmode = v:GetNWBool("BuildMode",nil)
		if vtestmode != nil then
			vmode=vtestmode
		end
		if (vmode != LocalPlayer():GetNWBool("BuildMode",nil) or vmode == "Error/Not Loaded In") and v:Alive() then

			local vStart = LocalPlayer():GetPos()
			local vEnd = v:GetPos() + Vector(0,0,40)
			local trace = util.TraceLine( {
				start = vStart,
				endpos = vEnd,
				filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
			} )
			if trace.Entity != NULL then
				--Do nothing!
			else
				local mepos = LocalPlayer():GetPos()
				local tpos = v:GetPos()
				local tdist = mepos:Distance(tpos)
				
				if tdist <= 3000 then
					local zadj = 0.03334 * tdist
					local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
					pos = pos:ToScreen()
					
					local alphavalue = (600 * distancemulti) - (tdist/1.5)
					alphavalue = math.Clamp(alphavalue, 0, 255)
					
					local outlinealpha = (450 * distancemulti) - (tdist/2)
					outlinealpha = math.Clamp(outlinealpha, 0, 255)
					
					
					local playercolour = Color(255,255,255)
					titlefont = "Trebuchet18"
					if v!=LocalPlayer() then
						if vmode == "Error/Not Loaded In" then
							draw.SimpleTextOutlined("ERROR/NOT LOADED IN", titlefont, pos.x, pos.y + 6, Color(255,255,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == true then
							draw.SimpleTextOutlined("BUILD MODE", titlefont, pos.x, pos.y + 6, Color(0,150,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == false then
							draw.SimpleTextOutlined("PVP MODE", titlefont, pos.x, pos.y + 6, Color(255,0,0,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						end
					end
				end
			end
		end
	end
end

net.Receive("CheckBM_Back", function(len,ply)
	local netply = net.ReadEntity()
	local mode = net.ReadBool()
	local netply = Player(netply:UserID())
	--netply.buildmode = mode
end)
timer.Simple(0,function()
	hook.Add("HUDPaint", "DrawNameTitle", DrawNameTitle)
end)

-- "lua\\autorun\\cl_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if not CLIENT then return end
surface.CreateFont( "BM_Large", {
	font = "Tahoma",
	size =  ScreenScale( 15 ),
	weight = 500
} )
surface.CreateFont( "BM_Medium", {
	font = "Tahoma",
	size =  ScreenScale( 10 ),
	weight = 500
} )
surface.CreateFont( "BM_Small", {
	font = "Tahoma",
	size =  ScreenScale( 7 ),
	weight = 500
} )
local function Buildmode_Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( ScreenScale(200), ScreenScale(200) )
	Frame:SetTitle( "" )
	Frame:ShowCloseButton(true)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 255 ) )
	end
	local function stage2(choice)
		--ChoiceLabel
		--First Label
		if choice == "PVP" then
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("   You have chosen PVP mode.\n  To switch to build mode, type \n                 '!build'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:Center()
		else
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("  You have chosen build mode.\n   To switch to PVP mode, type \n                  '!pvp'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:SetPos(0,ScreenScale(10))
			label_choice:Center()
		end
		--PVP Mode
		local but_close = vgui.Create( "DButton", Frame )
		but_close:SetText( "Close" )
		but_close:SetTextColor( Color( 255, 255, 255 ) )
		but_close:SetFont("BM_Large")
		but_close:SetSize( ScreenScale(100), ScreenScale(30) )
		but_close:SetPos( 0, ScreenScale(150) )
		but_close:CenterHorizontal()
		but_close.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		but_close.DoClick = function()
			Frame:Remove()
		end
		--[[
		local label_build = vgui.Create("DLabel", Frame)
		label_build:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_build:SetTextColor( Color(200,200,200))
		label_build:SetPos(100,50)
		--PVP Label
		local label_pvp = vgui.Create("DLabel", Frame)
		label_pvp:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvp:SetTextColor( Color(200,200,200))
		label_pvp:SetPos(100,50)
		--You Have Chosen Label
		local label_choice = vgui.Create("DLabel", Frame)
		label_choice:SetText("")
		label_choice:SetTextColor( Color(200,200,200))
		label_choice:SetPos(100,50)
		label_choice:SetText("You have chosen Build Mode. However, you may change this at any time by typing '!pvp' in chat.")
		]]
	end
	local function stage1()
		--First Label
		local label_choose = vgui.Create("DLabel", Frame)
		label_choose:SetFont("BM_Medium")
		label_choose:SetText("             Welcome to Hybrid Gaming - Sandbox.\n Please choose which mode you would like to play in. \n                    You can change it later.")
		label_choose:SizeToContents()	
		label_choose:SetTextColor( Color(200,200,200))
		label_choose:SetPos(0,ScreenScale(10))
		label_choose:CenterHorizontal()
		--Build Mode
		local but_build = vgui.Create( "DButton", Frame )
		but_build:SetText( "Build Mode" )
		but_build:SetTextColor( Color( 255, 255, 255 ) )
		but_build:SetFont("BM_Large")
		but_build:SetSize( ScreenScale(100), ScreenScale(30) )
		but_build:SetPos( 0, ScreenScale(70) )
		but_build:CenterHorizontal()
		but_build.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) ) 
		end
		--Build Desc
		local label_builddesc = vgui.Create("DLabel", Frame)
		label_builddesc:SetFont("BM_Small")
		label_builddesc:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_builddesc:SizeToContents()	
		label_builddesc:SetTextColor( Color(200,200,200))
		label_builddesc:SetPos(0,ScreenScale(110))
		label_builddesc:CenterHorizontal()
		--PVP Mode
		local but_pvp = vgui.Create( "DButton", Frame )
		but_pvp:SetText( "PVP Mode" )
		but_pvp:SetTextColor( Color( 255, 255, 255 ) )
		but_pvp:SetFont("BM_Large")
		but_pvp:SetSize( ScreenScale(100), ScreenScale(30) )
		but_pvp:SetPos( 0, ScreenScale(150) )
		but_pvp:CenterHorizontal()
		but_pvp.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		--PVP Desc
		local label_pvpdesc = vgui.Create("DLabel", Frame)
		label_pvpdesc:SetFont("BM_Small")
		label_pvpdesc:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvpdesc:SizeToContents()	
		label_pvpdesc:SetTextColor( Color(200,200,200))
		label_pvpdesc:SetPos(0,ScreenScale(190))
		label_pvpdesc:CenterHorizontal()
		but_build.DoClick = function()
			--SetBuild
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			
			net.Start("InitBuild")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("Build")
		end
		but_pvp.DoClick = function()
			--SetPVP
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			net.Start("InitPVP")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("PVP")
			--Start Timer to close
		end
	end
	stage1()
end

hook.Add("InitPostEntity", "PlayerJoinThing", function()
	local ply = LocalPlayer()
	if ply:IsBot() then	
		net.Start("InitPVP")
		net.WriteEntity(LocalPlayer())
		net.SendToServer()
	else
		net.Start("PlayerJoin")
		net.SendToServer()
		for k, v in pairs(player.GetAll()) do
		end
	end
end)
net.Receive("RightBackAtYou", function(len)
	Buildmode_Menu()
end)
//TITLE SHIT

function DrawNameTitle()
	local textalign = 1
	local distancemulti = 2
	local vStart = LocalPlayer():GetPos()
	local vEnd
	for k, v in pairs(player.GetAll()) do
		local vmode = "Error/Not Loaded In"
		local vtestmode = v:GetNWBool("BuildMode",nil)
		if vtestmode != nil then
			vmode=vtestmode
		end
		if (vmode != LocalPlayer():GetNWBool("BuildMode",nil) or vmode == "Error/Not Loaded In") and v:Alive() then

			local vStart = LocalPlayer():GetPos()
			local vEnd = v:GetPos() + Vector(0,0,40)
			local trace = util.TraceLine( {
				start = vStart,
				endpos = vEnd,
				filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
			} )
			if trace.Entity != NULL then
				--Do nothing!
			else
				local mepos = LocalPlayer():GetPos()
				local tpos = v:GetPos()
				local tdist = mepos:Distance(tpos)
				
				if tdist <= 3000 then
					local zadj = 0.03334 * tdist
					local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
					pos = pos:ToScreen()
					
					local alphavalue = (600 * distancemulti) - (tdist/1.5)
					alphavalue = math.Clamp(alphavalue, 0, 255)
					
					local outlinealpha = (450 * distancemulti) - (tdist/2)
					outlinealpha = math.Clamp(outlinealpha, 0, 255)
					
					
					local playercolour = Color(255,255,255)
					titlefont = "Trebuchet18"
					if v!=LocalPlayer() then
						if vmode == "Error/Not Loaded In" then
							draw.SimpleTextOutlined("ERROR/NOT LOADED IN", titlefont, pos.x, pos.y + 6, Color(255,255,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == true then
							draw.SimpleTextOutlined("BUILD MODE", titlefont, pos.x, pos.y + 6, Color(0,150,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == false then
							draw.SimpleTextOutlined("PVP MODE", titlefont, pos.x, pos.y + 6, Color(255,0,0,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						end
					end
				end
			end
		end
	end
end

net.Receive("CheckBM_Back", function(len,ply)
	local netply = net.ReadEntity()
	local mode = net.ReadBool()
	local netply = Player(netply:UserID())
	--netply.buildmode = mode
end)
timer.Simple(0,function()
	hook.Add("HUDPaint", "DrawNameTitle", DrawNameTitle)
end)

-- "lua\\autorun\\cl_buildmode.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
if not CLIENT then return end
surface.CreateFont( "BM_Large", {
	font = "Tahoma",
	size =  ScreenScale( 15 ),
	weight = 500
} )
surface.CreateFont( "BM_Medium", {
	font = "Tahoma",
	size =  ScreenScale( 10 ),
	weight = 500
} )
surface.CreateFont( "BM_Small", {
	font = "Tahoma",
	size =  ScreenScale( 7 ),
	weight = 500
} )
local function Buildmode_Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( ScreenScale(200), ScreenScale(200) )
	Frame:SetTitle( "" )
	Frame:ShowCloseButton(true)
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 255 ) )
	end
	local function stage2(choice)
		--ChoiceLabel
		--First Label
		if choice == "PVP" then
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("   You have chosen PVP mode.\n  To switch to build mode, type \n                 '!build'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:Center()
		else
			local label_choice = vgui.Create("DLabel", Frame)
			label_choice:SetFont("BM_Medium")
			label_choice:SetText("  You have chosen build mode.\n   To switch to PVP mode, type \n                  '!pvp'\n                 in chat.")
			label_choice:SizeToContents()	
			label_choice:SetTextColor( Color(200,200,200))
			label_choice:SetPos(0,ScreenScale(10))
			label_choice:Center()
		end
		--PVP Mode
		local but_close = vgui.Create( "DButton", Frame )
		but_close:SetText( "Close" )
		but_close:SetTextColor( Color( 255, 255, 255 ) )
		but_close:SetFont("BM_Large")
		but_close:SetSize( ScreenScale(100), ScreenScale(30) )
		but_close:SetPos( 0, ScreenScale(150) )
		but_close:CenterHorizontal()
		but_close.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		but_close.DoClick = function()
			Frame:Remove()
		end
		--[[
		local label_build = vgui.Create("DLabel", Frame)
		label_build:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_build:SetTextColor( Color(200,200,200))
		label_build:SetPos(100,50)
		--PVP Label
		local label_pvp = vgui.Create("DLabel", Frame)
		label_pvp:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvp:SetTextColor( Color(200,200,200))
		label_pvp:SetPos(100,50)
		--You Have Chosen Label
		local label_choice = vgui.Create("DLabel", Frame)
		label_choice:SetText("")
		label_choice:SetTextColor( Color(200,200,200))
		label_choice:SetPos(100,50)
		label_choice:SetText("You have chosen Build Mode. However, you may change this at any time by typing '!pvp' in chat.")
		]]
	end
	local function stage1()
		--First Label
		local label_choose = vgui.Create("DLabel", Frame)
		label_choose:SetFont("BM_Medium")
		label_choose:SetText("             Welcome to Hybrid Gaming - Sandbox.\n Please choose which mode you would like to play in. \n                    You can change it later.")
		label_choose:SizeToContents()	
		label_choose:SetTextColor( Color(200,200,200))
		label_choose:SetPos(0,ScreenScale(10))
		label_choose:CenterHorizontal()
		--Build Mode
		local but_build = vgui.Create( "DButton", Frame )
		but_build:SetText( "Build Mode" )
		but_build:SetTextColor( Color( 255, 255, 255 ) )
		but_build:SetFont("BM_Large")
		but_build:SetSize( ScreenScale(100), ScreenScale(30) )
		but_build:SetPos( 0, ScreenScale(70) )
		but_build:CenterHorizontal()
		but_build.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) ) 
		end
		--Build Desc
		local label_builddesc = vgui.Create("DLabel", Frame)
		label_builddesc:SetFont("BM_Small")
		label_builddesc:SetText("Build mode give you god mode and prevents you from hurting other players.")
		label_builddesc:SizeToContents()	
		label_builddesc:SetTextColor( Color(200,200,200))
		label_builddesc:SetPos(0,ScreenScale(110))
		label_builddesc:CenterHorizontal()
		--PVP Mode
		local but_pvp = vgui.Create( "DButton", Frame )
		but_pvp:SetText( "PVP Mode" )
		but_pvp:SetTextColor( Color( 255, 255, 255 ) )
		but_pvp:SetFont("BM_Large")
		but_pvp:SetSize( ScreenScale(100), ScreenScale(30) )
		but_pvp:SetPos( 0, ScreenScale(150) )
		but_pvp:CenterHorizontal()
		but_pvp.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 255 ) )
		end
		--PVP Desc
		local label_pvpdesc = vgui.Create("DLabel", Frame)
		label_pvpdesc:SetFont("BM_Small")
		label_pvpdesc:SetText("PVP mode allows you to hurt and be hurt.")
		label_pvpdesc:SizeToContents()	
		label_pvpdesc:SetTextColor( Color(200,200,200))
		label_pvpdesc:SetPos(0,ScreenScale(190))
		label_pvpdesc:CenterHorizontal()
		but_build.DoClick = function()
			--SetBuild
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			
			net.Start("InitBuild")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("Build")
		end
		but_pvp.DoClick = function()
			--SetPVP
			label_choose:Remove()
			label_pvpdesc:Remove()
			label_builddesc:Remove()
			but_build:Remove()
			but_pvp:Remove()
			net.Start("InitPVP")
			net.WriteEntity(LocalPlayer())
			net.SendToServer()
			stage2("PVP")
			--Start Timer to close
		end
	end
	stage1()
end

hook.Add("InitPostEntity", "PlayerJoinThing", function()
	local ply = LocalPlayer()
	if ply:IsBot() then	
		net.Start("InitPVP")
		net.WriteEntity(LocalPlayer())
		net.SendToServer()
	else
		net.Start("PlayerJoin")
		net.SendToServer()
		for k, v in pairs(player.GetAll()) do
		end
	end
end)
net.Receive("RightBackAtYou", function(len)
	Buildmode_Menu()
end)
//TITLE SHIT

function DrawNameTitle()
	local textalign = 1
	local distancemulti = 2
	local vStart = LocalPlayer():GetPos()
	local vEnd
	for k, v in pairs(player.GetAll()) do
		local vmode = "Error/Not Loaded In"
		local vtestmode = v:GetNWBool("BuildMode",nil)
		if vtestmode != nil then
			vmode=vtestmode
		end
		if (vmode != LocalPlayer():GetNWBool("BuildMode",nil) or vmode == "Error/Not Loaded In") and v:Alive() then

			local vStart = LocalPlayer():GetPos()
			local vEnd = v:GetPos() + Vector(0,0,40)
			local trace = util.TraceLine( {
				start = vStart,
				endpos = vEnd,
				filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return true end end
			} )
			if trace.Entity != NULL then
				--Do nothing!
			else
				local mepos = LocalPlayer():GetPos()
				local tpos = v:GetPos()
				local tdist = mepos:Distance(tpos)
				
				if tdist <= 3000 then
					local zadj = 0.03334 * tdist
					local pos = v:GetPos() + Vector(0,0,v:OBBMaxs().z + 5 + zadj)
					pos = pos:ToScreen()
					
					local alphavalue = (600 * distancemulti) - (tdist/1.5)
					alphavalue = math.Clamp(alphavalue, 0, 255)
					
					local outlinealpha = (450 * distancemulti) - (tdist/2)
					outlinealpha = math.Clamp(outlinealpha, 0, 255)
					
					
					local playercolour = Color(255,255,255)
					titlefont = "Trebuchet18"
					if v!=LocalPlayer() then
						if vmode == "Error/Not Loaded In" then
							draw.SimpleTextOutlined("ERROR/NOT LOADED IN", titlefont, pos.x, pos.y + 6, Color(255,255,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == true then
							draw.SimpleTextOutlined("BUILD MODE", titlefont, pos.x, pos.y + 6, Color(0,150,255,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						elseif vmode == false then
							draw.SimpleTextOutlined("PVP MODE", titlefont, pos.x, pos.y + 6, Color(255,0,0,alphavalue),textalign,1,1,Color(0,0,0,outlinealpha))
						end
					end
				end
			end
		end
	end
end

net.Receive("CheckBM_Back", function(len,ply)
	local netply = net.ReadEntity()
	local mode = net.ReadBool()
	local netply = Player(netply:UserID())
	--netply.buildmode = mode
end)
timer.Simple(0,function()
	hook.Add("HUDPaint", "DrawNameTitle", DrawNameTitle)
end)

