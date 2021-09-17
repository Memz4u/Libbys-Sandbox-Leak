-- "lua\\autorun\\client\\cl_jumpgame.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

if SERVER then
	print("Error. Client file ran on the server.")
	return
end

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathabs = math.abs
local Loaded = false
local ScoreList = {}
ScoreList = {

}
local MyScore = 100
local NextToBeat = {"[error]",0}
net.Receive( "NaksJumpGame", function( len )
	local msg = net.ReadString()
	if msg == "UpdateScore" then
		table.Empty(ScoreList)
		local n = net.ReadFloat()
		for I=1,n do
			local points = net.ReadFloat()
			local name = net.ReadString()
			local steamid = net.ReadString()
			table.insert(ScoreList,{points,name,steamid})
		end
	elseif msg == "SpawnMessage" then
		local text = net.ReadString()
		notification.AddLegacy( text, NOTIFY_ERROR, 3 )
		surface.PlaySound( "buttons/button15.wav" )
		MsgN(text)
	end
end)

local GetJBlist = {}
timer.Create("GetJBlist", 2, 0, function()
	GetJBlist = ents.FindByClass("ent_jumpgame")
end)
timer.Simple(4,function()
	if !Loaded then
		Loaded = true
		net.Start("NaksJumpGame")
			net.WriteString("UpdateScore")
		net.SendToServer()
	end
end)

local function FindNearestScore(myscore,ply)
	if !ply or !myscore then return {-1,"",""} end
	if table.Count(ScoreList)<1 then return {-1,"",""} end
	for I=#ScoreList,1,-1 do
		if ScoreList[I][1]>myscore then
			return ScoreList[I]
		end
	end
	return {myscore,"You",ply:SteamID()}
end

local filterfun = function( ent ) 
	if ( ent:GetClass() == "prop_physics" and !ent.JumpGamePlatForm ) then 
		return true
	elseif ent:GetClass()=="Player" then
		return false
	elseif ent:GetClass()=="prop_dynamic" then
		return false
	end 
end

local function potato(pos,self,min,max)
	local tr = util.TraceHull( {
		start = pos, 
		endpos = pos, 
		mins = min, 
		maxs = max, 
		filter = filterfun
	} )
	return !tr.Hit
end



hook.Add("PostDrawTranslucentRenderables","JGHUD",function(depth,skybox)
	if skybox then return end --duuuurr
	if !IsValid(LocalPlayer()) then return end

	local pl = player.GetAll()
	for I=1,#pl do
		local ply = pl[I]
		if ply:GetPos():Distance(LocalPlayer():GetPos())<1000 then
			local points = ply:GetNWFloat("JBScore",0)
			
			if points>0 then
				local pos = ply:GetShootPos()+ply:EyeAngles():Forward()*(50+maths(SysTime()/3)*4)+ply:EyeAngles():Right()*-40+ply:EyeAngles():Up()*10
				local ang = Angle(maths(SysTime()/2),ply:GetAngles().yaw-90+maths(SysTime()/1.4),-ply:EyeAngles().p+90)
				if !IsValid(ply.JGHUDAvatar) then
					local Avatar = vgui.Create( "AvatarImage" )
					ply.JGHUDAvatar = Avatar
					Avatar:SetSize( 1, 1)
					Avatar:SetPos( 20, 120 )
					ply.JGLastScoreList = ""
				end

				cam.Start3D2D(pos,ang,0.05)
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextColor(Color(200,200,255))
					surface.DrawRect(0,0,360,200)
					surface.SetFont("Jump_Game_Small")
					surface.SetTextPos(50,0)
					surface.DrawText("Jump Game")
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextPos(-surface.GetTextSize(points)/2+180,50)
					surface.DrawText(points)
					if table.Count(ScoreList)>0 then
						local nextscore = FindNearestScore(points,ply)
						if nextscore[1]<0 then
							-- No data
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextColor(Color(200,200,255,155+100*maths(SysTime())))
							surface.SetTextPos(180-surface.GetTextSize("No data")/2,120)
							surface.DrawText("No data")
						else
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextPos(100,150)
							surface.DrawText(nextscore[1])
							if nextscore[2]=="You" then
								surface.SetTextPos(100+mathabs(maths(SysTime()*1.4)*16),120)
								surface.SetTextColor(Color(255,255,0))
							else
								surface.SetTextPos(100,120)
							end
							surface.DrawText(nextscore[2])
							if IsValid(ply.JGHUDAvatar) then
								ply.JGHUDAvatar:SetSize( 64, 64)
								ply.JGHUDAvatar:PaintManual()
								ply.JGHUDAvatar:SetSize( 1, 1)
								if ply.JGLastScoreList != nextscore[3] then
									ply:EmitSound("buttons/button17.wav")
									ply.JGLastScoreList = nextscore[3]
									ply.JGHUDAvatar:SetSteamID(util.SteamIDTo64( nextscore[3] or "") or 0,64)
								end
							end
						end
					end
				cam.End3D2D()
			else
				if IsValid(ply.JGHUDAvatar) then
					ply.JGHUDAvatar:Remove()
				end
			end
		else
			if IsValid(ply.JGHUDAvatar) then
				ply.JGHUDAvatar:Remove()
			end
		end
	end

end)

function GetJumpGameScore()
	return ScoreList
end

-- "lua\\autorun\\client\\cl_jumpgame.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

if SERVER then
	print("Error. Client file ran on the server.")
	return
end

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathabs = math.abs
local Loaded = false
local ScoreList = {}
ScoreList = {

}
local MyScore = 100
local NextToBeat = {"[error]",0}
net.Receive( "NaksJumpGame", function( len )
	local msg = net.ReadString()
	if msg == "UpdateScore" then
		table.Empty(ScoreList)
		local n = net.ReadFloat()
		for I=1,n do
			local points = net.ReadFloat()
			local name = net.ReadString()
			local steamid = net.ReadString()
			table.insert(ScoreList,{points,name,steamid})
		end
	elseif msg == "SpawnMessage" then
		local text = net.ReadString()
		notification.AddLegacy( text, NOTIFY_ERROR, 3 )
		surface.PlaySound( "buttons/button15.wav" )
		MsgN(text)
	end
end)

local GetJBlist = {}
timer.Create("GetJBlist", 2, 0, function()
	GetJBlist = ents.FindByClass("ent_jumpgame")
end)
timer.Simple(4,function()
	if !Loaded then
		Loaded = true
		net.Start("NaksJumpGame")
			net.WriteString("UpdateScore")
		net.SendToServer()
	end
end)

local function FindNearestScore(myscore,ply)
	if !ply or !myscore then return {-1,"",""} end
	if table.Count(ScoreList)<1 then return {-1,"",""} end
	for I=#ScoreList,1,-1 do
		if ScoreList[I][1]>myscore then
			return ScoreList[I]
		end
	end
	return {myscore,"You",ply:SteamID()}
end

local filterfun = function( ent ) 
	if ( ent:GetClass() == "prop_physics" and !ent.JumpGamePlatForm ) then 
		return true
	elseif ent:GetClass()=="Player" then
		return false
	elseif ent:GetClass()=="prop_dynamic" then
		return false
	end 
end

local function potato(pos,self,min,max)
	local tr = util.TraceHull( {
		start = pos, 
		endpos = pos, 
		mins = min, 
		maxs = max, 
		filter = filterfun
	} )
	return !tr.Hit
end



hook.Add("PostDrawTranslucentRenderables","JGHUD",function(depth,skybox)
	if skybox then return end --duuuurr
	if !IsValid(LocalPlayer()) then return end

	local pl = player.GetAll()
	for I=1,#pl do
		local ply = pl[I]
		if ply:GetPos():Distance(LocalPlayer():GetPos())<1000 then
			local points = ply:GetNWFloat("JBScore",0)
			
			if points>0 then
				local pos = ply:GetShootPos()+ply:EyeAngles():Forward()*(50+maths(SysTime()/3)*4)+ply:EyeAngles():Right()*-40+ply:EyeAngles():Up()*10
				local ang = Angle(maths(SysTime()/2),ply:GetAngles().yaw-90+maths(SysTime()/1.4),-ply:EyeAngles().p+90)
				if !IsValid(ply.JGHUDAvatar) then
					local Avatar = vgui.Create( "AvatarImage" )
					ply.JGHUDAvatar = Avatar
					Avatar:SetSize( 1, 1)
					Avatar:SetPos( 20, 120 )
					ply.JGLastScoreList = ""
				end

				cam.Start3D2D(pos,ang,0.05)
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextColor(Color(200,200,255))
					surface.DrawRect(0,0,360,200)
					surface.SetFont("Jump_Game_Small")
					surface.SetTextPos(50,0)
					surface.DrawText("Jump Game")
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextPos(-surface.GetTextSize(points)/2+180,50)
					surface.DrawText(points)
					if table.Count(ScoreList)>0 then
						local nextscore = FindNearestScore(points,ply)
						if nextscore[1]<0 then
							-- No data
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextColor(Color(200,200,255,155+100*maths(SysTime())))
							surface.SetTextPos(180-surface.GetTextSize("No data")/2,120)
							surface.DrawText("No data")
						else
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextPos(100,150)
							surface.DrawText(nextscore[1])
							if nextscore[2]=="You" then
								surface.SetTextPos(100+mathabs(maths(SysTime()*1.4)*16),120)
								surface.SetTextColor(Color(255,255,0))
							else
								surface.SetTextPos(100,120)
							end
							surface.DrawText(nextscore[2])
							if IsValid(ply.JGHUDAvatar) then
								ply.JGHUDAvatar:SetSize( 64, 64)
								ply.JGHUDAvatar:PaintManual()
								ply.JGHUDAvatar:SetSize( 1, 1)
								if ply.JGLastScoreList != nextscore[3] then
									ply:EmitSound("buttons/button17.wav")
									ply.JGLastScoreList = nextscore[3]
									ply.JGHUDAvatar:SetSteamID(util.SteamIDTo64( nextscore[3] or "") or 0,64)
								end
							end
						end
					end
				cam.End3D2D()
			else
				if IsValid(ply.JGHUDAvatar) then
					ply.JGHUDAvatar:Remove()
				end
			end
		else
			if IsValid(ply.JGHUDAvatar) then
				ply.JGHUDAvatar:Remove()
			end
		end
	end

end)

function GetJumpGameScore()
	return ScoreList
end

-- "lua\\autorun\\client\\cl_jumpgame.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

if SERVER then
	print("Error. Client file ran on the server.")
	return
end

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathabs = math.abs
local Loaded = false
local ScoreList = {}
ScoreList = {

}
local MyScore = 100
local NextToBeat = {"[error]",0}
net.Receive( "NaksJumpGame", function( len )
	local msg = net.ReadString()
	if msg == "UpdateScore" then
		table.Empty(ScoreList)
		local n = net.ReadFloat()
		for I=1,n do
			local points = net.ReadFloat()
			local name = net.ReadString()
			local steamid = net.ReadString()
			table.insert(ScoreList,{points,name,steamid})
		end
	elseif msg == "SpawnMessage" then
		local text = net.ReadString()
		notification.AddLegacy( text, NOTIFY_ERROR, 3 )
		surface.PlaySound( "buttons/button15.wav" )
		MsgN(text)
	end
end)

local GetJBlist = {}
timer.Create("GetJBlist", 2, 0, function()
	GetJBlist = ents.FindByClass("ent_jumpgame")
end)
timer.Simple(4,function()
	if !Loaded then
		Loaded = true
		net.Start("NaksJumpGame")
			net.WriteString("UpdateScore")
		net.SendToServer()
	end
end)

local function FindNearestScore(myscore,ply)
	if !ply or !myscore then return {-1,"",""} end
	if table.Count(ScoreList)<1 then return {-1,"",""} end
	for I=#ScoreList,1,-1 do
		if ScoreList[I][1]>myscore then
			return ScoreList[I]
		end
	end
	return {myscore,"You",ply:SteamID()}
end

local filterfun = function( ent ) 
	if ( ent:GetClass() == "prop_physics" and !ent.JumpGamePlatForm ) then 
		return true
	elseif ent:GetClass()=="Player" then
		return false
	elseif ent:GetClass()=="prop_dynamic" then
		return false
	end 
end

local function potato(pos,self,min,max)
	local tr = util.TraceHull( {
		start = pos, 
		endpos = pos, 
		mins = min, 
		maxs = max, 
		filter = filterfun
	} )
	return !tr.Hit
end



hook.Add("PostDrawTranslucentRenderables","JGHUD",function(depth,skybox)
	if skybox then return end --duuuurr
	if !IsValid(LocalPlayer()) then return end

	local pl = player.GetAll()
	for I=1,#pl do
		local ply = pl[I]
		if ply:GetPos():Distance(LocalPlayer():GetPos())<1000 then
			local points = ply:GetNWFloat("JBScore",0)
			
			if points>0 then
				local pos = ply:GetShootPos()+ply:EyeAngles():Forward()*(50+maths(SysTime()/3)*4)+ply:EyeAngles():Right()*-40+ply:EyeAngles():Up()*10
				local ang = Angle(maths(SysTime()/2),ply:GetAngles().yaw-90+maths(SysTime()/1.4),-ply:EyeAngles().p+90)
				if !IsValid(ply.JGHUDAvatar) then
					local Avatar = vgui.Create( "AvatarImage" )
					ply.JGHUDAvatar = Avatar
					Avatar:SetSize( 1, 1)
					Avatar:SetPos( 20, 120 )
					ply.JGLastScoreList = ""
				end

				cam.Start3D2D(pos,ang,0.05)
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextColor(Color(200,200,255))
					surface.DrawRect(0,0,360,200)
					surface.SetFont("Jump_Game_Small")
					surface.SetTextPos(50,0)
					surface.DrawText("Jump Game")
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextPos(-surface.GetTextSize(points)/2+180,50)
					surface.DrawText(points)
					if table.Count(ScoreList)>0 then
						local nextscore = FindNearestScore(points,ply)
						if nextscore[1]<0 then
							-- No data
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextColor(Color(200,200,255,155+100*maths(SysTime())))
							surface.SetTextPos(180-surface.GetTextSize("No data")/2,120)
							surface.DrawText("No data")
						else
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextPos(100,150)
							surface.DrawText(nextscore[1])
							if nextscore[2]=="You" then
								surface.SetTextPos(100+mathabs(maths(SysTime()*1.4)*16),120)
								surface.SetTextColor(Color(255,255,0))
							else
								surface.SetTextPos(100,120)
							end
							surface.DrawText(nextscore[2])
							if IsValid(ply.JGHUDAvatar) then
								ply.JGHUDAvatar:SetSize( 64, 64)
								ply.JGHUDAvatar:PaintManual()
								ply.JGHUDAvatar:SetSize( 1, 1)
								if ply.JGLastScoreList != nextscore[3] then
									ply:EmitSound("buttons/button17.wav")
									ply.JGLastScoreList = nextscore[3]
									ply.JGHUDAvatar:SetSteamID(util.SteamIDTo64( nextscore[3] or "") or 0,64)
								end
							end
						end
					end
				cam.End3D2D()
			else
				if IsValid(ply.JGHUDAvatar) then
					ply.JGHUDAvatar:Remove()
				end
			end
		else
			if IsValid(ply.JGHUDAvatar) then
				ply.JGHUDAvatar:Remove()
			end
		end
	end

end)

function GetJumpGameScore()
	return ScoreList
end

-- "lua\\autorun\\client\\cl_jumpgame.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

if SERVER then
	print("Error. Client file ran on the server.")
	return
end

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathabs = math.abs
local Loaded = false
local ScoreList = {}
ScoreList = {

}
local MyScore = 100
local NextToBeat = {"[error]",0}
net.Receive( "NaksJumpGame", function( len )
	local msg = net.ReadString()
	if msg == "UpdateScore" then
		table.Empty(ScoreList)
		local n = net.ReadFloat()
		for I=1,n do
			local points = net.ReadFloat()
			local name = net.ReadString()
			local steamid = net.ReadString()
			table.insert(ScoreList,{points,name,steamid})
		end
	elseif msg == "SpawnMessage" then
		local text = net.ReadString()
		notification.AddLegacy( text, NOTIFY_ERROR, 3 )
		surface.PlaySound( "buttons/button15.wav" )
		MsgN(text)
	end
end)

local GetJBlist = {}
timer.Create("GetJBlist", 2, 0, function()
	GetJBlist = ents.FindByClass("ent_jumpgame")
end)
timer.Simple(4,function()
	if !Loaded then
		Loaded = true
		net.Start("NaksJumpGame")
			net.WriteString("UpdateScore")
		net.SendToServer()
	end
end)

local function FindNearestScore(myscore,ply)
	if !ply or !myscore then return {-1,"",""} end
	if table.Count(ScoreList)<1 then return {-1,"",""} end
	for I=#ScoreList,1,-1 do
		if ScoreList[I][1]>myscore then
			return ScoreList[I]
		end
	end
	return {myscore,"You",ply:SteamID()}
end

local filterfun = function( ent ) 
	if ( ent:GetClass() == "prop_physics" and !ent.JumpGamePlatForm ) then 
		return true
	elseif ent:GetClass()=="Player" then
		return false
	elseif ent:GetClass()=="prop_dynamic" then
		return false
	end 
end

local function potato(pos,self,min,max)
	local tr = util.TraceHull( {
		start = pos, 
		endpos = pos, 
		mins = min, 
		maxs = max, 
		filter = filterfun
	} )
	return !tr.Hit
end



hook.Add("PostDrawTranslucentRenderables","JGHUD",function(depth,skybox)
	if skybox then return end --duuuurr
	if !IsValid(LocalPlayer()) then return end

	local pl = player.GetAll()
	for I=1,#pl do
		local ply = pl[I]
		if ply:GetPos():Distance(LocalPlayer():GetPos())<1000 then
			local points = ply:GetNWFloat("JBScore",0)
			
			if points>0 then
				local pos = ply:GetShootPos()+ply:EyeAngles():Forward()*(50+maths(SysTime()/3)*4)+ply:EyeAngles():Right()*-40+ply:EyeAngles():Up()*10
				local ang = Angle(maths(SysTime()/2),ply:GetAngles().yaw-90+maths(SysTime()/1.4),-ply:EyeAngles().p+90)
				if !IsValid(ply.JGHUDAvatar) then
					local Avatar = vgui.Create( "AvatarImage" )
					ply.JGHUDAvatar = Avatar
					Avatar:SetSize( 1, 1)
					Avatar:SetPos( 20, 120 )
					ply.JGLastScoreList = ""
				end

				cam.Start3D2D(pos,ang,0.05)
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextColor(Color(200,200,255))
					surface.DrawRect(0,0,360,200)
					surface.SetFont("Jump_Game_Small")
					surface.SetTextPos(50,0)
					surface.DrawText("Jump Game")
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextPos(-surface.GetTextSize(points)/2+180,50)
					surface.DrawText(points)
					if table.Count(ScoreList)>0 then
						local nextscore = FindNearestScore(points,ply)
						if nextscore[1]<0 then
							-- No data
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextColor(Color(200,200,255,155+100*maths(SysTime())))
							surface.SetTextPos(180-surface.GetTextSize("No data")/2,120)
							surface.DrawText("No data")
						else
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextPos(100,150)
							surface.DrawText(nextscore[1])
							if nextscore[2]=="You" then
								surface.SetTextPos(100+mathabs(maths(SysTime()*1.4)*16),120)
								surface.SetTextColor(Color(255,255,0))
							else
								surface.SetTextPos(100,120)
							end
							surface.DrawText(nextscore[2])
							if IsValid(ply.JGHUDAvatar) then
								ply.JGHUDAvatar:SetSize( 64, 64)
								ply.JGHUDAvatar:PaintManual()
								ply.JGHUDAvatar:SetSize( 1, 1)
								if ply.JGLastScoreList != nextscore[3] then
									ply:EmitSound("buttons/button17.wav")
									ply.JGLastScoreList = nextscore[3]
									ply.JGHUDAvatar:SetSteamID(util.SteamIDTo64( nextscore[3] or "") or 0,64)
								end
							end
						end
					end
				cam.End3D2D()
			else
				if IsValid(ply.JGHUDAvatar) then
					ply.JGHUDAvatar:Remove()
				end
			end
		else
			if IsValid(ply.JGHUDAvatar) then
				ply.JGHUDAvatar:Remove()
			end
		end
	end

end)

function GetJumpGameScore()
	return ScoreList
end

-- "lua\\autorun\\client\\cl_jumpgame.lua"
-- Retrieved by https://github.com/c4fe/glua-steal

if SERVER then
	print("Error. Client file ran on the server.")
	return
end

surface.CreateFont( "Jump_Game", 
                    {
                    font    = "Tahoma",
                    size    = 60,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Small", 
                    {
                    font    = "Tahoma",
                    size    = 50,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

surface.CreateFont( "Jump_Game_Mini", 
                    {
                    font    = "Tahoma",
                    size    = 26,
                    weight  = 1000,
                    antialias = true,
                    shadow = false
            })

local maths = math.sin
local mathabs = math.abs
local Loaded = false
local ScoreList = {}
ScoreList = {

}
local MyScore = 100
local NextToBeat = {"[error]",0}
net.Receive( "NaksJumpGame", function( len )
	local msg = net.ReadString()
	if msg == "UpdateScore" then
		table.Empty(ScoreList)
		local n = net.ReadFloat()
		for I=1,n do
			local points = net.ReadFloat()
			local name = net.ReadString()
			local steamid = net.ReadString()
			table.insert(ScoreList,{points,name,steamid})
		end
	elseif msg == "SpawnMessage" then
		local text = net.ReadString()
		notification.AddLegacy( text, NOTIFY_ERROR, 3 )
		surface.PlaySound( "buttons/button15.wav" )
		MsgN(text)
	end
end)

local GetJBlist = {}
timer.Create("GetJBlist", 2, 0, function()
	GetJBlist = ents.FindByClass("ent_jumpgame")
end)
timer.Simple(4,function()
	if !Loaded then
		Loaded = true
		net.Start("NaksJumpGame")
			net.WriteString("UpdateScore")
		net.SendToServer()
	end
end)

local function FindNearestScore(myscore,ply)
	if !ply or !myscore then return {-1,"",""} end
	if table.Count(ScoreList)<1 then return {-1,"",""} end
	for I=#ScoreList,1,-1 do
		if ScoreList[I][1]>myscore then
			return ScoreList[I]
		end
	end
	return {myscore,"You",ply:SteamID()}
end

local filterfun = function( ent ) 
	if ( ent:GetClass() == "prop_physics" and !ent.JumpGamePlatForm ) then 
		return true
	elseif ent:GetClass()=="Player" then
		return false
	elseif ent:GetClass()=="prop_dynamic" then
		return false
	end 
end

local function potato(pos,self,min,max)
	local tr = util.TraceHull( {
		start = pos, 
		endpos = pos, 
		mins = min, 
		maxs = max, 
		filter = filterfun
	} )
	return !tr.Hit
end



hook.Add("PostDrawTranslucentRenderables","JGHUD",function(depth,skybox)
	if skybox then return end --duuuurr
	if !IsValid(LocalPlayer()) then return end

	local pl = player.GetAll()
	for I=1,#pl do
		local ply = pl[I]
		if ply:GetPos():Distance(LocalPlayer():GetPos())<1000 then
			local points = ply:GetNWFloat("JBScore",0)
			
			if points>0 then
				local pos = ply:GetShootPos()+ply:EyeAngles():Forward()*(50+maths(SysTime()/3)*4)+ply:EyeAngles():Right()*-40+ply:EyeAngles():Up()*10
				local ang = Angle(maths(SysTime()/2),ply:GetAngles().yaw-90+maths(SysTime()/1.4),-ply:EyeAngles().p+90)
				if !IsValid(ply.JGHUDAvatar) then
					local Avatar = vgui.Create( "AvatarImage" )
					ply.JGHUDAvatar = Avatar
					Avatar:SetSize( 1, 1)
					Avatar:SetPos( 20, 120 )
					ply.JGLastScoreList = ""
				end

				cam.Start3D2D(pos,ang,0.05)
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextColor(Color(200,200,255))
					surface.DrawRect(0,0,360,200)
					surface.SetFont("Jump_Game_Small")
					surface.SetTextPos(50,0)
					surface.DrawText("Jump Game")
					surface.SetDrawColor(Color(0,0,0,220))
					surface.SetTextPos(-surface.GetTextSize(points)/2+180,50)
					surface.DrawText(points)
					if table.Count(ScoreList)>0 then
						local nextscore = FindNearestScore(points,ply)
						if nextscore[1]<0 then
							-- No data
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextColor(Color(200,200,255,155+100*maths(SysTime())))
							surface.SetTextPos(180-surface.GetTextSize("No data")/2,120)
							surface.DrawText("No data")
						else
							surface.SetFont("Jump_Game_Mini")
							surface.SetTextPos(100,150)
							surface.DrawText(nextscore[1])
							if nextscore[2]=="You" then
								surface.SetTextPos(100+mathabs(maths(SysTime()*1.4)*16),120)
								surface.SetTextColor(Color(255,255,0))
							else
								surface.SetTextPos(100,120)
							end
							surface.DrawText(nextscore[2])
							if IsValid(ply.JGHUDAvatar) then
								ply.JGHUDAvatar:SetSize( 64, 64)
								ply.JGHUDAvatar:PaintManual()
								ply.JGHUDAvatar:SetSize( 1, 1)
								if ply.JGLastScoreList != nextscore[3] then
									ply:EmitSound("buttons/button17.wav")
									ply.JGLastScoreList = nextscore[3]
									ply.JGHUDAvatar:SetSteamID(util.SteamIDTo64( nextscore[3] or "") or 0,64)
								end
							end
						end
					end
				cam.End3D2D()
			else
				if IsValid(ply.JGHUDAvatar) then
					ply.JGHUDAvatar:Remove()
				end
			end
		else
			if IsValid(ply.JGHUDAvatar) then
				ply.JGHUDAvatar:Remove()
			end
		end
	end

end)

function GetJumpGameScore()
	return ScoreList
end

