-- "addons\\atags\\lua\\atags\\vgui\\atags_main_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local icon_up = "icon16/bullet_arrow_up.png"
local icon_down = "icon16/bullet_arrow_down.png"
local icon_player = "icon16/user.png"
local icon_rank = "icon16/award_star_gold_1.png"

local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self.Paint = function(pnl, w, h) end
	
	local NotifyLabel = vgui.Create("DLabel", self)
		NotifyLabel:SetText("")
		NotifyLabel:SizeToContents()
		NotifyLabel:SetPos(0, 5)
		NotifyLabel:SetTextColor(Color(0, 0, 0))
		
		self.NotifyLabel = NotifyLabel

	local Tabs = vgui.Create("DPropertySheet", self)
	Tabs:Dock(FILL)
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end

	self.Tabs = Tabs
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Scoreboard Tags", Tags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self.Tags = {}
	self:Fill_Tags(Tags)
	
	if ATAG.CanEditOwnChatTag then
		local TagEdit = vgui.Create("DPanel")
		local Tab_TagEdit = Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
		self:PaintTab(Tabs, TagEdit, Tab_TagEdit)
		self.TagEdit = {}
		self:Fill_TagEdit(TagEdit)
		
		self.TagEdit_Tab = Tab_TagEdit.Tab
		
		ATAG.CH_GetOwnTags()
	end
	
	ATAG.CH_GetCanSetOwnTag()
	
	if ATAG:HasPermissions(LocalPlayer()) then
		local Admin = vgui.Create("DPanel")
		local Tab_Admin = Tabs:AddSheet("Admin", Admin, "icon16/shield.png", false, false, nil)
		self:PaintTab(Tabs, Admin, Tab_Admin)
		self.Admin = {}
		self:Fill_Admin(Admin)
	end
	
	local Settings = vgui.Create("DPanel") -- Currently disabled, no settings yet.
	local Tab_Settings = Tabs:AddSheet("Settings", Settings, "icon16/wrench.png", false, false, nil)
	self:PaintTab(Tabs, Settings, Tab_Settings)
	self.Settings = {}
	self:Fill_Settings(Settings)
	
end

function PANEL:SetNotifyMessage(msg, duration)
	
	self.NotifyLabel.Think = function(pnl) end

	self.NotifyLabel:SetText(msg)
	self.NotifyLabel:SizeToContents()
	self.NotifyLabel:SetPos(self:GetWide() - self.NotifyLabel:GetWide(), 5)
	self.NotifyLabel:SetTextColor(Color(0, 0, 0, 255))
	self.NotifyLabel.EndAlpha = duration or 5000
	self.NotifyLabel.ShouldFade = true
	
	self.NotifyLabel.Think = function(pnl)
		if pnl.ShouldFade then
			if not pnl.EndAlpha then
				pnl.EndAlpha = duration or 5000
			end
			
			if pnl.EndAlpha ~= 0 then
				pnl.EndAlpha = math.Approach(pnl.EndAlpha, 0, (math.abs(pnl.EndAlpha - 0) + 1) * 1 * FrameTime())
				if pnl.EndAlpha <= 255 then
					pnl:SetTextColor(Color(0, 0, 0, pnl.EndAlpha))
				end
			else
				pnl.ShouldFade = false
			end
		end
	end
end

function PANEL:PaintTab(parent, panel, tab)

	panel.Paint = function(pnl, w, h) end
	
	tab.Tab.Paint = function(pnl, w, h)
		if parent:GetActiveTab() == pnl then
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h-7)
			surface.SetDrawColor(230, 230, 230)
			surface.DrawRect(1, 1, w-2, h-7)
		else
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(180, 180, 180)
			surface.DrawRect(1, 1, w-2, h)
		end
	end
end

function PANEL:ListPaint(panel, ln)
	panel.Paint = function(pnl, w, h)
		if ln:IsSelected() then
			surface.SetDrawColor(80, 130, 255)
		elseif ln:IsHovered() then
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(165, 170, 200)
			else
				surface.SetDrawColor(210, 215, 250)
			end
		else
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(100, 100, 100)
			end
		end
		surface.DrawRect(0, 0, w, h)
		surface.SetTextColor(ln.data[3])
		surface.SetTextPos(5, 2)
		surface.SetFont("DermaDefault") -- Doing this because font size will but out??? cba to figure out why.
		surface.DrawText(ln.data[2])
	end
end

-- TAGS
function PANEL:Fill_Tags(panel)

	self.Tags.tg = {}

	local CurrentTagContainer = vgui.Create("DPanel", panel)
	CurrentTagContainer:Dock(TOP)
	CurrentTagContainer:DockMargin(0, 4, 0, 0)
	CurrentTagContainer:SetTall(30)
	CurrentTagContainer.Paint = function(pnl, w, h) end
	
	local CurrentTagLabel = vgui.Create("DLabel", CurrentTagContainer)
	CurrentTagLabel:Dock(LEFT)
	CurrentTagLabel:SetWide(65)
	CurrentTagLabel:DockMargin(4, 0, 0, 0)
	CurrentTagLabel:SetText("Current Tag: ")
	CurrentTagLabel:SetTextColor(Color(0, 0, 0))
	
	local CurrentTag = vgui.Create("DPanel", CurrentTagContainer)
	CurrentTag:Dock( FILL )
	CurrentTag:DockMargin(4, 0, 0, 0)
	CurrentTag.Paint = function( pnl, w, h )
		
		local name, color = LocalPlayer():getScoreboardTag()
		
		surface.SetTextColor( color or Color( 255, 255, 255 ) )
		surface.SetFont("DermaDefault")
		surface.SetTextPos( 0, ( h/2 ) - ( select( 2, surface.GetTextSize(  "" ) )/2 ) )
		surface.DrawText( name or "" )
		
	end
	
	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(FILL)
		container_1:DockMargin(0, 0, 0, 0)
		container_1.Paint = function() end
	
	local container_1_1 = vgui.Create("DPanel", container_1)
		container_1_1:Dock(FILL)
		container_1_1:DockMargin(0, 0, 0, 0)
		container_1_1.Paint = function() end
	
	local ButtonContainer = vgui.Create("DPanel", container_1_1)
	ButtonContainer:Dock(BOTTOM)
	ButtonContainer:DockMargin(0, 4, 0, 0)
	ButtonContainer:SetTall(30)
	
	local UseBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseBtn:Dock(FILL)
	UseBtn:DockMargin(0, 0, 0, 0)
	UseBtn:SetText("Use Tag")
	
	local UseNoneBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseNoneBtn:Dock(RIGHT)
	UseNoneBtn:DockMargin(4, 0, 0, 0)
	UseNoneBtn:SetWide(120)
	UseNoneBtn:SetText("Use none")
	
	local List = vgui.Create("DListView", container_1_1)
	List:Dock(FILL)
	List:DockMargin(0, 0, 0, 0)
	List:SetMultiSelect(false)
	List:AddColumn("Tag")
	List:AddColumn("Type"):SetFixedWidth(120)
	
	self.Tags.List = List
	
	ATAG.GetUserTags()
	
	UseBtn.DoClick = function()
		if not List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag.") return end
		ATAG.UseTag(List:GetLine(List:GetSelectedLine()).data[1], List:GetLine(List:GetSelectedLine()).Type)
	end
	
	UseNoneBtn.DoClick = function()
		ATAG.UseTag(0, "remove")
	end
	
	local container_1_2 = vgui.Create("DPanel", container_1)
		container_1_2:Dock(RIGHT)
		container_1_2:DockMargin(4, 0, 0, 0)
		container_1_2:SetVisible(false)
		container_1_2.Paint = function() end
		
		container_1_2.PerformLayout = function(pnl)
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
		self.Tags.tg.container_1_2 = container_1_2
		
	local container_1_2_1 = vgui.Create("DPanel", container_1_2)
		container_1_2_1:Dock(BOTTOM)
		container_1_2_1:DockMargin(4, 0, 0, 0)
		container_1_2_1.Paint = function() end
		
		container_1_2_1.PerformLayout = function(pnl)
			pnl:SetTall(ATAG.GUI:GetTall()*0.42)
		end
		
	local Mixer = vgui.Create("DColorMixer", container_1_2_1)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 0, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
	
	local SetTagBtn = vgui.Create("ATAG_Button", container_1_2_1)
		SetTagBtn:Dock(BOTTOM)
		SetTagBtn:DockMargin(0, 4, 0, 0)
		SetTagBtn:SetTall(30)
		SetTagBtn:SetText("Set Tag")
	
	local SetTagBox = vgui.Create("DTextEntry", container_1_2_1)
		SetTagBox:Dock(BOTTOM)
		SetTagBox:DockMargin(0, 4, 0, 0)
		SetTagBox:SetTall(25)
		SetTagBox:SetText("")
		
		SetTagBtn.DoClick = function()
			ATAG.SB_SetOwnTag(SetTagBox:GetValue(), Mixer:GetColor())
		end
		
	local container_1_2_2 = vgui.Create("DPanel", container_1_2)
		container_1_2_2:Dock(BOTTOM)
		container_1_2_2:DockMargin(4, 0, 0, 4)
		container_1_2_2:SetTall(20)
		container_1_2_2.Paint = function() end
		
	local InfoLabel = vgui.Create( "DLabel", container_1_2_2)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetText("You can set your own tag!")
		InfoLabel:SetTextColor(Color(0, 0, 0))
	
	if ATAG.Tags_MyTags then
		if ATAG.Tags_MyTags.SB_CST then
			self.Tags.tg.container_1_2:SetVisible(true)
		end
	end
	
end

function PANEL:Tags_FillTags(Tags)
	if not self.Tags then return end
	if not self.Tags.List then return end
	
	local Tags = Tags or ATAG.Tags_MyTags
	
	if not Tags then return end
	
	self.Tags.List:Clear()
	
	if Tags.PTags then
		local Tags = Tags.PTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Player Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Player Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end

	if Tags.RTags then
		local Tags = Tags.RTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Rank Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Rank Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end
	
end


-- ADMIN
function PANEL:Fill_Admin(panel)

	local Tabs = vgui.Create("DPropertySheet", panel)
	Tabs:Dock(FILL)
	
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Global Tags", Tags, "icon16/tag_blue.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self:Admin_Tags(Tags)
	
	local PlayerTags = vgui.Create("DPanel")
	local Tab_PlayerTags = Tabs:AddSheet("Scoreboard Tags", PlayerTags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, PlayerTags, Tab_PlayerTags)
	self:Admin_ScoreboardTags(PlayerTags)
	
	local ChatTags = vgui.Create("DPanel")
	local Tab_ChatTags = Tabs:AddSheet("Chat Tags", ChatTags, "icon16/comment.png", false, false, nil)
	self:PaintTab(Tabs, ChatTags, Tab_ChatTags)
	self:Admin_ChatTags(ChatTags)
	
end

function PANEL:Admin_Tags(panel)
	
	local Mixer_Container = vgui.Create("DPanel", panel)
	Mixer_Container:Dock(RIGHT)
	Mixer_Container:DockMargin(0, 4, 4, 0)
	Mixer_Container:SetWide(150)
	Mixer_Container.Paint = function(pnl, w, h) end
	
	local Mixer = vgui.Create("DColorMixer", Mixer_Container)
	Mixer:Dock(TOP)
	Mixer:DockMargin(0, 0, 0, 0)
	Mixer:SetTall(150)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(true)
	Mixer:SetColor(Color(255, 255, 255))
	
	-- hehe
	Mixer.WangsPanel:Dock(BOTTOM)
	Mixer.WangsPanel:DockMargin(0, 4, 0, 0)
	Mixer.txtR:Dock(LEFT)
	Mixer.txtR:SetWide(47)
	Mixer.txtR:DockMargin( 0, 0, 0, 0 )
	Mixer.txtG:Dock(LEFT)
	Mixer.txtG:SetWide(48)
	Mixer.txtG:DockMargin( 4, 0, 0, 0 )
	Mixer.txtB:Dock(LEFT)
	Mixer.txtB:SetWide(47)
	Mixer.txtB:DockMargin( 4, 0, 0, 0 )
	Mixer.txtA:SetVisible(false)
	
	
	local panel2 = vgui.Create("DPanel", panel)
	panel2:Dock(FILL)
	panel2.Paint = function(pnl, w, h) end
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(BOTTOM)
	panel3:SetTall(25)
	panel3:DockMargin(4, 4, 10, 0)
	panel3.Paint = function(pnl, w, h) end
	
	local DButton = vgui.Create("ATAG_Button", panel3)
	DButton:Dock(FILL)
	DButton:DockMargin(0, 0, 0, 0)
	DButton:SetText("Add Tag")
	
	local DButton2 = vgui.Create("ATAG_Button", panel3)
	DButton2:Dock(RIGHT)
	DButton2:DockMargin(4, 0, 0, 0)
	DButton2:SetWide(100)
	DButton2:SetText("Stop Editing")
	DButton2:SetVisible(false)
	
	local TextEntry = vgui.Create("DTextEntry", panel2)
	TextEntry:Dock(BOTTOM)
	TextEntry:SetTall(25)
	TextEntry:DockMargin(4, 6, 10, 0)
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(FILL)
	panel3.Paint = function(pnl, w, h) end
	
	local DListView = vgui.Create("DListView", panel3)
	DListView:Dock(FILL)
	DListView:DockMargin(4, 4, 10, 0)
	DListView:SetMultiSelect(false)
	
	ATAG.GetTags()
	
	DListView.OnClickLine = function(pnl, ln)	
		if input.IsMouseDown(MOUSE_LEFT) then
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
	end
		
	DListView.OnRowRightClick = function(pnl, n, ln)
		if pnl.Menu then pnl.Menu:Remove() end
		
		local Menu = vgui.Create("DMenu")
		
		Menu:AddOption("Edit", function()
			pnl:ClearSelection()
			pnl:SelectItem(ln)
			DButton:SetText("Edit Tag")
			DButton2:SetVisible(true)
			TextEntry:SetValue(ln.data[2])
			Mixer:SetColor(ln.data[3])
		end):SetIcon("icon16/page_white_gear.png")
		
		Menu:AddOption("Remove", function()
			ATAG.RemoveTag(ln.data[1])
		end):SetIcon("icon16/cross.png")
		
		Menu:Open()
		
		pnl.Menu = Menu
	end
	
	DButton.DoClick = function(pnl)
		if pnl:GetText() == "Edit Tag" then
			ATAG.EditTag(DListView:GetLine(DListView:GetSelectedLine()).data[1], TextEntry:GetValue(), Mixer:GetColor())
			DButton2:SetVisible(false)
			DButton:SetText("Add Tag")
			DListView:ClearSelection()
			DButton:SetVisible(false)
			DButton:SetVisible(true)
			TextEntry:SetValue("")
		else
			ATAG.AddTag(TextEntry:GetValue(), Mixer:GetColor())
		end
	end
	
	DButton2.DoClick = function()
		DButton2:SetVisible(false)
		DButton:SetText("Add Tag")
		DListView:ClearSelection()
		DButton:SetVisible(false)
		DButton:SetVisible(true)
		TextEntry:SetValue("")
	end
	
	DListView:AddColumn("Tag")
	
	self.Admin.List = DListView
end

function PANEL:Admin_ScoreboardTags(panel)
	
	self.Admin.sbtags = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(RIGHT)
		container_2:DockMargin(4, 4, 4, 4)
		container_2:SetWide(150)
		container_2.Paint = function(pnl, w, h) end
		
		container_2.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_3 = vgui.Create("DPanel", panel)
		container_3:Dock(RIGHT)
		container_3:DockMargin(4, 4, 4, 4)
		container_3:SetWide(25)
		container_3.Paint = function(pnl, w, h) end

	local container_4 = vgui.Create("DPanel", panel)
		container_4:Dock(FILL)
		container_4:DockMargin(4, 4, 4, 4)
		container_4.Paint = function(pnl, w, h) end
		
	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
	
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.sbtags.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				self.Admin.sbtags.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.SB_GetRanks()
				self:Admin_Scoreboard_FillRanks()
				
				self.Admin.sbtags.AddBox:SetText("Rank (Name)")
				self.Admin.sbtags.AddButton:SetText("Add Rank")
				self.Admin.sbtags.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.sbtags.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.sbtags.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.sbtags.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.sbtags.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.sbtags.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.sbtags.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.sbtags.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
					
				
			elseif self.Admin.sbtags.TYPE == "rank" then
				self.Admin.sbtags.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.SB_GetPlayers()
				self:Admin_Scoreboard_FillPlayers()
				
				self.Admin.sbtags.AddBox:SetText("Player (SteamID)")
				self.Admin.sbtags.AddButton:SetText("Add Player")
				self.Admin.sbtags.List.Column:SetName("Player")
				self.Admin.sbtags.aList.Column:SetName("Currently Online Players")
				
				self.Admin.sbtags.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self.Admin.sbtags.GlobalList:Clear()
			self.Admin.sbtags.CustomList:Clear()
		end
	
	-- Search in the list.
	-- If the aList is visible it will search in that list.
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:Clear()
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
	
	
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.sbtags.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
				
				end
				
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers()
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks()
				end
			else
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers(value)
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks(value)
				end
			end
		end
	
	-- The list with the Players or Ranks.
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.sbtags.List = List
		
		ATAG.SB_GetPlayers()

		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if not ln.data then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_GetTags_player(ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "scoreboard")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.SB_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.SB_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.sbtags.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.SB_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.sbtags.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	-- Button to add a player or rank.
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.sbtags.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddPlayer(self.Admin.sbtags.AddBox:GetValue())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddRank(self.Admin.sbtags.AddBox:GetValue())
			end
		end
		
	-- Container to make the Dock work.
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)

	-- Button to make the aList visible.
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))
		
		aListBtn.DoClick = function(pnl)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.sbtags.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.sbtags.aList:Clear()
				
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.sbtags.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.sbtags.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.sbtags.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.sbtags.List:SetVisible(false)
			self.Admin.sbtags.List:SetVisible(true)
		end
	
	-- Textbox to add a player or rank.
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.sbtags.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
	
	-- List for the online players or all ULX / evolve ranks.
	local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:DockMargin(0, 0, 0, 0)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.sbtags.aList = aList

		aList.OnClickLine = function(pnl, ln)
			self.Admin.sbtags.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
	-- Container 2
	-- List for global tags.
	local GlobalTagList = vgui.Create("DListView", container_2)
		GlobalTagList:Dock(FILL)
		GlobalTagList:DockMargin(0, 0, 0, 0)
		GlobalTagList:SetMultiSelect(false)
		GlobalTagList:AddColumn("Tags")
		
		self.Admin.sbtags.GlobalTagList = GlobalTagList
		
		GlobalTagList.OnClickLine = function(pnl, ln)		
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalTagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Add", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/add.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local CustomTag_Container = vgui.Create("DPanel", container_2)
		CustomTag_Container:Dock(BOTTOM)
		CustomTag_Container.Paint = function() end
		
		CustomTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
	
	-- Button to add a custom tag.
	local AddCustomTagBtn = vgui.Create("ATAG_Button", CustomTag_Container)
		AddCustomTagBtn:Dock(BOTTOM)
		AddCustomTagBtn:DockMargin(0, 4, 0, 0)
		AddCustomTagBtn:SetTall(25)
		AddCustomTagBtn:SetText("Add Custom Tag")
		
		AddCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			end
		end
	
	-- TextBox for the custom tag.
	local CustomTagBox = vgui.Create("DTextEntry", CustomTag_Container)
		CustomTagBox:Dock(BOTTOM)
		CustomTagBox:DockMargin(0, 4, 0, 0)
		CustomTagBox:SetTall(25)
		CustomTagBox:SetText("Custom Tag")
		
		self.Admin.sbtags.CustomTagBox = CustomTagBox
		
		CustomTagBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Custom Tag" then
				pnl:SetValue("")
			end
		end
		CustomTagBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Custom Tag")
			end
		end
	
	-- Color mixer for the custom tag.
	local Mixer = vgui.Create("DColorMixer", CustomTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.sbtags.Mixer = Mixer
		
	-- Container 3
	-- Button to add a global tag.
	local AddTagButton = vgui.Create("ATAG_Button", container_3)
		AddTagButton:Dock(TOP)
		AddTagButton:DockMargin(0, 40, 0, 0)
		AddTagButton:SetTall(25)
		AddTagButton:SetIcon(icon_up)
		AddTagButton:SetIconRotation(90)
		AddTagButton:SetIconColor(Color(0, 0, 0, 120))
		
		AddTagButton.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalTagList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to add.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a global tag.
	local RemoveTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveTagBtn:Dock(TOP)
		RemoveTagBtn:DockMargin(0, 4, 0, 0)
		RemoveTagBtn:SetTall(25)
		RemoveTagBtn:SetIcon(icon_down)
		RemoveTagBtn:SetIconRotation(90)
		RemoveTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a custom tag.
	local RemoveCustomTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveCustomTagBtn:Dock(BOTTOM)
		RemoveCustomTagBtn:DockMargin(0, 0, 0, 55)
		RemoveCustomTagBtn:SetTall(25)
		RemoveCustomTagBtn:SetIcon(icon_down)
		RemoveCustomTagBtn:SetIconRotation(90)
		RemoveCustomTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.CustomList:GetSelectedLine() then ATAG.NotifyMessage("Please select the custom tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			end
		end
	
	-- Container 4
	-- List for the global tags the player / rank has.
	local GlobalList = vgui.Create("DListView", container_4)
		GlobalList:Dock(FILL)
		GlobalList:DockMargin(0, 0, 0, 0)
		GlobalList:SetMultiSelect(false)
		GlobalList:AddColumn("Tag")
		
		self.Admin.sbtags.GlobalList = GlobalList
		
		GlobalList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
	
	-- List for the custom tags the player / rank has.
	local CustomList_Container = vgui.Create("DPanel", container_4)
		CustomList_Container:Dock(BOTTOM)
		CustomList_Container:DockMargin(0, 4, 0, 0)
		CustomList_Container:SetTall(140)
		
		CustomList_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local CustomList = vgui.Create("DListView", CustomList_Container)
		CustomList:Dock(FILL)
		CustomList:DockMargin(0, 0, 0, 0)
		CustomList:SetMultiSelect(false)
		CustomList:AddColumn("Custom Tag")
		
		self.Admin.sbtags.CustomList = CustomList
		
		CustomList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		CustomList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
end

function PANEL:Admin_CanSetOwnTag(ln)
	ln.PaintOver = function(pnl, w, h)
		if ln.data.CST then
			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(50, 50, 50))
			surface.DrawOutlinedRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/pencil.png"))
			surface.DrawTexturedRect(w-16, 0, 16, 16)
		end
		if ln.data.AA then
			if ln.data.CST then
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16-16, 0, 16, 16)
			else
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			ln:SetTooltip("This user has been automatically added because rank " .. ln.data.AA .. " can/could edit their own tag.")
		else
			ln:SetTooltip()
		end
	end
end

function PANEL:Admin_Scoreboard_FillPlayers(searchValue)
	if not ATAG.PlayerTags_Players then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.PlayerTags_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.sbtags.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.sbtags.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillRanks(searchValue)

	if not ATAG.Scoreboard_Ranks then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.Scoreboard_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.sbtags.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.sbtags.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_player(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Player_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_rank(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Rank_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	local AutoAssign_TagID, AutoAssign_Type
	
	if Tags.AssignTag then
		AutoAssign_TagID = Tags.AssignTag[1]
		AutoAssign_Type = Tags.AssignTag[2]
	end
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			if AutoAssign_Type == "e" and tostring(data[1]) == AutoAssign_TagID then
				ln.data.autoAssign = true
				
				ln.PaintOver = function(pnl, w, h)
					surface.SetDrawColor(Color(255, 255, 255))
					surface.SetMaterial(Material("icon16/link_go.png"))
					surface.DrawTexturedRect(w-16, 0, 16, 16)
				end
				
			else
				ln.data.autoAssign = false
			end
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		if AutoAssign_Type == "c" and tostring(v[1]) == AutoAssign_TagID then
			ln.data.autoAssign = true
			
			ln.PaintOver = function(pnl, w, h)
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/link_go.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			
		else
			ln.data.autoAssign = false
		end
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
	
end




function PANEL:Admin_ChatTags(panel)

	self.Admin.ch = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
	

	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
		
		
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.ch.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				self.Admin.ch.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.CH_GetRanks()
				self:Admin_Chat_FillRanks()
				
				self.Admin.ch.AddBox:SetText("Rank (Name)")
				self.Admin.ch.AddButton:SetText("Add Rank")
				self.Admin.ch.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.ch.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.ch.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.ch.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.ch.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.ch.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.ch.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.ch.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
			elseif self.Admin.ch.TYPE == "rank" then
				self.Admin.ch.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.CH_GetPlayers()
				self:Admin_Chat_FillPlayers()
				
				self.Admin.ch.AddBox:SetText("Player (SteamID)")
				self.Admin.ch.AddButton:SetText("Add Player")
				self.Admin.ch.List.Column:SetName("Player")
				self.Admin.ch.aList.Column:SetName("Currently Online Players")
				
				self.Admin.ch.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.ch.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, nil)
			self.Admin.ch.TagList:Clear()
		end
		
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.ch.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.ch.TYPE == "rank" then
				
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.ch.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
						
					
				end
				
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers()
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks()
				end
			else
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers(value)
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks(value)
				end
			end
		end
		
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.ch.List = List
		
		ATAG.CH_GetPlayers()
		
		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_GetTags_player(ln.data[1])
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.ch.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "chat")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.CH_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.CH_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.ch.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.CH_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.ch.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.ch.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddPlayer(self.Admin.ch.AddBox:GetValue())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddRank(self.Admin.ch.AddBox:GetValue())
			end
		end
		
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)
		
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))

		aListBtn.DoClick = function(pnl)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.ch.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.ch.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.ch.TYPE == "rank" then
					
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.ch.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.ch.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.ch.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.ch.List:SetVisible(false)
			self.Admin.ch.List:SetVisible(true)
		end
		
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.ch.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
		
		local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.ch.aList = aList
		
		aList.OnClickLine = function(pnl, ln)
			self.Admin.ch.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.Admin.ch.TagList = TagList

		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.Admin.ch.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.ch.List:GetSelectedLine() then return end
				if not pnl:GetSelectedLine() then return end
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_RemoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_RemoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				end
				
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			end
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.Admin.ch.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.ch.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.Admin.ch.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			end
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			end
		end
end



function PANEL:Admin_ChatTags_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

local function IsOnlySpaces(Text)
	if Text == "" then return false end
	for i=1, string.len(Text) do
		if string.GetChar(Text, i) ~= " " then return false end
	end
	return string.len(Text)
end

function PANEL:Admin_Chat_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.Chat_Tags
	if not Tags then return end
	
	self.Admin.ch.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.ch.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.Admin.ch.TagList:SelectItem(self.Admin.ch.TagList:GetLine(Pos))
	end
	
	self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, Tags)
end

function PANEL:Admin_Chat_FillPlayers(searchValue)
	if not ATAG.Chat_Players then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.ch.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.ch.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Chat_FillRanks(searchValue)
	if not ATAG.Chat_Ranks then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.ch.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.ch.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end




function PANEL:OpenSetPlayerNamePnl(SteamID, Type)
	local Frame = vgui.Create("DFrame")
		Frame:SetSize( 300, 85 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("Set Name '" .. SteamID .. "'")
		Frame.Paint = function(pnl, w, h)
			surface.SetDrawColor(100, 150, 200)
			surface.DrawRect(0, 0, w, h)
		end
		
	local TextEntry = vgui.Create( "DTextEntry", Frame )	-- create the form as a child of frame
		TextEntry:SetText("")
		TextEntry:Dock(FILL)
	
	local DButton = vgui.Create( "ATAG_Button", Frame )
		DButton:Dock(BOTTOM)
		DButton:DockMargin(0, 4, 0, 0)
		DButton:SetText( "Set Name for '" .. SteamID .. "'" )
		DButton.DoClick = function()
			if Type == "scoreboard" then
				ATAG.SB_ChangePlayerName(SteamID, TextEntry:GetValue())
			elseif Type == "chat" then
				ATAG.CH_ChangePlayerName(SteamID, TextEntry:GetValue())
			end
			
			Frame:Remove()
		end
end




function PANEL:Admin_PlayerTags_FillTags(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalTagList then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.sbtags.GlobalTagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.sbtags.GlobalTagList:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end

function PANEL:Admin_FillTagList(Tags)
	if not self.Admin then return end
	if not self.Admin.List then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.List:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.List:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end




function PANEL:Fill_Settings(panel)

	-- Container 1
	local Container_1 = vgui.Create("DPanel", panel)
		Container_1:Dock(TOP)
		Container_1:DockMargin(0, 0, 0, 0)
		Container_1:SetTall(32)
		Container_1.Paint = function(pnl, w, h) end
		
	local Info_FrameSize = vgui.Create("DLabel", Container_1)
		Info_FrameSize:SetText("Hover your mouse over the bottom right corner to resize the frame.\nResizing the window might glitch out some of the panels (This is to prevent unnecessary lag). Re-open to fix this.")
		Info_FrameSize:SetTextColor(Color(0, 0, 0))
		Info_FrameSize:SizeToContents()
		
	local Reset_FrameSize = vgui.Create("ATAG_Button", panel)
		Reset_FrameSize:Dock(TOP)
		Reset_FrameSize:DockMargin(0, 0, 0, 0)
		Reset_FrameSize:SetTall(30)
		Reset_FrameSize:SetText("Reset Frame Size")
		
		Reset_FrameSize.DoClick = function()
			ATAG.SetFrameSize(600, 400)
		end
		
	local Center_Frame = vgui.Create("ATAG_Button", panel)
		Center_Frame:Dock(TOP)
		Center_Frame:DockMargin(0, 6, 0, 0)
		Center_Frame:SetTall(30)
		Center_Frame:SetText("Center Frame")
		
		Center_Frame.DoClick = function()
			ATAG.SetFramePos(nil, nil, true)
		end
		
	local Save_Frame = vgui.Create("ATAG_Button", panel)
		Save_Frame:Dock(TOP)
		Save_Frame:DockMargin(0, 6, 0, 0)
		Save_Frame:SetTall(30)
		Save_Frame:SetText("Save Settings")
		
		Save_Frame.DoClick = function()
			ATAG.SaveFrameSettings()
			
			ATAG.NotifyMessage("Settings saved!")
			
		end

end








function PANEL:Fill_TagEdit(panel)

	self.TagEdit.ed = {}

	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.TagEdit.ed.TagList = TagList
		
		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.TagEdit.ed.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not pnl:GetSelectedLine() then return end
				ATAG.CH_RemoveTagPiece_owntag(pnl:GetSelectedLine())
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			ATAG.CH_AddTagPiece_owntag(self.TagEdit.ed.AddTagBox:GetValue(),self.TagEdit.ed.Mixer:GetColor())
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.TagEdit.ed.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.TagEdit.ed.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.TagEdit.ed.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() - 1)
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() + 2)
		end

end

function PANEL:TagEdit_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.OwnTag
	if not Tags then return end
	
	self.TagEdit.ed.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.TagEdit.ed.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.TagEdit.ed.TagList:SelectItem(self.TagEdit.ed.TagList:GetLine(Pos))
	end
	
	self:TagEdit_CreateTagExample(self.TagEdit.ed.TagExample, Tags)
end

function PANEL:TagEdit_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

function PANEL:Create_TagEdit()
	local TagEdit = vgui.Create("DPanel")
	local Tab_TagEdit = self.Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
	self:PaintTab(self.Tabs, TagEdit, Tab_TagEdit)
	self.TagEdit = {}
	self:Fill_TagEdit(TagEdit)
	self.TagEdit_Tab = Tab_TagEdit.Tab
	
	ATAG.CH_GetOwnTags()
end

vgui.Register("atags_main_gui", PANEL, "DPanel")

-- "addons\\atags\\lua\\atags\\vgui\\atags_main_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local icon_up = "icon16/bullet_arrow_up.png"
local icon_down = "icon16/bullet_arrow_down.png"
local icon_player = "icon16/user.png"
local icon_rank = "icon16/award_star_gold_1.png"

local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self.Paint = function(pnl, w, h) end
	
	local NotifyLabel = vgui.Create("DLabel", self)
		NotifyLabel:SetText("")
		NotifyLabel:SizeToContents()
		NotifyLabel:SetPos(0, 5)
		NotifyLabel:SetTextColor(Color(0, 0, 0))
		
		self.NotifyLabel = NotifyLabel

	local Tabs = vgui.Create("DPropertySheet", self)
	Tabs:Dock(FILL)
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end

	self.Tabs = Tabs
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Scoreboard Tags", Tags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self.Tags = {}
	self:Fill_Tags(Tags)
	
	if ATAG.CanEditOwnChatTag then
		local TagEdit = vgui.Create("DPanel")
		local Tab_TagEdit = Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
		self:PaintTab(Tabs, TagEdit, Tab_TagEdit)
		self.TagEdit = {}
		self:Fill_TagEdit(TagEdit)
		
		self.TagEdit_Tab = Tab_TagEdit.Tab
		
		ATAG.CH_GetOwnTags()
	end
	
	ATAG.CH_GetCanSetOwnTag()
	
	if ATAG:HasPermissions(LocalPlayer()) then
		local Admin = vgui.Create("DPanel")
		local Tab_Admin = Tabs:AddSheet("Admin", Admin, "icon16/shield.png", false, false, nil)
		self:PaintTab(Tabs, Admin, Tab_Admin)
		self.Admin = {}
		self:Fill_Admin(Admin)
	end
	
	local Settings = vgui.Create("DPanel") -- Currently disabled, no settings yet.
	local Tab_Settings = Tabs:AddSheet("Settings", Settings, "icon16/wrench.png", false, false, nil)
	self:PaintTab(Tabs, Settings, Tab_Settings)
	self.Settings = {}
	self:Fill_Settings(Settings)
	
end

function PANEL:SetNotifyMessage(msg, duration)
	
	self.NotifyLabel.Think = function(pnl) end

	self.NotifyLabel:SetText(msg)
	self.NotifyLabel:SizeToContents()
	self.NotifyLabel:SetPos(self:GetWide() - self.NotifyLabel:GetWide(), 5)
	self.NotifyLabel:SetTextColor(Color(0, 0, 0, 255))
	self.NotifyLabel.EndAlpha = duration or 5000
	self.NotifyLabel.ShouldFade = true
	
	self.NotifyLabel.Think = function(pnl)
		if pnl.ShouldFade then
			if not pnl.EndAlpha then
				pnl.EndAlpha = duration or 5000
			end
			
			if pnl.EndAlpha ~= 0 then
				pnl.EndAlpha = math.Approach(pnl.EndAlpha, 0, (math.abs(pnl.EndAlpha - 0) + 1) * 1 * FrameTime())
				if pnl.EndAlpha <= 255 then
					pnl:SetTextColor(Color(0, 0, 0, pnl.EndAlpha))
				end
			else
				pnl.ShouldFade = false
			end
		end
	end
end

function PANEL:PaintTab(parent, panel, tab)

	panel.Paint = function(pnl, w, h) end
	
	tab.Tab.Paint = function(pnl, w, h)
		if parent:GetActiveTab() == pnl then
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h-7)
			surface.SetDrawColor(230, 230, 230)
			surface.DrawRect(1, 1, w-2, h-7)
		else
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(180, 180, 180)
			surface.DrawRect(1, 1, w-2, h)
		end
	end
end

function PANEL:ListPaint(panel, ln)
	panel.Paint = function(pnl, w, h)
		if ln:IsSelected() then
			surface.SetDrawColor(80, 130, 255)
		elseif ln:IsHovered() then
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(165, 170, 200)
			else
				surface.SetDrawColor(210, 215, 250)
			end
		else
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(100, 100, 100)
			end
		end
		surface.DrawRect(0, 0, w, h)
		surface.SetTextColor(ln.data[3])
		surface.SetTextPos(5, 2)
		surface.SetFont("DermaDefault") -- Doing this because font size will but out??? cba to figure out why.
		surface.DrawText(ln.data[2])
	end
end

-- TAGS
function PANEL:Fill_Tags(panel)

	self.Tags.tg = {}

	local CurrentTagContainer = vgui.Create("DPanel", panel)
	CurrentTagContainer:Dock(TOP)
	CurrentTagContainer:DockMargin(0, 4, 0, 0)
	CurrentTagContainer:SetTall(30)
	CurrentTagContainer.Paint = function(pnl, w, h) end
	
	local CurrentTagLabel = vgui.Create("DLabel", CurrentTagContainer)
	CurrentTagLabel:Dock(LEFT)
	CurrentTagLabel:SetWide(65)
	CurrentTagLabel:DockMargin(4, 0, 0, 0)
	CurrentTagLabel:SetText("Current Tag: ")
	CurrentTagLabel:SetTextColor(Color(0, 0, 0))
	
	local CurrentTag = vgui.Create("DPanel", CurrentTagContainer)
	CurrentTag:Dock( FILL )
	CurrentTag:DockMargin(4, 0, 0, 0)
	CurrentTag.Paint = function( pnl, w, h )
		
		local name, color = LocalPlayer():getScoreboardTag()
		
		surface.SetTextColor( color or Color( 255, 255, 255 ) )
		surface.SetFont("DermaDefault")
		surface.SetTextPos( 0, ( h/2 ) - ( select( 2, surface.GetTextSize(  "" ) )/2 ) )
		surface.DrawText( name or "" )
		
	end
	
	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(FILL)
		container_1:DockMargin(0, 0, 0, 0)
		container_1.Paint = function() end
	
	local container_1_1 = vgui.Create("DPanel", container_1)
		container_1_1:Dock(FILL)
		container_1_1:DockMargin(0, 0, 0, 0)
		container_1_1.Paint = function() end
	
	local ButtonContainer = vgui.Create("DPanel", container_1_1)
	ButtonContainer:Dock(BOTTOM)
	ButtonContainer:DockMargin(0, 4, 0, 0)
	ButtonContainer:SetTall(30)
	
	local UseBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseBtn:Dock(FILL)
	UseBtn:DockMargin(0, 0, 0, 0)
	UseBtn:SetText("Use Tag")
	
	local UseNoneBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseNoneBtn:Dock(RIGHT)
	UseNoneBtn:DockMargin(4, 0, 0, 0)
	UseNoneBtn:SetWide(120)
	UseNoneBtn:SetText("Use none")
	
	local List = vgui.Create("DListView", container_1_1)
	List:Dock(FILL)
	List:DockMargin(0, 0, 0, 0)
	List:SetMultiSelect(false)
	List:AddColumn("Tag")
	List:AddColumn("Type"):SetFixedWidth(120)
	
	self.Tags.List = List
	
	ATAG.GetUserTags()
	
	UseBtn.DoClick = function()
		if not List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag.") return end
		ATAG.UseTag(List:GetLine(List:GetSelectedLine()).data[1], List:GetLine(List:GetSelectedLine()).Type)
	end
	
	UseNoneBtn.DoClick = function()
		ATAG.UseTag(0, "remove")
	end
	
	local container_1_2 = vgui.Create("DPanel", container_1)
		container_1_2:Dock(RIGHT)
		container_1_2:DockMargin(4, 0, 0, 0)
		container_1_2:SetVisible(false)
		container_1_2.Paint = function() end
		
		container_1_2.PerformLayout = function(pnl)
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
		self.Tags.tg.container_1_2 = container_1_2
		
	local container_1_2_1 = vgui.Create("DPanel", container_1_2)
		container_1_2_1:Dock(BOTTOM)
		container_1_2_1:DockMargin(4, 0, 0, 0)
		container_1_2_1.Paint = function() end
		
		container_1_2_1.PerformLayout = function(pnl)
			pnl:SetTall(ATAG.GUI:GetTall()*0.42)
		end
		
	local Mixer = vgui.Create("DColorMixer", container_1_2_1)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 0, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
	
	local SetTagBtn = vgui.Create("ATAG_Button", container_1_2_1)
		SetTagBtn:Dock(BOTTOM)
		SetTagBtn:DockMargin(0, 4, 0, 0)
		SetTagBtn:SetTall(30)
		SetTagBtn:SetText("Set Tag")
	
	local SetTagBox = vgui.Create("DTextEntry", container_1_2_1)
		SetTagBox:Dock(BOTTOM)
		SetTagBox:DockMargin(0, 4, 0, 0)
		SetTagBox:SetTall(25)
		SetTagBox:SetText("")
		
		SetTagBtn.DoClick = function()
			ATAG.SB_SetOwnTag(SetTagBox:GetValue(), Mixer:GetColor())
		end
		
	local container_1_2_2 = vgui.Create("DPanel", container_1_2)
		container_1_2_2:Dock(BOTTOM)
		container_1_2_2:DockMargin(4, 0, 0, 4)
		container_1_2_2:SetTall(20)
		container_1_2_2.Paint = function() end
		
	local InfoLabel = vgui.Create( "DLabel", container_1_2_2)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetText("You can set your own tag!")
		InfoLabel:SetTextColor(Color(0, 0, 0))
	
	if ATAG.Tags_MyTags then
		if ATAG.Tags_MyTags.SB_CST then
			self.Tags.tg.container_1_2:SetVisible(true)
		end
	end
	
end

function PANEL:Tags_FillTags(Tags)
	if not self.Tags then return end
	if not self.Tags.List then return end
	
	local Tags = Tags or ATAG.Tags_MyTags
	
	if not Tags then return end
	
	self.Tags.List:Clear()
	
	if Tags.PTags then
		local Tags = Tags.PTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Player Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Player Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end

	if Tags.RTags then
		local Tags = Tags.RTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Rank Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Rank Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end
	
end


-- ADMIN
function PANEL:Fill_Admin(panel)

	local Tabs = vgui.Create("DPropertySheet", panel)
	Tabs:Dock(FILL)
	
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Global Tags", Tags, "icon16/tag_blue.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self:Admin_Tags(Tags)
	
	local PlayerTags = vgui.Create("DPanel")
	local Tab_PlayerTags = Tabs:AddSheet("Scoreboard Tags", PlayerTags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, PlayerTags, Tab_PlayerTags)
	self:Admin_ScoreboardTags(PlayerTags)
	
	local ChatTags = vgui.Create("DPanel")
	local Tab_ChatTags = Tabs:AddSheet("Chat Tags", ChatTags, "icon16/comment.png", false, false, nil)
	self:PaintTab(Tabs, ChatTags, Tab_ChatTags)
	self:Admin_ChatTags(ChatTags)
	
end

function PANEL:Admin_Tags(panel)
	
	local Mixer_Container = vgui.Create("DPanel", panel)
	Mixer_Container:Dock(RIGHT)
	Mixer_Container:DockMargin(0, 4, 4, 0)
	Mixer_Container:SetWide(150)
	Mixer_Container.Paint = function(pnl, w, h) end
	
	local Mixer = vgui.Create("DColorMixer", Mixer_Container)
	Mixer:Dock(TOP)
	Mixer:DockMargin(0, 0, 0, 0)
	Mixer:SetTall(150)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(true)
	Mixer:SetColor(Color(255, 255, 255))
	
	-- hehe
	Mixer.WangsPanel:Dock(BOTTOM)
	Mixer.WangsPanel:DockMargin(0, 4, 0, 0)
	Mixer.txtR:Dock(LEFT)
	Mixer.txtR:SetWide(47)
	Mixer.txtR:DockMargin( 0, 0, 0, 0 )
	Mixer.txtG:Dock(LEFT)
	Mixer.txtG:SetWide(48)
	Mixer.txtG:DockMargin( 4, 0, 0, 0 )
	Mixer.txtB:Dock(LEFT)
	Mixer.txtB:SetWide(47)
	Mixer.txtB:DockMargin( 4, 0, 0, 0 )
	Mixer.txtA:SetVisible(false)
	
	
	local panel2 = vgui.Create("DPanel", panel)
	panel2:Dock(FILL)
	panel2.Paint = function(pnl, w, h) end
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(BOTTOM)
	panel3:SetTall(25)
	panel3:DockMargin(4, 4, 10, 0)
	panel3.Paint = function(pnl, w, h) end
	
	local DButton = vgui.Create("ATAG_Button", panel3)
	DButton:Dock(FILL)
	DButton:DockMargin(0, 0, 0, 0)
	DButton:SetText("Add Tag")
	
	local DButton2 = vgui.Create("ATAG_Button", panel3)
	DButton2:Dock(RIGHT)
	DButton2:DockMargin(4, 0, 0, 0)
	DButton2:SetWide(100)
	DButton2:SetText("Stop Editing")
	DButton2:SetVisible(false)
	
	local TextEntry = vgui.Create("DTextEntry", panel2)
	TextEntry:Dock(BOTTOM)
	TextEntry:SetTall(25)
	TextEntry:DockMargin(4, 6, 10, 0)
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(FILL)
	panel3.Paint = function(pnl, w, h) end
	
	local DListView = vgui.Create("DListView", panel3)
	DListView:Dock(FILL)
	DListView:DockMargin(4, 4, 10, 0)
	DListView:SetMultiSelect(false)
	
	ATAG.GetTags()
	
	DListView.OnClickLine = function(pnl, ln)	
		if input.IsMouseDown(MOUSE_LEFT) then
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
	end
		
	DListView.OnRowRightClick = function(pnl, n, ln)
		if pnl.Menu then pnl.Menu:Remove() end
		
		local Menu = vgui.Create("DMenu")
		
		Menu:AddOption("Edit", function()
			pnl:ClearSelection()
			pnl:SelectItem(ln)
			DButton:SetText("Edit Tag")
			DButton2:SetVisible(true)
			TextEntry:SetValue(ln.data[2])
			Mixer:SetColor(ln.data[3])
		end):SetIcon("icon16/page_white_gear.png")
		
		Menu:AddOption("Remove", function()
			ATAG.RemoveTag(ln.data[1])
		end):SetIcon("icon16/cross.png")
		
		Menu:Open()
		
		pnl.Menu = Menu
	end
	
	DButton.DoClick = function(pnl)
		if pnl:GetText() == "Edit Tag" then
			ATAG.EditTag(DListView:GetLine(DListView:GetSelectedLine()).data[1], TextEntry:GetValue(), Mixer:GetColor())
			DButton2:SetVisible(false)
			DButton:SetText("Add Tag")
			DListView:ClearSelection()
			DButton:SetVisible(false)
			DButton:SetVisible(true)
			TextEntry:SetValue("")
		else
			ATAG.AddTag(TextEntry:GetValue(), Mixer:GetColor())
		end
	end
	
	DButton2.DoClick = function()
		DButton2:SetVisible(false)
		DButton:SetText("Add Tag")
		DListView:ClearSelection()
		DButton:SetVisible(false)
		DButton:SetVisible(true)
		TextEntry:SetValue("")
	end
	
	DListView:AddColumn("Tag")
	
	self.Admin.List = DListView
end

function PANEL:Admin_ScoreboardTags(panel)
	
	self.Admin.sbtags = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(RIGHT)
		container_2:DockMargin(4, 4, 4, 4)
		container_2:SetWide(150)
		container_2.Paint = function(pnl, w, h) end
		
		container_2.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_3 = vgui.Create("DPanel", panel)
		container_3:Dock(RIGHT)
		container_3:DockMargin(4, 4, 4, 4)
		container_3:SetWide(25)
		container_3.Paint = function(pnl, w, h) end

	local container_4 = vgui.Create("DPanel", panel)
		container_4:Dock(FILL)
		container_4:DockMargin(4, 4, 4, 4)
		container_4.Paint = function(pnl, w, h) end
		
	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
	
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.sbtags.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				self.Admin.sbtags.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.SB_GetRanks()
				self:Admin_Scoreboard_FillRanks()
				
				self.Admin.sbtags.AddBox:SetText("Rank (Name)")
				self.Admin.sbtags.AddButton:SetText("Add Rank")
				self.Admin.sbtags.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.sbtags.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.sbtags.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.sbtags.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.sbtags.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.sbtags.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.sbtags.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.sbtags.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
					
				
			elseif self.Admin.sbtags.TYPE == "rank" then
				self.Admin.sbtags.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.SB_GetPlayers()
				self:Admin_Scoreboard_FillPlayers()
				
				self.Admin.sbtags.AddBox:SetText("Player (SteamID)")
				self.Admin.sbtags.AddButton:SetText("Add Player")
				self.Admin.sbtags.List.Column:SetName("Player")
				self.Admin.sbtags.aList.Column:SetName("Currently Online Players")
				
				self.Admin.sbtags.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self.Admin.sbtags.GlobalList:Clear()
			self.Admin.sbtags.CustomList:Clear()
		end
	
	-- Search in the list.
	-- If the aList is visible it will search in that list.
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:Clear()
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
	
	
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.sbtags.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
				
				end
				
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers()
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks()
				end
			else
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers(value)
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks(value)
				end
			end
		end
	
	-- The list with the Players or Ranks.
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.sbtags.List = List
		
		ATAG.SB_GetPlayers()

		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if not ln.data then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_GetTags_player(ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "scoreboard")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.SB_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.SB_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.sbtags.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.SB_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.sbtags.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	-- Button to add a player or rank.
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.sbtags.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddPlayer(self.Admin.sbtags.AddBox:GetValue())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddRank(self.Admin.sbtags.AddBox:GetValue())
			end
		end
		
	-- Container to make the Dock work.
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)

	-- Button to make the aList visible.
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))
		
		aListBtn.DoClick = function(pnl)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.sbtags.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.sbtags.aList:Clear()
				
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.sbtags.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.sbtags.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.sbtags.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.sbtags.List:SetVisible(false)
			self.Admin.sbtags.List:SetVisible(true)
		end
	
	-- Textbox to add a player or rank.
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.sbtags.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
	
	-- List for the online players or all ULX / evolve ranks.
	local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:DockMargin(0, 0, 0, 0)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.sbtags.aList = aList

		aList.OnClickLine = function(pnl, ln)
			self.Admin.sbtags.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
	-- Container 2
	-- List for global tags.
	local GlobalTagList = vgui.Create("DListView", container_2)
		GlobalTagList:Dock(FILL)
		GlobalTagList:DockMargin(0, 0, 0, 0)
		GlobalTagList:SetMultiSelect(false)
		GlobalTagList:AddColumn("Tags")
		
		self.Admin.sbtags.GlobalTagList = GlobalTagList
		
		GlobalTagList.OnClickLine = function(pnl, ln)		
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalTagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Add", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/add.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local CustomTag_Container = vgui.Create("DPanel", container_2)
		CustomTag_Container:Dock(BOTTOM)
		CustomTag_Container.Paint = function() end
		
		CustomTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
	
	-- Button to add a custom tag.
	local AddCustomTagBtn = vgui.Create("ATAG_Button", CustomTag_Container)
		AddCustomTagBtn:Dock(BOTTOM)
		AddCustomTagBtn:DockMargin(0, 4, 0, 0)
		AddCustomTagBtn:SetTall(25)
		AddCustomTagBtn:SetText("Add Custom Tag")
		
		AddCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			end
		end
	
	-- TextBox for the custom tag.
	local CustomTagBox = vgui.Create("DTextEntry", CustomTag_Container)
		CustomTagBox:Dock(BOTTOM)
		CustomTagBox:DockMargin(0, 4, 0, 0)
		CustomTagBox:SetTall(25)
		CustomTagBox:SetText("Custom Tag")
		
		self.Admin.sbtags.CustomTagBox = CustomTagBox
		
		CustomTagBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Custom Tag" then
				pnl:SetValue("")
			end
		end
		CustomTagBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Custom Tag")
			end
		end
	
	-- Color mixer for the custom tag.
	local Mixer = vgui.Create("DColorMixer", CustomTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.sbtags.Mixer = Mixer
		
	-- Container 3
	-- Button to add a global tag.
	local AddTagButton = vgui.Create("ATAG_Button", container_3)
		AddTagButton:Dock(TOP)
		AddTagButton:DockMargin(0, 40, 0, 0)
		AddTagButton:SetTall(25)
		AddTagButton:SetIcon(icon_up)
		AddTagButton:SetIconRotation(90)
		AddTagButton:SetIconColor(Color(0, 0, 0, 120))
		
		AddTagButton.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalTagList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to add.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a global tag.
	local RemoveTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveTagBtn:Dock(TOP)
		RemoveTagBtn:DockMargin(0, 4, 0, 0)
		RemoveTagBtn:SetTall(25)
		RemoveTagBtn:SetIcon(icon_down)
		RemoveTagBtn:SetIconRotation(90)
		RemoveTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a custom tag.
	local RemoveCustomTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveCustomTagBtn:Dock(BOTTOM)
		RemoveCustomTagBtn:DockMargin(0, 0, 0, 55)
		RemoveCustomTagBtn:SetTall(25)
		RemoveCustomTagBtn:SetIcon(icon_down)
		RemoveCustomTagBtn:SetIconRotation(90)
		RemoveCustomTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.CustomList:GetSelectedLine() then ATAG.NotifyMessage("Please select the custom tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			end
		end
	
	-- Container 4
	-- List for the global tags the player / rank has.
	local GlobalList = vgui.Create("DListView", container_4)
		GlobalList:Dock(FILL)
		GlobalList:DockMargin(0, 0, 0, 0)
		GlobalList:SetMultiSelect(false)
		GlobalList:AddColumn("Tag")
		
		self.Admin.sbtags.GlobalList = GlobalList
		
		GlobalList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
	
	-- List for the custom tags the player / rank has.
	local CustomList_Container = vgui.Create("DPanel", container_4)
		CustomList_Container:Dock(BOTTOM)
		CustomList_Container:DockMargin(0, 4, 0, 0)
		CustomList_Container:SetTall(140)
		
		CustomList_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local CustomList = vgui.Create("DListView", CustomList_Container)
		CustomList:Dock(FILL)
		CustomList:DockMargin(0, 0, 0, 0)
		CustomList:SetMultiSelect(false)
		CustomList:AddColumn("Custom Tag")
		
		self.Admin.sbtags.CustomList = CustomList
		
		CustomList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		CustomList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
end

function PANEL:Admin_CanSetOwnTag(ln)
	ln.PaintOver = function(pnl, w, h)
		if ln.data.CST then
			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(50, 50, 50))
			surface.DrawOutlinedRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/pencil.png"))
			surface.DrawTexturedRect(w-16, 0, 16, 16)
		end
		if ln.data.AA then
			if ln.data.CST then
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16-16, 0, 16, 16)
			else
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			ln:SetTooltip("This user has been automatically added because rank " .. ln.data.AA .. " can/could edit their own tag.")
		else
			ln:SetTooltip()
		end
	end
end

function PANEL:Admin_Scoreboard_FillPlayers(searchValue)
	if not ATAG.PlayerTags_Players then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.PlayerTags_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.sbtags.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.sbtags.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillRanks(searchValue)

	if not ATAG.Scoreboard_Ranks then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.Scoreboard_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.sbtags.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.sbtags.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_player(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Player_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_rank(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Rank_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	local AutoAssign_TagID, AutoAssign_Type
	
	if Tags.AssignTag then
		AutoAssign_TagID = Tags.AssignTag[1]
		AutoAssign_Type = Tags.AssignTag[2]
	end
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			if AutoAssign_Type == "e" and tostring(data[1]) == AutoAssign_TagID then
				ln.data.autoAssign = true
				
				ln.PaintOver = function(pnl, w, h)
					surface.SetDrawColor(Color(255, 255, 255))
					surface.SetMaterial(Material("icon16/link_go.png"))
					surface.DrawTexturedRect(w-16, 0, 16, 16)
				end
				
			else
				ln.data.autoAssign = false
			end
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		if AutoAssign_Type == "c" and tostring(v[1]) == AutoAssign_TagID then
			ln.data.autoAssign = true
			
			ln.PaintOver = function(pnl, w, h)
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/link_go.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			
		else
			ln.data.autoAssign = false
		end
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
	
end




function PANEL:Admin_ChatTags(panel)

	self.Admin.ch = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
	

	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
		
		
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.ch.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				self.Admin.ch.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.CH_GetRanks()
				self:Admin_Chat_FillRanks()
				
				self.Admin.ch.AddBox:SetText("Rank (Name)")
				self.Admin.ch.AddButton:SetText("Add Rank")
				self.Admin.ch.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.ch.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.ch.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.ch.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.ch.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.ch.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.ch.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.ch.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
			elseif self.Admin.ch.TYPE == "rank" then
				self.Admin.ch.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.CH_GetPlayers()
				self:Admin_Chat_FillPlayers()
				
				self.Admin.ch.AddBox:SetText("Player (SteamID)")
				self.Admin.ch.AddButton:SetText("Add Player")
				self.Admin.ch.List.Column:SetName("Player")
				self.Admin.ch.aList.Column:SetName("Currently Online Players")
				
				self.Admin.ch.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.ch.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, nil)
			self.Admin.ch.TagList:Clear()
		end
		
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.ch.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.ch.TYPE == "rank" then
				
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.ch.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
						
					
				end
				
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers()
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks()
				end
			else
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers(value)
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks(value)
				end
			end
		end
		
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.ch.List = List
		
		ATAG.CH_GetPlayers()
		
		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_GetTags_player(ln.data[1])
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.ch.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "chat")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.CH_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.CH_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.ch.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.CH_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.ch.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.ch.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddPlayer(self.Admin.ch.AddBox:GetValue())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddRank(self.Admin.ch.AddBox:GetValue())
			end
		end
		
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)
		
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))

		aListBtn.DoClick = function(pnl)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.ch.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.ch.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.ch.TYPE == "rank" then
					
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.ch.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.ch.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.ch.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.ch.List:SetVisible(false)
			self.Admin.ch.List:SetVisible(true)
		end
		
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.ch.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
		
		local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.ch.aList = aList
		
		aList.OnClickLine = function(pnl, ln)
			self.Admin.ch.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.Admin.ch.TagList = TagList

		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.Admin.ch.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.ch.List:GetSelectedLine() then return end
				if not pnl:GetSelectedLine() then return end
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_RemoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_RemoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				end
				
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			end
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.Admin.ch.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.ch.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.Admin.ch.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			end
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			end
		end
end



function PANEL:Admin_ChatTags_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

local function IsOnlySpaces(Text)
	if Text == "" then return false end
	for i=1, string.len(Text) do
		if string.GetChar(Text, i) ~= " " then return false end
	end
	return string.len(Text)
end

function PANEL:Admin_Chat_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.Chat_Tags
	if not Tags then return end
	
	self.Admin.ch.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.ch.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.Admin.ch.TagList:SelectItem(self.Admin.ch.TagList:GetLine(Pos))
	end
	
	self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, Tags)
end

function PANEL:Admin_Chat_FillPlayers(searchValue)
	if not ATAG.Chat_Players then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.ch.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.ch.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Chat_FillRanks(searchValue)
	if not ATAG.Chat_Ranks then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.ch.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.ch.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end




function PANEL:OpenSetPlayerNamePnl(SteamID, Type)
	local Frame = vgui.Create("DFrame")
		Frame:SetSize( 300, 85 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("Set Name '" .. SteamID .. "'")
		Frame.Paint = function(pnl, w, h)
			surface.SetDrawColor(100, 150, 200)
			surface.DrawRect(0, 0, w, h)
		end
		
	local TextEntry = vgui.Create( "DTextEntry", Frame )	-- create the form as a child of frame
		TextEntry:SetText("")
		TextEntry:Dock(FILL)
	
	local DButton = vgui.Create( "ATAG_Button", Frame )
		DButton:Dock(BOTTOM)
		DButton:DockMargin(0, 4, 0, 0)
		DButton:SetText( "Set Name for '" .. SteamID .. "'" )
		DButton.DoClick = function()
			if Type == "scoreboard" then
				ATAG.SB_ChangePlayerName(SteamID, TextEntry:GetValue())
			elseif Type == "chat" then
				ATAG.CH_ChangePlayerName(SteamID, TextEntry:GetValue())
			end
			
			Frame:Remove()
		end
end




function PANEL:Admin_PlayerTags_FillTags(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalTagList then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.sbtags.GlobalTagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.sbtags.GlobalTagList:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end

function PANEL:Admin_FillTagList(Tags)
	if not self.Admin then return end
	if not self.Admin.List then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.List:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.List:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end




function PANEL:Fill_Settings(panel)

	-- Container 1
	local Container_1 = vgui.Create("DPanel", panel)
		Container_1:Dock(TOP)
		Container_1:DockMargin(0, 0, 0, 0)
		Container_1:SetTall(32)
		Container_1.Paint = function(pnl, w, h) end
		
	local Info_FrameSize = vgui.Create("DLabel", Container_1)
		Info_FrameSize:SetText("Hover your mouse over the bottom right corner to resize the frame.\nResizing the window might glitch out some of the panels (This is to prevent unnecessary lag). Re-open to fix this.")
		Info_FrameSize:SetTextColor(Color(0, 0, 0))
		Info_FrameSize:SizeToContents()
		
	local Reset_FrameSize = vgui.Create("ATAG_Button", panel)
		Reset_FrameSize:Dock(TOP)
		Reset_FrameSize:DockMargin(0, 0, 0, 0)
		Reset_FrameSize:SetTall(30)
		Reset_FrameSize:SetText("Reset Frame Size")
		
		Reset_FrameSize.DoClick = function()
			ATAG.SetFrameSize(600, 400)
		end
		
	local Center_Frame = vgui.Create("ATAG_Button", panel)
		Center_Frame:Dock(TOP)
		Center_Frame:DockMargin(0, 6, 0, 0)
		Center_Frame:SetTall(30)
		Center_Frame:SetText("Center Frame")
		
		Center_Frame.DoClick = function()
			ATAG.SetFramePos(nil, nil, true)
		end
		
	local Save_Frame = vgui.Create("ATAG_Button", panel)
		Save_Frame:Dock(TOP)
		Save_Frame:DockMargin(0, 6, 0, 0)
		Save_Frame:SetTall(30)
		Save_Frame:SetText("Save Settings")
		
		Save_Frame.DoClick = function()
			ATAG.SaveFrameSettings()
			
			ATAG.NotifyMessage("Settings saved!")
			
		end

end








function PANEL:Fill_TagEdit(panel)

	self.TagEdit.ed = {}

	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.TagEdit.ed.TagList = TagList
		
		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.TagEdit.ed.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not pnl:GetSelectedLine() then return end
				ATAG.CH_RemoveTagPiece_owntag(pnl:GetSelectedLine())
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			ATAG.CH_AddTagPiece_owntag(self.TagEdit.ed.AddTagBox:GetValue(),self.TagEdit.ed.Mixer:GetColor())
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.TagEdit.ed.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.TagEdit.ed.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.TagEdit.ed.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() - 1)
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() + 2)
		end

end

function PANEL:TagEdit_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.OwnTag
	if not Tags then return end
	
	self.TagEdit.ed.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.TagEdit.ed.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.TagEdit.ed.TagList:SelectItem(self.TagEdit.ed.TagList:GetLine(Pos))
	end
	
	self:TagEdit_CreateTagExample(self.TagEdit.ed.TagExample, Tags)
end

function PANEL:TagEdit_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

function PANEL:Create_TagEdit()
	local TagEdit = vgui.Create("DPanel")
	local Tab_TagEdit = self.Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
	self:PaintTab(self.Tabs, TagEdit, Tab_TagEdit)
	self.TagEdit = {}
	self:Fill_TagEdit(TagEdit)
	self.TagEdit_Tab = Tab_TagEdit.Tab
	
	ATAG.CH_GetOwnTags()
end

vgui.Register("atags_main_gui", PANEL, "DPanel")

-- "addons\\atags\\lua\\atags\\vgui\\atags_main_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local icon_up = "icon16/bullet_arrow_up.png"
local icon_down = "icon16/bullet_arrow_down.png"
local icon_player = "icon16/user.png"
local icon_rank = "icon16/award_star_gold_1.png"

local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self.Paint = function(pnl, w, h) end
	
	local NotifyLabel = vgui.Create("DLabel", self)
		NotifyLabel:SetText("")
		NotifyLabel:SizeToContents()
		NotifyLabel:SetPos(0, 5)
		NotifyLabel:SetTextColor(Color(0, 0, 0))
		
		self.NotifyLabel = NotifyLabel

	local Tabs = vgui.Create("DPropertySheet", self)
	Tabs:Dock(FILL)
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end

	self.Tabs = Tabs
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Scoreboard Tags", Tags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self.Tags = {}
	self:Fill_Tags(Tags)
	
	if ATAG.CanEditOwnChatTag then
		local TagEdit = vgui.Create("DPanel")
		local Tab_TagEdit = Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
		self:PaintTab(Tabs, TagEdit, Tab_TagEdit)
		self.TagEdit = {}
		self:Fill_TagEdit(TagEdit)
		
		self.TagEdit_Tab = Tab_TagEdit.Tab
		
		ATAG.CH_GetOwnTags()
	end
	
	ATAG.CH_GetCanSetOwnTag()
	
	if ATAG:HasPermissions(LocalPlayer()) then
		local Admin = vgui.Create("DPanel")
		local Tab_Admin = Tabs:AddSheet("Admin", Admin, "icon16/shield.png", false, false, nil)
		self:PaintTab(Tabs, Admin, Tab_Admin)
		self.Admin = {}
		self:Fill_Admin(Admin)
	end
	
	local Settings = vgui.Create("DPanel") -- Currently disabled, no settings yet.
	local Tab_Settings = Tabs:AddSheet("Settings", Settings, "icon16/wrench.png", false, false, nil)
	self:PaintTab(Tabs, Settings, Tab_Settings)
	self.Settings = {}
	self:Fill_Settings(Settings)
	
end

function PANEL:SetNotifyMessage(msg, duration)
	
	self.NotifyLabel.Think = function(pnl) end

	self.NotifyLabel:SetText(msg)
	self.NotifyLabel:SizeToContents()
	self.NotifyLabel:SetPos(self:GetWide() - self.NotifyLabel:GetWide(), 5)
	self.NotifyLabel:SetTextColor(Color(0, 0, 0, 255))
	self.NotifyLabel.EndAlpha = duration or 5000
	self.NotifyLabel.ShouldFade = true
	
	self.NotifyLabel.Think = function(pnl)
		if pnl.ShouldFade then
			if not pnl.EndAlpha then
				pnl.EndAlpha = duration or 5000
			end
			
			if pnl.EndAlpha ~= 0 then
				pnl.EndAlpha = math.Approach(pnl.EndAlpha, 0, (math.abs(pnl.EndAlpha - 0) + 1) * 1 * FrameTime())
				if pnl.EndAlpha <= 255 then
					pnl:SetTextColor(Color(0, 0, 0, pnl.EndAlpha))
				end
			else
				pnl.ShouldFade = false
			end
		end
	end
end

function PANEL:PaintTab(parent, panel, tab)

	panel.Paint = function(pnl, w, h) end
	
	tab.Tab.Paint = function(pnl, w, h)
		if parent:GetActiveTab() == pnl then
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h-7)
			surface.SetDrawColor(230, 230, 230)
			surface.DrawRect(1, 1, w-2, h-7)
		else
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(180, 180, 180)
			surface.DrawRect(1, 1, w-2, h)
		end
	end
end

function PANEL:ListPaint(panel, ln)
	panel.Paint = function(pnl, w, h)
		if ln:IsSelected() then
			surface.SetDrawColor(80, 130, 255)
		elseif ln:IsHovered() then
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(165, 170, 200)
			else
				surface.SetDrawColor(210, 215, 250)
			end
		else
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(100, 100, 100)
			end
		end
		surface.DrawRect(0, 0, w, h)
		surface.SetTextColor(ln.data[3])
		surface.SetTextPos(5, 2)
		surface.SetFont("DermaDefault") -- Doing this because font size will but out??? cba to figure out why.
		surface.DrawText(ln.data[2])
	end
end

-- TAGS
function PANEL:Fill_Tags(panel)

	self.Tags.tg = {}

	local CurrentTagContainer = vgui.Create("DPanel", panel)
	CurrentTagContainer:Dock(TOP)
	CurrentTagContainer:DockMargin(0, 4, 0, 0)
	CurrentTagContainer:SetTall(30)
	CurrentTagContainer.Paint = function(pnl, w, h) end
	
	local CurrentTagLabel = vgui.Create("DLabel", CurrentTagContainer)
	CurrentTagLabel:Dock(LEFT)
	CurrentTagLabel:SetWide(65)
	CurrentTagLabel:DockMargin(4, 0, 0, 0)
	CurrentTagLabel:SetText("Current Tag: ")
	CurrentTagLabel:SetTextColor(Color(0, 0, 0))
	
	local CurrentTag = vgui.Create("DPanel", CurrentTagContainer)
	CurrentTag:Dock( FILL )
	CurrentTag:DockMargin(4, 0, 0, 0)
	CurrentTag.Paint = function( pnl, w, h )
		
		local name, color = LocalPlayer():getScoreboardTag()
		
		surface.SetTextColor( color or Color( 255, 255, 255 ) )
		surface.SetFont("DermaDefault")
		surface.SetTextPos( 0, ( h/2 ) - ( select( 2, surface.GetTextSize(  "" ) )/2 ) )
		surface.DrawText( name or "" )
		
	end
	
	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(FILL)
		container_1:DockMargin(0, 0, 0, 0)
		container_1.Paint = function() end
	
	local container_1_1 = vgui.Create("DPanel", container_1)
		container_1_1:Dock(FILL)
		container_1_1:DockMargin(0, 0, 0, 0)
		container_1_1.Paint = function() end
	
	local ButtonContainer = vgui.Create("DPanel", container_1_1)
	ButtonContainer:Dock(BOTTOM)
	ButtonContainer:DockMargin(0, 4, 0, 0)
	ButtonContainer:SetTall(30)
	
	local UseBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseBtn:Dock(FILL)
	UseBtn:DockMargin(0, 0, 0, 0)
	UseBtn:SetText("Use Tag")
	
	local UseNoneBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseNoneBtn:Dock(RIGHT)
	UseNoneBtn:DockMargin(4, 0, 0, 0)
	UseNoneBtn:SetWide(120)
	UseNoneBtn:SetText("Use none")
	
	local List = vgui.Create("DListView", container_1_1)
	List:Dock(FILL)
	List:DockMargin(0, 0, 0, 0)
	List:SetMultiSelect(false)
	List:AddColumn("Tag")
	List:AddColumn("Type"):SetFixedWidth(120)
	
	self.Tags.List = List
	
	ATAG.GetUserTags()
	
	UseBtn.DoClick = function()
		if not List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag.") return end
		ATAG.UseTag(List:GetLine(List:GetSelectedLine()).data[1], List:GetLine(List:GetSelectedLine()).Type)
	end
	
	UseNoneBtn.DoClick = function()
		ATAG.UseTag(0, "remove")
	end
	
	local container_1_2 = vgui.Create("DPanel", container_1)
		container_1_2:Dock(RIGHT)
		container_1_2:DockMargin(4, 0, 0, 0)
		container_1_2:SetVisible(false)
		container_1_2.Paint = function() end
		
		container_1_2.PerformLayout = function(pnl)
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
		self.Tags.tg.container_1_2 = container_1_2
		
	local container_1_2_1 = vgui.Create("DPanel", container_1_2)
		container_1_2_1:Dock(BOTTOM)
		container_1_2_1:DockMargin(4, 0, 0, 0)
		container_1_2_1.Paint = function() end
		
		container_1_2_1.PerformLayout = function(pnl)
			pnl:SetTall(ATAG.GUI:GetTall()*0.42)
		end
		
	local Mixer = vgui.Create("DColorMixer", container_1_2_1)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 0, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
	
	local SetTagBtn = vgui.Create("ATAG_Button", container_1_2_1)
		SetTagBtn:Dock(BOTTOM)
		SetTagBtn:DockMargin(0, 4, 0, 0)
		SetTagBtn:SetTall(30)
		SetTagBtn:SetText("Set Tag")
	
	local SetTagBox = vgui.Create("DTextEntry", container_1_2_1)
		SetTagBox:Dock(BOTTOM)
		SetTagBox:DockMargin(0, 4, 0, 0)
		SetTagBox:SetTall(25)
		SetTagBox:SetText("")
		
		SetTagBtn.DoClick = function()
			ATAG.SB_SetOwnTag(SetTagBox:GetValue(), Mixer:GetColor())
		end
		
	local container_1_2_2 = vgui.Create("DPanel", container_1_2)
		container_1_2_2:Dock(BOTTOM)
		container_1_2_2:DockMargin(4, 0, 0, 4)
		container_1_2_2:SetTall(20)
		container_1_2_2.Paint = function() end
		
	local InfoLabel = vgui.Create( "DLabel", container_1_2_2)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetText("You can set your own tag!")
		InfoLabel:SetTextColor(Color(0, 0, 0))
	
	if ATAG.Tags_MyTags then
		if ATAG.Tags_MyTags.SB_CST then
			self.Tags.tg.container_1_2:SetVisible(true)
		end
	end
	
end

function PANEL:Tags_FillTags(Tags)
	if not self.Tags then return end
	if not self.Tags.List then return end
	
	local Tags = Tags or ATAG.Tags_MyTags
	
	if not Tags then return end
	
	self.Tags.List:Clear()
	
	if Tags.PTags then
		local Tags = Tags.PTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Player Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Player Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end

	if Tags.RTags then
		local Tags = Tags.RTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Rank Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Rank Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end
	
end


-- ADMIN
function PANEL:Fill_Admin(panel)

	local Tabs = vgui.Create("DPropertySheet", panel)
	Tabs:Dock(FILL)
	
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Global Tags", Tags, "icon16/tag_blue.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self:Admin_Tags(Tags)
	
	local PlayerTags = vgui.Create("DPanel")
	local Tab_PlayerTags = Tabs:AddSheet("Scoreboard Tags", PlayerTags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, PlayerTags, Tab_PlayerTags)
	self:Admin_ScoreboardTags(PlayerTags)
	
	local ChatTags = vgui.Create("DPanel")
	local Tab_ChatTags = Tabs:AddSheet("Chat Tags", ChatTags, "icon16/comment.png", false, false, nil)
	self:PaintTab(Tabs, ChatTags, Tab_ChatTags)
	self:Admin_ChatTags(ChatTags)
	
end

function PANEL:Admin_Tags(panel)
	
	local Mixer_Container = vgui.Create("DPanel", panel)
	Mixer_Container:Dock(RIGHT)
	Mixer_Container:DockMargin(0, 4, 4, 0)
	Mixer_Container:SetWide(150)
	Mixer_Container.Paint = function(pnl, w, h) end
	
	local Mixer = vgui.Create("DColorMixer", Mixer_Container)
	Mixer:Dock(TOP)
	Mixer:DockMargin(0, 0, 0, 0)
	Mixer:SetTall(150)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(true)
	Mixer:SetColor(Color(255, 255, 255))
	
	-- hehe
	Mixer.WangsPanel:Dock(BOTTOM)
	Mixer.WangsPanel:DockMargin(0, 4, 0, 0)
	Mixer.txtR:Dock(LEFT)
	Mixer.txtR:SetWide(47)
	Mixer.txtR:DockMargin( 0, 0, 0, 0 )
	Mixer.txtG:Dock(LEFT)
	Mixer.txtG:SetWide(48)
	Mixer.txtG:DockMargin( 4, 0, 0, 0 )
	Mixer.txtB:Dock(LEFT)
	Mixer.txtB:SetWide(47)
	Mixer.txtB:DockMargin( 4, 0, 0, 0 )
	Mixer.txtA:SetVisible(false)
	
	
	local panel2 = vgui.Create("DPanel", panel)
	panel2:Dock(FILL)
	panel2.Paint = function(pnl, w, h) end
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(BOTTOM)
	panel3:SetTall(25)
	panel3:DockMargin(4, 4, 10, 0)
	panel3.Paint = function(pnl, w, h) end
	
	local DButton = vgui.Create("ATAG_Button", panel3)
	DButton:Dock(FILL)
	DButton:DockMargin(0, 0, 0, 0)
	DButton:SetText("Add Tag")
	
	local DButton2 = vgui.Create("ATAG_Button", panel3)
	DButton2:Dock(RIGHT)
	DButton2:DockMargin(4, 0, 0, 0)
	DButton2:SetWide(100)
	DButton2:SetText("Stop Editing")
	DButton2:SetVisible(false)
	
	local TextEntry = vgui.Create("DTextEntry", panel2)
	TextEntry:Dock(BOTTOM)
	TextEntry:SetTall(25)
	TextEntry:DockMargin(4, 6, 10, 0)
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(FILL)
	panel3.Paint = function(pnl, w, h) end
	
	local DListView = vgui.Create("DListView", panel3)
	DListView:Dock(FILL)
	DListView:DockMargin(4, 4, 10, 0)
	DListView:SetMultiSelect(false)
	
	ATAG.GetTags()
	
	DListView.OnClickLine = function(pnl, ln)	
		if input.IsMouseDown(MOUSE_LEFT) then
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
	end
		
	DListView.OnRowRightClick = function(pnl, n, ln)
		if pnl.Menu then pnl.Menu:Remove() end
		
		local Menu = vgui.Create("DMenu")
		
		Menu:AddOption("Edit", function()
			pnl:ClearSelection()
			pnl:SelectItem(ln)
			DButton:SetText("Edit Tag")
			DButton2:SetVisible(true)
			TextEntry:SetValue(ln.data[2])
			Mixer:SetColor(ln.data[3])
		end):SetIcon("icon16/page_white_gear.png")
		
		Menu:AddOption("Remove", function()
			ATAG.RemoveTag(ln.data[1])
		end):SetIcon("icon16/cross.png")
		
		Menu:Open()
		
		pnl.Menu = Menu
	end
	
	DButton.DoClick = function(pnl)
		if pnl:GetText() == "Edit Tag" then
			ATAG.EditTag(DListView:GetLine(DListView:GetSelectedLine()).data[1], TextEntry:GetValue(), Mixer:GetColor())
			DButton2:SetVisible(false)
			DButton:SetText("Add Tag")
			DListView:ClearSelection()
			DButton:SetVisible(false)
			DButton:SetVisible(true)
			TextEntry:SetValue("")
		else
			ATAG.AddTag(TextEntry:GetValue(), Mixer:GetColor())
		end
	end
	
	DButton2.DoClick = function()
		DButton2:SetVisible(false)
		DButton:SetText("Add Tag")
		DListView:ClearSelection()
		DButton:SetVisible(false)
		DButton:SetVisible(true)
		TextEntry:SetValue("")
	end
	
	DListView:AddColumn("Tag")
	
	self.Admin.List = DListView
end

function PANEL:Admin_ScoreboardTags(panel)
	
	self.Admin.sbtags = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(RIGHT)
		container_2:DockMargin(4, 4, 4, 4)
		container_2:SetWide(150)
		container_2.Paint = function(pnl, w, h) end
		
		container_2.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_3 = vgui.Create("DPanel", panel)
		container_3:Dock(RIGHT)
		container_3:DockMargin(4, 4, 4, 4)
		container_3:SetWide(25)
		container_3.Paint = function(pnl, w, h) end

	local container_4 = vgui.Create("DPanel", panel)
		container_4:Dock(FILL)
		container_4:DockMargin(4, 4, 4, 4)
		container_4.Paint = function(pnl, w, h) end
		
	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
	
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.sbtags.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				self.Admin.sbtags.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.SB_GetRanks()
				self:Admin_Scoreboard_FillRanks()
				
				self.Admin.sbtags.AddBox:SetText("Rank (Name)")
				self.Admin.sbtags.AddButton:SetText("Add Rank")
				self.Admin.sbtags.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.sbtags.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.sbtags.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.sbtags.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.sbtags.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.sbtags.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.sbtags.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.sbtags.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
					
				
			elseif self.Admin.sbtags.TYPE == "rank" then
				self.Admin.sbtags.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.SB_GetPlayers()
				self:Admin_Scoreboard_FillPlayers()
				
				self.Admin.sbtags.AddBox:SetText("Player (SteamID)")
				self.Admin.sbtags.AddButton:SetText("Add Player")
				self.Admin.sbtags.List.Column:SetName("Player")
				self.Admin.sbtags.aList.Column:SetName("Currently Online Players")
				
				self.Admin.sbtags.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self.Admin.sbtags.GlobalList:Clear()
			self.Admin.sbtags.CustomList:Clear()
		end
	
	-- Search in the list.
	-- If the aList is visible it will search in that list.
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:Clear()
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
	
	
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.sbtags.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
				
				end
				
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers()
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks()
				end
			else
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers(value)
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks(value)
				end
			end
		end
	
	-- The list with the Players or Ranks.
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.sbtags.List = List
		
		ATAG.SB_GetPlayers()

		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if not ln.data then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_GetTags_player(ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "scoreboard")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.SB_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.SB_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.sbtags.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.SB_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.sbtags.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	-- Button to add a player or rank.
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.sbtags.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddPlayer(self.Admin.sbtags.AddBox:GetValue())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddRank(self.Admin.sbtags.AddBox:GetValue())
			end
		end
		
	-- Container to make the Dock work.
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)

	-- Button to make the aList visible.
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))
		
		aListBtn.DoClick = function(pnl)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.sbtags.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.sbtags.aList:Clear()
				
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.sbtags.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.sbtags.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.sbtags.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.sbtags.List:SetVisible(false)
			self.Admin.sbtags.List:SetVisible(true)
		end
	
	-- Textbox to add a player or rank.
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.sbtags.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
	
	-- List for the online players or all ULX / evolve ranks.
	local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:DockMargin(0, 0, 0, 0)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.sbtags.aList = aList

		aList.OnClickLine = function(pnl, ln)
			self.Admin.sbtags.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
	-- Container 2
	-- List for global tags.
	local GlobalTagList = vgui.Create("DListView", container_2)
		GlobalTagList:Dock(FILL)
		GlobalTagList:DockMargin(0, 0, 0, 0)
		GlobalTagList:SetMultiSelect(false)
		GlobalTagList:AddColumn("Tags")
		
		self.Admin.sbtags.GlobalTagList = GlobalTagList
		
		GlobalTagList.OnClickLine = function(pnl, ln)		
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalTagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Add", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/add.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local CustomTag_Container = vgui.Create("DPanel", container_2)
		CustomTag_Container:Dock(BOTTOM)
		CustomTag_Container.Paint = function() end
		
		CustomTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
	
	-- Button to add a custom tag.
	local AddCustomTagBtn = vgui.Create("ATAG_Button", CustomTag_Container)
		AddCustomTagBtn:Dock(BOTTOM)
		AddCustomTagBtn:DockMargin(0, 4, 0, 0)
		AddCustomTagBtn:SetTall(25)
		AddCustomTagBtn:SetText("Add Custom Tag")
		
		AddCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			end
		end
	
	-- TextBox for the custom tag.
	local CustomTagBox = vgui.Create("DTextEntry", CustomTag_Container)
		CustomTagBox:Dock(BOTTOM)
		CustomTagBox:DockMargin(0, 4, 0, 0)
		CustomTagBox:SetTall(25)
		CustomTagBox:SetText("Custom Tag")
		
		self.Admin.sbtags.CustomTagBox = CustomTagBox
		
		CustomTagBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Custom Tag" then
				pnl:SetValue("")
			end
		end
		CustomTagBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Custom Tag")
			end
		end
	
	-- Color mixer for the custom tag.
	local Mixer = vgui.Create("DColorMixer", CustomTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.sbtags.Mixer = Mixer
		
	-- Container 3
	-- Button to add a global tag.
	local AddTagButton = vgui.Create("ATAG_Button", container_3)
		AddTagButton:Dock(TOP)
		AddTagButton:DockMargin(0, 40, 0, 0)
		AddTagButton:SetTall(25)
		AddTagButton:SetIcon(icon_up)
		AddTagButton:SetIconRotation(90)
		AddTagButton:SetIconColor(Color(0, 0, 0, 120))
		
		AddTagButton.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalTagList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to add.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a global tag.
	local RemoveTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveTagBtn:Dock(TOP)
		RemoveTagBtn:DockMargin(0, 4, 0, 0)
		RemoveTagBtn:SetTall(25)
		RemoveTagBtn:SetIcon(icon_down)
		RemoveTagBtn:SetIconRotation(90)
		RemoveTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a custom tag.
	local RemoveCustomTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveCustomTagBtn:Dock(BOTTOM)
		RemoveCustomTagBtn:DockMargin(0, 0, 0, 55)
		RemoveCustomTagBtn:SetTall(25)
		RemoveCustomTagBtn:SetIcon(icon_down)
		RemoveCustomTagBtn:SetIconRotation(90)
		RemoveCustomTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.CustomList:GetSelectedLine() then ATAG.NotifyMessage("Please select the custom tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			end
		end
	
	-- Container 4
	-- List for the global tags the player / rank has.
	local GlobalList = vgui.Create("DListView", container_4)
		GlobalList:Dock(FILL)
		GlobalList:DockMargin(0, 0, 0, 0)
		GlobalList:SetMultiSelect(false)
		GlobalList:AddColumn("Tag")
		
		self.Admin.sbtags.GlobalList = GlobalList
		
		GlobalList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
	
	-- List for the custom tags the player / rank has.
	local CustomList_Container = vgui.Create("DPanel", container_4)
		CustomList_Container:Dock(BOTTOM)
		CustomList_Container:DockMargin(0, 4, 0, 0)
		CustomList_Container:SetTall(140)
		
		CustomList_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local CustomList = vgui.Create("DListView", CustomList_Container)
		CustomList:Dock(FILL)
		CustomList:DockMargin(0, 0, 0, 0)
		CustomList:SetMultiSelect(false)
		CustomList:AddColumn("Custom Tag")
		
		self.Admin.sbtags.CustomList = CustomList
		
		CustomList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		CustomList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
end

function PANEL:Admin_CanSetOwnTag(ln)
	ln.PaintOver = function(pnl, w, h)
		if ln.data.CST then
			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(50, 50, 50))
			surface.DrawOutlinedRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/pencil.png"))
			surface.DrawTexturedRect(w-16, 0, 16, 16)
		end
		if ln.data.AA then
			if ln.data.CST then
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16-16, 0, 16, 16)
			else
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			ln:SetTooltip("This user has been automatically added because rank " .. ln.data.AA .. " can/could edit their own tag.")
		else
			ln:SetTooltip()
		end
	end
end

function PANEL:Admin_Scoreboard_FillPlayers(searchValue)
	if not ATAG.PlayerTags_Players then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.PlayerTags_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.sbtags.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.sbtags.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillRanks(searchValue)

	if not ATAG.Scoreboard_Ranks then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.Scoreboard_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.sbtags.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.sbtags.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_player(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Player_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_rank(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Rank_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	local AutoAssign_TagID, AutoAssign_Type
	
	if Tags.AssignTag then
		AutoAssign_TagID = Tags.AssignTag[1]
		AutoAssign_Type = Tags.AssignTag[2]
	end
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			if AutoAssign_Type == "e" and tostring(data[1]) == AutoAssign_TagID then
				ln.data.autoAssign = true
				
				ln.PaintOver = function(pnl, w, h)
					surface.SetDrawColor(Color(255, 255, 255))
					surface.SetMaterial(Material("icon16/link_go.png"))
					surface.DrawTexturedRect(w-16, 0, 16, 16)
				end
				
			else
				ln.data.autoAssign = false
			end
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		if AutoAssign_Type == "c" and tostring(v[1]) == AutoAssign_TagID then
			ln.data.autoAssign = true
			
			ln.PaintOver = function(pnl, w, h)
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/link_go.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			
		else
			ln.data.autoAssign = false
		end
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
	
end




function PANEL:Admin_ChatTags(panel)

	self.Admin.ch = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
	

	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
		
		
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.ch.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				self.Admin.ch.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.CH_GetRanks()
				self:Admin_Chat_FillRanks()
				
				self.Admin.ch.AddBox:SetText("Rank (Name)")
				self.Admin.ch.AddButton:SetText("Add Rank")
				self.Admin.ch.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.ch.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.ch.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.ch.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.ch.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.ch.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.ch.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.ch.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
			elseif self.Admin.ch.TYPE == "rank" then
				self.Admin.ch.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.CH_GetPlayers()
				self:Admin_Chat_FillPlayers()
				
				self.Admin.ch.AddBox:SetText("Player (SteamID)")
				self.Admin.ch.AddButton:SetText("Add Player")
				self.Admin.ch.List.Column:SetName("Player")
				self.Admin.ch.aList.Column:SetName("Currently Online Players")
				
				self.Admin.ch.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.ch.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, nil)
			self.Admin.ch.TagList:Clear()
		end
		
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.ch.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.ch.TYPE == "rank" then
				
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.ch.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
						
					
				end
				
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers()
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks()
				end
			else
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers(value)
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks(value)
				end
			end
		end
		
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.ch.List = List
		
		ATAG.CH_GetPlayers()
		
		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_GetTags_player(ln.data[1])
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.ch.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "chat")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.CH_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.CH_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.ch.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.CH_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.ch.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.ch.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddPlayer(self.Admin.ch.AddBox:GetValue())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddRank(self.Admin.ch.AddBox:GetValue())
			end
		end
		
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)
		
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))

		aListBtn.DoClick = function(pnl)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.ch.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.ch.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.ch.TYPE == "rank" then
					
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.ch.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.ch.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.ch.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.ch.List:SetVisible(false)
			self.Admin.ch.List:SetVisible(true)
		end
		
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.ch.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
		
		local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.ch.aList = aList
		
		aList.OnClickLine = function(pnl, ln)
			self.Admin.ch.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.Admin.ch.TagList = TagList

		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.Admin.ch.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.ch.List:GetSelectedLine() then return end
				if not pnl:GetSelectedLine() then return end
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_RemoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_RemoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				end
				
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			end
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.Admin.ch.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.ch.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.Admin.ch.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			end
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			end
		end
end



function PANEL:Admin_ChatTags_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

local function IsOnlySpaces(Text)
	if Text == "" then return false end
	for i=1, string.len(Text) do
		if string.GetChar(Text, i) ~= " " then return false end
	end
	return string.len(Text)
end

function PANEL:Admin_Chat_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.Chat_Tags
	if not Tags then return end
	
	self.Admin.ch.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.ch.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.Admin.ch.TagList:SelectItem(self.Admin.ch.TagList:GetLine(Pos))
	end
	
	self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, Tags)
end

function PANEL:Admin_Chat_FillPlayers(searchValue)
	if not ATAG.Chat_Players then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.ch.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.ch.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Chat_FillRanks(searchValue)
	if not ATAG.Chat_Ranks then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.ch.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.ch.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end




function PANEL:OpenSetPlayerNamePnl(SteamID, Type)
	local Frame = vgui.Create("DFrame")
		Frame:SetSize( 300, 85 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("Set Name '" .. SteamID .. "'")
		Frame.Paint = function(pnl, w, h)
			surface.SetDrawColor(100, 150, 200)
			surface.DrawRect(0, 0, w, h)
		end
		
	local TextEntry = vgui.Create( "DTextEntry", Frame )	-- create the form as a child of frame
		TextEntry:SetText("")
		TextEntry:Dock(FILL)
	
	local DButton = vgui.Create( "ATAG_Button", Frame )
		DButton:Dock(BOTTOM)
		DButton:DockMargin(0, 4, 0, 0)
		DButton:SetText( "Set Name for '" .. SteamID .. "'" )
		DButton.DoClick = function()
			if Type == "scoreboard" then
				ATAG.SB_ChangePlayerName(SteamID, TextEntry:GetValue())
			elseif Type == "chat" then
				ATAG.CH_ChangePlayerName(SteamID, TextEntry:GetValue())
			end
			
			Frame:Remove()
		end
end




function PANEL:Admin_PlayerTags_FillTags(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalTagList then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.sbtags.GlobalTagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.sbtags.GlobalTagList:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end

function PANEL:Admin_FillTagList(Tags)
	if not self.Admin then return end
	if not self.Admin.List then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.List:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.List:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end




function PANEL:Fill_Settings(panel)

	-- Container 1
	local Container_1 = vgui.Create("DPanel", panel)
		Container_1:Dock(TOP)
		Container_1:DockMargin(0, 0, 0, 0)
		Container_1:SetTall(32)
		Container_1.Paint = function(pnl, w, h) end
		
	local Info_FrameSize = vgui.Create("DLabel", Container_1)
		Info_FrameSize:SetText("Hover your mouse over the bottom right corner to resize the frame.\nResizing the window might glitch out some of the panels (This is to prevent unnecessary lag). Re-open to fix this.")
		Info_FrameSize:SetTextColor(Color(0, 0, 0))
		Info_FrameSize:SizeToContents()
		
	local Reset_FrameSize = vgui.Create("ATAG_Button", panel)
		Reset_FrameSize:Dock(TOP)
		Reset_FrameSize:DockMargin(0, 0, 0, 0)
		Reset_FrameSize:SetTall(30)
		Reset_FrameSize:SetText("Reset Frame Size")
		
		Reset_FrameSize.DoClick = function()
			ATAG.SetFrameSize(600, 400)
		end
		
	local Center_Frame = vgui.Create("ATAG_Button", panel)
		Center_Frame:Dock(TOP)
		Center_Frame:DockMargin(0, 6, 0, 0)
		Center_Frame:SetTall(30)
		Center_Frame:SetText("Center Frame")
		
		Center_Frame.DoClick = function()
			ATAG.SetFramePos(nil, nil, true)
		end
		
	local Save_Frame = vgui.Create("ATAG_Button", panel)
		Save_Frame:Dock(TOP)
		Save_Frame:DockMargin(0, 6, 0, 0)
		Save_Frame:SetTall(30)
		Save_Frame:SetText("Save Settings")
		
		Save_Frame.DoClick = function()
			ATAG.SaveFrameSettings()
			
			ATAG.NotifyMessage("Settings saved!")
			
		end

end








function PANEL:Fill_TagEdit(panel)

	self.TagEdit.ed = {}

	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.TagEdit.ed.TagList = TagList
		
		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.TagEdit.ed.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not pnl:GetSelectedLine() then return end
				ATAG.CH_RemoveTagPiece_owntag(pnl:GetSelectedLine())
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			ATAG.CH_AddTagPiece_owntag(self.TagEdit.ed.AddTagBox:GetValue(),self.TagEdit.ed.Mixer:GetColor())
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.TagEdit.ed.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.TagEdit.ed.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.TagEdit.ed.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() - 1)
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() + 2)
		end

end

function PANEL:TagEdit_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.OwnTag
	if not Tags then return end
	
	self.TagEdit.ed.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.TagEdit.ed.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.TagEdit.ed.TagList:SelectItem(self.TagEdit.ed.TagList:GetLine(Pos))
	end
	
	self:TagEdit_CreateTagExample(self.TagEdit.ed.TagExample, Tags)
end

function PANEL:TagEdit_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

function PANEL:Create_TagEdit()
	local TagEdit = vgui.Create("DPanel")
	local Tab_TagEdit = self.Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
	self:PaintTab(self.Tabs, TagEdit, Tab_TagEdit)
	self.TagEdit = {}
	self:Fill_TagEdit(TagEdit)
	self.TagEdit_Tab = Tab_TagEdit.Tab
	
	ATAG.CH_GetOwnTags()
end

vgui.Register("atags_main_gui", PANEL, "DPanel")

-- "addons\\atags\\lua\\atags\\vgui\\atags_main_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local icon_up = "icon16/bullet_arrow_up.png"
local icon_down = "icon16/bullet_arrow_down.png"
local icon_player = "icon16/user.png"
local icon_rank = "icon16/award_star_gold_1.png"

local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self.Paint = function(pnl, w, h) end
	
	local NotifyLabel = vgui.Create("DLabel", self)
		NotifyLabel:SetText("")
		NotifyLabel:SizeToContents()
		NotifyLabel:SetPos(0, 5)
		NotifyLabel:SetTextColor(Color(0, 0, 0))
		
		self.NotifyLabel = NotifyLabel

	local Tabs = vgui.Create("DPropertySheet", self)
	Tabs:Dock(FILL)
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end

	self.Tabs = Tabs
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Scoreboard Tags", Tags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self.Tags = {}
	self:Fill_Tags(Tags)
	
	if ATAG.CanEditOwnChatTag then
		local TagEdit = vgui.Create("DPanel")
		local Tab_TagEdit = Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
		self:PaintTab(Tabs, TagEdit, Tab_TagEdit)
		self.TagEdit = {}
		self:Fill_TagEdit(TagEdit)
		
		self.TagEdit_Tab = Tab_TagEdit.Tab
		
		ATAG.CH_GetOwnTags()
	end
	
	ATAG.CH_GetCanSetOwnTag()
	
	if ATAG:HasPermissions(LocalPlayer()) then
		local Admin = vgui.Create("DPanel")
		local Tab_Admin = Tabs:AddSheet("Admin", Admin, "icon16/shield.png", false, false, nil)
		self:PaintTab(Tabs, Admin, Tab_Admin)
		self.Admin = {}
		self:Fill_Admin(Admin)
	end
	
	local Settings = vgui.Create("DPanel") -- Currently disabled, no settings yet.
	local Tab_Settings = Tabs:AddSheet("Settings", Settings, "icon16/wrench.png", false, false, nil)
	self:PaintTab(Tabs, Settings, Tab_Settings)
	self.Settings = {}
	self:Fill_Settings(Settings)
	
end

function PANEL:SetNotifyMessage(msg, duration)
	
	self.NotifyLabel.Think = function(pnl) end

	self.NotifyLabel:SetText(msg)
	self.NotifyLabel:SizeToContents()
	self.NotifyLabel:SetPos(self:GetWide() - self.NotifyLabel:GetWide(), 5)
	self.NotifyLabel:SetTextColor(Color(0, 0, 0, 255))
	self.NotifyLabel.EndAlpha = duration or 5000
	self.NotifyLabel.ShouldFade = true
	
	self.NotifyLabel.Think = function(pnl)
		if pnl.ShouldFade then
			if not pnl.EndAlpha then
				pnl.EndAlpha = duration or 5000
			end
			
			if pnl.EndAlpha ~= 0 then
				pnl.EndAlpha = math.Approach(pnl.EndAlpha, 0, (math.abs(pnl.EndAlpha - 0) + 1) * 1 * FrameTime())
				if pnl.EndAlpha <= 255 then
					pnl:SetTextColor(Color(0, 0, 0, pnl.EndAlpha))
				end
			else
				pnl.ShouldFade = false
			end
		end
	end
end

function PANEL:PaintTab(parent, panel, tab)

	panel.Paint = function(pnl, w, h) end
	
	tab.Tab.Paint = function(pnl, w, h)
		if parent:GetActiveTab() == pnl then
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h-7)
			surface.SetDrawColor(230, 230, 230)
			surface.DrawRect(1, 1, w-2, h-7)
		else
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(180, 180, 180)
			surface.DrawRect(1, 1, w-2, h)
		end
	end
end

function PANEL:ListPaint(panel, ln)
	panel.Paint = function(pnl, w, h)
		if ln:IsSelected() then
			surface.SetDrawColor(80, 130, 255)
		elseif ln:IsHovered() then
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(165, 170, 200)
			else
				surface.SetDrawColor(210, 215, 250)
			end
		else
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(100, 100, 100)
			end
		end
		surface.DrawRect(0, 0, w, h)
		surface.SetTextColor(ln.data[3])
		surface.SetTextPos(5, 2)
		surface.SetFont("DermaDefault") -- Doing this because font size will but out??? cba to figure out why.
		surface.DrawText(ln.data[2])
	end
end

-- TAGS
function PANEL:Fill_Tags(panel)

	self.Tags.tg = {}

	local CurrentTagContainer = vgui.Create("DPanel", panel)
	CurrentTagContainer:Dock(TOP)
	CurrentTagContainer:DockMargin(0, 4, 0, 0)
	CurrentTagContainer:SetTall(30)
	CurrentTagContainer.Paint = function(pnl, w, h) end
	
	local CurrentTagLabel = vgui.Create("DLabel", CurrentTagContainer)
	CurrentTagLabel:Dock(LEFT)
	CurrentTagLabel:SetWide(65)
	CurrentTagLabel:DockMargin(4, 0, 0, 0)
	CurrentTagLabel:SetText("Current Tag: ")
	CurrentTagLabel:SetTextColor(Color(0, 0, 0))
	
	local CurrentTag = vgui.Create("DPanel", CurrentTagContainer)
	CurrentTag:Dock( FILL )
	CurrentTag:DockMargin(4, 0, 0, 0)
	CurrentTag.Paint = function( pnl, w, h )
		
		local name, color = LocalPlayer():getScoreboardTag()
		
		surface.SetTextColor( color or Color( 255, 255, 255 ) )
		surface.SetFont("DermaDefault")
		surface.SetTextPos( 0, ( h/2 ) - ( select( 2, surface.GetTextSize(  "" ) )/2 ) )
		surface.DrawText( name or "" )
		
	end
	
	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(FILL)
		container_1:DockMargin(0, 0, 0, 0)
		container_1.Paint = function() end
	
	local container_1_1 = vgui.Create("DPanel", container_1)
		container_1_1:Dock(FILL)
		container_1_1:DockMargin(0, 0, 0, 0)
		container_1_1.Paint = function() end
	
	local ButtonContainer = vgui.Create("DPanel", container_1_1)
	ButtonContainer:Dock(BOTTOM)
	ButtonContainer:DockMargin(0, 4, 0, 0)
	ButtonContainer:SetTall(30)
	
	local UseBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseBtn:Dock(FILL)
	UseBtn:DockMargin(0, 0, 0, 0)
	UseBtn:SetText("Use Tag")
	
	local UseNoneBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseNoneBtn:Dock(RIGHT)
	UseNoneBtn:DockMargin(4, 0, 0, 0)
	UseNoneBtn:SetWide(120)
	UseNoneBtn:SetText("Use none")
	
	local List = vgui.Create("DListView", container_1_1)
	List:Dock(FILL)
	List:DockMargin(0, 0, 0, 0)
	List:SetMultiSelect(false)
	List:AddColumn("Tag")
	List:AddColumn("Type"):SetFixedWidth(120)
	
	self.Tags.List = List
	
	ATAG.GetUserTags()
	
	UseBtn.DoClick = function()
		if not List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag.") return end
		ATAG.UseTag(List:GetLine(List:GetSelectedLine()).data[1], List:GetLine(List:GetSelectedLine()).Type)
	end
	
	UseNoneBtn.DoClick = function()
		ATAG.UseTag(0, "remove")
	end
	
	local container_1_2 = vgui.Create("DPanel", container_1)
		container_1_2:Dock(RIGHT)
		container_1_2:DockMargin(4, 0, 0, 0)
		container_1_2:SetVisible(false)
		container_1_2.Paint = function() end
		
		container_1_2.PerformLayout = function(pnl)
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
		self.Tags.tg.container_1_2 = container_1_2
		
	local container_1_2_1 = vgui.Create("DPanel", container_1_2)
		container_1_2_1:Dock(BOTTOM)
		container_1_2_1:DockMargin(4, 0, 0, 0)
		container_1_2_1.Paint = function() end
		
		container_1_2_1.PerformLayout = function(pnl)
			pnl:SetTall(ATAG.GUI:GetTall()*0.42)
		end
		
	local Mixer = vgui.Create("DColorMixer", container_1_2_1)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 0, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
	
	local SetTagBtn = vgui.Create("ATAG_Button", container_1_2_1)
		SetTagBtn:Dock(BOTTOM)
		SetTagBtn:DockMargin(0, 4, 0, 0)
		SetTagBtn:SetTall(30)
		SetTagBtn:SetText("Set Tag")
	
	local SetTagBox = vgui.Create("DTextEntry", container_1_2_1)
		SetTagBox:Dock(BOTTOM)
		SetTagBox:DockMargin(0, 4, 0, 0)
		SetTagBox:SetTall(25)
		SetTagBox:SetText("")
		
		SetTagBtn.DoClick = function()
			ATAG.SB_SetOwnTag(SetTagBox:GetValue(), Mixer:GetColor())
		end
		
	local container_1_2_2 = vgui.Create("DPanel", container_1_2)
		container_1_2_2:Dock(BOTTOM)
		container_1_2_2:DockMargin(4, 0, 0, 4)
		container_1_2_2:SetTall(20)
		container_1_2_2.Paint = function() end
		
	local InfoLabel = vgui.Create( "DLabel", container_1_2_2)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetText("You can set your own tag!")
		InfoLabel:SetTextColor(Color(0, 0, 0))
	
	if ATAG.Tags_MyTags then
		if ATAG.Tags_MyTags.SB_CST then
			self.Tags.tg.container_1_2:SetVisible(true)
		end
	end
	
end

function PANEL:Tags_FillTags(Tags)
	if not self.Tags then return end
	if not self.Tags.List then return end
	
	local Tags = Tags or ATAG.Tags_MyTags
	
	if not Tags then return end
	
	self.Tags.List:Clear()
	
	if Tags.PTags then
		local Tags = Tags.PTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Player Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Player Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end

	if Tags.RTags then
		local Tags = Tags.RTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Rank Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Rank Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end
	
end


-- ADMIN
function PANEL:Fill_Admin(panel)

	local Tabs = vgui.Create("DPropertySheet", panel)
	Tabs:Dock(FILL)
	
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Global Tags", Tags, "icon16/tag_blue.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self:Admin_Tags(Tags)
	
	local PlayerTags = vgui.Create("DPanel")
	local Tab_PlayerTags = Tabs:AddSheet("Scoreboard Tags", PlayerTags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, PlayerTags, Tab_PlayerTags)
	self:Admin_ScoreboardTags(PlayerTags)
	
	local ChatTags = vgui.Create("DPanel")
	local Tab_ChatTags = Tabs:AddSheet("Chat Tags", ChatTags, "icon16/comment.png", false, false, nil)
	self:PaintTab(Tabs, ChatTags, Tab_ChatTags)
	self:Admin_ChatTags(ChatTags)
	
end

function PANEL:Admin_Tags(panel)
	
	local Mixer_Container = vgui.Create("DPanel", panel)
	Mixer_Container:Dock(RIGHT)
	Mixer_Container:DockMargin(0, 4, 4, 0)
	Mixer_Container:SetWide(150)
	Mixer_Container.Paint = function(pnl, w, h) end
	
	local Mixer = vgui.Create("DColorMixer", Mixer_Container)
	Mixer:Dock(TOP)
	Mixer:DockMargin(0, 0, 0, 0)
	Mixer:SetTall(150)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(true)
	Mixer:SetColor(Color(255, 255, 255))
	
	-- hehe
	Mixer.WangsPanel:Dock(BOTTOM)
	Mixer.WangsPanel:DockMargin(0, 4, 0, 0)
	Mixer.txtR:Dock(LEFT)
	Mixer.txtR:SetWide(47)
	Mixer.txtR:DockMargin( 0, 0, 0, 0 )
	Mixer.txtG:Dock(LEFT)
	Mixer.txtG:SetWide(48)
	Mixer.txtG:DockMargin( 4, 0, 0, 0 )
	Mixer.txtB:Dock(LEFT)
	Mixer.txtB:SetWide(47)
	Mixer.txtB:DockMargin( 4, 0, 0, 0 )
	Mixer.txtA:SetVisible(false)
	
	
	local panel2 = vgui.Create("DPanel", panel)
	panel2:Dock(FILL)
	panel2.Paint = function(pnl, w, h) end
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(BOTTOM)
	panel3:SetTall(25)
	panel3:DockMargin(4, 4, 10, 0)
	panel3.Paint = function(pnl, w, h) end
	
	local DButton = vgui.Create("ATAG_Button", panel3)
	DButton:Dock(FILL)
	DButton:DockMargin(0, 0, 0, 0)
	DButton:SetText("Add Tag")
	
	local DButton2 = vgui.Create("ATAG_Button", panel3)
	DButton2:Dock(RIGHT)
	DButton2:DockMargin(4, 0, 0, 0)
	DButton2:SetWide(100)
	DButton2:SetText("Stop Editing")
	DButton2:SetVisible(false)
	
	local TextEntry = vgui.Create("DTextEntry", panel2)
	TextEntry:Dock(BOTTOM)
	TextEntry:SetTall(25)
	TextEntry:DockMargin(4, 6, 10, 0)
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(FILL)
	panel3.Paint = function(pnl, w, h) end
	
	local DListView = vgui.Create("DListView", panel3)
	DListView:Dock(FILL)
	DListView:DockMargin(4, 4, 10, 0)
	DListView:SetMultiSelect(false)
	
	ATAG.GetTags()
	
	DListView.OnClickLine = function(pnl, ln)	
		if input.IsMouseDown(MOUSE_LEFT) then
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
	end
		
	DListView.OnRowRightClick = function(pnl, n, ln)
		if pnl.Menu then pnl.Menu:Remove() end
		
		local Menu = vgui.Create("DMenu")
		
		Menu:AddOption("Edit", function()
			pnl:ClearSelection()
			pnl:SelectItem(ln)
			DButton:SetText("Edit Tag")
			DButton2:SetVisible(true)
			TextEntry:SetValue(ln.data[2])
			Mixer:SetColor(ln.data[3])
		end):SetIcon("icon16/page_white_gear.png")
		
		Menu:AddOption("Remove", function()
			ATAG.RemoveTag(ln.data[1])
		end):SetIcon("icon16/cross.png")
		
		Menu:Open()
		
		pnl.Menu = Menu
	end
	
	DButton.DoClick = function(pnl)
		if pnl:GetText() == "Edit Tag" then
			ATAG.EditTag(DListView:GetLine(DListView:GetSelectedLine()).data[1], TextEntry:GetValue(), Mixer:GetColor())
			DButton2:SetVisible(false)
			DButton:SetText("Add Tag")
			DListView:ClearSelection()
			DButton:SetVisible(false)
			DButton:SetVisible(true)
			TextEntry:SetValue("")
		else
			ATAG.AddTag(TextEntry:GetValue(), Mixer:GetColor())
		end
	end
	
	DButton2.DoClick = function()
		DButton2:SetVisible(false)
		DButton:SetText("Add Tag")
		DListView:ClearSelection()
		DButton:SetVisible(false)
		DButton:SetVisible(true)
		TextEntry:SetValue("")
	end
	
	DListView:AddColumn("Tag")
	
	self.Admin.List = DListView
end

function PANEL:Admin_ScoreboardTags(panel)
	
	self.Admin.sbtags = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(RIGHT)
		container_2:DockMargin(4, 4, 4, 4)
		container_2:SetWide(150)
		container_2.Paint = function(pnl, w, h) end
		
		container_2.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_3 = vgui.Create("DPanel", panel)
		container_3:Dock(RIGHT)
		container_3:DockMargin(4, 4, 4, 4)
		container_3:SetWide(25)
		container_3.Paint = function(pnl, w, h) end

	local container_4 = vgui.Create("DPanel", panel)
		container_4:Dock(FILL)
		container_4:DockMargin(4, 4, 4, 4)
		container_4.Paint = function(pnl, w, h) end
		
	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
	
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.sbtags.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				self.Admin.sbtags.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.SB_GetRanks()
				self:Admin_Scoreboard_FillRanks()
				
				self.Admin.sbtags.AddBox:SetText("Rank (Name)")
				self.Admin.sbtags.AddButton:SetText("Add Rank")
				self.Admin.sbtags.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.sbtags.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.sbtags.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.sbtags.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.sbtags.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.sbtags.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.sbtags.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.sbtags.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
					
				
			elseif self.Admin.sbtags.TYPE == "rank" then
				self.Admin.sbtags.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.SB_GetPlayers()
				self:Admin_Scoreboard_FillPlayers()
				
				self.Admin.sbtags.AddBox:SetText("Player (SteamID)")
				self.Admin.sbtags.AddButton:SetText("Add Player")
				self.Admin.sbtags.List.Column:SetName("Player")
				self.Admin.sbtags.aList.Column:SetName("Currently Online Players")
				
				self.Admin.sbtags.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self.Admin.sbtags.GlobalList:Clear()
			self.Admin.sbtags.CustomList:Clear()
		end
	
	-- Search in the list.
	-- If the aList is visible it will search in that list.
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:Clear()
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
	
	
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.sbtags.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
				
				end
				
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers()
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks()
				end
			else
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers(value)
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks(value)
				end
			end
		end
	
	-- The list with the Players or Ranks.
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.sbtags.List = List
		
		ATAG.SB_GetPlayers()

		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if not ln.data then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_GetTags_player(ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "scoreboard")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.SB_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.SB_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.sbtags.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.SB_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.sbtags.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	-- Button to add a player or rank.
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.sbtags.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddPlayer(self.Admin.sbtags.AddBox:GetValue())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddRank(self.Admin.sbtags.AddBox:GetValue())
			end
		end
		
	-- Container to make the Dock work.
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)

	-- Button to make the aList visible.
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))
		
		aListBtn.DoClick = function(pnl)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.sbtags.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.sbtags.aList:Clear()
				
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.sbtags.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.sbtags.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.sbtags.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.sbtags.List:SetVisible(false)
			self.Admin.sbtags.List:SetVisible(true)
		end
	
	-- Textbox to add a player or rank.
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.sbtags.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
	
	-- List for the online players or all ULX / evolve ranks.
	local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:DockMargin(0, 0, 0, 0)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.sbtags.aList = aList

		aList.OnClickLine = function(pnl, ln)
			self.Admin.sbtags.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
	-- Container 2
	-- List for global tags.
	local GlobalTagList = vgui.Create("DListView", container_2)
		GlobalTagList:Dock(FILL)
		GlobalTagList:DockMargin(0, 0, 0, 0)
		GlobalTagList:SetMultiSelect(false)
		GlobalTagList:AddColumn("Tags")
		
		self.Admin.sbtags.GlobalTagList = GlobalTagList
		
		GlobalTagList.OnClickLine = function(pnl, ln)		
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalTagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Add", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/add.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local CustomTag_Container = vgui.Create("DPanel", container_2)
		CustomTag_Container:Dock(BOTTOM)
		CustomTag_Container.Paint = function() end
		
		CustomTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
	
	-- Button to add a custom tag.
	local AddCustomTagBtn = vgui.Create("ATAG_Button", CustomTag_Container)
		AddCustomTagBtn:Dock(BOTTOM)
		AddCustomTagBtn:DockMargin(0, 4, 0, 0)
		AddCustomTagBtn:SetTall(25)
		AddCustomTagBtn:SetText("Add Custom Tag")
		
		AddCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			end
		end
	
	-- TextBox for the custom tag.
	local CustomTagBox = vgui.Create("DTextEntry", CustomTag_Container)
		CustomTagBox:Dock(BOTTOM)
		CustomTagBox:DockMargin(0, 4, 0, 0)
		CustomTagBox:SetTall(25)
		CustomTagBox:SetText("Custom Tag")
		
		self.Admin.sbtags.CustomTagBox = CustomTagBox
		
		CustomTagBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Custom Tag" then
				pnl:SetValue("")
			end
		end
		CustomTagBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Custom Tag")
			end
		end
	
	-- Color mixer for the custom tag.
	local Mixer = vgui.Create("DColorMixer", CustomTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.sbtags.Mixer = Mixer
		
	-- Container 3
	-- Button to add a global tag.
	local AddTagButton = vgui.Create("ATAG_Button", container_3)
		AddTagButton:Dock(TOP)
		AddTagButton:DockMargin(0, 40, 0, 0)
		AddTagButton:SetTall(25)
		AddTagButton:SetIcon(icon_up)
		AddTagButton:SetIconRotation(90)
		AddTagButton:SetIconColor(Color(0, 0, 0, 120))
		
		AddTagButton.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalTagList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to add.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a global tag.
	local RemoveTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveTagBtn:Dock(TOP)
		RemoveTagBtn:DockMargin(0, 4, 0, 0)
		RemoveTagBtn:SetTall(25)
		RemoveTagBtn:SetIcon(icon_down)
		RemoveTagBtn:SetIconRotation(90)
		RemoveTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a custom tag.
	local RemoveCustomTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveCustomTagBtn:Dock(BOTTOM)
		RemoveCustomTagBtn:DockMargin(0, 0, 0, 55)
		RemoveCustomTagBtn:SetTall(25)
		RemoveCustomTagBtn:SetIcon(icon_down)
		RemoveCustomTagBtn:SetIconRotation(90)
		RemoveCustomTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.CustomList:GetSelectedLine() then ATAG.NotifyMessage("Please select the custom tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			end
		end
	
	-- Container 4
	-- List for the global tags the player / rank has.
	local GlobalList = vgui.Create("DListView", container_4)
		GlobalList:Dock(FILL)
		GlobalList:DockMargin(0, 0, 0, 0)
		GlobalList:SetMultiSelect(false)
		GlobalList:AddColumn("Tag")
		
		self.Admin.sbtags.GlobalList = GlobalList
		
		GlobalList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
	
	-- List for the custom tags the player / rank has.
	local CustomList_Container = vgui.Create("DPanel", container_4)
		CustomList_Container:Dock(BOTTOM)
		CustomList_Container:DockMargin(0, 4, 0, 0)
		CustomList_Container:SetTall(140)
		
		CustomList_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local CustomList = vgui.Create("DListView", CustomList_Container)
		CustomList:Dock(FILL)
		CustomList:DockMargin(0, 0, 0, 0)
		CustomList:SetMultiSelect(false)
		CustomList:AddColumn("Custom Tag")
		
		self.Admin.sbtags.CustomList = CustomList
		
		CustomList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		CustomList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
end

function PANEL:Admin_CanSetOwnTag(ln)
	ln.PaintOver = function(pnl, w, h)
		if ln.data.CST then
			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(50, 50, 50))
			surface.DrawOutlinedRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/pencil.png"))
			surface.DrawTexturedRect(w-16, 0, 16, 16)
		end
		if ln.data.AA then
			if ln.data.CST then
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16-16, 0, 16, 16)
			else
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			ln:SetTooltip("This user has been automatically added because rank " .. ln.data.AA .. " can/could edit their own tag.")
		else
			ln:SetTooltip()
		end
	end
end

function PANEL:Admin_Scoreboard_FillPlayers(searchValue)
	if not ATAG.PlayerTags_Players then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.PlayerTags_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.sbtags.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.sbtags.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillRanks(searchValue)

	if not ATAG.Scoreboard_Ranks then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.Scoreboard_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.sbtags.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.sbtags.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_player(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Player_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_rank(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Rank_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	local AutoAssign_TagID, AutoAssign_Type
	
	if Tags.AssignTag then
		AutoAssign_TagID = Tags.AssignTag[1]
		AutoAssign_Type = Tags.AssignTag[2]
	end
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			if AutoAssign_Type == "e" and tostring(data[1]) == AutoAssign_TagID then
				ln.data.autoAssign = true
				
				ln.PaintOver = function(pnl, w, h)
					surface.SetDrawColor(Color(255, 255, 255))
					surface.SetMaterial(Material("icon16/link_go.png"))
					surface.DrawTexturedRect(w-16, 0, 16, 16)
				end
				
			else
				ln.data.autoAssign = false
			end
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		if AutoAssign_Type == "c" and tostring(v[1]) == AutoAssign_TagID then
			ln.data.autoAssign = true
			
			ln.PaintOver = function(pnl, w, h)
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/link_go.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			
		else
			ln.data.autoAssign = false
		end
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
	
end




function PANEL:Admin_ChatTags(panel)

	self.Admin.ch = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
	

	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
		
		
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.ch.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				self.Admin.ch.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.CH_GetRanks()
				self:Admin_Chat_FillRanks()
				
				self.Admin.ch.AddBox:SetText("Rank (Name)")
				self.Admin.ch.AddButton:SetText("Add Rank")
				self.Admin.ch.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.ch.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.ch.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.ch.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.ch.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.ch.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.ch.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.ch.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
			elseif self.Admin.ch.TYPE == "rank" then
				self.Admin.ch.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.CH_GetPlayers()
				self:Admin_Chat_FillPlayers()
				
				self.Admin.ch.AddBox:SetText("Player (SteamID)")
				self.Admin.ch.AddButton:SetText("Add Player")
				self.Admin.ch.List.Column:SetName("Player")
				self.Admin.ch.aList.Column:SetName("Currently Online Players")
				
				self.Admin.ch.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.ch.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, nil)
			self.Admin.ch.TagList:Clear()
		end
		
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.ch.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.ch.TYPE == "rank" then
				
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.ch.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
						
					
				end
				
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers()
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks()
				end
			else
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers(value)
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks(value)
				end
			end
		end
		
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.ch.List = List
		
		ATAG.CH_GetPlayers()
		
		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_GetTags_player(ln.data[1])
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.ch.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "chat")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.CH_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.CH_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.ch.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.CH_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.ch.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.ch.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddPlayer(self.Admin.ch.AddBox:GetValue())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddRank(self.Admin.ch.AddBox:GetValue())
			end
		end
		
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)
		
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))

		aListBtn.DoClick = function(pnl)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.ch.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.ch.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.ch.TYPE == "rank" then
					
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.ch.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.ch.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.ch.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.ch.List:SetVisible(false)
			self.Admin.ch.List:SetVisible(true)
		end
		
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.ch.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
		
		local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.ch.aList = aList
		
		aList.OnClickLine = function(pnl, ln)
			self.Admin.ch.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.Admin.ch.TagList = TagList

		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.Admin.ch.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.ch.List:GetSelectedLine() then return end
				if not pnl:GetSelectedLine() then return end
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_RemoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_RemoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				end
				
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			end
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.Admin.ch.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.ch.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.Admin.ch.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			end
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			end
		end
end



function PANEL:Admin_ChatTags_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

local function IsOnlySpaces(Text)
	if Text == "" then return false end
	for i=1, string.len(Text) do
		if string.GetChar(Text, i) ~= " " then return false end
	end
	return string.len(Text)
end

function PANEL:Admin_Chat_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.Chat_Tags
	if not Tags then return end
	
	self.Admin.ch.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.ch.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.Admin.ch.TagList:SelectItem(self.Admin.ch.TagList:GetLine(Pos))
	end
	
	self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, Tags)
end

function PANEL:Admin_Chat_FillPlayers(searchValue)
	if not ATAG.Chat_Players then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.ch.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.ch.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Chat_FillRanks(searchValue)
	if not ATAG.Chat_Ranks then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.ch.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.ch.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end




function PANEL:OpenSetPlayerNamePnl(SteamID, Type)
	local Frame = vgui.Create("DFrame")
		Frame:SetSize( 300, 85 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("Set Name '" .. SteamID .. "'")
		Frame.Paint = function(pnl, w, h)
			surface.SetDrawColor(100, 150, 200)
			surface.DrawRect(0, 0, w, h)
		end
		
	local TextEntry = vgui.Create( "DTextEntry", Frame )	-- create the form as a child of frame
		TextEntry:SetText("")
		TextEntry:Dock(FILL)
	
	local DButton = vgui.Create( "ATAG_Button", Frame )
		DButton:Dock(BOTTOM)
		DButton:DockMargin(0, 4, 0, 0)
		DButton:SetText( "Set Name for '" .. SteamID .. "'" )
		DButton.DoClick = function()
			if Type == "scoreboard" then
				ATAG.SB_ChangePlayerName(SteamID, TextEntry:GetValue())
			elseif Type == "chat" then
				ATAG.CH_ChangePlayerName(SteamID, TextEntry:GetValue())
			end
			
			Frame:Remove()
		end
end




function PANEL:Admin_PlayerTags_FillTags(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalTagList then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.sbtags.GlobalTagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.sbtags.GlobalTagList:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end

function PANEL:Admin_FillTagList(Tags)
	if not self.Admin then return end
	if not self.Admin.List then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.List:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.List:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end




function PANEL:Fill_Settings(panel)

	-- Container 1
	local Container_1 = vgui.Create("DPanel", panel)
		Container_1:Dock(TOP)
		Container_1:DockMargin(0, 0, 0, 0)
		Container_1:SetTall(32)
		Container_1.Paint = function(pnl, w, h) end
		
	local Info_FrameSize = vgui.Create("DLabel", Container_1)
		Info_FrameSize:SetText("Hover your mouse over the bottom right corner to resize the frame.\nResizing the window might glitch out some of the panels (This is to prevent unnecessary lag). Re-open to fix this.")
		Info_FrameSize:SetTextColor(Color(0, 0, 0))
		Info_FrameSize:SizeToContents()
		
	local Reset_FrameSize = vgui.Create("ATAG_Button", panel)
		Reset_FrameSize:Dock(TOP)
		Reset_FrameSize:DockMargin(0, 0, 0, 0)
		Reset_FrameSize:SetTall(30)
		Reset_FrameSize:SetText("Reset Frame Size")
		
		Reset_FrameSize.DoClick = function()
			ATAG.SetFrameSize(600, 400)
		end
		
	local Center_Frame = vgui.Create("ATAG_Button", panel)
		Center_Frame:Dock(TOP)
		Center_Frame:DockMargin(0, 6, 0, 0)
		Center_Frame:SetTall(30)
		Center_Frame:SetText("Center Frame")
		
		Center_Frame.DoClick = function()
			ATAG.SetFramePos(nil, nil, true)
		end
		
	local Save_Frame = vgui.Create("ATAG_Button", panel)
		Save_Frame:Dock(TOP)
		Save_Frame:DockMargin(0, 6, 0, 0)
		Save_Frame:SetTall(30)
		Save_Frame:SetText("Save Settings")
		
		Save_Frame.DoClick = function()
			ATAG.SaveFrameSettings()
			
			ATAG.NotifyMessage("Settings saved!")
			
		end

end








function PANEL:Fill_TagEdit(panel)

	self.TagEdit.ed = {}

	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.TagEdit.ed.TagList = TagList
		
		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.TagEdit.ed.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not pnl:GetSelectedLine() then return end
				ATAG.CH_RemoveTagPiece_owntag(pnl:GetSelectedLine())
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			ATAG.CH_AddTagPiece_owntag(self.TagEdit.ed.AddTagBox:GetValue(),self.TagEdit.ed.Mixer:GetColor())
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.TagEdit.ed.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.TagEdit.ed.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.TagEdit.ed.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() - 1)
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() + 2)
		end

end

function PANEL:TagEdit_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.OwnTag
	if not Tags then return end
	
	self.TagEdit.ed.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.TagEdit.ed.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.TagEdit.ed.TagList:SelectItem(self.TagEdit.ed.TagList:GetLine(Pos))
	end
	
	self:TagEdit_CreateTagExample(self.TagEdit.ed.TagExample, Tags)
end

function PANEL:TagEdit_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

function PANEL:Create_TagEdit()
	local TagEdit = vgui.Create("DPanel")
	local Tab_TagEdit = self.Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
	self:PaintTab(self.Tabs, TagEdit, Tab_TagEdit)
	self.TagEdit = {}
	self:Fill_TagEdit(TagEdit)
	self.TagEdit_Tab = Tab_TagEdit.Tab
	
	ATAG.CH_GetOwnTags()
end

vgui.Register("atags_main_gui", PANEL, "DPanel")

-- "addons\\atags\\lua\\atags\\vgui\\atags_main_gui.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local icon_up = "icon16/bullet_arrow_up.png"
local icon_down = "icon16/bullet_arrow_down.png"
local icon_player = "icon16/user.png"
local icon_rank = "icon16/award_star_gold_1.png"

local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self.Paint = function(pnl, w, h) end
	
	local NotifyLabel = vgui.Create("DLabel", self)
		NotifyLabel:SetText("")
		NotifyLabel:SizeToContents()
		NotifyLabel:SetPos(0, 5)
		NotifyLabel:SetTextColor(Color(0, 0, 0))
		
		self.NotifyLabel = NotifyLabel

	local Tabs = vgui.Create("DPropertySheet", self)
	Tabs:Dock(FILL)
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end

	self.Tabs = Tabs
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Scoreboard Tags", Tags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self.Tags = {}
	self:Fill_Tags(Tags)
	
	if ATAG.CanEditOwnChatTag then
		local TagEdit = vgui.Create("DPanel")
		local Tab_TagEdit = Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
		self:PaintTab(Tabs, TagEdit, Tab_TagEdit)
		self.TagEdit = {}
		self:Fill_TagEdit(TagEdit)
		
		self.TagEdit_Tab = Tab_TagEdit.Tab
		
		ATAG.CH_GetOwnTags()
	end
	
	ATAG.CH_GetCanSetOwnTag()
	
	if ATAG:HasPermissions(LocalPlayer()) then
		local Admin = vgui.Create("DPanel")
		local Tab_Admin = Tabs:AddSheet("Admin", Admin, "icon16/shield.png", false, false, nil)
		self:PaintTab(Tabs, Admin, Tab_Admin)
		self.Admin = {}
		self:Fill_Admin(Admin)
	end
	
	local Settings = vgui.Create("DPanel") -- Currently disabled, no settings yet.
	local Tab_Settings = Tabs:AddSheet("Settings", Settings, "icon16/wrench.png", false, false, nil)
	self:PaintTab(Tabs, Settings, Tab_Settings)
	self.Settings = {}
	self:Fill_Settings(Settings)
	
end

function PANEL:SetNotifyMessage(msg, duration)
	
	self.NotifyLabel.Think = function(pnl) end

	self.NotifyLabel:SetText(msg)
	self.NotifyLabel:SizeToContents()
	self.NotifyLabel:SetPos(self:GetWide() - self.NotifyLabel:GetWide(), 5)
	self.NotifyLabel:SetTextColor(Color(0, 0, 0, 255))
	self.NotifyLabel.EndAlpha = duration or 5000
	self.NotifyLabel.ShouldFade = true
	
	self.NotifyLabel.Think = function(pnl)
		if pnl.ShouldFade then
			if not pnl.EndAlpha then
				pnl.EndAlpha = duration or 5000
			end
			
			if pnl.EndAlpha ~= 0 then
				pnl.EndAlpha = math.Approach(pnl.EndAlpha, 0, (math.abs(pnl.EndAlpha - 0) + 1) * 1 * FrameTime())
				if pnl.EndAlpha <= 255 then
					pnl:SetTextColor(Color(0, 0, 0, pnl.EndAlpha))
				end
			else
				pnl.ShouldFade = false
			end
		end
	end
end

function PANEL:PaintTab(parent, panel, tab)

	panel.Paint = function(pnl, w, h) end
	
	tab.Tab.Paint = function(pnl, w, h)
		if parent:GetActiveTab() == pnl then
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h-7)
			surface.SetDrawColor(230, 230, 230)
			surface.DrawRect(1, 1, w-2, h-7)
		else
			surface.SetDrawColor(100, 100, 100)
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(180, 180, 180)
			surface.DrawRect(1, 1, w-2, h)
		end
	end
end

function PANEL:ListPaint(panel, ln)
	panel.Paint = function(pnl, w, h)
		if ln:IsSelected() then
			surface.SetDrawColor(80, 130, 255)
		elseif ln:IsHovered() then
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(165, 170, 200)
			else
				surface.SetDrawColor(210, 215, 250)
			end
		else
			if ln.data[3].r + ln.data[3].g + ln.data[3].b > 450 then
				surface.SetDrawColor(100, 100, 100)
			end
		end
		surface.DrawRect(0, 0, w, h)
		surface.SetTextColor(ln.data[3])
		surface.SetTextPos(5, 2)
		surface.SetFont("DermaDefault") -- Doing this because font size will but out??? cba to figure out why.
		surface.DrawText(ln.data[2])
	end
end

-- TAGS
function PANEL:Fill_Tags(panel)

	self.Tags.tg = {}

	local CurrentTagContainer = vgui.Create("DPanel", panel)
	CurrentTagContainer:Dock(TOP)
	CurrentTagContainer:DockMargin(0, 4, 0, 0)
	CurrentTagContainer:SetTall(30)
	CurrentTagContainer.Paint = function(pnl, w, h) end
	
	local CurrentTagLabel = vgui.Create("DLabel", CurrentTagContainer)
	CurrentTagLabel:Dock(LEFT)
	CurrentTagLabel:SetWide(65)
	CurrentTagLabel:DockMargin(4, 0, 0, 0)
	CurrentTagLabel:SetText("Current Tag: ")
	CurrentTagLabel:SetTextColor(Color(0, 0, 0))
	
	local CurrentTag = vgui.Create("DPanel", CurrentTagContainer)
	CurrentTag:Dock( FILL )
	CurrentTag:DockMargin(4, 0, 0, 0)
	CurrentTag.Paint = function( pnl, w, h )
		
		local name, color = LocalPlayer():getScoreboardTag()
		
		surface.SetTextColor( color or Color( 255, 255, 255 ) )
		surface.SetFont("DermaDefault")
		surface.SetTextPos( 0, ( h/2 ) - ( select( 2, surface.GetTextSize(  "" ) )/2 ) )
		surface.DrawText( name or "" )
		
	end
	
	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(FILL)
		container_1:DockMargin(0, 0, 0, 0)
		container_1.Paint = function() end
	
	local container_1_1 = vgui.Create("DPanel", container_1)
		container_1_1:Dock(FILL)
		container_1_1:DockMargin(0, 0, 0, 0)
		container_1_1.Paint = function() end
	
	local ButtonContainer = vgui.Create("DPanel", container_1_1)
	ButtonContainer:Dock(BOTTOM)
	ButtonContainer:DockMargin(0, 4, 0, 0)
	ButtonContainer:SetTall(30)
	
	local UseBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseBtn:Dock(FILL)
	UseBtn:DockMargin(0, 0, 0, 0)
	UseBtn:SetText("Use Tag")
	
	local UseNoneBtn = vgui.Create("ATAG_Button", ButtonContainer)
	UseNoneBtn:Dock(RIGHT)
	UseNoneBtn:DockMargin(4, 0, 0, 0)
	UseNoneBtn:SetWide(120)
	UseNoneBtn:SetText("Use none")
	
	local List = vgui.Create("DListView", container_1_1)
	List:Dock(FILL)
	List:DockMargin(0, 0, 0, 0)
	List:SetMultiSelect(false)
	List:AddColumn("Tag")
	List:AddColumn("Type"):SetFixedWidth(120)
	
	self.Tags.List = List
	
	ATAG.GetUserTags()
	
	UseBtn.DoClick = function()
		if not List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag.") return end
		ATAG.UseTag(List:GetLine(List:GetSelectedLine()).data[1], List:GetLine(List:GetSelectedLine()).Type)
	end
	
	UseNoneBtn.DoClick = function()
		ATAG.UseTag(0, "remove")
	end
	
	local container_1_2 = vgui.Create("DPanel", container_1)
		container_1_2:Dock(RIGHT)
		container_1_2:DockMargin(4, 0, 0, 0)
		container_1_2:SetVisible(false)
		container_1_2.Paint = function() end
		
		container_1_2.PerformLayout = function(pnl)
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
		self.Tags.tg.container_1_2 = container_1_2
		
	local container_1_2_1 = vgui.Create("DPanel", container_1_2)
		container_1_2_1:Dock(BOTTOM)
		container_1_2_1:DockMargin(4, 0, 0, 0)
		container_1_2_1.Paint = function() end
		
		container_1_2_1.PerformLayout = function(pnl)
			pnl:SetTall(ATAG.GUI:GetTall()*0.42)
		end
		
	local Mixer = vgui.Create("DColorMixer", container_1_2_1)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 0, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
	
	local SetTagBtn = vgui.Create("ATAG_Button", container_1_2_1)
		SetTagBtn:Dock(BOTTOM)
		SetTagBtn:DockMargin(0, 4, 0, 0)
		SetTagBtn:SetTall(30)
		SetTagBtn:SetText("Set Tag")
	
	local SetTagBox = vgui.Create("DTextEntry", container_1_2_1)
		SetTagBox:Dock(BOTTOM)
		SetTagBox:DockMargin(0, 4, 0, 0)
		SetTagBox:SetTall(25)
		SetTagBox:SetText("")
		
		SetTagBtn.DoClick = function()
			ATAG.SB_SetOwnTag(SetTagBox:GetValue(), Mixer:GetColor())
		end
		
	local container_1_2_2 = vgui.Create("DPanel", container_1_2)
		container_1_2_2:Dock(BOTTOM)
		container_1_2_2:DockMargin(4, 0, 0, 4)
		container_1_2_2:SetTall(20)
		container_1_2_2.Paint = function() end
		
	local InfoLabel = vgui.Create( "DLabel", container_1_2_2)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetText("You can set your own tag!")
		InfoLabel:SetTextColor(Color(0, 0, 0))
	
	if ATAG.Tags_MyTags then
		if ATAG.Tags_MyTags.SB_CST then
			self.Tags.tg.container_1_2:SetVisible(true)
		end
	end
	
end

function PANEL:Tags_FillTags(Tags)
	if not self.Tags then return end
	if not self.Tags.List then return end
	
	local Tags = Tags or ATAG.Tags_MyTags
	
	if not Tags then return end
	
	self.Tags.List:Clear()
	
	if Tags.PTags then
		local Tags = Tags.PTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Player Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Player Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "p_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end

	if Tags.RTags then
		local Tags = Tags.RTags
		
		for k, v in pairs(Tags.Etags) do
			local ln = self.Tags.List:AddLine("", "Rank Global")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_global"
			if v then
				for n, p in pairs(ln:GetChildren()) do
					if n == 1 then
						self:ListPaint(p, ln) -- PAINT
					end
				end
			end
		end
		
		for k, v in pairs(Tags.Ctags) do
			local ln = self.Tags.List:AddLine("", "Rank Custom")
			ln.Columns[2]:SetContentAlignment(5)
			ln.data = v
			ln.Type = "r_custom"
			
			for n, p in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(p, ln) -- PAINT
				end
			end
		end
	end
	
end


-- ADMIN
function PANEL:Fill_Admin(panel)

	local Tabs = vgui.Create("DPropertySheet", panel)
	Tabs:Dock(FILL)
	
	Tabs.Paint = function(pnl, w, h)
		surface.SetDrawColor(230, 230, 230)
		surface.DrawRect(0, 20, w, h)
		surface.SetDrawColor(100, 100, 100)
		surface.DrawOutlinedRect(0, 20, w, h-20)
	end
	
	local Tags = vgui.Create("DPanel")
	local Tab_Tags = Tabs:AddSheet("Global Tags", Tags, "icon16/tag_blue.png", false, false, nil)
	self:PaintTab(Tabs, Tags, Tab_Tags)
	self:Admin_Tags(Tags)
	
	local PlayerTags = vgui.Create("DPanel")
	local Tab_PlayerTags = Tabs:AddSheet("Scoreboard Tags", PlayerTags, "icon16/table.png", false, false, nil)
	self:PaintTab(Tabs, PlayerTags, Tab_PlayerTags)
	self:Admin_ScoreboardTags(PlayerTags)
	
	local ChatTags = vgui.Create("DPanel")
	local Tab_ChatTags = Tabs:AddSheet("Chat Tags", ChatTags, "icon16/comment.png", false, false, nil)
	self:PaintTab(Tabs, ChatTags, Tab_ChatTags)
	self:Admin_ChatTags(ChatTags)
	
end

function PANEL:Admin_Tags(panel)
	
	local Mixer_Container = vgui.Create("DPanel", panel)
	Mixer_Container:Dock(RIGHT)
	Mixer_Container:DockMargin(0, 4, 4, 0)
	Mixer_Container:SetWide(150)
	Mixer_Container.Paint = function(pnl, w, h) end
	
	local Mixer = vgui.Create("DColorMixer", Mixer_Container)
	Mixer:Dock(TOP)
	Mixer:DockMargin(0, 0, 0, 0)
	Mixer:SetTall(150)
	Mixer:SetPalette(false)
	Mixer:SetAlphaBar(false)
	Mixer:SetWangs(true)
	Mixer:SetColor(Color(255, 255, 255))
	
	-- hehe
	Mixer.WangsPanel:Dock(BOTTOM)
	Mixer.WangsPanel:DockMargin(0, 4, 0, 0)
	Mixer.txtR:Dock(LEFT)
	Mixer.txtR:SetWide(47)
	Mixer.txtR:DockMargin( 0, 0, 0, 0 )
	Mixer.txtG:Dock(LEFT)
	Mixer.txtG:SetWide(48)
	Mixer.txtG:DockMargin( 4, 0, 0, 0 )
	Mixer.txtB:Dock(LEFT)
	Mixer.txtB:SetWide(47)
	Mixer.txtB:DockMargin( 4, 0, 0, 0 )
	Mixer.txtA:SetVisible(false)
	
	
	local panel2 = vgui.Create("DPanel", panel)
	panel2:Dock(FILL)
	panel2.Paint = function(pnl, w, h) end
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(BOTTOM)
	panel3:SetTall(25)
	panel3:DockMargin(4, 4, 10, 0)
	panel3.Paint = function(pnl, w, h) end
	
	local DButton = vgui.Create("ATAG_Button", panel3)
	DButton:Dock(FILL)
	DButton:DockMargin(0, 0, 0, 0)
	DButton:SetText("Add Tag")
	
	local DButton2 = vgui.Create("ATAG_Button", panel3)
	DButton2:Dock(RIGHT)
	DButton2:DockMargin(4, 0, 0, 0)
	DButton2:SetWide(100)
	DButton2:SetText("Stop Editing")
	DButton2:SetVisible(false)
	
	local TextEntry = vgui.Create("DTextEntry", panel2)
	TextEntry:Dock(BOTTOM)
	TextEntry:SetTall(25)
	TextEntry:DockMargin(4, 6, 10, 0)
	
	local panel3 = vgui.Create("DPanel", panel2)
	panel3:Dock(FILL)
	panel3.Paint = function(pnl, w, h) end
	
	local DListView = vgui.Create("DListView", panel3)
	DListView:Dock(FILL)
	DListView:DockMargin(4, 4, 10, 0)
	DListView:SetMultiSelect(false)
	
	ATAG.GetTags()
	
	DListView.OnClickLine = function(pnl, ln)	
		if input.IsMouseDown(MOUSE_LEFT) then
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
	end
		
	DListView.OnRowRightClick = function(pnl, n, ln)
		if pnl.Menu then pnl.Menu:Remove() end
		
		local Menu = vgui.Create("DMenu")
		
		Menu:AddOption("Edit", function()
			pnl:ClearSelection()
			pnl:SelectItem(ln)
			DButton:SetText("Edit Tag")
			DButton2:SetVisible(true)
			TextEntry:SetValue(ln.data[2])
			Mixer:SetColor(ln.data[3])
		end):SetIcon("icon16/page_white_gear.png")
		
		Menu:AddOption("Remove", function()
			ATAG.RemoveTag(ln.data[1])
		end):SetIcon("icon16/cross.png")
		
		Menu:Open()
		
		pnl.Menu = Menu
	end
	
	DButton.DoClick = function(pnl)
		if pnl:GetText() == "Edit Tag" then
			ATAG.EditTag(DListView:GetLine(DListView:GetSelectedLine()).data[1], TextEntry:GetValue(), Mixer:GetColor())
			DButton2:SetVisible(false)
			DButton:SetText("Add Tag")
			DListView:ClearSelection()
			DButton:SetVisible(false)
			DButton:SetVisible(true)
			TextEntry:SetValue("")
		else
			ATAG.AddTag(TextEntry:GetValue(), Mixer:GetColor())
		end
	end
	
	DButton2.DoClick = function()
		DButton2:SetVisible(false)
		DButton:SetText("Add Tag")
		DListView:ClearSelection()
		DButton:SetVisible(false)
		DButton:SetVisible(true)
		TextEntry:SetValue("")
	end
	
	DListView:AddColumn("Tag")
	
	self.Admin.List = DListView
end

function PANEL:Admin_ScoreboardTags(panel)
	
	self.Admin.sbtags = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(RIGHT)
		container_2:DockMargin(4, 4, 4, 4)
		container_2:SetWide(150)
		container_2.Paint = function(pnl, w, h) end
		
		container_2.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_3 = vgui.Create("DPanel", panel)
		container_3:Dock(RIGHT)
		container_3:DockMargin(4, 4, 4, 4)
		container_3:SetWide(25)
		container_3.Paint = function(pnl, w, h) end

	local container_4 = vgui.Create("DPanel", panel)
		container_4:Dock(FILL)
		container_4:DockMargin(4, 4, 4, 4)
		container_4.Paint = function(pnl, w, h) end
		
	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
	
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.sbtags.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				self.Admin.sbtags.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.SB_GetRanks()
				self:Admin_Scoreboard_FillRanks()
				
				self.Admin.sbtags.AddBox:SetText("Rank (Name)")
				self.Admin.sbtags.AddButton:SetText("Add Rank")
				self.Admin.sbtags.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.sbtags.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.sbtags.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.sbtags.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.sbtags.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.sbtags.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.sbtags.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.sbtags.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
					
				
			elseif self.Admin.sbtags.TYPE == "rank" then
				self.Admin.sbtags.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.SB_GetPlayers()
				self:Admin_Scoreboard_FillPlayers()
				
				self.Admin.sbtags.AddBox:SetText("Player (SteamID)")
				self.Admin.sbtags.AddButton:SetText("Add Player")
				self.Admin.sbtags.List.Column:SetName("Player")
				self.Admin.sbtags.aList.Column:SetName("Currently Online Players")
				
				self.Admin.sbtags.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self.Admin.sbtags.GlobalList:Clear()
			self.Admin.sbtags.CustomList:Clear()
		end
	
	-- Search in the list.
	-- If the aList is visible it will search in that list.
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:Clear()
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
	
	
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.sbtags.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.sbtags.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
				
				end
				
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers()
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks()
				end
			else
				if self.Admin.sbtags.TYPE == "player" then
					self:Admin_Scoreboard_FillPlayers(value)
				elseif self.Admin.sbtags.TYPE == "rank" then
					self:Admin_Scoreboard_FillRanks(value)
				end
			end
		end
	
	-- The list with the Players or Ranks.
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.sbtags.List = List
		
		ATAG.SB_GetPlayers()

		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if not ln.data then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_GetTags_player(ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "scoreboard")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.SB_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.SB_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.sbtags.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can set own tag'", function()
						ATAG.SB_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "sb_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.SB_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.sbtags.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	-- Button to add a player or rank.
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.sbtags.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddPlayer(self.Admin.sbtags.AddBox:GetValue())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddRank(self.Admin.sbtags.AddBox:GetValue())
			end
		end
		
	-- Container to make the Dock work.
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)

	-- Button to make the aList visible.
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))
		
		aListBtn.DoClick = function(pnl)
			if self.Admin.sbtags.aList:IsVisible() then
				self.Admin.sbtags.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.sbtags.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.sbtags.aList:Clear()
				
				
				if self.Admin.sbtags.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.sbtags.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.sbtags.TYPE == "rank" then
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.sbtags.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.sbtags.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.sbtags.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.sbtags.List:SetVisible(false)
			self.Admin.sbtags.List:SetVisible(true)
		end
	
	-- Textbox to add a player or rank.
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.sbtags.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.sbtags.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.sbtags.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
	
	-- List for the online players or all ULX / evolve ranks.
	local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:DockMargin(0, 0, 0, 0)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.sbtags.aList = aList

		aList.OnClickLine = function(pnl, ln)
			self.Admin.sbtags.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
	-- Container 2
	-- List for global tags.
	local GlobalTagList = vgui.Create("DListView", container_2)
		GlobalTagList:Dock(FILL)
		GlobalTagList:DockMargin(0, 0, 0, 0)
		GlobalTagList:SetMultiSelect(false)
		GlobalTagList:AddColumn("Tags")
		
		self.Admin.sbtags.GlobalTagList = GlobalTagList
		
		GlobalTagList.OnClickLine = function(pnl, ln)		
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalTagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Add", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/add.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local CustomTag_Container = vgui.Create("DPanel", container_2)
		CustomTag_Container:Dock(BOTTOM)
		CustomTag_Container.Paint = function() end
		
		CustomTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
	
	-- Button to add a custom tag.
	local AddCustomTagBtn = vgui.Create("ATAG_Button", CustomTag_Container)
		AddCustomTagBtn:Dock(BOTTOM)
		AddCustomTagBtn:DockMargin(0, 4, 0, 0)
		AddCustomTagBtn:SetTall(25)
		AddCustomTagBtn:SetText("Add Custom Tag")
		
		AddCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomTagBox:GetValue(), self.Admin.sbtags.Mixer:GetColor())
			end
		end
	
	-- TextBox for the custom tag.
	local CustomTagBox = vgui.Create("DTextEntry", CustomTag_Container)
		CustomTagBox:Dock(BOTTOM)
		CustomTagBox:DockMargin(0, 4, 0, 0)
		CustomTagBox:SetTall(25)
		CustomTagBox:SetText("Custom Tag")
		
		self.Admin.sbtags.CustomTagBox = CustomTagBox
		
		CustomTagBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Custom Tag" then
				pnl:SetValue("")
			end
		end
		CustomTagBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Custom Tag")
			end
		end
	
	-- Color mixer for the custom tag.
	local Mixer = vgui.Create("DColorMixer", CustomTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.sbtags.Mixer = Mixer
		
	-- Container 3
	-- Button to add a global tag.
	local AddTagButton = vgui.Create("ATAG_Button", container_3)
		AddTagButton:Dock(TOP)
		AddTagButton:DockMargin(0, 40, 0, 0)
		AddTagButton:SetTall(25)
		AddTagButton:SetIcon(icon_up)
		AddTagButton:SetIconRotation(90)
		AddTagButton:SetIconColor(Color(0, 0, 0, 120))
		
		AddTagButton.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalTagList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to add.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_AddTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_AddTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalTagList:GetLine(self.Admin.sbtags.GlobalTagList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a global tag.
	local RemoveTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveTagBtn:Dock(TOP)
		RemoveTagBtn:DockMargin(0, 4, 0, 0)
		RemoveTagBtn:SetTall(25)
		RemoveTagBtn:SetIcon(icon_down)
		RemoveTagBtn:SetIconRotation(90)
		RemoveTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.GlobalList:GetSelectedLine() then ATAG.NotifyMessage("Please select the global tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.GlobalList:GetLine(self.Admin.sbtags.GlobalList:GetSelectedLine()).data[1])
			end
		end
	
	-- Button to remove a custom tag.
	local RemoveCustomTagBtn = vgui.Create("ATAG_Button", container_3)
		RemoveCustomTagBtn:Dock(BOTTOM)
		RemoveCustomTagBtn:DockMargin(0, 0, 0, 55)
		RemoveCustomTagBtn:SetTall(25)
		RemoveCustomTagBtn:SetIcon(icon_down)
		RemoveCustomTagBtn:SetIconRotation(90)
		RemoveCustomTagBtn:SetIconColor(Color(0, 0, 0, 120))
		
		RemoveCustomTagBtn.DoClick = function()
			if not self.Admin.sbtags.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.sbtags.CustomList:GetSelectedLine() then ATAG.NotifyMessage("Please select the custom tag you want to remove.") return end
			if self.Admin.sbtags.TYPE == "player" then
				ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			elseif self.Admin.sbtags.TYPE == "rank" then
				ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], self.Admin.sbtags.CustomList:GetLine(self.Admin.sbtags.CustomList:GetSelectedLine()).data[1])
			end
		end
	
	-- Container 4
	-- List for the global tags the player / rank has.
	local GlobalList = vgui.Create("DListView", container_4)
		GlobalList:Dock(FILL)
		GlobalList:DockMargin(0, 0, 0, 0)
		GlobalList:SetMultiSelect(false)
		GlobalList:AddColumn("Tag")
		
		self.Admin.sbtags.GlobalList = GlobalList
		
		GlobalList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		GlobalList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "e")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
	
	-- List for the custom tags the player / rank has.
	local CustomList_Container = vgui.Create("DPanel", container_4)
		CustomList_Container:Dock(BOTTOM)
		CustomList_Container:DockMargin(0, 4, 0, 0)
		CustomList_Container:SetTall(140)
		
		CustomList_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local CustomList = vgui.Create("DListView", CustomList_Container)
		CustomList:Dock(FILL)
		CustomList:DockMargin(0, 0, 0, 0)
		CustomList:SetMultiSelect(false)
		CustomList:AddColumn("Custom Tag")
		
		self.Admin.sbtags.CustomList = CustomList
		
		CustomList.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
			end
		end
		
		CustomList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.sbtags.TYPE == "rank" then
				if ln.data.autoAssign then
					Menu:AddOption("Stop AutoAssign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_break.png")
				else
					Menu:AddOption("Auto Assign", function()
						ATAG.SB_SetAutoAssignedTag_rank(self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1], "c")
					end):SetIcon("icon16/link_go.png")
				end
			end
			
			Menu:AddOption("Copy Color", function()
				self.Admin.sbtags.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.sbtags.List:GetSelectedLine() then return end
				
				if self.Admin.sbtags.TYPE == "player" then
					ATAG.SB_RemoveCustomTag("player", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				elseif self.Admin.sbtags.TYPE == "rank" then
					ATAG.SB_RemoveCustomTag("rank", self.Admin.sbtags.List:GetLine(self.Admin.sbtags.List:GetSelectedLine()).data[1], ln.data[1])
				end
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
end

function PANEL:Admin_CanSetOwnTag(ln)
	ln.PaintOver = function(pnl, w, h)
		if ln.data.CST then
			surface.SetDrawColor(Color(255, 255, 255))
			surface.DrawRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(50, 50, 50))
			surface.DrawOutlinedRect(w-17, 2, 14, h-2)
			
			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/pencil.png"))
			surface.DrawTexturedRect(w-16, 0, 16, 16)
		end
		if ln.data.AA then
			if ln.data.CST then
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16-16, 0, 16, 16)
			else
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/medal_gold_1.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			ln:SetTooltip("This user has been automatically added because rank " .. ln.data.AA .. " can/could edit their own tag.")
		else
			ln:SetTooltip()
		end
	end
end

function PANEL:Admin_Scoreboard_FillPlayers(searchValue)
	if not ATAG.PlayerTags_Players then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.PlayerTags_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.sbtags.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.sbtags.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillRanks(searchValue)

	if not ATAG.Scoreboard_Ranks then return end
	
	self.Admin.sbtags.List:Clear()
	
	for k, v in pairs(ATAG.Scoreboard_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.sbtags.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.sbtags.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_player(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Player_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
end

function PANEL:Admin_Scoreboard_FillTags_rank(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalList then return end
	if not self.Admin.sbtags.CustomList then return end
	
	local Tags = Tags or ATAG.SB_Rank_Tags
	
	self.Admin.sbtags.GlobalList:Clear()
	self.Admin.sbtags.CustomList:Clear()
	
	local AutoAssign_TagID, AutoAssign_Type
	
	if Tags.AssignTag then
		AutoAssign_TagID = Tags.AssignTag[1]
		AutoAssign_Type = Tags.AssignTag[2]
	end
	
	for k, v in pairs(Tags.Etags) do
	
		local data = nil
		
		for n, t in pairs(ATAG.Tags) do
			if t[1] == v then
				data = t
			end
		end
		
		if data then
			local ln = self.Admin.sbtags.GlobalList:AddLine("")
			
			ln.data = data
			
			if AutoAssign_Type == "e" and tostring(data[1]) == AutoAssign_TagID then
				ln.data.autoAssign = true
				
				ln.PaintOver = function(pnl, w, h)
					surface.SetDrawColor(Color(255, 255, 255))
					surface.SetMaterial(Material("icon16/link_go.png"))
					surface.DrawTexturedRect(w-16, 0, 16, 16)
				end
				
			else
				ln.data.autoAssign = false
			end
			
			for n, t in pairs(ln:GetChildren()) do
				if n == 1 then
					self:ListPaint(t, ln) -- PAINT
				end
			end
		end
	end
	
	for k, v in pairs(Tags.Ctags) do
		local ln = self.Admin.sbtags.CustomList:AddLine("")
		ln.data = v
		
		if AutoAssign_Type == "c" and tostring(v[1]) == AutoAssign_TagID then
			ln.data.autoAssign = true
			
			ln.PaintOver = function(pnl, w, h)
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/link_go.png"))
				surface.DrawTexturedRect(w-16, 0, 16, 16)
			end
			
		else
			ln.data.autoAssign = false
		end
		
		for n, t in pairs(ln:GetChildren()) do
			if n == 1 then
				self:ListPaint(t, ln) -- PAINT
			end
		end
	end
	
end




function PANEL:Admin_ChatTags(panel)

	self.Admin.ch = {}

	local container_1 = vgui.Create("DPanel", panel)
		container_1:Dock(LEFT)
		container_1:DockMargin(4, 4, 4, 4)
		container_1:SetWide(160)
		container_1.Paint = function(pnl, w, h) end
		
		container_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.28)
		end
		
	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
	

	-- Container 1
	local container1_1 = vgui.Create("DPanel", container_1)
		container1_1:Dock(TOP)
		container1_1:DockMargin(0, 0, 0, 0)
		container1_1:SetTall(25)
		container1_1.Paint = function(pnl, w, h) end
		
		
	-- Button to toggle Players to ranks.
	local ToggleBtn = vgui.Create("ATAG_Button", container1_1)
		ToggleBtn:Dock(RIGHT)
		ToggleBtn:DockMargin(4, 0, 0, 0)
		ToggleBtn:SetWide(26)
		ToggleBtn:SetText("")
		ToggleBtn.Type = "player"
		ToggleBtn:SetIcon(icon_player)
		ToggleBtn:SetIconColor(Color(255, 255, 255, 255))
		
		self.Admin.ch.TYPE = ToggleBtn.Type
		
		ToggleBtn.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				self.Admin.ch.TYPE = "rank"
				ToggleBtn:SetIcon(icon_rank)
				ATAG.CH_GetRanks()
				self:Admin_Chat_FillRanks()
				
				self.Admin.ch.AddBox:SetText("Rank (Name)")
				self.Admin.ch.AddButton:SetText("Add Rank")
				self.Admin.ch.List.Column:SetName("Rank")
				
				if xgui then
					self.Admin.ch.aList.Column:SetName("ULX Rank")
				elseif evolve then
					self.Admin.ch.aList.Column:SetName("Evolve Rank")
				elseif serverguard.ranks then
					self.Admin.ch.aList.Column:SetName("ServerGuard Rank")
				end
				
				self.Admin.ch.aList:Clear()
				
				if xgui then
					for _, rank in pairs(xgui.data.groups) do
						if isstring(rank) then
							local ln = self.Admin.ch.aList:AddLine(rank)
							ln.Value = rank
						end
					end
				elseif evolve then
					for id, rank in pairs( evolve.ranks ) do
						if isstring(id) then
							local ln = self.Admin.ch.aList:AddLine(id)
							ln.Value = id
						end
					end
				elseif serverguard.ranks then
					for id, rank in pairs( serverguard.ranks:GetRanks() ) do
						if isstring( id ) then
							local ln = self.Admin.ch.aList:AddLine( id )
							ln.Value = id
						end
					end
				end
				
			elseif self.Admin.ch.TYPE == "rank" then
				self.Admin.ch.TYPE = "player"
				ToggleBtn:SetIcon(icon_player)
				ATAG.CH_GetPlayers()
				self:Admin_Chat_FillPlayers()
				
				self.Admin.ch.AddBox:SetText("Player (SteamID)")
				self.Admin.ch.AddButton:SetText("Add Player")
				self.Admin.ch.List.Column:SetName("Player")
				self.Admin.ch.aList.Column:SetName("Currently Online Players")
				
				self.Admin.ch.aList:Clear()
				for _, ply in pairs(player.GetAll()) do
					local ln = self.Admin.ch.aList:AddLine(ply:Name())
					ln.Value = ply:SteamID()
				end
			end
			
			self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, nil)
			self.Admin.ch.TagList:Clear()
		end
		
	local SearchBox = vgui.Create("DTextEntry", container1_1)
		SearchBox:Dock(FILL)
		SearchBox:DockMargin(0, 0, 0, 0)
		SearchBox:SetText("Search...")
		SearchBox:SetUpdateOnType(true)
		
		SearchBox.OnGetFocus = function(pnl)
			if pnl:GetValue() == "Search..." then
				pnl:SetValue("")
			end
		end
		SearchBox.OnLoseFocus = function(pnl)
			if pnl:GetValue() == "" then
				pnl:SetText("Search...")
			end
		end
		
		SearchBox.OnValueChange = function(pnl, value)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						if string.find(string.lower(ply:Name()), string.lower(value)) then
							local ln = self.Admin.ch.aList:AddLine(ply:Name())
							ln.Value = ply:SteamID()
						end
					end
				elseif self.Admin.ch.TYPE == "rank" then
				
				
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								if string.find(string.lower(rank), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(rank)
									ln.Value = rank
								end
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								if string.find(string.lower(id), string.lower(value)) then
									local ln = self.Admin.ch.aList:AddLine(id)
									ln.Value = id
								end
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								if string.find( string.lower( id ), string.lower( value ) ) then
									local ln = self.Admin.ch.aList:AddLine( id )
									ln.Value = id
								end
							end
						end
					end
						
					
				end
				
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers()
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks()
				end
			else
				if self.Admin.ch.TYPE == "player" then
					self:Admin_Chat_FillPlayers(value)
				elseif self.Admin.ch.TYPE == "rank" then
					self:Admin_Chat_FillRanks(value)
				end
			end
		end
		
	local List = vgui.Create("DListView", container_1)
		List:Dock(FILL)
		List:DockMargin(0, 6, 0, 0)
		List:SetMultiSelect(false)
		List.Column = List:AddColumn("Player")
		
		self.Admin.ch.List = List
		
		ATAG.CH_GetPlayers()
		
		List.OnClickLine = function(pnl, ln)
			if input.IsMouseDown(MOUSE_LEFT) then
				pnl:ClearSelection()
				pnl:SelectItem(ln)
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_GetTags_player(ln.data[1])
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_GetTags_rank(ln.data[1])
				end
			end
		end
		
		List.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			if self.Admin.ch.TYPE == "player" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("player", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
			
				Menu:AddOption("Set Name", function()
					self:OpenSetPlayerNamePnl(ln.data[1], "chat")
				end):SetIcon("icon16/report_edit.png")
				
				Menu:AddOption("Update Name", function()
					ATAG.CH_ChangePlayerName(ln.data[1], "\nil")
				end):SetIcon("icon16/report_go.png")
				
				Menu:AddOption("Change SteamID", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "Change SteamID: " .. ln.data[1] )
					textPanel:setButtonText( "Change SteamID" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_player", ln.data[1], text )
					
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
				
				Menu:AddOption("Remove", function()
					ATAG.CH_RemovePlayer(ln.data[1])
				end):SetIcon("icon16/cross.png")
				
			elseif self.Admin.ch.TYPE == "rank" then
			
				if ln.data.CST then
					Menu:AddOption("Revoke 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/cross.png")
				else
					Menu:AddOption("Grant 'Can edit own tag'", function()
						ATAG.CH_ToggleCanSetOwnTag("rank", ln.data[1])
					end):SetIcon("icon16/tick.png")
				end
				
				Menu:AddOption("Change name", function()
					
					local textPanel = vgui.Create( "atags_settext_panel" )
					textPanel:setTitle( "change rank name: " .. ln.data[1] )
					textPanel:setButtonText( "Change rank name" )
					textPanel:setCallback( function( pnl, text ) 
						
						ATAG:ChangePrimaryKey( "c_rank", ln.data[1], text )
						
						pnl:Remove()
					
					end)
					
				end):SetIcon("icon16/book_edit.png")
			
				Menu:AddOption("Remove", function()
					ATAG.CH_RemoveRank(ln.data[1])
				end):SetIcon("icon16/cross.png")
			end
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
	local Add_Container = vgui.Create("DPanel", container_1)
		Add_Container:Dock(BOTTOM)
		Add_Container:DockMargin(0, 4, 0, 0)
		
		Add_Container.Think = function(pnl) -- This works i guess :P?
			if self.Admin.ch.aList:IsVisible() then
				pnl:SetTall(ATAG.GUI:GetTall()*0.38)
			else
				pnl:SetTall(54)
			end
		end
		
	local AddButton = vgui.Create("ATAG_Button", Add_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Player")
		
		self.Admin.ch.AddButton = AddButton
		
		AddButton.DoClick = function()
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddPlayer(self.Admin.ch.AddBox:GetValue())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddRank(self.Admin.ch.AddBox:GetValue())
			end
		end
		
	local AddBoxContainer = vgui.Create("DPanel", Add_Container)	
		AddBoxContainer:Dock(BOTTOM)
		AddBoxContainer:DockMargin(0, 4, 0, 0)
		
	local aListBtn = vgui.Create("ATAG_Button", AddBoxContainer)
		aListBtn:Dock(RIGHT)
		aListBtn:DockMargin(2, 0, 0, 0)
		aListBtn:SetWide(20)
		aListBtn:SetText("")
		aListBtn:SetIcon(icon_down)
		aListBtn:SetIconColor(Color(0, 0, 0, 120))

		aListBtn.DoClick = function(pnl)
			if self.Admin.ch.aList:IsVisible() then
				self.Admin.ch.aList:SetVisible(false)
				pnl:SetIcon(icon_down)
			else
				self.Admin.ch.aList:SetVisible(true)
				pnl:SetIcon(icon_up)
				
				self.Admin.ch.aList:Clear()
				
				if self.Admin.ch.TYPE == "player" then
					for _, ply in pairs(player.GetAll()) do
						local ln = self.Admin.ch.aList:AddLine(ply:Name())
						ln.Value = ply:SteamID()
					end
				elseif self.Admin.ch.TYPE == "rank" then
					
					if xgui then
						for _, rank in pairs(xgui.data.groups) do
							if isstring(rank) then
								local ln = self.Admin.ch.aList:AddLine(rank)
								ln.Value = rank
							end
						end
					elseif evolve then
						for id, rank in pairs( evolve.ranks ) do
							if isstring(id) then
								local ln = self.Admin.ch.aList:AddLine(id)
								ln.Value = id
							end
						end
					elseif serverguard.ranks then
						for id, rank in pairs( serverguard.ranks:GetRanks() ) do
							if isstring( id ) then
								local ln = self.Admin.ch.aList:AddLine( id )
								ln.Value = id
							end
						end
					end
					
				end
			
			end
			self.Admin.ch.List:SetVisible(false)
			self.Admin.ch.List:SetVisible(true)
		end
		
	local AddBox = vgui.Create("DTextEntry", AddBoxContainer)
		AddBox:Dock(FILL)
		AddBox:DockMargin(0, 0, 0, 0)
		AddBox:SetTall(25)
		AddBox:SetText("Player (SteamID)")
		
		self.Admin.ch.AddBox = AddBox
		
		AddBox.OnGetFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "Player (SteamID)" then
					pnl:SetValue("")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "Rank (Name)" then
					pnl:SetValue("")
				end
			end
		end
		
		AddBox.OnLoseFocus = function(pnl)
			if self.Admin.ch.TYPE == "player" then
				if pnl:GetValue() == "" then
					pnl:SetText("Player (SteamID)")
				end
			elseif self.Admin.ch.TYPE == "rank" then
				if pnl:GetValue() == "" then
					pnl:SetText("Rank (Name)")
				end
			end
		end
		
		local aList = vgui.Create("DListView", Add_Container)
		aList:Dock(FILL)
		aList:SetMultiSelect(false)
		aList:SetVisible(false)
		aList.Column = aList:AddColumn("Currently Online Players")
		
		self.Admin.ch.aList = aList
		
		aList.OnClickLine = function(pnl, ln)
			self.Admin.ch.AddBox:SetText(ln.Value)
			pnl:ClearSelection()
			pnl:SelectItem(ln)
		end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.Admin.ch.TagList = TagList

		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.Admin.ch.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not self.Admin.ch.List:GetSelectedLine() then return end
				if not pnl:GetSelectedLine() then return end
				
				if self.Admin.ch.TYPE == "player" then
					ATAG.CH_RemoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				elseif self.Admin.ch.TYPE == "rank" then
					ATAG.CH_RemoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], pnl:GetSelectedLine())
				end
				
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_AddTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_AddTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.AddTagBox:GetValue(), self.Admin.ch.Mixer:GetColor())
			end
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.Admin.ch.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.Admin.ch.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.Admin.ch.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() - 1)
			end
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.Admin.ch.List:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag owner.") return end
			if not self.Admin.ch.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			
			if self.Admin.ch.TYPE == "player" then
				ATAG.CH_MoveTagPiece_player(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			elseif self.Admin.ch.TYPE == "rank" then
				ATAG.CH_MoveTagPiece_rank(self.Admin.ch.List:GetLine(self.Admin.ch.List:GetSelectedLine()).data[1], self.Admin.ch.TagList:GetSelectedLine(), self.Admin.ch.TagList:GetSelectedLine() + 2)
			end
		end
end



function PANEL:Admin_ChatTags_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

local function IsOnlySpaces(Text)
	if Text == "" then return false end
	for i=1, string.len(Text) do
		if string.GetChar(Text, i) ~= " " then return false end
	end
	return string.len(Text)
end

function PANEL:Admin_Chat_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.Chat_Tags
	if not Tags then return end
	
	self.Admin.ch.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.ch.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.Admin.ch.TagList:SelectItem(self.Admin.ch.TagList:GetLine(Pos))
	end
	
	self:Admin_ChatTags_CreateTagExample(self.Admin.ch.TagExample, Tags)
end

function PANEL:Admin_Chat_FillPlayers(searchValue)
	if not ATAG.Chat_Players then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Players) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[2]), string.lower(searchValue)) then
				local lineText = v[1]
				if v[2] ~= nil and v[2] ~= "" then
					lineText = "(" .. v[2] .. ") " .. lineText
				end
				local ln = self.Admin.ch.List:AddLine(lineText)
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local lineText = v[1]
			if v[2] ~= nil and v[2] ~= "" then
				lineText = "(" .. v[2] .. ") " .. lineText
			end
			local ln = self.Admin.ch.List:AddLine(lineText)
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end

function PANEL:Admin_Chat_FillRanks(searchValue)
	if not ATAG.Chat_Ranks then return end
	
	self.Admin.ch.List:Clear()
	
	for k, v in pairs(ATAG.Chat_Ranks) do
		if searchValue ~= nil and searchValue ~= "" and searchValue ~= "Search..." then
			if string.find(string.lower(v[1]), string.lower(searchValue)) ~= nil or string.find(string.lower(v[1]), string.lower(searchValue)) then
				local ln = self.Admin.ch.List:AddLine(v[1])
				ln.data = v
				
				self:Admin_CanSetOwnTag(ln)
			end
		else
			local ln = self.Admin.ch.List:AddLine(v[1])
			ln.data = v
			
			self:Admin_CanSetOwnTag(ln)
		end
	end
end




function PANEL:OpenSetPlayerNamePnl(SteamID, Type)
	local Frame = vgui.Create("DFrame")
		Frame:SetSize( 300, 85 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle("Set Name '" .. SteamID .. "'")
		Frame.Paint = function(pnl, w, h)
			surface.SetDrawColor(100, 150, 200)
			surface.DrawRect(0, 0, w, h)
		end
		
	local TextEntry = vgui.Create( "DTextEntry", Frame )	-- create the form as a child of frame
		TextEntry:SetText("")
		TextEntry:Dock(FILL)
	
	local DButton = vgui.Create( "ATAG_Button", Frame )
		DButton:Dock(BOTTOM)
		DButton:DockMargin(0, 4, 0, 0)
		DButton:SetText( "Set Name for '" .. SteamID .. "'" )
		DButton.DoClick = function()
			if Type == "scoreboard" then
				ATAG.SB_ChangePlayerName(SteamID, TextEntry:GetValue())
			elseif Type == "chat" then
				ATAG.CH_ChangePlayerName(SteamID, TextEntry:GetValue())
			end
			
			Frame:Remove()
		end
end




function PANEL:Admin_PlayerTags_FillTags(Tags)
	if not self.Admin then return end
	if not self.Admin.sbtags.GlobalTagList then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.sbtags.GlobalTagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.sbtags.GlobalTagList:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end

function PANEL:Admin_FillTagList(Tags)
	if not self.Admin then return end
	if not self.Admin.List then return end
	
	local Tags = Tags or ATAG.Tags
	
	self.Admin.List:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.Admin.List:AddLine("")
		ln.data = v
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln) -- PAINT
		end
	end
end




function PANEL:Fill_Settings(panel)

	-- Container 1
	local Container_1 = vgui.Create("DPanel", panel)
		Container_1:Dock(TOP)
		Container_1:DockMargin(0, 0, 0, 0)
		Container_1:SetTall(32)
		Container_1.Paint = function(pnl, w, h) end
		
	local Info_FrameSize = vgui.Create("DLabel", Container_1)
		Info_FrameSize:SetText("Hover your mouse over the bottom right corner to resize the frame.\nResizing the window might glitch out some of the panels (This is to prevent unnecessary lag). Re-open to fix this.")
		Info_FrameSize:SetTextColor(Color(0, 0, 0))
		Info_FrameSize:SizeToContents()
		
	local Reset_FrameSize = vgui.Create("ATAG_Button", panel)
		Reset_FrameSize:Dock(TOP)
		Reset_FrameSize:DockMargin(0, 0, 0, 0)
		Reset_FrameSize:SetTall(30)
		Reset_FrameSize:SetText("Reset Frame Size")
		
		Reset_FrameSize.DoClick = function()
			ATAG.SetFrameSize(600, 400)
		end
		
	local Center_Frame = vgui.Create("ATAG_Button", panel)
		Center_Frame:Dock(TOP)
		Center_Frame:DockMargin(0, 6, 0, 0)
		Center_Frame:SetTall(30)
		Center_Frame:SetText("Center Frame")
		
		Center_Frame.DoClick = function()
			ATAG.SetFramePos(nil, nil, true)
		end
		
	local Save_Frame = vgui.Create("ATAG_Button", panel)
		Save_Frame:Dock(TOP)
		Save_Frame:DockMargin(0, 6, 0, 0)
		Save_Frame:SetTall(30)
		Save_Frame:SetText("Save Settings")
		
		Save_Frame.DoClick = function()
			ATAG.SaveFrameSettings()
			
			ATAG.NotifyMessage("Settings saved!")
			
		end

end








function PANEL:Fill_TagEdit(panel)

	self.TagEdit.ed = {}

	local container_2 = vgui.Create("DPanel", panel)
		container_2:Dock(FILL)
		container_2:DockMargin(4, 4, 4, 4)
		container_2.Paint = function(pnl, w, h) end
		
	local container_2_4 = vgui.Create("DPanel", container_2)
		container_2_4:Dock(TOP)
		container_2_4:DockMargin(0, 0, 0, 0)
		container_2_4:SetTall(20)
		container_2_4.Paint = function(pnl, w, h) end
		
	local container_2_1 = vgui.Create("DPanel", container_2)
		container_2_1:Dock(RIGHT)
		container_2_1:DockMargin(0, 0, 0, 0)
		container_2_1:SetWide(140)
		container_2_1.Paint = function(pnl, w, h) end
		
		container_2_1.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetWide(ATAG.GUI:GetWide()*0.25)
		end
		
	local container_2_2 = vgui.Create("DPanel", container_2)
		container_2_2:Dock(RIGHT)
		container_2_2:DockMargin(4, 0, 4, 0)
		container_2_2:SetWide(25)
		container_2_2.Paint = function(pnl, w, h) end
		
	local container_2_3 = vgui.Create("DPanel", container_2)
		container_2_3:Dock(FILL)
		container_2_3:DockMargin(0, 0, 0, 0)
		container_2_3.Paint = function(pnl, w, h) end
		
		-- Container 2_3
		local TagList = vgui.Create("DListView", container_2_3)
		TagList:Dock(FILL)
		TagList:DockMargin(0, 6, 0, 0)
		TagList:SetMultiSelect(false)
		TagList:AddColumn("Tag Piece")
		
		self.TagEdit.ed.TagList = TagList
		
		TagList.OnRowRightClick = function(pnl, n, ln)
			if pnl.Menu then pnl.Menu:Remove() end
			
			local Menu = vgui.Create("DMenu")
			
			Menu:AddOption("Copy Color", function()
				self.TagEdit.ed.Mixer:SetColor(ln.data[3])
			end):SetIcon("icon16/color_wheel.png")
			
			Menu:AddOption("Remove", function()
				if not pnl:GetSelectedLine() then return end
				ATAG.CH_RemoveTagPiece_owntag(pnl:GetSelectedLine())
			end):SetIcon("icon16/cross.png")
			
			Menu:Open()
			
			pnl.Menu = Menu
		end
		
		-- Container 2_1	
	local AddTag_Container = vgui.Create("DPanel", container_2_1)
		AddTag_Container:Dock(BOTTOM)
		AddTag_Container.Paint = function() end
		
		AddTag_Container.PerformLayout = function(pnl) -- This works i guess :P?
			pnl:SetTall(ATAG.GUI:GetTall()*0.38)
		end
		
	local AddButton = vgui.Create("ATAG_Button", AddTag_Container)
		AddButton:Dock(BOTTOM)
		AddButton:DockMargin(0, 4, 0, 0)
		AddButton:SetTall(25)
		AddButton:SetText("Add Tag Piece")
		
		AddButton.DoClick = function()
			ATAG.CH_AddTagPiece_owntag(self.TagEdit.ed.AddTagBox:GetValue(),self.TagEdit.ed.Mixer:GetColor())
		end
		
	local AddTagBox = vgui.Create("DTextEntry", AddTag_Container)
		AddTagBox:Dock(BOTTOM)
		AddTagBox:DockMargin(0, 4, 0, 0)
		AddTagBox:SetTall(25)
		AddTagBox:SetText("")
		
		self.TagEdit.ed.AddTagBox = AddTagBox
		
	local Mixer = vgui.Create("DColorMixer", AddTag_Container)
		Mixer:Dock(FILL)
		Mixer:DockMargin(0, 6, 0, 0)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(255, 255, 255))
		Mixer:SetTall(70)
		Mixer.WangsPanel:SetWide(35)
		
		self.TagEdit.ed.Mixer = Mixer
		
	local InfoLabel = vgui.Create( "DLabel", container_2_1)
		InfoLabel:Dock(BOTTOM)
		InfoLabel:DockMargin(4, 10, 0, 0)
		InfoLabel:SetTall(95)
		InfoLabel:SetText("TIPS:\nThe last color used or\n\\NAMECOL will be the\nplayer name color.\n\n\\MESSAGE will change the\nmessage color.")
		InfoLabel:SetTextColor(Color(0, 0, 0))
		
	-- Container 2_4
	local TagExample = vgui.Create("DPanel", container_2_4)
		TagExample:Dock(FILL)
		TagExample:DockMargin(0, 0, 0, 0)
		TagExample:DockPadding(4, 0, 0, 0)
		TagExample.Paint = function(pnl, w, h)
			if pnl:IsHovered() then
				if input.IsMouseDown(MOUSE_LEFT) then
					surface.SetDrawColor(Color(0, 0, 0, 255))
				elseif input.IsMouseDown(MOUSE_RIGHT) then
					surface.SetDrawColor(Color(100, 100, 100, 255))
				else
					surface.SetDrawColor(Color(175, 175, 175, 255))
				end
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
			end
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(0, 0, 0))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
		
		self.TagEdit.ed.TagExample = TagExample
		
	-- Container 2_2
	local UpBtn = vgui.Create("ATAG_Button", container_2_2)
		UpBtn:Dock(TOP)
		UpBtn:DockMargin(0, 22, 0, 0)
		UpBtn:SetTall(25)
		UpBtn:SetIcon(icon_up)
		UpBtn:SetIconColor(Color(0, 0, 0, 120))
		
		UpBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() - 1)
		end
		
	local DownBtn = vgui.Create("ATAG_Button", container_2_2)
		DownBtn:Dock(TOP)
		DownBtn:DockMargin(0, 4, 0, 0)
		DownBtn:SetTall(25)
		DownBtn:SetIcon(icon_down)
		DownBtn:SetIconColor(Color(0, 0, 0, 120))
		
		DownBtn.DoClick = function()
			if not self.TagEdit.ed.TagList:GetSelectedLine() then ATAG.NotifyMessage("Please select a tag piece.") return end
			ATAG.CH_MoveTagPiece_owntag(self.TagEdit.ed.TagList:GetSelectedLine(), self.TagEdit.ed.TagList:GetSelectedLine() + 2)
		end

end

function PANEL:TagEdit_FillTags(Tags, Pos)
	local Tags = Tags or ATAG.OwnTag
	if not Tags then return end
	
	self.TagEdit.ed.TagList:Clear()
	
	for k, v in pairs(Tags) do
		local ln = self.TagEdit.ed.TagList:AddLine("")
		local Text = v[1]
		local IsSpaced = IsOnlySpaces(Text)
		
		if Text == "" then
			Text = "EMPTY STRING"
		elseif IsSpaced then
			Text = "ONLY SPACES (" .. IsSpaced ..")"
		elseif Text == "\\MESSAGE" then
			Text = "MESSAGE TEXT"
		elseif Text == "\\NAMECOL" then
			Text = "NAME COLOR"
		end
		
		ln.data = {0, Text, v[2]}
		
		for n, p in pairs(ln:GetChildren()) do
			self:ListPaint(p, ln)
		end
	end
	
	if Pos then
		self.TagEdit.ed.TagList:SelectItem(self.TagEdit.ed.TagList:GetLine(Pos))
	end
	
	self:TagEdit_CreateTagExample(self.TagEdit.ed.TagExample, Tags)
end

function PANEL:TagEdit_CreateTagExample(Panel, Tag)
	local Tag = Tag
	
	Panel:Clear()
	
	if not Tag then return end
	
	local MessageColor = Color(255, 255, 255)
	local LastColor = Color(255, 255, 255)
	local NameColor = nil
	
	for k, v in pairs(Tag) do
		local Text = v[1]
		if Text == "\\MESSAGE" then 
			MessageCol = v[2]
		elseif Text == "\\NAMECOL" then
			NameColor = v[2]
		else
			local DLabel = vgui.Create("DLabel", Panel)
			DLabel:SetFont("DermaDefault")
			DLabel:SetText(Text)
			DLabel:SetTextColor(v[2])
			DLabel:SizeToContentsX(0)
			DLabel:Dock(LEFT)
			LastColor = v[2]
		end
	end
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText("Player")
	DLabel:SetTextColor(NameColor or LastColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
	local DLabel = vgui.Create("DLabel", Panel)
	DLabel:SetFont("DermaDefault")
	DLabel:SetText(": Message")
	DLabel:SetTextColor(MessageColor)
	DLabel:SizeToContentsX(0)
	DLabel:Dock(LEFT)
	
end

function PANEL:Create_TagEdit()
	local TagEdit = vgui.Create("DPanel")
	local Tab_TagEdit = self.Tabs:AddSheet("Chat Tag Editor", TagEdit, "icon16/comment_edit.png", false, false, nil)
	self:PaintTab(self.Tabs, TagEdit, Tab_TagEdit)
	self.TagEdit = {}
	self:Fill_TagEdit(TagEdit)
	self.TagEdit_Tab = Tab_TagEdit.Tab
	
	ATAG.CH_GetOwnTags()
end

vgui.Register("atags_main_gui", PANEL, "DPanel")

