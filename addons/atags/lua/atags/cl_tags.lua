-- "addons\\atags\\lua\\atags\\cl_tags.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ATAG.Tags = {}
ATAG.SB_Tags = {}
ATAG.ChatTags = {}

ATAG.CanEditOwnChatTag = false

local PANEL = {}

function PANEL:Init()
	self:MakePopup()
	self:SetTitle("aTags - By ikefi")
	self:SetSizable(true)
	self:SetMinWidth(600)
	self:SetMinHeight(400)
	
	self:SetSize(cookie.GetNumber("ATAG_Frame_w", nil) or 600, cookie.GetNumber("ATAG_Frame_h", nil) or 400)
	self:SetPos(cookie.GetNumber("ATAG_Frame_x", nil) or (ScrW() / 2) - (self:GetWide() / 2), cookie.GetNumber("ATAG_Frame_y", nil) or (ScrH() / 2) - (self:GetTall() / 2))
	self.Paint = function(pnl, w, h)
		surface.SetDrawColor(100, 150, 200)
		surface.DrawRect(0, 0, w, h)
	end
	
	ATAG.GUI = vgui.Create("atags_main_gui", self)
end
vgui.Register("atags_frame_gui", PANEL, "DFrame")

function ATAG.OpenGui()
	if IsValid(ATAG.Frame) then return end
	ATAG.Frame = vgui.Create("atags_frame_gui")
end

hook.Add("PlayerButtonDown", "scoreboardtags_opengui_chat", function(ply, btn)
	if ATAG.Key == nil then return end
	if ply ~= LocalPlayer() then return end
	if btn ~= ATAG.Key then return end
	ATAG.OpenGui()
end)

net.Receive("ATAG_OpenMenu", function()
	ATAG.OpenGui()
end)

concommand.Add(ATAG.ConCommand, ATAG.OpenGui)

function ATAG.SetFrameSize(w, h)

	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if w then
		pnl:SetWide(w)
	end
	
	if h then
		pnl:SetTall(h)
	end
	
end

function ATAG.SetFramePos(x, y, center)
	
	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if x then
		pnl:SetPos(x, nil)
	end
	
	if y then
		pnl:SetPos(nil, y)
	end
	
	if center then
		pnl:Center()
	end
	
end

function ATAG.SaveFrameSettings()

	local pnl = ATAG.Frame
	
	if not IsValid(pnl) then return end

	local Pos_x, Pos_y = pnl:GetPos()
	local Size_w, Size_h = pnl:GetSize()
	
	cookie.Set("ATAG_Frame_x", Pos_x)
	cookie.Set("ATAG_Frame_y", Pos_y)
	cookie.Set("ATAG_Frame_w", Size_w)
	cookie.Set("ATAG_Frame_h", Size_h)

end

function ATAG.NotifyMessage(msg, duration)
	if not msg or msg == "" then return end
	
	if not IsValid(ATAG.GUI) then return end
	
	ATAG.GUI:SetNotifyMessage(msg, duration)
	
end

function ATAG:GetScoreboardTag( ply )
	
	if not ply:GetNWBool( "aTags_sb_hasTag", false ) then
		return "", Color( 255, 255, 255 )
	end
	
	local name = ply:GetNWString( "aTags_sb_name", "" )
	local color = ply:GetNWString( "aTags_sb_color", "" )
	
	if not color or color == "" then
		color = Color( 255, 255, 255 )
	else
		color = string.ToColor( color )
	end
	
	return name, color
	
end

-- Needed Scoreboard Data
function ATAG.GetScoreBoardTagData()
	net.Start("ATAG_GetSBTagData")
	net.SendToServer()
end

net.Receive("ATAG_SendSBTagData", function()
	ATAG.SB_Tags = net.ReadTable()
end)

-- USE TAGS
function ATAG.UseTag(TagID, Type)
	net.Start("ATAG_SelectUserTags")
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

function ATAG.GetUserTags()
	net.Start("ATAG_GetUserTags")
	net.SendToServer()
end

net.Receive("ATAG_SendUserTags", function()
	ATAG.Tags_MyTags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Tags_FillTags(ATAG.Tags_MyTags)
	
	if ATAG.Tags_MyTags.SB_CST then
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(true)
	else
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(false)
	end
end)

-- TAGS
function ATAG.AddTag(name, color)
	if not color then return end
	if name == "" then ATAG.NotifyMessage("A tag can not be an empty string.") return end
	
	net.Start("ATAG_Tags_AddTag")
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.RemoveTag(ID)
	if not ID then return end
	net.Start("ATAG_Tags_RemoveTag")
		net.WriteString(tostring(ID))
	net.SendToServer()
end

function ATAG.EditTag(ID, name, color)
	if not ID then return end
	if not color then return end
	if name == "" then return end
	
	net.Start("ATAG_Tags_EditTag")
		net.WriteString(tostring(ID))
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.GetTags()
	net.Start("ATAG_Tags_GetTags")
	net.SendToServer()
end

net.Receive("ATAG_Tags_SendTags", function()
	ATAG.Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_FillTagList(ATAG.Tags)
	ATAG.GUI:Admin_PlayerTags_FillTags(ATAG.Tags)
end)





-- Scoreboard Tags

function ATAG.SB_SetOwnTag(Name, color)
	if not Name or Name == "" then return end
	if not color then return end

	net.Start("ATAG_Scoreboard_SetOwnTag")
		net.WriteString(Name)
		net.WriteTable(color)
	net.SendToServer()
	
end

function ATAG.SB_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Scoreboard_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.SB_SetAutoAssignedTag_rank(Rank, TagID, Type)
	if not Rank then return end
	if not TagID then end
	if not Type then return end
	
	net.Start("ATAG_Scoreboard_SetAutoAssignedTag_rank")
		net.WriteString(Rank)
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

-- PLAYERS
function ATAG.SB_GetPlayers()
	net.Start("ATAG_Scoreboard_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendPlayers", function()
	ATAG.PlayerTags_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillPlayers()
end)

function ATAG.SB_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Scoreboard_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

function ATAG.SB_GetTags_player(SteamID)
	net.Start("ATAG_Scoreboard_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_player", function()
	ATAG.SB_Player_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_player(ATAG.SB_Player_Tags)
end)

-- RANKS
function ATAG.SB_GetRanks()
	net.Start("ATAG_Scoreboard_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendRanks", function()
	ATAG.Scoreboard_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillRanks()
end)

function ATAG.SB_AddRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_GetTags_rank(Rank)
	net.Start("ATAG_Scoreboard_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_rank", function()
	ATAG.SB_Rank_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_rank(ATAG.SB_Rank_Tags)
end)

-- Custom Tags
function ATAG.SB_AddCustomTag(Type, PKey, TagName, TagColor)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagName or TagName == "" then return end
	if not TagColor then TagColor = Color(255, 255, 255) end
	
	net.Start("ATAG_Scoreboard_AddCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(TagName)
		net.WriteTable({TagColor.r, TagColor.g, TagColor.b})
	net.SendToServer()
end

function ATAG.SB_RemoveCustomTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

-- Existing Tags
function ATAG.SB_AddTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_AddTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

function ATAG.SB_RemoveTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end






-- Chat Tags

net.Receive("ATAG_Chat_SendUsingChatTags", function()
	ATAG.ChatTags = net.ReadTable()
end)

-- Ranks
function ATAG.CH_GetTags_rank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_rank", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetRanks()
	net.Start("ATAG_Chat_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendRanks", function()
	ATAG.Chat_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillRanks()
end)

function ATAG.CH_AddRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.CH_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_rank(Rank, Name, color)
	if not Rank or Rank == "" then return end
	if not Name then return end
	if not color then return end
	
	net.Start("ATAG_Chat_AddTag_rank")
		net.WriteString(Rank)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_rank(Rank, Pos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	
	net.Start("ATAG_Chat_RemoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_rank(Rank, Pos, NewPos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Players
function ATAG.CH_GetTags_player(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_player", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetPlayers()
	net.Start("ATAG_Chat_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendPlayers", function()
	ATAG.Chat_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillPlayers()
end)

function ATAG.CH_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Chat_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_player(SteamID, Name, color)
	if not SteamID or SteamID == "" then return end
	if not Name then return end
	if not color then return end
	net.Start("ATAG_Chat_AddTag_player")
		net.WriteString(SteamID)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_player(SteamID, Pos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_player(SteamID, Pos, NewPos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Own Tag
function ATAG.CH_GetCanSetOwnTag()
	net.Start("ATAG_Chat_GetCanSetOwnTag")
	net.SendToServer()
end

timer.Simple(1, function()
	ATAG.CH_GetCanSetOwnTag()
end)

net.Receive("ATAG_Chat_SendCanSetOwnTag", function()
	local bool = net.ReadString()
	
	if bool == "true" then
		ATAG.CanEditOwnChatTag = true
		
		if not IsValid(ATAG.GUI) then return end
		if IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI:Create_TagEdit()
	else
		ATAG.CanEditOwnChatTag = false
		
		if not IsValid(ATAG.GUI) then return end
		if not IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI.Tabs:CloseTab(ATAG.GUI.TagEdit_Tab)
	end
end)

function ATAG.CH_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Chat_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.CH_GetOwnTags()
	net.Start("ATAG_Chat_GetOwnTag")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendOwnTag", function()
	ATAG.OwnTag = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	
	if not IsValid(ATAG.GUI) then return end
	if not ATAG.GUI.TagEdit then return end
	
	ATAG.GUI:TagEdit_FillTags(ATAG.OwnTag, Pos)
end)

function ATAG.CH_AddTagPiece_owntag(Name, color)
	if not Name then return end
	if not color then return end
	
	if not ATAG.AllowUserToChangeChatMessageColor then
		if Name == "\\MESSAGE" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	if not ATAG.AllowUserToChangePlayerNameColor then
		if Name == "\\NAMECOL" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	
	net.Start("ATAG_Chat_AddTag_owntag")
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_owntag(Pos)
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_owntag")
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_owntag(Pos, NewPos)
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_owntag")
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

function ATAG:ChangePrimaryKey( type, old, new )
	
	if not ( old or new or old != "" or new != "" ) then return end
	
	net.Start("ATAG_ChangePrimaryKey")
		net.WriteString( type )
		net.WriteString( old )
		net.WriteString( new )
	net.SendToServer()
	
end

-- "addons\\atags\\lua\\atags\\cl_tags.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ATAG.Tags = {}
ATAG.SB_Tags = {}
ATAG.ChatTags = {}

ATAG.CanEditOwnChatTag = false

local PANEL = {}

function PANEL:Init()
	self:MakePopup()
	self:SetTitle("aTags - By ikefi")
	self:SetSizable(true)
	self:SetMinWidth(600)
	self:SetMinHeight(400)
	
	self:SetSize(cookie.GetNumber("ATAG_Frame_w", nil) or 600, cookie.GetNumber("ATAG_Frame_h", nil) or 400)
	self:SetPos(cookie.GetNumber("ATAG_Frame_x", nil) or (ScrW() / 2) - (self:GetWide() / 2), cookie.GetNumber("ATAG_Frame_y", nil) or (ScrH() / 2) - (self:GetTall() / 2))
	self.Paint = function(pnl, w, h)
		surface.SetDrawColor(100, 150, 200)
		surface.DrawRect(0, 0, w, h)
	end
	
	ATAG.GUI = vgui.Create("atags_main_gui", self)
end
vgui.Register("atags_frame_gui", PANEL, "DFrame")

function ATAG.OpenGui()
	if IsValid(ATAG.Frame) then return end
	ATAG.Frame = vgui.Create("atags_frame_gui")
end

hook.Add("PlayerButtonDown", "scoreboardtags_opengui_chat", function(ply, btn)
	if ATAG.Key == nil then return end
	if ply ~= LocalPlayer() then return end
	if btn ~= ATAG.Key then return end
	ATAG.OpenGui()
end)

net.Receive("ATAG_OpenMenu", function()
	ATAG.OpenGui()
end)

concommand.Add(ATAG.ConCommand, ATAG.OpenGui)

function ATAG.SetFrameSize(w, h)

	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if w then
		pnl:SetWide(w)
	end
	
	if h then
		pnl:SetTall(h)
	end
	
end

function ATAG.SetFramePos(x, y, center)
	
	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if x then
		pnl:SetPos(x, nil)
	end
	
	if y then
		pnl:SetPos(nil, y)
	end
	
	if center then
		pnl:Center()
	end
	
end

function ATAG.SaveFrameSettings()

	local pnl = ATAG.Frame
	
	if not IsValid(pnl) then return end

	local Pos_x, Pos_y = pnl:GetPos()
	local Size_w, Size_h = pnl:GetSize()
	
	cookie.Set("ATAG_Frame_x", Pos_x)
	cookie.Set("ATAG_Frame_y", Pos_y)
	cookie.Set("ATAG_Frame_w", Size_w)
	cookie.Set("ATAG_Frame_h", Size_h)

end

function ATAG.NotifyMessage(msg, duration)
	if not msg or msg == "" then return end
	
	if not IsValid(ATAG.GUI) then return end
	
	ATAG.GUI:SetNotifyMessage(msg, duration)
	
end

function ATAG:GetScoreboardTag( ply )
	
	if not ply:GetNWBool( "aTags_sb_hasTag", false ) then
		return "", Color( 255, 255, 255 )
	end
	
	local name = ply:GetNWString( "aTags_sb_name", "" )
	local color = ply:GetNWString( "aTags_sb_color", "" )
	
	if not color or color == "" then
		color = Color( 255, 255, 255 )
	else
		color = string.ToColor( color )
	end
	
	return name, color
	
end

-- Needed Scoreboard Data
function ATAG.GetScoreBoardTagData()
	net.Start("ATAG_GetSBTagData")
	net.SendToServer()
end

net.Receive("ATAG_SendSBTagData", function()
	ATAG.SB_Tags = net.ReadTable()
end)

-- USE TAGS
function ATAG.UseTag(TagID, Type)
	net.Start("ATAG_SelectUserTags")
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

function ATAG.GetUserTags()
	net.Start("ATAG_GetUserTags")
	net.SendToServer()
end

net.Receive("ATAG_SendUserTags", function()
	ATAG.Tags_MyTags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Tags_FillTags(ATAG.Tags_MyTags)
	
	if ATAG.Tags_MyTags.SB_CST then
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(true)
	else
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(false)
	end
end)

-- TAGS
function ATAG.AddTag(name, color)
	if not color then return end
	if name == "" then ATAG.NotifyMessage("A tag can not be an empty string.") return end
	
	net.Start("ATAG_Tags_AddTag")
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.RemoveTag(ID)
	if not ID then return end
	net.Start("ATAG_Tags_RemoveTag")
		net.WriteString(tostring(ID))
	net.SendToServer()
end

function ATAG.EditTag(ID, name, color)
	if not ID then return end
	if not color then return end
	if name == "" then return end
	
	net.Start("ATAG_Tags_EditTag")
		net.WriteString(tostring(ID))
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.GetTags()
	net.Start("ATAG_Tags_GetTags")
	net.SendToServer()
end

net.Receive("ATAG_Tags_SendTags", function()
	ATAG.Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_FillTagList(ATAG.Tags)
	ATAG.GUI:Admin_PlayerTags_FillTags(ATAG.Tags)
end)





-- Scoreboard Tags

function ATAG.SB_SetOwnTag(Name, color)
	if not Name or Name == "" then return end
	if not color then return end

	net.Start("ATAG_Scoreboard_SetOwnTag")
		net.WriteString(Name)
		net.WriteTable(color)
	net.SendToServer()
	
end

function ATAG.SB_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Scoreboard_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.SB_SetAutoAssignedTag_rank(Rank, TagID, Type)
	if not Rank then return end
	if not TagID then end
	if not Type then return end
	
	net.Start("ATAG_Scoreboard_SetAutoAssignedTag_rank")
		net.WriteString(Rank)
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

-- PLAYERS
function ATAG.SB_GetPlayers()
	net.Start("ATAG_Scoreboard_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendPlayers", function()
	ATAG.PlayerTags_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillPlayers()
end)

function ATAG.SB_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Scoreboard_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

function ATAG.SB_GetTags_player(SteamID)
	net.Start("ATAG_Scoreboard_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_player", function()
	ATAG.SB_Player_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_player(ATAG.SB_Player_Tags)
end)

-- RANKS
function ATAG.SB_GetRanks()
	net.Start("ATAG_Scoreboard_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendRanks", function()
	ATAG.Scoreboard_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillRanks()
end)

function ATAG.SB_AddRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_GetTags_rank(Rank)
	net.Start("ATAG_Scoreboard_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_rank", function()
	ATAG.SB_Rank_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_rank(ATAG.SB_Rank_Tags)
end)

-- Custom Tags
function ATAG.SB_AddCustomTag(Type, PKey, TagName, TagColor)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagName or TagName == "" then return end
	if not TagColor then TagColor = Color(255, 255, 255) end
	
	net.Start("ATAG_Scoreboard_AddCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(TagName)
		net.WriteTable({TagColor.r, TagColor.g, TagColor.b})
	net.SendToServer()
end

function ATAG.SB_RemoveCustomTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

-- Existing Tags
function ATAG.SB_AddTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_AddTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

function ATAG.SB_RemoveTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end






-- Chat Tags

net.Receive("ATAG_Chat_SendUsingChatTags", function()
	ATAG.ChatTags = net.ReadTable()
end)

-- Ranks
function ATAG.CH_GetTags_rank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_rank", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetRanks()
	net.Start("ATAG_Chat_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendRanks", function()
	ATAG.Chat_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillRanks()
end)

function ATAG.CH_AddRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.CH_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_rank(Rank, Name, color)
	if not Rank or Rank == "" then return end
	if not Name then return end
	if not color then return end
	
	net.Start("ATAG_Chat_AddTag_rank")
		net.WriteString(Rank)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_rank(Rank, Pos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	
	net.Start("ATAG_Chat_RemoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_rank(Rank, Pos, NewPos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Players
function ATAG.CH_GetTags_player(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_player", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetPlayers()
	net.Start("ATAG_Chat_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendPlayers", function()
	ATAG.Chat_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillPlayers()
end)

function ATAG.CH_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Chat_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_player(SteamID, Name, color)
	if not SteamID or SteamID == "" then return end
	if not Name then return end
	if not color then return end
	net.Start("ATAG_Chat_AddTag_player")
		net.WriteString(SteamID)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_player(SteamID, Pos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_player(SteamID, Pos, NewPos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Own Tag
function ATAG.CH_GetCanSetOwnTag()
	net.Start("ATAG_Chat_GetCanSetOwnTag")
	net.SendToServer()
end

timer.Simple(1, function()
	ATAG.CH_GetCanSetOwnTag()
end)

net.Receive("ATAG_Chat_SendCanSetOwnTag", function()
	local bool = net.ReadString()
	
	if bool == "true" then
		ATAG.CanEditOwnChatTag = true
		
		if not IsValid(ATAG.GUI) then return end
		if IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI:Create_TagEdit()
	else
		ATAG.CanEditOwnChatTag = false
		
		if not IsValid(ATAG.GUI) then return end
		if not IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI.Tabs:CloseTab(ATAG.GUI.TagEdit_Tab)
	end
end)

function ATAG.CH_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Chat_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.CH_GetOwnTags()
	net.Start("ATAG_Chat_GetOwnTag")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendOwnTag", function()
	ATAG.OwnTag = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	
	if not IsValid(ATAG.GUI) then return end
	if not ATAG.GUI.TagEdit then return end
	
	ATAG.GUI:TagEdit_FillTags(ATAG.OwnTag, Pos)
end)

function ATAG.CH_AddTagPiece_owntag(Name, color)
	if not Name then return end
	if not color then return end
	
	if not ATAG.AllowUserToChangeChatMessageColor then
		if Name == "\\MESSAGE" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	if not ATAG.AllowUserToChangePlayerNameColor then
		if Name == "\\NAMECOL" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	
	net.Start("ATAG_Chat_AddTag_owntag")
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_owntag(Pos)
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_owntag")
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_owntag(Pos, NewPos)
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_owntag")
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

function ATAG:ChangePrimaryKey( type, old, new )
	
	if not ( old or new or old != "" or new != "" ) then return end
	
	net.Start("ATAG_ChangePrimaryKey")
		net.WriteString( type )
		net.WriteString( old )
		net.WriteString( new )
	net.SendToServer()
	
end

-- "addons\\atags\\lua\\atags\\cl_tags.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ATAG.Tags = {}
ATAG.SB_Tags = {}
ATAG.ChatTags = {}

ATAG.CanEditOwnChatTag = false

local PANEL = {}

function PANEL:Init()
	self:MakePopup()
	self:SetTitle("aTags - By ikefi")
	self:SetSizable(true)
	self:SetMinWidth(600)
	self:SetMinHeight(400)
	
	self:SetSize(cookie.GetNumber("ATAG_Frame_w", nil) or 600, cookie.GetNumber("ATAG_Frame_h", nil) or 400)
	self:SetPos(cookie.GetNumber("ATAG_Frame_x", nil) or (ScrW() / 2) - (self:GetWide() / 2), cookie.GetNumber("ATAG_Frame_y", nil) or (ScrH() / 2) - (self:GetTall() / 2))
	self.Paint = function(pnl, w, h)
		surface.SetDrawColor(100, 150, 200)
		surface.DrawRect(0, 0, w, h)
	end
	
	ATAG.GUI = vgui.Create("atags_main_gui", self)
end
vgui.Register("atags_frame_gui", PANEL, "DFrame")

function ATAG.OpenGui()
	if IsValid(ATAG.Frame) then return end
	ATAG.Frame = vgui.Create("atags_frame_gui")
end

hook.Add("PlayerButtonDown", "scoreboardtags_opengui_chat", function(ply, btn)
	if ATAG.Key == nil then return end
	if ply ~= LocalPlayer() then return end
	if btn ~= ATAG.Key then return end
	ATAG.OpenGui()
end)

net.Receive("ATAG_OpenMenu", function()
	ATAG.OpenGui()
end)

concommand.Add(ATAG.ConCommand, ATAG.OpenGui)

function ATAG.SetFrameSize(w, h)

	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if w then
		pnl:SetWide(w)
	end
	
	if h then
		pnl:SetTall(h)
	end
	
end

function ATAG.SetFramePos(x, y, center)
	
	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if x then
		pnl:SetPos(x, nil)
	end
	
	if y then
		pnl:SetPos(nil, y)
	end
	
	if center then
		pnl:Center()
	end
	
end

function ATAG.SaveFrameSettings()

	local pnl = ATAG.Frame
	
	if not IsValid(pnl) then return end

	local Pos_x, Pos_y = pnl:GetPos()
	local Size_w, Size_h = pnl:GetSize()
	
	cookie.Set("ATAG_Frame_x", Pos_x)
	cookie.Set("ATAG_Frame_y", Pos_y)
	cookie.Set("ATAG_Frame_w", Size_w)
	cookie.Set("ATAG_Frame_h", Size_h)

end

function ATAG.NotifyMessage(msg, duration)
	if not msg or msg == "" then return end
	
	if not IsValid(ATAG.GUI) then return end
	
	ATAG.GUI:SetNotifyMessage(msg, duration)
	
end

function ATAG:GetScoreboardTag( ply )
	
	if not ply:GetNWBool( "aTags_sb_hasTag", false ) then
		return "", Color( 255, 255, 255 )
	end
	
	local name = ply:GetNWString( "aTags_sb_name", "" )
	local color = ply:GetNWString( "aTags_sb_color", "" )
	
	if not color or color == "" then
		color = Color( 255, 255, 255 )
	else
		color = string.ToColor( color )
	end
	
	return name, color
	
end

-- Needed Scoreboard Data
function ATAG.GetScoreBoardTagData()
	net.Start("ATAG_GetSBTagData")
	net.SendToServer()
end

net.Receive("ATAG_SendSBTagData", function()
	ATAG.SB_Tags = net.ReadTable()
end)

-- USE TAGS
function ATAG.UseTag(TagID, Type)
	net.Start("ATAG_SelectUserTags")
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

function ATAG.GetUserTags()
	net.Start("ATAG_GetUserTags")
	net.SendToServer()
end

net.Receive("ATAG_SendUserTags", function()
	ATAG.Tags_MyTags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Tags_FillTags(ATAG.Tags_MyTags)
	
	if ATAG.Tags_MyTags.SB_CST then
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(true)
	else
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(false)
	end
end)

-- TAGS
function ATAG.AddTag(name, color)
	if not color then return end
	if name == "" then ATAG.NotifyMessage("A tag can not be an empty string.") return end
	
	net.Start("ATAG_Tags_AddTag")
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.RemoveTag(ID)
	if not ID then return end
	net.Start("ATAG_Tags_RemoveTag")
		net.WriteString(tostring(ID))
	net.SendToServer()
end

function ATAG.EditTag(ID, name, color)
	if not ID then return end
	if not color then return end
	if name == "" then return end
	
	net.Start("ATAG_Tags_EditTag")
		net.WriteString(tostring(ID))
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.GetTags()
	net.Start("ATAG_Tags_GetTags")
	net.SendToServer()
end

net.Receive("ATAG_Tags_SendTags", function()
	ATAG.Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_FillTagList(ATAG.Tags)
	ATAG.GUI:Admin_PlayerTags_FillTags(ATAG.Tags)
end)





-- Scoreboard Tags

function ATAG.SB_SetOwnTag(Name, color)
	if not Name or Name == "" then return end
	if not color then return end

	net.Start("ATAG_Scoreboard_SetOwnTag")
		net.WriteString(Name)
		net.WriteTable(color)
	net.SendToServer()
	
end

function ATAG.SB_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Scoreboard_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.SB_SetAutoAssignedTag_rank(Rank, TagID, Type)
	if not Rank then return end
	if not TagID then end
	if not Type then return end
	
	net.Start("ATAG_Scoreboard_SetAutoAssignedTag_rank")
		net.WriteString(Rank)
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

-- PLAYERS
function ATAG.SB_GetPlayers()
	net.Start("ATAG_Scoreboard_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendPlayers", function()
	ATAG.PlayerTags_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillPlayers()
end)

function ATAG.SB_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Scoreboard_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

function ATAG.SB_GetTags_player(SteamID)
	net.Start("ATAG_Scoreboard_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_player", function()
	ATAG.SB_Player_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_player(ATAG.SB_Player_Tags)
end)

-- RANKS
function ATAG.SB_GetRanks()
	net.Start("ATAG_Scoreboard_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendRanks", function()
	ATAG.Scoreboard_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillRanks()
end)

function ATAG.SB_AddRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_GetTags_rank(Rank)
	net.Start("ATAG_Scoreboard_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_rank", function()
	ATAG.SB_Rank_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_rank(ATAG.SB_Rank_Tags)
end)

-- Custom Tags
function ATAG.SB_AddCustomTag(Type, PKey, TagName, TagColor)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagName or TagName == "" then return end
	if not TagColor then TagColor = Color(255, 255, 255) end
	
	net.Start("ATAG_Scoreboard_AddCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(TagName)
		net.WriteTable({TagColor.r, TagColor.g, TagColor.b})
	net.SendToServer()
end

function ATAG.SB_RemoveCustomTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

-- Existing Tags
function ATAG.SB_AddTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_AddTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

function ATAG.SB_RemoveTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end






-- Chat Tags

net.Receive("ATAG_Chat_SendUsingChatTags", function()
	ATAG.ChatTags = net.ReadTable()
end)

-- Ranks
function ATAG.CH_GetTags_rank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_rank", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetRanks()
	net.Start("ATAG_Chat_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendRanks", function()
	ATAG.Chat_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillRanks()
end)

function ATAG.CH_AddRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.CH_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_rank(Rank, Name, color)
	if not Rank or Rank == "" then return end
	if not Name then return end
	if not color then return end
	
	net.Start("ATAG_Chat_AddTag_rank")
		net.WriteString(Rank)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_rank(Rank, Pos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	
	net.Start("ATAG_Chat_RemoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_rank(Rank, Pos, NewPos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Players
function ATAG.CH_GetTags_player(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_player", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetPlayers()
	net.Start("ATAG_Chat_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendPlayers", function()
	ATAG.Chat_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillPlayers()
end)

function ATAG.CH_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Chat_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_player(SteamID, Name, color)
	if not SteamID or SteamID == "" then return end
	if not Name then return end
	if not color then return end
	net.Start("ATAG_Chat_AddTag_player")
		net.WriteString(SteamID)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_player(SteamID, Pos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_player(SteamID, Pos, NewPos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Own Tag
function ATAG.CH_GetCanSetOwnTag()
	net.Start("ATAG_Chat_GetCanSetOwnTag")
	net.SendToServer()
end

timer.Simple(1, function()
	ATAG.CH_GetCanSetOwnTag()
end)

net.Receive("ATAG_Chat_SendCanSetOwnTag", function()
	local bool = net.ReadString()
	
	if bool == "true" then
		ATAG.CanEditOwnChatTag = true
		
		if not IsValid(ATAG.GUI) then return end
		if IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI:Create_TagEdit()
	else
		ATAG.CanEditOwnChatTag = false
		
		if not IsValid(ATAG.GUI) then return end
		if not IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI.Tabs:CloseTab(ATAG.GUI.TagEdit_Tab)
	end
end)

function ATAG.CH_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Chat_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.CH_GetOwnTags()
	net.Start("ATAG_Chat_GetOwnTag")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendOwnTag", function()
	ATAG.OwnTag = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	
	if not IsValid(ATAG.GUI) then return end
	if not ATAG.GUI.TagEdit then return end
	
	ATAG.GUI:TagEdit_FillTags(ATAG.OwnTag, Pos)
end)

function ATAG.CH_AddTagPiece_owntag(Name, color)
	if not Name then return end
	if not color then return end
	
	if not ATAG.AllowUserToChangeChatMessageColor then
		if Name == "\\MESSAGE" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	if not ATAG.AllowUserToChangePlayerNameColor then
		if Name == "\\NAMECOL" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	
	net.Start("ATAG_Chat_AddTag_owntag")
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_owntag(Pos)
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_owntag")
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_owntag(Pos, NewPos)
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_owntag")
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

function ATAG:ChangePrimaryKey( type, old, new )
	
	if not ( old or new or old != "" or new != "" ) then return end
	
	net.Start("ATAG_ChangePrimaryKey")
		net.WriteString( type )
		net.WriteString( old )
		net.WriteString( new )
	net.SendToServer()
	
end

-- "addons\\atags\\lua\\atags\\cl_tags.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ATAG.Tags = {}
ATAG.SB_Tags = {}
ATAG.ChatTags = {}

ATAG.CanEditOwnChatTag = false

local PANEL = {}

function PANEL:Init()
	self:MakePopup()
	self:SetTitle("aTags - By ikefi")
	self:SetSizable(true)
	self:SetMinWidth(600)
	self:SetMinHeight(400)
	
	self:SetSize(cookie.GetNumber("ATAG_Frame_w", nil) or 600, cookie.GetNumber("ATAG_Frame_h", nil) or 400)
	self:SetPos(cookie.GetNumber("ATAG_Frame_x", nil) or (ScrW() / 2) - (self:GetWide() / 2), cookie.GetNumber("ATAG_Frame_y", nil) or (ScrH() / 2) - (self:GetTall() / 2))
	self.Paint = function(pnl, w, h)
		surface.SetDrawColor(100, 150, 200)
		surface.DrawRect(0, 0, w, h)
	end
	
	ATAG.GUI = vgui.Create("atags_main_gui", self)
end
vgui.Register("atags_frame_gui", PANEL, "DFrame")

function ATAG.OpenGui()
	if IsValid(ATAG.Frame) then return end
	ATAG.Frame = vgui.Create("atags_frame_gui")
end

hook.Add("PlayerButtonDown", "scoreboardtags_opengui_chat", function(ply, btn)
	if ATAG.Key == nil then return end
	if ply ~= LocalPlayer() then return end
	if btn ~= ATAG.Key then return end
	ATAG.OpenGui()
end)

net.Receive("ATAG_OpenMenu", function()
	ATAG.OpenGui()
end)

concommand.Add(ATAG.ConCommand, ATAG.OpenGui)

function ATAG.SetFrameSize(w, h)

	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if w then
		pnl:SetWide(w)
	end
	
	if h then
		pnl:SetTall(h)
	end
	
end

function ATAG.SetFramePos(x, y, center)
	
	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if x then
		pnl:SetPos(x, nil)
	end
	
	if y then
		pnl:SetPos(nil, y)
	end
	
	if center then
		pnl:Center()
	end
	
end

function ATAG.SaveFrameSettings()

	local pnl = ATAG.Frame
	
	if not IsValid(pnl) then return end

	local Pos_x, Pos_y = pnl:GetPos()
	local Size_w, Size_h = pnl:GetSize()
	
	cookie.Set("ATAG_Frame_x", Pos_x)
	cookie.Set("ATAG_Frame_y", Pos_y)
	cookie.Set("ATAG_Frame_w", Size_w)
	cookie.Set("ATAG_Frame_h", Size_h)

end

function ATAG.NotifyMessage(msg, duration)
	if not msg or msg == "" then return end
	
	if not IsValid(ATAG.GUI) then return end
	
	ATAG.GUI:SetNotifyMessage(msg, duration)
	
end

function ATAG:GetScoreboardTag( ply )
	
	if not ply:GetNWBool( "aTags_sb_hasTag", false ) then
		return "", Color( 255, 255, 255 )
	end
	
	local name = ply:GetNWString( "aTags_sb_name", "" )
	local color = ply:GetNWString( "aTags_sb_color", "" )
	
	if not color or color == "" then
		color = Color( 255, 255, 255 )
	else
		color = string.ToColor( color )
	end
	
	return name, color
	
end

-- Needed Scoreboard Data
function ATAG.GetScoreBoardTagData()
	net.Start("ATAG_GetSBTagData")
	net.SendToServer()
end

net.Receive("ATAG_SendSBTagData", function()
	ATAG.SB_Tags = net.ReadTable()
end)

-- USE TAGS
function ATAG.UseTag(TagID, Type)
	net.Start("ATAG_SelectUserTags")
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

function ATAG.GetUserTags()
	net.Start("ATAG_GetUserTags")
	net.SendToServer()
end

net.Receive("ATAG_SendUserTags", function()
	ATAG.Tags_MyTags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Tags_FillTags(ATAG.Tags_MyTags)
	
	if ATAG.Tags_MyTags.SB_CST then
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(true)
	else
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(false)
	end
end)

-- TAGS
function ATAG.AddTag(name, color)
	if not color then return end
	if name == "" then ATAG.NotifyMessage("A tag can not be an empty string.") return end
	
	net.Start("ATAG_Tags_AddTag")
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.RemoveTag(ID)
	if not ID then return end
	net.Start("ATAG_Tags_RemoveTag")
		net.WriteString(tostring(ID))
	net.SendToServer()
end

function ATAG.EditTag(ID, name, color)
	if not ID then return end
	if not color then return end
	if name == "" then return end
	
	net.Start("ATAG_Tags_EditTag")
		net.WriteString(tostring(ID))
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.GetTags()
	net.Start("ATAG_Tags_GetTags")
	net.SendToServer()
end

net.Receive("ATAG_Tags_SendTags", function()
	ATAG.Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_FillTagList(ATAG.Tags)
	ATAG.GUI:Admin_PlayerTags_FillTags(ATAG.Tags)
end)





-- Scoreboard Tags

function ATAG.SB_SetOwnTag(Name, color)
	if not Name or Name == "" then return end
	if not color then return end

	net.Start("ATAG_Scoreboard_SetOwnTag")
		net.WriteString(Name)
		net.WriteTable(color)
	net.SendToServer()
	
end

function ATAG.SB_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Scoreboard_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.SB_SetAutoAssignedTag_rank(Rank, TagID, Type)
	if not Rank then return end
	if not TagID then end
	if not Type then return end
	
	net.Start("ATAG_Scoreboard_SetAutoAssignedTag_rank")
		net.WriteString(Rank)
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

-- PLAYERS
function ATAG.SB_GetPlayers()
	net.Start("ATAG_Scoreboard_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendPlayers", function()
	ATAG.PlayerTags_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillPlayers()
end)

function ATAG.SB_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Scoreboard_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

function ATAG.SB_GetTags_player(SteamID)
	net.Start("ATAG_Scoreboard_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_player", function()
	ATAG.SB_Player_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_player(ATAG.SB_Player_Tags)
end)

-- RANKS
function ATAG.SB_GetRanks()
	net.Start("ATAG_Scoreboard_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendRanks", function()
	ATAG.Scoreboard_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillRanks()
end)

function ATAG.SB_AddRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_GetTags_rank(Rank)
	net.Start("ATAG_Scoreboard_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_rank", function()
	ATAG.SB_Rank_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_rank(ATAG.SB_Rank_Tags)
end)

-- Custom Tags
function ATAG.SB_AddCustomTag(Type, PKey, TagName, TagColor)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagName or TagName == "" then return end
	if not TagColor then TagColor = Color(255, 255, 255) end
	
	net.Start("ATAG_Scoreboard_AddCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(TagName)
		net.WriteTable({TagColor.r, TagColor.g, TagColor.b})
	net.SendToServer()
end

function ATAG.SB_RemoveCustomTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

-- Existing Tags
function ATAG.SB_AddTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_AddTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

function ATAG.SB_RemoveTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end






-- Chat Tags

net.Receive("ATAG_Chat_SendUsingChatTags", function()
	ATAG.ChatTags = net.ReadTable()
end)

-- Ranks
function ATAG.CH_GetTags_rank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_rank", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetRanks()
	net.Start("ATAG_Chat_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendRanks", function()
	ATAG.Chat_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillRanks()
end)

function ATAG.CH_AddRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.CH_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_rank(Rank, Name, color)
	if not Rank or Rank == "" then return end
	if not Name then return end
	if not color then return end
	
	net.Start("ATAG_Chat_AddTag_rank")
		net.WriteString(Rank)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_rank(Rank, Pos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	
	net.Start("ATAG_Chat_RemoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_rank(Rank, Pos, NewPos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Players
function ATAG.CH_GetTags_player(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_player", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetPlayers()
	net.Start("ATAG_Chat_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendPlayers", function()
	ATAG.Chat_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillPlayers()
end)

function ATAG.CH_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Chat_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_player(SteamID, Name, color)
	if not SteamID or SteamID == "" then return end
	if not Name then return end
	if not color then return end
	net.Start("ATAG_Chat_AddTag_player")
		net.WriteString(SteamID)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_player(SteamID, Pos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_player(SteamID, Pos, NewPos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Own Tag
function ATAG.CH_GetCanSetOwnTag()
	net.Start("ATAG_Chat_GetCanSetOwnTag")
	net.SendToServer()
end

timer.Simple(1, function()
	ATAG.CH_GetCanSetOwnTag()
end)

net.Receive("ATAG_Chat_SendCanSetOwnTag", function()
	local bool = net.ReadString()
	
	if bool == "true" then
		ATAG.CanEditOwnChatTag = true
		
		if not IsValid(ATAG.GUI) then return end
		if IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI:Create_TagEdit()
	else
		ATAG.CanEditOwnChatTag = false
		
		if not IsValid(ATAG.GUI) then return end
		if not IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI.Tabs:CloseTab(ATAG.GUI.TagEdit_Tab)
	end
end)

function ATAG.CH_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Chat_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.CH_GetOwnTags()
	net.Start("ATAG_Chat_GetOwnTag")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendOwnTag", function()
	ATAG.OwnTag = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	
	if not IsValid(ATAG.GUI) then return end
	if not ATAG.GUI.TagEdit then return end
	
	ATAG.GUI:TagEdit_FillTags(ATAG.OwnTag, Pos)
end)

function ATAG.CH_AddTagPiece_owntag(Name, color)
	if not Name then return end
	if not color then return end
	
	if not ATAG.AllowUserToChangeChatMessageColor then
		if Name == "\\MESSAGE" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	if not ATAG.AllowUserToChangePlayerNameColor then
		if Name == "\\NAMECOL" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	
	net.Start("ATAG_Chat_AddTag_owntag")
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_owntag(Pos)
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_owntag")
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_owntag(Pos, NewPos)
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_owntag")
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

function ATAG:ChangePrimaryKey( type, old, new )
	
	if not ( old or new or old != "" or new != "" ) then return end
	
	net.Start("ATAG_ChangePrimaryKey")
		net.WriteString( type )
		net.WriteString( old )
		net.WriteString( new )
	net.SendToServer()
	
end

-- "addons\\atags\\lua\\atags\\cl_tags.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ATAG.Tags = {}
ATAG.SB_Tags = {}
ATAG.ChatTags = {}

ATAG.CanEditOwnChatTag = false

local PANEL = {}

function PANEL:Init()
	self:MakePopup()
	self:SetTitle("aTags - By ikefi")
	self:SetSizable(true)
	self:SetMinWidth(600)
	self:SetMinHeight(400)
	
	self:SetSize(cookie.GetNumber("ATAG_Frame_w", nil) or 600, cookie.GetNumber("ATAG_Frame_h", nil) or 400)
	self:SetPos(cookie.GetNumber("ATAG_Frame_x", nil) or (ScrW() / 2) - (self:GetWide() / 2), cookie.GetNumber("ATAG_Frame_y", nil) or (ScrH() / 2) - (self:GetTall() / 2))
	self.Paint = function(pnl, w, h)
		surface.SetDrawColor(100, 150, 200)
		surface.DrawRect(0, 0, w, h)
	end
	
	ATAG.GUI = vgui.Create("atags_main_gui", self)
end
vgui.Register("atags_frame_gui", PANEL, "DFrame")

function ATAG.OpenGui()
	if IsValid(ATAG.Frame) then return end
	ATAG.Frame = vgui.Create("atags_frame_gui")
end

hook.Add("PlayerButtonDown", "scoreboardtags_opengui_chat", function(ply, btn)
	if ATAG.Key == nil then return end
	if ply ~= LocalPlayer() then return end
	if btn ~= ATAG.Key then return end
	ATAG.OpenGui()
end)

net.Receive("ATAG_OpenMenu", function()
	ATAG.OpenGui()
end)

concommand.Add(ATAG.ConCommand, ATAG.OpenGui)

function ATAG.SetFrameSize(w, h)

	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if w then
		pnl:SetWide(w)
	end
	
	if h then
		pnl:SetTall(h)
	end
	
end

function ATAG.SetFramePos(x, y, center)
	
	local pnl = ATAG.Frame

	if not IsValid(pnl) then return end
	
	if x then
		pnl:SetPos(x, nil)
	end
	
	if y then
		pnl:SetPos(nil, y)
	end
	
	if center then
		pnl:Center()
	end
	
end

function ATAG.SaveFrameSettings()

	local pnl = ATAG.Frame
	
	if not IsValid(pnl) then return end

	local Pos_x, Pos_y = pnl:GetPos()
	local Size_w, Size_h = pnl:GetSize()
	
	cookie.Set("ATAG_Frame_x", Pos_x)
	cookie.Set("ATAG_Frame_y", Pos_y)
	cookie.Set("ATAG_Frame_w", Size_w)
	cookie.Set("ATAG_Frame_h", Size_h)

end

function ATAG.NotifyMessage(msg, duration)
	if not msg or msg == "" then return end
	
	if not IsValid(ATAG.GUI) then return end
	
	ATAG.GUI:SetNotifyMessage(msg, duration)
	
end

function ATAG:GetScoreboardTag( ply )
	
	if not ply:GetNWBool( "aTags_sb_hasTag", false ) then
		return "", Color( 255, 255, 255 )
	end
	
	local name = ply:GetNWString( "aTags_sb_name", "" )
	local color = ply:GetNWString( "aTags_sb_color", "" )
	
	if not color or color == "" then
		color = Color( 255, 255, 255 )
	else
		color = string.ToColor( color )
	end
	
	return name, color
	
end

-- Needed Scoreboard Data
function ATAG.GetScoreBoardTagData()
	net.Start("ATAG_GetSBTagData")
	net.SendToServer()
end

net.Receive("ATAG_SendSBTagData", function()
	ATAG.SB_Tags = net.ReadTable()
end)

-- USE TAGS
function ATAG.UseTag(TagID, Type)
	net.Start("ATAG_SelectUserTags")
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

function ATAG.GetUserTags()
	net.Start("ATAG_GetUserTags")
	net.SendToServer()
end

net.Receive("ATAG_SendUserTags", function()
	ATAG.Tags_MyTags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Tags_FillTags(ATAG.Tags_MyTags)
	
	if ATAG.Tags_MyTags.SB_CST then
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(true)
	else
		ATAG.GUI.Tags.tg.container_1_2:SetVisible(false)
	end
end)

-- TAGS
function ATAG.AddTag(name, color)
	if not color then return end
	if name == "" then ATAG.NotifyMessage("A tag can not be an empty string.") return end
	
	net.Start("ATAG_Tags_AddTag")
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.RemoveTag(ID)
	if not ID then return end
	net.Start("ATAG_Tags_RemoveTag")
		net.WriteString(tostring(ID))
	net.SendToServer()
end

function ATAG.EditTag(ID, name, color)
	if not ID then return end
	if not color then return end
	if name == "" then return end
	
	net.Start("ATAG_Tags_EditTag")
		net.WriteString(tostring(ID))
		net.WriteString(name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.GetTags()
	net.Start("ATAG_Tags_GetTags")
	net.SendToServer()
end

net.Receive("ATAG_Tags_SendTags", function()
	ATAG.Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_FillTagList(ATAG.Tags)
	ATAG.GUI:Admin_PlayerTags_FillTags(ATAG.Tags)
end)





-- Scoreboard Tags

function ATAG.SB_SetOwnTag(Name, color)
	if not Name or Name == "" then return end
	if not color then return end

	net.Start("ATAG_Scoreboard_SetOwnTag")
		net.WriteString(Name)
		net.WriteTable(color)
	net.SendToServer()
	
end

function ATAG.SB_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Scoreboard_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.SB_SetAutoAssignedTag_rank(Rank, TagID, Type)
	if not Rank then return end
	if not TagID then end
	if not Type then return end
	
	net.Start("ATAG_Scoreboard_SetAutoAssignedTag_rank")
		net.WriteString(Rank)
		net.WriteString(TagID)
		net.WriteString(Type)
	net.SendToServer()
end

-- PLAYERS
function ATAG.SB_GetPlayers()
	net.Start("ATAG_Scoreboard_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendPlayers", function()
	ATAG.PlayerTags_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillPlayers()
end)

function ATAG.SB_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	
	net.Start("ATAG_Scoreboard_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.SB_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Scoreboard_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

function ATAG.SB_GetTags_player(SteamID)
	net.Start("ATAG_Scoreboard_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_player", function()
	ATAG.SB_Player_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_player(ATAG.SB_Player_Tags)
end)

-- RANKS
function ATAG.SB_GetRanks()
	net.Start("ATAG_Scoreboard_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendRanks", function()
	ATAG.Scoreboard_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillRanks()
end)

function ATAG.SB_AddRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	
	net.Start("ATAG_Scoreboard_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.SB_GetTags_rank(Rank)
	net.Start("ATAG_Scoreboard_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Scoreboard_SendTags_rank", function()
	ATAG.SB_Rank_Tags = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Scoreboard_FillTags_rank(ATAG.SB_Rank_Tags)
end)

-- Custom Tags
function ATAG.SB_AddCustomTag(Type, PKey, TagName, TagColor)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagName or TagName == "" then return end
	if not TagColor then TagColor = Color(255, 255, 255) end
	
	net.Start("ATAG_Scoreboard_AddCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(TagName)
		net.WriteTable({TagColor.r, TagColor.g, TagColor.b})
	net.SendToServer()
end

function ATAG.SB_RemoveCustomTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveCustomTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

-- Existing Tags
function ATAG.SB_AddTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_AddTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end

function ATAG.SB_RemoveTag(Type, PKey, TagID)
	if not (Type == "player" or Type == "rank") then return end
	if not PKey or PKey == "" then return end
	if not TagID then return end
	
	net.Start("ATAG_Scoreboard_RemoveTag")
		net.WriteString(Type)
		net.WriteString(PKey)
		net.WriteString(tostring(TagID))
	net.SendToServer()
end






-- Chat Tags

net.Receive("ATAG_Chat_SendUsingChatTags", function()
	ATAG.ChatTags = net.ReadTable()
end)

-- Ranks
function ATAG.CH_GetTags_rank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_GetTags_rank")
		net.WriteString(Rank)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_rank", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetRanks()
	net.Start("ATAG_Chat_GetRanks")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendRanks", function()
	ATAG.Chat_Ranks = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillRanks()
end)

function ATAG.CH_AddRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_AddRank")
		net.WriteString(Rank)
	net.SendToServer()
end

function ATAG.CH_RemoveRank(Rank)
	if not Rank or Rank == "" then return end
	net.Start("ATAG_Chat_RemoveRank")
		net.WriteString(Rank)
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_rank(Rank, Name, color)
	if not Rank or Rank == "" then return end
	if not Name then return end
	if not color then return end
	
	net.Start("ATAG_Chat_AddTag_rank")
		net.WriteString(Rank)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_rank(Rank, Pos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	
	net.Start("ATAG_Chat_RemoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_rank(Rank, Pos, NewPos)
	if not Rank or Rank == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_rank")
		net.WriteString(Rank)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Players
function ATAG.CH_GetTags_player(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_GetTags_player")
		net.WriteString(SteamID)
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendTags_player", function()
	ATAG.Chat_Tags = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillTags(ATAG.Chat_Tags, Pos)
end)

function ATAG.CH_GetPlayers()
	net.Start("ATAG_Chat_GetPlayers")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendPlayers", function()
	ATAG.Chat_Players = net.ReadTable()
	if not IsValid(ATAG.GUI) then return end
	ATAG.GUI:Admin_Chat_FillPlayers()
end)

function ATAG.CH_AddPlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_AddPlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_RemovePlayer(SteamID)
	if not SteamID or SteamID == "" then return end
	net.Start("ATAG_Chat_RemovePlayer")
		net.WriteString(SteamID)
	net.SendToServer()
end

function ATAG.CH_ChangePlayerName(SteamID, Name)
	if not SteamID then return end
	
	net.Start("ATAG_Chat_ChangePlayerName")
		net.WriteString(SteamID)
		if Name then
			net.WriteString(Name)
		end
	net.SendToServer()
end

-- Tag piece
function ATAG.CH_AddTagPiece_player(SteamID, Name, color)
	if not SteamID or SteamID == "" then return end
	if not Name then return end
	if not color then return end
	net.Start("ATAG_Chat_AddTag_player")
		net.WriteString(SteamID)
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_player(SteamID, Pos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_player(SteamID, Pos, NewPos)
	if not SteamID or SteamID == "" then return end
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_player")
		net.WriteString(SteamID)
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

-- Own Tag
function ATAG.CH_GetCanSetOwnTag()
	net.Start("ATAG_Chat_GetCanSetOwnTag")
	net.SendToServer()
end

timer.Simple(1, function()
	ATAG.CH_GetCanSetOwnTag()
end)

net.Receive("ATAG_Chat_SendCanSetOwnTag", function()
	local bool = net.ReadString()
	
	if bool == "true" then
		ATAG.CanEditOwnChatTag = true
		
		if not IsValid(ATAG.GUI) then return end
		if IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI:Create_TagEdit()
	else
		ATAG.CanEditOwnChatTag = false
		
		if not IsValid(ATAG.GUI) then return end
		if not IsValid(ATAG.GUI.TagEdit_Tab) then return end
		ATAG.GUI.Tabs:CloseTab(ATAG.GUI.TagEdit_Tab)
	end
end)

function ATAG.CH_ToggleCanSetOwnTag(Type, Value)
	if not (Type == "player" or Type == "rank") then return end
	if not Value or Value == "" then return end
	
	net.Start("ATAG_Chat_ToggleCanSetOwnTag")
		net.WriteString(Type)
		net.WriteString(Value)
	net.SendToServer()
end

function ATAG.CH_GetOwnTags()
	net.Start("ATAG_Chat_GetOwnTag")
	net.SendToServer()
end

net.Receive("ATAG_Chat_SendOwnTag", function()
	ATAG.OwnTag = net.ReadTable()
	local Pos = tonumber(net.ReadString())
	
	if not IsValid(ATAG.GUI) then return end
	if not ATAG.GUI.TagEdit then return end
	
	ATAG.GUI:TagEdit_FillTags(ATAG.OwnTag, Pos)
end)

function ATAG.CH_AddTagPiece_owntag(Name, color)
	if not Name then return end
	if not color then return end
	
	if not ATAG.AllowUserToChangeChatMessageColor then
		if Name == "\\MESSAGE" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	if not ATAG.AllowUserToChangePlayerNameColor then
		if Name == "\\NAMECOL" then ATAG.NotifyMessage("You do not have the permissions to do that!") return end
	end
	
	net.Start("ATAG_Chat_AddTag_owntag")
		net.WriteString(Name)
		net.WriteTable({color.r, color.g, color.b})
	net.SendToServer()
end

function ATAG.CH_RemoveTagPiece_owntag(Pos)
	if not Pos then return end
	net.Start("ATAG_Chat_RemoveTag_owntag")
		net.WriteString(tostring(Pos))
	net.SendToServer()
end

function ATAG.CH_MoveTagPiece_owntag(Pos, NewPos)
	if not Pos then return end
	if not NewPos then return end
	net.Start("ATAG_Chat_MoveTag_owntag")
		net.WriteString(tostring(Pos))
		net.WriteString(tostring(NewPos))
	net.SendToServer()
end

function ATAG:ChangePrimaryKey( type, old, new )
	
	if not ( old or new or old != "" or new != "" ) then return end
	
	net.Start("ATAG_ChangePrimaryKey")
		net.WriteString( type )
		net.WriteString( old )
		net.WriteString( new )
	net.SendToServer()
	
end

