-- "addons\\atags\\lua\\atags\\vgui\\settext_panel.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local PANEL = {}

function PANEL:Init()

	self:SetSize( 300, 85 )
	self:Center()
	self:MakePopup()
	self:SetTitle( "" )
	
	self.textEntry = vgui.Create( "DTextEntry", self )
	self.textEntry:Dock( FILL )
	self.textEntry:SetText( "" )
	
	self.button = vgui.Create( "ATAG_Button", self )
	self.button:Dock( BOTTOM )
	self.button:DockMargin( 0, 4, 0, 0 )
	self.button:SetText( "" )

end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( 100, 150, 200 )
	surface.DrawRect( 0, 0, w, h )
	
end

function PANEL:setTitle( text )
	
	self:SetTitle( text )
	
end

function PANEL:setButtonText( text )
	
	self.button:SetText( text )
	
end

function PANEL:setCallback( callback )
	
	self.button.DoClick = function()
	
		callback( self, self.textEntry:GetValue() )
		
	end
	
end

vgui.Register( "atags_settext_panel", PANEL, "DFrame" )

-- "addons\\atags\\lua\\atags\\vgui\\settext_panel.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local PANEL = {}

function PANEL:Init()

	self:SetSize( 300, 85 )
	self:Center()
	self:MakePopup()
	self:SetTitle( "" )
	
	self.textEntry = vgui.Create( "DTextEntry", self )
	self.textEntry:Dock( FILL )
	self.textEntry:SetText( "" )
	
	self.button = vgui.Create( "ATAG_Button", self )
	self.button:Dock( BOTTOM )
	self.button:DockMargin( 0, 4, 0, 0 )
	self.button:SetText( "" )

end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( 100, 150, 200 )
	surface.DrawRect( 0, 0, w, h )
	
end

function PANEL:setTitle( text )
	
	self:SetTitle( text )
	
end

function PANEL:setButtonText( text )
	
	self.button:SetText( text )
	
end

function PANEL:setCallback( callback )
	
	self.button.DoClick = function()
	
		callback( self, self.textEntry:GetValue() )
		
	end
	
end

vgui.Register( "atags_settext_panel", PANEL, "DFrame" )

-- "addons\\atags\\lua\\atags\\vgui\\settext_panel.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local PANEL = {}

function PANEL:Init()

	self:SetSize( 300, 85 )
	self:Center()
	self:MakePopup()
	self:SetTitle( "" )
	
	self.textEntry = vgui.Create( "DTextEntry", self )
	self.textEntry:Dock( FILL )
	self.textEntry:SetText( "" )
	
	self.button = vgui.Create( "ATAG_Button", self )
	self.button:Dock( BOTTOM )
	self.button:DockMargin( 0, 4, 0, 0 )
	self.button:SetText( "" )

end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( 100, 150, 200 )
	surface.DrawRect( 0, 0, w, h )
	
end

function PANEL:setTitle( text )
	
	self:SetTitle( text )
	
end

function PANEL:setButtonText( text )
	
	self.button:SetText( text )
	
end

function PANEL:setCallback( callback )
	
	self.button.DoClick = function()
	
		callback( self, self.textEntry:GetValue() )
		
	end
	
end

vgui.Register( "atags_settext_panel", PANEL, "DFrame" )

-- "addons\\atags\\lua\\atags\\vgui\\settext_panel.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local PANEL = {}

function PANEL:Init()

	self:SetSize( 300, 85 )
	self:Center()
	self:MakePopup()
	self:SetTitle( "" )
	
	self.textEntry = vgui.Create( "DTextEntry", self )
	self.textEntry:Dock( FILL )
	self.textEntry:SetText( "" )
	
	self.button = vgui.Create( "ATAG_Button", self )
	self.button:Dock( BOTTOM )
	self.button:DockMargin( 0, 4, 0, 0 )
	self.button:SetText( "" )

end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( 100, 150, 200 )
	surface.DrawRect( 0, 0, w, h )
	
end

function PANEL:setTitle( text )
	
	self:SetTitle( text )
	
end

function PANEL:setButtonText( text )
	
	self.button:SetText( text )
	
end

function PANEL:setCallback( callback )
	
	self.button.DoClick = function()
	
		callback( self, self.textEntry:GetValue() )
		
	end
	
end

vgui.Register( "atags_settext_panel", PANEL, "DFrame" )

-- "addons\\atags\\lua\\atags\\vgui\\settext_panel.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local PANEL = {}

function PANEL:Init()

	self:SetSize( 300, 85 )
	self:Center()
	self:MakePopup()
	self:SetTitle( "" )
	
	self.textEntry = vgui.Create( "DTextEntry", self )
	self.textEntry:Dock( FILL )
	self.textEntry:SetText( "" )
	
	self.button = vgui.Create( "ATAG_Button", self )
	self.button:Dock( BOTTOM )
	self.button:DockMargin( 0, 4, 0, 0 )
	self.button:SetText( "" )

end

function PANEL:Paint( w, h )
	
	surface.SetDrawColor( 100, 150, 200 )
	surface.DrawRect( 0, 0, w, h )
	
end

function PANEL:setTitle( text )
	
	self:SetTitle( text )
	
end

function PANEL:setButtonText( text )
	
	self.button:SetText( text )
	
end

function PANEL:setCallback( callback )
	
	self.button.DoClick = function()
	
		callback( self, self.textEntry:GetValue() )
		
	end
	
end

vgui.Register( "atags_settext_panel", PANEL, "DFrame" )

