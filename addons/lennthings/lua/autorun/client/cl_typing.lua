-- "addons\\lennthings\\lua\\autorun\\client\\cl_typing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local admin_only = false // are only admins allowed to see the typing?
local disabled_slash_noview = false // if they use / or ! in the beginning, it wont render.

hook.Add( "ChatTextChanged", "sendMessageTyping", function( text )
	if ( !LocalPlayer():Alive() ) then return end
	
	net.Start( "rayCollectRealChat" )
		net.WriteString( text )
	net.SendToServer()
end )

net.Receive("rayStreamChatMessage", function()
	local str = net.ReadString()
	local ent = net.ReadEntity()
	
	ent.real_chat = string.sub( str, 0, 60 )
end )

surface.CreateFont("HUDTypingText", {
	font = "Roboto",
	size = 35,
	weight = 800,
	antialias = true,
} )

local offset = Vector( 0, 0, 75 )
local mat_type = Material("icon16/comment.png")

hook.Add( "PostPlayerDraw", "drawChatOverheadRay", function( ply )
	if ( !IsValid( ply ) or !ply.real_chat or !IsValid( LocalPlayer() ) ) then return end

	if ( admin_only ) then
		if ( !LocalPlayer():IsAdmin() ) then
			return
		end
	end
	
	if ( !ply:Alive() or !ply:IsTyping() ) then
		ply.real_chat = nil
		return
	end
	
	if ( disabled_slash_noview ) then
		local str = string.Left( ply.real_chat, 1 )
		
		if ( str == "/" or str == "!" or str == "@" ) then
			return
		end	
	end
	
	if ( LocalPlayer():GetPos():Distance( ply:GetPos() ) > 300 ) then
		return
	end

	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local new_txt = ply.real_chat
	
	surface.SetFont( "HUDTypingText" )
	local tW, tH = surface.GetTextSize( new_txt )
	
	local pad = 8
	
	tW = tW + 47
	
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )
		draw.RoundedBox( 4, -(tW/2) - pad, 0 - pad, tW + (pad*2), tH + (pad*2), Color( 0, 0, 0, 100 ) )
		draw.SimpleText( new_txt, "HUDTypingText", 15, 0, Color( 250, 250, 250 ), TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat_type )
		surface.DrawTexturedRect( -(tW/2), 4, 32, 32 )
	cam.End3D2D()
end )

-- "addons\\lennthings\\lua\\autorun\\client\\cl_typing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local admin_only = false // are only admins allowed to see the typing?
local disabled_slash_noview = false // if they use / or ! in the beginning, it wont render.

hook.Add( "ChatTextChanged", "sendMessageTyping", function( text )
	if ( !LocalPlayer():Alive() ) then return end
	
	net.Start( "rayCollectRealChat" )
		net.WriteString( text )
	net.SendToServer()
end )

net.Receive("rayStreamChatMessage", function()
	local str = net.ReadString()
	local ent = net.ReadEntity()
	
	ent.real_chat = string.sub( str, 0, 60 )
end )

surface.CreateFont("HUDTypingText", {
	font = "Roboto",
	size = 35,
	weight = 800,
	antialias = true,
} )

local offset = Vector( 0, 0, 75 )
local mat_type = Material("icon16/comment.png")

hook.Add( "PostPlayerDraw", "drawChatOverheadRay", function( ply )
	if ( !IsValid( ply ) or !ply.real_chat or !IsValid( LocalPlayer() ) ) then return end

	if ( admin_only ) then
		if ( !LocalPlayer():IsAdmin() ) then
			return
		end
	end
	
	if ( !ply:Alive() or !ply:IsTyping() ) then
		ply.real_chat = nil
		return
	end
	
	if ( disabled_slash_noview ) then
		local str = string.Left( ply.real_chat, 1 )
		
		if ( str == "/" or str == "!" or str == "@" ) then
			return
		end	
	end
	
	if ( LocalPlayer():GetPos():Distance( ply:GetPos() ) > 300 ) then
		return
	end

	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local new_txt = ply.real_chat
	
	surface.SetFont( "HUDTypingText" )
	local tW, tH = surface.GetTextSize( new_txt )
	
	local pad = 8
	
	tW = tW + 47
	
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )
		draw.RoundedBox( 4, -(tW/2) - pad, 0 - pad, tW + (pad*2), tH + (pad*2), Color( 0, 0, 0, 100 ) )
		draw.SimpleText( new_txt, "HUDTypingText", 15, 0, Color( 250, 250, 250 ), TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat_type )
		surface.DrawTexturedRect( -(tW/2), 4, 32, 32 )
	cam.End3D2D()
end )

-- "addons\\lennthings\\lua\\autorun\\client\\cl_typing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local admin_only = false // are only admins allowed to see the typing?
local disabled_slash_noview = false // if they use / or ! in the beginning, it wont render.

hook.Add( "ChatTextChanged", "sendMessageTyping", function( text )
	if ( !LocalPlayer():Alive() ) then return end
	
	net.Start( "rayCollectRealChat" )
		net.WriteString( text )
	net.SendToServer()
end )

net.Receive("rayStreamChatMessage", function()
	local str = net.ReadString()
	local ent = net.ReadEntity()
	
	ent.real_chat = string.sub( str, 0, 60 )
end )

surface.CreateFont("HUDTypingText", {
	font = "Roboto",
	size = 35,
	weight = 800,
	antialias = true,
} )

local offset = Vector( 0, 0, 75 )
local mat_type = Material("icon16/comment.png")

hook.Add( "PostPlayerDraw", "drawChatOverheadRay", function( ply )
	if ( !IsValid( ply ) or !ply.real_chat or !IsValid( LocalPlayer() ) ) then return end

	if ( admin_only ) then
		if ( !LocalPlayer():IsAdmin() ) then
			return
		end
	end
	
	if ( !ply:Alive() or !ply:IsTyping() ) then
		ply.real_chat = nil
		return
	end
	
	if ( disabled_slash_noview ) then
		local str = string.Left( ply.real_chat, 1 )
		
		if ( str == "/" or str == "!" or str == "@" ) then
			return
		end	
	end
	
	if ( LocalPlayer():GetPos():Distance( ply:GetPos() ) > 300 ) then
		return
	end

	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local new_txt = ply.real_chat
	
	surface.SetFont( "HUDTypingText" )
	local tW, tH = surface.GetTextSize( new_txt )
	
	local pad = 8
	
	tW = tW + 47
	
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )
		draw.RoundedBox( 4, -(tW/2) - pad, 0 - pad, tW + (pad*2), tH + (pad*2), Color( 0, 0, 0, 100 ) )
		draw.SimpleText( new_txt, "HUDTypingText", 15, 0, Color( 250, 250, 250 ), TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat_type )
		surface.DrawTexturedRect( -(tW/2), 4, 32, 32 )
	cam.End3D2D()
end )

-- "addons\\lennthings\\lua\\autorun\\client\\cl_typing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local admin_only = false // are only admins allowed to see the typing?
local disabled_slash_noview = false // if they use / or ! in the beginning, it wont render.

hook.Add( "ChatTextChanged", "sendMessageTyping", function( text )
	if ( !LocalPlayer():Alive() ) then return end
	
	net.Start( "rayCollectRealChat" )
		net.WriteString( text )
	net.SendToServer()
end )

net.Receive("rayStreamChatMessage", function()
	local str = net.ReadString()
	local ent = net.ReadEntity()
	
	ent.real_chat = string.sub( str, 0, 60 )
end )

surface.CreateFont("HUDTypingText", {
	font = "Roboto",
	size = 35,
	weight = 800,
	antialias = true,
} )

local offset = Vector( 0, 0, 75 )
local mat_type = Material("icon16/comment.png")

hook.Add( "PostPlayerDraw", "drawChatOverheadRay", function( ply )
	if ( !IsValid( ply ) or !ply.real_chat or !IsValid( LocalPlayer() ) ) then return end

	if ( admin_only ) then
		if ( !LocalPlayer():IsAdmin() ) then
			return
		end
	end
	
	if ( !ply:Alive() or !ply:IsTyping() ) then
		ply.real_chat = nil
		return
	end
	
	if ( disabled_slash_noview ) then
		local str = string.Left( ply.real_chat, 1 )
		
		if ( str == "/" or str == "!" or str == "@" ) then
			return
		end	
	end
	
	if ( LocalPlayer():GetPos():Distance( ply:GetPos() ) > 300 ) then
		return
	end

	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local new_txt = ply.real_chat
	
	surface.SetFont( "HUDTypingText" )
	local tW, tH = surface.GetTextSize( new_txt )
	
	local pad = 8
	
	tW = tW + 47
	
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )
		draw.RoundedBox( 4, -(tW/2) - pad, 0 - pad, tW + (pad*2), tH + (pad*2), Color( 0, 0, 0, 100 ) )
		draw.SimpleText( new_txt, "HUDTypingText", 15, 0, Color( 250, 250, 250 ), TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat_type )
		surface.DrawTexturedRect( -(tW/2), 4, 32, 32 )
	cam.End3D2D()
end )

-- "addons\\lennthings\\lua\\autorun\\client\\cl_typing.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local admin_only = false // are only admins allowed to see the typing?
local disabled_slash_noview = false // if they use / or ! in the beginning, it wont render.

hook.Add( "ChatTextChanged", "sendMessageTyping", function( text )
	if ( !LocalPlayer():Alive() ) then return end
	
	net.Start( "rayCollectRealChat" )
		net.WriteString( text )
	net.SendToServer()
end )

net.Receive("rayStreamChatMessage", function()
	local str = net.ReadString()
	local ent = net.ReadEntity()
	
	ent.real_chat = string.sub( str, 0, 60 )
end )

surface.CreateFont("HUDTypingText", {
	font = "Roboto",
	size = 35,
	weight = 800,
	antialias = true,
} )

local offset = Vector( 0, 0, 75 )
local mat_type = Material("icon16/comment.png")

hook.Add( "PostPlayerDraw", "drawChatOverheadRay", function( ply )
	if ( !IsValid( ply ) or !ply.real_chat or !IsValid( LocalPlayer() ) ) then return end

	if ( admin_only ) then
		if ( !LocalPlayer():IsAdmin() ) then
			return
		end
	end
	
	if ( !ply:Alive() or !ply:IsTyping() ) then
		ply.real_chat = nil
		return
	end
	
	if ( disabled_slash_noview ) then
		local str = string.Left( ply.real_chat, 1 )
		
		if ( str == "/" or str == "!" or str == "@" ) then
			return
		end	
	end
	
	if ( LocalPlayer():GetPos():Distance( ply:GetPos() ) > 300 ) then
		return
	end

	local ang = LocalPlayer():EyeAngles()
	local pos = ply:GetPos() + offset + ang:Up()

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local new_txt = ply.real_chat
	
	surface.SetFont( "HUDTypingText" )
	local tW, tH = surface.GetTextSize( new_txt )
	
	local pad = 8
	
	tW = tW + 47
	
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )
		draw.RoundedBox( 4, -(tW/2) - pad, 0 - pad, tW + (pad*2), tH + (pad*2), Color( 0, 0, 0, 100 ) )
		draw.SimpleText( new_txt, "HUDTypingText", 15, 0, Color( 250, 250, 250 ), TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor( 255, 255, 255 )
		surface.SetMaterial( mat_type )
		surface.DrawTexturedRect( -(tW/2), 4, 32, 32 )
	cam.End3D2D()
end )

